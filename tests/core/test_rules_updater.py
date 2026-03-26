import errno
import io
import json
import os
import shutil
import socket
import tarfile
import tempfile
from unittest import mock
from urllib import error

import pytest

from rostran.core.rules_updater import (
    _read_meta,
    _write_meta,
    get_local_rules_version,
    get_builtin_rules_version,
    fetch_remote_latest_version,
    fetch_available_versions,
    update_rules,
    has_user_rules,
    clean_user_rules,
    RulesUpdateError,
)


@pytest.fixture
def temp_user_dir(tmp_path, monkeypatch):
    """Redirect all user-level paths to a temp directory."""
    user_data = tmp_path / ".rostran"
    user_data.mkdir()
    rules_dir = user_data / "rules"
    meta_file = user_data / "rules_meta.json"

    monkeypatch.setattr("rostran.core.rules_updater.USER_DATA_DIR", str(user_data))
    monkeypatch.setattr("rostran.core.rules_updater.USER_RULES_DIR", str(rules_dir))
    monkeypatch.setattr("rostran.core.rules_updater.USER_RULES_META_FILE", str(meta_file))

    return {
        "user_data": user_data,
        "rules_dir": rules_dir,
        "meta_file": meta_file,
    }


FAKE_VERSIONS_JSON = {
    "latest": "2.0.0",
    "versions": {
        "2.0.0": {
            "commit": "abc123def456abc123def456abc123def456abc1",
            "date": "2026-03-20",
            "description": "Added new DTS resources",
        },
        "1.0.0": {
            "commit": "b7935bb63ce23206ff5c10ff5b2759ffacc4f8de",
            "date": "2026-03-01",
            "description": "Initial versioned release",
        },
    },
}


class TestMeta:
    def test_read_meta_missing(self, temp_user_dir):
        assert _read_meta() == {}

    def test_write_and_read_meta(self, temp_user_dir):
        _write_meta({"version": "1.0.0"})
        assert _read_meta() == {"version": "1.0.0"}

    def test_get_local_version_none(self, temp_user_dir):
        assert get_local_rules_version() is None

    def test_get_local_version(self, temp_user_dir):
        _write_meta({"version": "1.2.3"})
        assert get_local_rules_version() == "1.2.3"


class TestBuiltinVersion:
    def test_reads_versions_json_latest(self):
        version = get_builtin_rules_version()
        assert version is not None
        assert version == "1.0.0"


class TestHasUserRules:
    def test_no_rules(self, temp_user_dir):
        assert has_user_rules() is False

    def test_with_rules(self, temp_user_dir):
        rules_dir = temp_user_dir["rules_dir"]
        rules_dir.mkdir(parents=True)
        assert has_user_rules() is True


class TestCleanUserRules:
    def test_clean_removes_cache(self, temp_user_dir):
        rules_dir = temp_user_dir["rules_dir"]
        rules_dir.mkdir(parents=True)
        (rules_dir / "test.yml").write_text("data")
        _write_meta({"version": "1.0.0"})

        msg = clean_user_rules()
        assert "cleared" in msg.lower()
        assert not rules_dir.exists()
        assert not temp_user_dir["meta_file"].exists()


def _make_rules_tarball(rules_files: dict, prefix: str = "repo-main") -> bytes:
    """Create an in-memory tar.gz archive mimicking the GitHub archive layout."""
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode="w:gz") as tf:
        for path, content in rules_files.items():
            full_path = f"{prefix}/rostran/rules/{path}"
            data = content.encode() if isinstance(content, str) else content
            info = tarfile.TarInfo(name=full_path)
            info.size = len(data)
            tf.addfile(info, io.BytesIO(data))
    return buf.getvalue()


class TestFetchRemoteLatestVersion:
    def test_fetches_version(self):
        with mock.patch(
            "rostran.core.rules_updater._http_get",
            return_value=json.dumps(FAKE_VERSIONS_JSON),
        ):
            ver = fetch_remote_latest_version()
            assert ver == "2.0.0"


class TestHttpGetRetry:
    def test_retries_on_socket_timeout_then_succeeds(self):
        from rostran.core import rules_updater as ru

        resp_ok = mock.MagicMock()
        resp_ok.__enter__ = mock.Mock(return_value=resp_ok)
        resp_ok.__exit__ = mock.Mock(return_value=False)
        resp_ok.read.return_value = b'{"latest": "1.0.0", "versions": {}}'

        with mock.patch(
            "rostran.core.rules_updater.request.urlopen",
            side_effect=[
                error.URLError(socket.timeout("timed out")),
                error.URLError(socket.timeout("timed out")),
                resp_ok,
            ],
        ) as mock_urlopen, mock.patch(
            "rostran.core.rules_updater.time.sleep"
        ) as mock_sleep:
            out = ru._http_get("https://example.com/x")
            assert '{"latest":' in out
            assert mock_urlopen.call_count == 3
            assert mock_sleep.call_count == 2

    def test_fails_after_six_timeout_attempts(self):
        from rostran.core import rules_updater as ru

        with mock.patch(
            "rostran.core.rules_updater.request.urlopen",
            side_effect=error.URLError(socket.timeout()),
        ) as mock_urlopen, mock.patch(
            "rostran.core.rules_updater.time.sleep"
        ):
            with pytest.raises(RulesUpdateError, match="Cannot reach remote"):
                ru._http_get("https://example.com/x")
            assert mock_urlopen.call_count == 6

    def test_no_retry_on_non_timeout_urlerror(self):
        from rostran.core import rules_updater as ru

        with mock.patch(
            "rostran.core.rules_updater.request.urlopen",
            side_effect=error.URLError(
                OSError(errno.ECONNREFUSED, "Connection refused")
            ),
        ) as mock_urlopen, mock.patch(
            "rostran.core.rules_updater.time.sleep"
        ) as mock_sleep:
            with pytest.raises(RulesUpdateError, match="Cannot reach remote"):
                ru._http_get("https://example.com/x")
            assert mock_urlopen.call_count == 1
            assert mock_sleep.call_count == 0


class TestFetchAvailableVersions:
    def test_lists_versions_with_metadata(self):
        with mock.patch(
            "rostran.core.rules_updater._http_get",
            return_value=json.dumps(FAKE_VERSIONS_JSON),
        ):
            versions = fetch_available_versions()
            assert len(versions) == 2
            assert versions[0]["version"] == "2.0.0"
            assert versions[0]["commit"].startswith("abc123")
            assert versions[1]["version"] == "1.0.0"

    def test_empty_when_no_versions(self):
        empty_data = {"latest": "1.0.0", "versions": {}}
        with mock.patch(
            "rostran.core.rules_updater._http_get",
            return_value=json.dumps(empty_data),
        ):
            versions = fetch_available_versions()
            assert versions == []


class TestUpdateRules:
    def _mock_http_get(self, tarball_data, versions_json=None):
        """Returns a side_effect function for _http_get."""
        vj = versions_json or FAKE_VERSIONS_JSON

        def side_effect(url, headers=None, decode=True):
            if "VERSIONS.json" in url:
                return json.dumps(vj)
            if url.endswith(".tar.gz"):
                return tarball_data
            return ""
        return side_effect

    def test_update_to_latest(self, temp_user_dir):
        tarball = _make_rules_tarball({
            "VERSIONS.json": json.dumps(
                {"latest": "2.0.0", "versions": FAKE_VERSIONS_JSON["versions"]}
            ),
            "terraform/alicloud/vpc.yml": "Version: '2020-06-01'\nType: Resource\n",
        })

        with mock.patch(
            "rostran.core.rules_updater._http_get",
            side_effect=self._mock_http_get(tarball),
        ):
            msg = update_rules()
            assert "2.0.0" in msg
            assert has_user_rules()
            assert get_local_rules_version() == "2.0.0"
            assert (temp_user_dir["rules_dir"] / "terraform" / "alicloud" / "vpc.yml").exists()

    def test_update_to_specific_version(self, temp_user_dir):
        tarball = _make_rules_tarball({
            "VERSIONS.json": json.dumps(
                {"latest": "1.0.0", "versions": FAKE_VERSIONS_JSON["versions"]}
            ),
            "terraform/alicloud/vpc.yml": "data",
        }, prefix="repo-b7935bb")

        with mock.patch(
            "rostran.core.rules_updater._http_get",
            side_effect=self._mock_http_get(tarball),
        ):
            msg = update_rules(version="1.0.0")
            assert "1.0.0" in msg
            assert get_local_rules_version() == "1.0.0"

    def test_update_specific_version_not_found(self, temp_user_dir):
        with mock.patch(
            "rostran.core.rules_updater._http_get",
            return_value=json.dumps(FAKE_VERSIONS_JSON),
        ):
            with pytest.raises(RulesUpdateError, match="not found"):
                update_rules(version="9.9.9")

    def test_update_skip_when_up_to_date(self, temp_user_dir):
        _write_meta({"version": "2.0.0"})

        with mock.patch(
            "rostran.core.rules_updater._http_get",
            return_value=json.dumps(FAKE_VERSIONS_JSON),
        ):
            msg = update_rules()
            assert "up-to-date" in msg.lower()

    def test_update_force_redownloads(self, temp_user_dir):
        _write_meta({"version": "2.0.0"})

        tarball = _make_rules_tarball({
            "VERSIONS.json": json.dumps(
                {"latest": "2.0.0", "versions": FAKE_VERSIONS_JSON["versions"]}
            ),
        })

        with mock.patch(
            "rostran.core.rules_updater._http_get",
            side_effect=self._mock_http_get(tarball),
        ):
            msg = update_rules(force=True)
            assert "2.0.0" in msg


class TestRuleManagerUserRules:
    """Test that RuleManager prefers user-level rules when available."""

    def test_uses_user_rules_dir(self, temp_user_dir, monkeypatch):
        from rostran.core.rule_manager import RuleManager, RuleClassifier

        monkeypatch.setattr(
            "rostran.core.rule_manager.USER_RULES_DIR",
            str(temp_user_dir["rules_dir"]),
        )

        rules_dir = temp_user_dir["rules_dir"] / "terraform" / "alicloud"
        rules_dir.mkdir(parents=True)
        (rules_dir / "vpc.yml").write_text(
            "Version: '2020-06-01'\n"
            "Type: Resource\n"
            "ResourceType:\n"
            "  From: alicloud_vpc\n"
            "  To: ALIYUN::ECS::VPC\n"
            "Properties: {}\n"
            "Attributes: {}\n"
        )

        rm = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
        assert "alicloud_vpc" in rm.resource_rules
        assert len(rm.resource_rules) == 1

    def test_falls_back_to_builtin(self, temp_user_dir, monkeypatch):
        from rostran.core.rule_manager import RuleManager, RuleClassifier

        monkeypatch.setattr(
            "rostran.core.rule_manager.USER_RULES_DIR",
            str(temp_user_dir["rules_dir"]),
        )

        rm = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
        assert len(rm.resource_rules) > 0
