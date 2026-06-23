import asyncio
import json
import os
from pathlib import Path, PureWindowsPath

import pytest

pytest.importorskip("fastapi")
from fastapi.testclient import TestClient  # noqa: E402

from rostran.core.format import (  # noqa: E402
    SourceTemplateFormat,
    TargetTemplateFormat,
)
from rostran.web.server import STATIC_DIR, build_app  # noqa: E402
from rostran.web import service  # noqa: E402


CFN_TEMPLATE = json.dumps(
    {
        "AWSTemplateFormatVersion": "2010-09-09",
        "Description": "test",
        "Resources": {
            "Vpc": {
                "Type": "AWS::EC2::VPC",
                "Properties": {"CidrBlock": "192.168.0.0/16"},
            }
        },
    }
)

ROS_TEMPLATE = (
    "ROSTemplateFormatVersion: '2015-09-01'\n"
    "Description: test\n"
    "Resources:\n"
    "  Vpc:\n"
    "    Type: ALIYUN::ECS::VPC\n"
    "    Properties:\n"
    "      CidrBlock: 192.168.0.0/16\n"
)


@pytest.fixture
def client():
    return TestClient(build_app())


def test_meta(client):
    resp = client.get("/api/meta")
    assert resp.status_code == 200
    data = resp.json()
    assert "version" in data
    assert "cloudformation" in data["source_formats"]
    assert "terraform/alicloud" in data["rules_classifiers"]


def test_health(client):
    assert client.get("/api/health").json() == {"status": "ok"}


def test_web_static_declares_and_serves_favicon(client):
    html = (STATIC_DIR / "index.html").read_text(encoding="utf-8")
    assert 'rel="icon"' in html
    assert 'href="/favicon.svg"' in html
    assert (STATIC_DIR / "favicon.svg").is_file()

    resp = client.get("/favicon.svg")
    assert resp.status_code == 200
    assert resp.text.startswith("<svg")


def test_transform_cloudformation_to_ros(client):
    resp = client.post(
        "/api/transform",
        data={"source_format": "cloudformation", "target_format": "yaml"},
        files={"files": ("vpc.json", CFN_TEMPLATE, "application/json")},
    )
    assert resp.status_code == 200, resp.text
    data = resp.json()
    assert data["targets"], data
    content = data["targets"][0]["content"]
    assert "ROSTemplateFormatVersion" in content
    assert "ALIYUN::ECS::VPC" in content


def test_transform_stream_emits_log_and_result(client):
    with client.stream(
        "POST",
        "/api/transform/stream",
        data={"source_format": "cloudformation", "target_format": "yaml"},
        files={"files": ("vpc.json", CFN_TEMPLATE, "application/json")},
    ) as resp:
        assert resp.status_code == 200
        assert "text/event-stream" in resp.headers["content-type"]
        body = "".join(resp.iter_text())

    assert "event: log" in body
    assert "event: result" in body
    # The final result event carries the transformed template.
    events = body.split("\n\n")
    result_event = [e for e in events if "event: result" in e][0]
    data = json.loads(result_event.splitlines()[1][len("data: ") :])
    assert data["targets"][0]["content"].count("ROSTemplateFormatVersion") == 1
    assert "ALIYUN::ECS::VPC" in data["targets"][0]["content"]


def test_transform_stream_forwards_terraform_logs(tmp_path, monkeypatch, client):
    def fake_transform(spec):
        print("Running terraform init...")
        print("Initializing provider plugins...")
        Path(spec["target_path"]).write_text("ok: true\n", encoding="utf-8")

    monkeypatch.setenv("ROSTRAN_TERRAFORM_CACHE_DIR", str(tmp_path / "cache"))
    monkeypatch.setattr(service, "_run_transform_spec", fake_transform)

    with client.stream(
        "POST",
        "/api/transform/stream",
        data={"source_format": "terraform", "target_format": "yaml"},
        files={"files": ("main.tf", 'resource "x" "y" {}\n', "text/plain")},
    ) as resp:
        assert resp.status_code == 200
        body = "".join(resp.iter_text())

    assert "event: log" in body
    assert "Running terraform init..." in body
    assert "Initializing provider plugins..." in body
    assert "event: result" in body


def test_transform_stream_error_event(client):
    with client.stream(
        "POST",
        "/api/transform/stream",
        data={"source_format": "bogus"},
        files={"files": ("x.json", "{}", "application/json")},
    ) as resp:
        assert resp.status_code == 200
        body = "".join(resp.iter_text())
    assert "event: error" in body


def test_transform_invalid_source_format(client):
    resp = client.post(
        "/api/transform",
        data={"source_format": "nope"},
        files={"files": ("x.json", "{}", "application/json")},
    )
    assert resp.status_code == 400
    assert resp.json()["error"]["type"] == "InvalidRequest"


def test_format_endpoint(client):
    resp = client.post(
        "/api/format",
        data={"content": ROS_TEMPLATE, "format": "yaml"},
    )
    assert resp.status_code == 200, resp.text
    assert "ROSTemplateFormatVersion" in resp.json()["content"]


def test_format_invalid(client):
    resp = client.post(
        "/api/format",
        data={"content": "{ not valid", "format": "json"},
    )
    assert resp.status_code == 422


def test_examples_list_and_get(client):
    resp = client.get("/api/examples")
    assert resp.status_code == 200
    examples = resp.json()["examples"]
    assert any(e["id"] == "cloudformation-vpc" for e in examples)
    # content omitted in list
    assert all("content" not in e for e in examples)

    resp = client.get("/api/examples/cloudformation-vpc")
    assert resp.status_code == 200
    assert "content" in resp.json()

    assert client.get("/api/examples/missing").status_code == 404


def test_rules_classifiers(client):
    resp = client.get("/api/rules/classifiers")
    assert resp.status_code == 200
    assert "cloudformation" in resp.json()["classifiers"]


def test_service_transform_no_files():
    with pytest.raises(service.TransformError):
        service.transform(files=[], source_format=None)  # type: ignore[arg-type]


def test_safe_member_path_removes_windows_drive_prefix():
    rel = service._safe_member_path(r"C:\repo\nested\main.tf")

    assert rel == "repo/nested/main.tf"
    assert PureWindowsPath(rel).drive == ""
    assert not PureWindowsPath(rel).is_absolute()


def test_service_transform_uses_cached_terraform_result(tmp_path, monkeypatch):
    calls = []
    cache_root = tmp_path / "cache"

    def fake_transform(spec):
        calls.append(spec)
        Path(spec["target_path"]).write_text("ok: true\n", encoding="utf-8")

    monkeypatch.setenv("ROSTRAN_TERRAFORM_CACHE_DIR", str(cache_root))
    monkeypatch.setattr(service, "_run_transform_spec", fake_transform)

    kwargs = {
        "files": [("main.tf", b'resource "x" "y" {}\n')],
        "source_format": SourceTemplateFormat.Terraform,
        "target_format": TargetTemplateFormat.Yaml,
    }

    first = service.transform(**kwargs)
    second = service.transform(**kwargs)

    assert len(calls) == 1
    assert first.targets[0].content == "ok: true\n"
    assert second.targets[0].content == "ok: true\n"
    assert str(cache_root) in first.log
    assert str(cache_root) in second.log
    assert "Using cached Terraform transform result." in second.log


def test_terraform_project_cache_evicts_least_recent_project(tmp_path):
    cache = service.TerraformProjectCache(tmp_path, max_projects=2)

    for name in ("a", "b", "c"):
        cache.prepare_project(name, [("main.tf", name.encode())])
        cache.save_result(
            name,
            service.TransformResult(
                targets=[service.TargetFile("template.yml", f"{name}: true\n")]
            ),
        )

    cached_projects = sorted(p.name for p in tmp_path.iterdir() if p.is_dir())

    assert cached_projects == ["b", "c"]
    assert not (tmp_path / "a").exists()


def test_ros_to_terraform_without_credentials():
    """ROS -> Terraform must work without Alibaba Cloud credentials by skipping
    the validation API call (which would otherwise raise), and must run cleanly
    in a worker thread (no `signal only works in main thread` error)."""
    import concurrent.futures

    ros = (
        "ROSTemplateFormatVersion: '2015-09-01'\n"
        "Resources:\n"
        "  SG:\n"
        "    Type: ALIYUN::ECS::SecurityGroup\n"
        "    Properties:\n"
        "      VpcId: vpc-x\n"
    )

    def run():
        return service.transform(
            files=[("template.yml", ros.encode())],
            source_format=SourceTemplateFormat.ROS,
            target_format=TargetTemplateFormat.Auto,
        )

    with concurrent.futures.ThreadPoolExecutor() as ex:
        result = ex.submit(run).result()

    assert any(t.filename.endswith(".tf") for t in result.targets)


def test_transform_endpoint_awaits_async_service(monkeypatch, client):
    """The web endpoint should use the async service path instead of wrapping
    the synchronous transform in Starlette's threadpool."""
    captured = {}

    async def record_transform(*_args, **_kwargs):
        asyncio.get_running_loop()
        captured["async_service_called"] = True
        return service.TransformResult(
            targets=[service.TargetFile("template.yml", "ok: true\n")],
            log="",
        )

    def sync_transform_should_not_run(*_args, **_kwargs):
        raise AssertionError("web endpoint should await service.transform_async")

    monkeypatch.setattr(service, "transform_async", record_transform, raising=False)
    monkeypatch.setattr(service, "transform", sync_transform_should_not_run)

    resp = client.post(
        "/api/transform",
        data={"source_format": "cloudformation"},
        files={"files": ("a.json", "{}", "application/json")},
    )
    assert resp.status_code == 200, resp.text
    assert captured.get("async_service_called") is True


def test_service_transform_does_not_start_web_worker(monkeypatch):
    """The service should run the transform in-process; Terraform operations are
    isolated by libterraform's TerraformPool worker processes."""
    import subprocess

    cfn = '{"AWSTemplateFormatVersion":"2010-09-09","Resources":{"Vpc":{"Type":"AWS::EC2::VPC","Properties":{"CidrBlock":"192.168.0.0/16"}}}}'
    before = os.getcwd()

    def worker_should_not_run(*_args, **_kwargs):
        raise AssertionError("service.transform should not start a worker process")

    monkeypatch.setattr(subprocess, "Popen", worker_should_not_run)
    res = service.transform(
        files=[("vpc.json", cfn.encode())],
        source_format=SourceTemplateFormat.CloudFormation,
        target_format=TargetTemplateFormat.Yaml,
    )
    assert any("ALIYUN::ECS::VPC" in t.content for t in res.targets)
    assert os.getcwd() == before
    assert "Save template to" not in res.log
