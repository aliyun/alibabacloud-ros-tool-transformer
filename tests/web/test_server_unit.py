import pytest
from fastapi.testclient import TestClient

from rostran.web import server, service


@pytest.fixture
def client(tmp_path, monkeypatch):
    monkeypatch.setattr(server, "STATIC_DIR", tmp_path)
    return TestClient(server.build_app())


@pytest.mark.parametrize("endpoint", ["/api/transform", "/api/transform/stream"])
def test_invalid_options_and_oversized_uploads(endpoint, client, monkeypatch):
    files = {"files": ("template.yml", b"12345", "text/plain")}
    invalid = client.post(
        endpoint, data={"source_format": "ros", "options": "{"}, files=files
    )
    if endpoint.endswith("stream"):
        assert "Invalid options JSON" in invalid.text
    else:
        assert invalid.status_code == 400
        assert invalid.json()["error"]["type"] == "InvalidRequest"
    monkeypatch.setattr(server, "MAX_UPLOAD_BYTES", 4)
    oversized = client.post(endpoint, data={"source_format": "ros"}, files=files)
    if endpoint.endswith("stream"):
        assert "PayloadTooLarge" in oversized.text
    else:
        assert oversized.status_code == 413


def test_invalid_target_and_service_error(client, monkeypatch):
    files = {"files": ("template.yml", b"test", "text/plain")}
    bad = client.post(
        "/api/transform",
        data={"source_format": "ros", "target_format": "bad"},
        files=files,
    )
    assert bad.status_code == 400

    async def fail(**kwargs):
        raise service.TransformError("broken", "InvalidTemplate", "trace")

    monkeypatch.setattr(service, "transform_async", fail)
    result = client.post("/api/transform", data={"source_format": "ros"}, files=files)
    assert result.status_code == 422
    assert result.json()["error"] == {
        "type": "InvalidTemplate",
        "message": "broken",
        "log": "trace",
    }


def test_stream_reports_unexpected_service_failure(client, monkeypatch):
    async def fail(**kwargs):
        raise ValueError("broken")

    monkeypatch.setattr(service, "transform_async", fail)
    response = client.post(
        "/api/transform/stream",
        data={"source_format": "ros"},
        files={"files": ("test.yml", b"test")},
    )
    assert '"type": "ValueError"' in response.text
    assert '"message": "broken"' in response.text


def test_missing_frontend_and_unknown_rules(client):
    assert "not bundled" in client.get("/").json()["message"]
    assert client.get("/api/rules", params={"classifier": "unknown"}).status_code == 400
    assert client.get("/api/examples/not-found").status_code == 404


def test_static_files_and_spa_fallback(tmp_path, monkeypatch):
    (tmp_path / "assets").mkdir()
    (tmp_path / "index.html").write_text("index")
    (tmp_path / "image.txt").write_text("asset")
    monkeypatch.setattr(server, "STATIC_DIR", tmp_path)
    client = TestClient(server.build_app())
    assert client.get("/").text == "index"
    assert client.get("/image.txt").text == "asset"
    assert client.get("/unknown-route").text == "index"


def test_server_run_opens_browser_and_stops_after_uvicorn(monkeypatch):
    import threading
    import uvicorn
    import webbrowser

    monkeypatch.setattr(server, "_require_web_deps", lambda: None)
    monkeypatch.setattr(server, "_preload_libterraform", lambda: None)
    monkeypatch.setattr(server, "build_app", lambda: "app")
    calls = []
    monkeypatch.setattr(
        uvicorn, "run", lambda app, **kwargs: calls.append((app, kwargs))
    )
    monkeypatch.setattr(webbrowser, "open", lambda url: calls.append(url))

    class Timer:
        def __init__(self, delay, callback):
            self.callback = callback

        def start(self):
            self.callback()

    monkeypatch.setattr(threading, "Timer", Timer)

    def exit_process(code):
        raise SystemExit(code)

    monkeypatch.setattr(server.os, "_exit", exit_process)
    with pytest.raises(SystemExit):
        server.run(host="0.0.0.0", port=8123, open_browser=True)
    assert calls[0] == "http://127.0.0.1:8123"
    assert calls[1][0] == "app" and calls[1][1]["port"] == 8123


def test_preload_ignores_terraform_runtime_errors(monkeypatch):
    from libterraform import TerraformConfig

    def fail(path):
        raise RuntimeError("not available")

    monkeypatch.setattr(TerraformConfig, "load_config_dir", fail)
    server._preload_libterraform()
