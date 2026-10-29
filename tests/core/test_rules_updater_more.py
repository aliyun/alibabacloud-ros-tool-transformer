import errno
import io
import tarfile
from urllib.error import URLError

import pytest

from rostran.core import rules_updater as updater


def test_invalid_version_files_and_remote_versions(tmp_path, monkeypatch):
    assert updater._read_latest_from_versions_json(str(tmp_path / "missing")) is None
    version = tmp_path / "VERSIONS.json"
    version.write_text("not json")
    assert updater._read_latest_from_versions_json(str(version)) is None
    monkeypatch.setattr(updater, "USER_RULES_META_FILE", str(version))
    assert updater._read_meta() == {}
    monkeypatch.setattr(updater, "_http_get", lambda *args, **kwargs: "invalid")
    with pytest.raises(updater.RulesUpdateError, match="Invalid VERSIONS"):
        updater._fetch_remote_versions_json()
    monkeypatch.setattr(
        updater, "_fetch_remote_versions_json", lambda: {"versions": {"1": {}}}
    )
    with pytest.raises(updater.RulesUpdateError, match="latest"):
        updater.fetch_remote_latest_version()
    with pytest.raises(updater.RulesUpdateError, match="no commit"):
        updater._resolve_commit_for_version("1")


def test_timeout_classification_and_request_headers(monkeypatch):
    assert updater._urlerror_is_timeout(URLError(OSError(errno.ETIMEDOUT, "timeout")))
    assert not updater._urlerror_is_timeout(
        URLError(OSError(errno.ECONNREFUSED, "refused"))
    )
    seen = []

    class Response:
        def __enter__(self):
            return self

        def __exit__(self, *args):
            return None

        def read(self):
            return b"payload"

    monkeypatch.setattr(
        updater.request, "urlopen", lambda req, timeout: seen.append(req) or Response()
    )
    assert (
        updater._http_get(
            "https://example.invalid", headers={"X-Test": "value"}, decode=False
        )
        == b"payload"
    )
    assert seen[0].get_header("X-test") == "value"


def test_extract_rules_ignores_other_files_and_rejects_invalid_archive(monkeypatch):
    archive = io.BytesIO()
    with tarfile.open(fileobj=archive, mode="w:gz") as tf:
        for name, content in [
            ("repo/rostran/rules/thing.yml", b"rule"),
            ("repo/README.md", b"ignore"),
        ]:
            info = tarfile.TarInfo(name)
            info.size = len(content)
            tf.addfile(info, io.BytesIO(content))
    monkeypatch.setattr(
        updater, "_http_get", lambda *args, **kwargs: archive.getvalue()
    )
    path = updater._download_and_extract_rules("main")
    try:
        from pathlib import Path

        assert (Path(path) / "thing.yml").read_bytes() == b"rule"
        assert not (Path(path) / "README.md").exists()
    finally:
        updater.shutil.rmtree(path)
    monkeypatch.setattr(updater, "_http_get", lambda *args, **kwargs: b"invalid")
    with pytest.raises(updater.RulesUpdateError, match="Failed to extract"):
        updater._download_and_extract_rules("main")


def test_update_replaces_cache_and_uses_downloaded_version(
    tmp_path, monkeypatch, caplog
):
    cache = tmp_path / "cache"
    cache.mkdir()
    (cache / "old.yml").write_text("old")
    extracted = tmp_path / "download"
    extracted.mkdir()
    (extracted / "VERSIONS.json").write_text('{"latest": "2.0"}')
    monkeypatch.setattr(updater, "USER_RULES_DIR", str(cache))
    monkeypatch.setattr(updater, "USER_DATA_DIR", str(tmp_path))
    monkeypatch.setattr(updater, "USER_RULES_META_FILE", str(tmp_path / "meta.json"))
    monkeypatch.setattr(updater, "fetch_remote_latest_version", lambda: "1.0")
    monkeypatch.setattr(
        updater, "_download_and_extract_rules", lambda ref: str(extracted)
    )
    result = updater.update_rules()
    assert "version 2.0" in result
    assert not (cache / "old.yml").exists()
    assert updater.get_local_rules_version() == "2.0"
    assert "latest mismatch" in caplog.text


def test_extract_preserves_directories_and_skips_root(monkeypatch):
    archive = io.BytesIO()
    with tarfile.open(fileobj=archive, mode="w:gz") as tf:
        for name in ("repo/rostran/rules", "repo/rostran/rules/nested"):
            info = tarfile.TarInfo(name)
            info.type = tarfile.DIRTYPE
            tf.addfile(info)
        info = tarfile.TarInfo("repo/rostran/rules/nested/rule.yml")
        info.size = 4
        tf.addfile(info, io.BytesIO(b"rule"))
    monkeypatch.setattr(updater, "_http_get", lambda *a, **kw: archive.getvalue())
    path = updater._download_and_extract_rules("main")
    try:
        from pathlib import Path

        assert (Path(path) / "nested" / "rule.yml").read_bytes() == b"rule"
    finally:
        updater.shutil.rmtree(path)


def test_clean_rules_when_cache_and_metadata_are_absent(tmp_path, monkeypatch):
    monkeypatch.setattr(updater, "USER_RULES_DIR", str(tmp_path / "absent"))
    monkeypatch.setattr(updater, "USER_RULES_META_FILE", str(tmp_path / "absent.json"))
    assert "cleared" in updater.clean_user_rules()
