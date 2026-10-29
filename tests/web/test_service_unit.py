import json
import os
from pathlib import Path

import pytest

from rostran.core.format import (
    SourceTemplateFormat as Source,
    TargetTemplateFormat as Target,
)
from rostran.web import service


def test_credential_detection_prefers_environment_and_reads_profiles(
    tmp_path, monkeypatch
):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    monkeypatch.delenv("ALIBABA_CLOUD_CREDENTIALS_FILE", raising=False)
    monkeypatch.setenv("ALIBABA_CLOUD_ACCESS_KEY_ID", "id")
    monkeypatch.setenv("ALIBABA_CLOUD_ACCESS_KEY_SECRET", "secret")
    assert service.detect_credentials()["source"] == "environment"
    monkeypatch.delenv("ALIBABA_CLOUD_ACCESS_KEY_ID")
    monkeypatch.delenv("ALIBABA_CLOUD_ACCESS_KEY_SECRET")
    config = tmp_path / ".aliyun" / "config.json"
    config.parent.mkdir()
    config.write_text(
        json.dumps(
            {
                "current": "p",
                "profiles": [
                    {"name": "other"},
                    {
                        "name": "p",
                        "access_key_id": "id",
                        "access_key_secret": "secret",
                        "sts_token": "token",
                    },
                ],
            }
        )
    )
    result = service.detect_credentials()
    assert result["source"] == "Aliyun CLI (profile: p)"
    assert result["env"]["ALIBABA_CLOUD_SECURITY_TOKEN"] == "token"
    config.write_text("invalid json")
    credentials = tmp_path / "credentials.ini"
    credentials.touch()
    monkeypatch.setenv("ALIBABA_CLOUD_CREDENTIALS_FILE", str(credentials))
    assert service.detect_credentials()["source"] == "credentials file"
    credentials.unlink()
    assert not service.detect_credentials()["available"]


def test_cache_handles_invalid_results_and_corrupt_metadata(tmp_path, monkeypatch):
    monkeypatch.setenv("ROSTRAN_TERRAFORM_CACHE_DIR", str(tmp_path))
    monkeypatch.setenv("ROSTRAN_TERRAFORM_CACHE_MAX_PROJECTS", "invalid")
    cache = service.TerraformProjectCache.from_env()
    assert cache.max_projects == 20
    key = cache.key_for([("main.tf", b"source")], Target.Yaml, False, None, False)
    assert cache.load_result(key) is None
    project = cache.project_path(key)
    project.mkdir()
    (project / "result.json").write_text("not json")
    assert cache.load_result(key) is None
    (project / "metadata.json").write_text("not json")
    assert cache._last_used_ns(project) > 0
    output = service.TransformResult([service.TargetFile("x.yml", "hello")])
    cache.save_result(key, output)
    assert cache.load_result(key).targets == output.targets


@pytest.mark.parametrize(
    ("name", "kind", "content", "expected"),
    [
        ("source", Source.Terraform, b"", "source.tf"),
        ("source.tf", Source.Terraform, b"", "source.tf"),
        ("sheet", Source.Excel, b"", "sheet.xlsx"),
        ("sheet.xlsx", Source.Excel, b"", "sheet.xlsx"),
        ("source.txt", Source.ROS, b" {}", "source.json"),
        ("source", Source.ROS, b"x: 1", "source.yml"),
    ],
)
def test_normalizes_input_filenames(name, kind, content, expected):
    assert service._normalize_input_filename(name, kind, content) == expected


def test_target_resolution_and_binary_outputs(tmp_path):
    assert service._resolve_target(tmp_path, Source.ROS, Target.Auto) == (
        str(tmp_path),
        Target.Terraform,
    )
    assert service._resolve_target(tmp_path, Source.ROSTerraform, Target.Auto) == (
        str(tmp_path / "template"),
        Target.Auto,
    )
    assert service._resolve_target(tmp_path, Source.ROS, Target.Json)[0].endswith(
        "template.json"
    )
    (tmp_path / "file.txt").write_text("hello")
    (tmp_path / "file.bin").write_bytes(b"\xff\x00")
    targets = {item.filename: item for item in service._collect_outputs(tmp_path)}
    assert targets["file.txt"].content == "hello"
    assert targets["file.bin"].is_binary and targets["file.bin"].content == "/wA="


def test_log_capture_cleans_paths_and_tolerates_callback_failure():
    lines = []

    def fail_callback(line):
        raise RuntimeError("log receiver disconnected")

    capture = service._LogCapture(
        service._make_log_cleaner("/tmp/work"), lines, fail_callback
    )
    assert capture.writable()
    capture.write(b"Save template to /tmp/work/file\n")
    capture.write("Found /tmp/work/file\npartial")
    capture.finish()
    assert lines == ["Found file\n", "partial"]


def test_context_managers_restore_environment_and_working_directory(
    tmp_path, monkeypatch
):
    original = os.getcwd()
    monkeypatch.setenv("ROSTRAN_EXISTING", "old")
    monkeypatch.delenv("ROSTRAN_NEW", raising=False)
    with (
        pytest.raises(RuntimeError),
        service._temporary_cwd(tmp_path),
        service._temporary_env({"ROSTRAN_EXISTING": "new", "ROSTRAN_NEW": "added"}),
    ):
        assert os.getcwd() == str(tmp_path)
        raise RuntimeError("test")
    assert os.getcwd() == original
    assert os.environ["ROSTRAN_EXISTING"] == "old"
    assert "ROSTRAN_NEW" not in os.environ


def test_format_and_rules_fail_with_structured_errors():
    with pytest.raises(service.TransformError) as error:
        service.format_template("[", "json")
    assert error.value.error_type == "InvalidTemplate"
    with pytest.raises(service.TransformError) as error:
        service.format_template("anything", "unknown")
    assert error.value.error_type == "UnsupportedFormat"
    with pytest.raises(service.TransformError) as error:
        service.get_rules("not-a-classifier")
    assert error.value.error_type == "UnknownRules"


def test_credentials_fall_back_to_first_profile_and_default_cache(
    tmp_path, monkeypatch
):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    for key in (
        "ALIBABA_CLOUD_ACCESS_KEY_ID",
        "ALIBABA_CLOUD_ACCESS_KEY_SECRET",
        "ALIBABA_CLOUD_CREDENTIALS_FILE",
        "ROSTRAN_TERRAFORM_CACHE_DIR",
    ):
        monkeypatch.delenv(key, raising=False)
    config = tmp_path / ".aliyun" / "config.json"
    config.parent.mkdir()
    config.write_text(
        json.dumps(
            {"profiles": [{"access_key_id": "id", "access_key_secret": "secret"}]}
        )
    )
    assert service.detect_credentials()["source"] == "Aliyun CLI (profile: default)"
    assert (
        service.TerraformProjectCache.from_env().root
        == tmp_path / ".cache" / "rostran" / "terraform-projects"
    )


def test_cache_replaces_old_outputs_and_handles_missing_root(tmp_path):
    cache = service.TerraformProjectCache(tmp_path / "cache")
    cache.evict()
    project, _, out = cache.prepare_project("key", [("main.tf", b"input")])
    (out / "old.txt").write_text("old")
    _, _, out = cache.prepare_project("key", [("main.tf", b"new")])
    assert not (out / "old.txt").exists()
    assert (project / "in" / "main.tf").read_text() == "new"


def test_workspace_validation_injects_credentials_and_reports_errors(
    tmp_path, monkeypatch
):
    out = tmp_path / "out"
    out.mkdir()
    seen = []
    monkeypatch.setattr(
        service,
        "detect_credentials",
        lambda: {"available": True, "env": {"ROSTRAN_TEST_CREDENTIAL": "temporary"}},
    )

    def produce(spec):
        seen.append((spec, os.environ.get("ROSTRAN_TEST_CREDENTIAL")))
        print("converted")
        (out / "main.tf").write_text("output")

    monkeypatch.setattr(service, "_run_transform_spec", produce)
    result = service._run_transform_workspace(
        tmp_path, "source", out, Source.ROS, Target.Auto, False, None, True, None
    )
    assert result.targets[0].content == "output"
    assert not seen[0][0]["skip_ros_validation"] and seen[0][1] == "temporary"
    assert "ROSTRAN_TEST_CREDENTIAL" not in os.environ

    def fail(spec):
        print("useful log")
        raise service.TransformError("failed", "Custom")

    monkeypatch.setattr(service, "_run_transform_spec", fail)
    with pytest.raises(service.TransformError) as error:
        service._run_transform_workspace(
            tmp_path, "source", out, Source.ROS, Target.Auto, False, None, False, None
        )
    assert error.value.error_type == "Custom" and "useful log" in error.value.log
    (out / "main.tf").unlink()
    monkeypatch.setattr(service, "_run_transform_spec", lambda spec: None)
    with pytest.raises(service.TransformError) as error:
        service._run_transform_workspace(
            tmp_path, "source", out, Source.ROS, Target.Auto, False, None, False, None
        )
    assert error.value.error_type == "EmptyOutput"


def test_transform_spec_wraps_cli_errors(monkeypatch):
    from rostran.cli import __main__ as cli
    from rostran.core.exceptions import TemplateNotExist

    spec = {
        "source_path": "missing",
        "source_format": "ros",
        "target_path": "out",
        "target_format": "tf",
    }

    def fail(**kwargs):
        raise TemplateNotExist(path="missing")

    monkeypatch.setattr(cli, "transform", fail)
    with pytest.raises(service.TransformError) as error:
        service._run_transform_spec(spec)
    assert error.value.error_type == "TemplateNotExist"
    monkeypatch.setattr(
        cli, "transform", lambda **kwargs: (_ for _ in ()).throw(ValueError("bad"))
    )
    with pytest.raises(service.TransformError) as error:
        service._run_transform_spec(spec)
    assert error.value.error_type == "ValueError"


def test_rules_rendering_and_json_format(monkeypatch):
    from rostran.core.rule_manager import RuleManager
    from types import SimpleNamespace

    monkeypatch.setattr(
        RuleManager,
        "initialize",
        lambda classifier: SimpleNamespace(show=lambda *args: print("rules")),
    )
    assert "rules" in service.get_rules("ros")
    formatted = service.format_template(
        '{"ROSTemplateFormatVersion": "2015-09-01"}', "json"
    )
    assert json.loads(formatted)["ROSTemplateFormatVersion"] == "2015-09-01"


def test_terraform_upload_normalization_and_invalid_cache_configuration(
    tmp_path, monkeypatch
):
    assert service._normalize_input_files([("../", b"data")], Source.Terraform) == [
        ("source.tf", b"data")
    ]
    cache = service.TerraformProjectCache(tmp_path, max_projects=0)
    assert cache.max_projects == 1
    (tmp_path / "subdirectory").mkdir()
    assert service._collect_outputs(tmp_path) == []
    assert service._LogCapture(lambda line: line, [], None).write("") == 0


def test_workspace_skips_validation_without_credentials(tmp_path, monkeypatch):
    out = tmp_path / "out"
    out.mkdir()
    seen = []
    monkeypatch.setattr(
        service, "detect_credentials", lambda: {"available": False, "env": {}}
    )

    def produce(spec):
        seen.append(spec)
        (out / "main.tf").write_text("output")

    monkeypatch.setattr(service, "_run_transform_spec", produce)
    service._run_transform_workspace(
        tmp_path, "source", out, Source.ROS, Target.Auto, False, None, True, None
    )
    assert seen[0]["skip_ros_validation"] is True


def test_transform_spec_preserves_structured_errors(monkeypatch):
    from rostran.cli import __main__ as cli

    def fail(**kwargs):
        raise service.TransformError("already wrapped", "Custom")

    monkeypatch.setattr(cli, "transform", fail)
    spec = {
        "source_path": "x",
        "source_format": "ros",
        "target_path": "out",
        "target_format": "tf",
    }
    with pytest.raises(service.TransformError) as error:
        service._run_transform_spec(spec)
    assert error.value.error_type == "Custom"


def test_format_reports_invalid_ros_template():
    with pytest.raises(service.TransformError) as error:
        service.format_template('{"ROSTemplateFormatVersion": "wrong"}', "json")
    assert error.value.error_type == "InvalidRosTemplateFormatVersion"


def test_credentials_missing_and_profile_without_keys(tmp_path, monkeypatch):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    for name in (
        "ALIBABA_CLOUD_ACCESS_KEY_ID",
        "ALIBABA_CLOUD_ACCESS_KEY_SECRET",
        "ALIBABA_CLOUD_CREDENTIALS_FILE",
    ):
        monkeypatch.delenv(name, raising=False)
    assert service.detect_credentials()["available"] is False
    config = tmp_path / ".aliyun" / "config.json"
    config.parent.mkdir()
    config.write_text(json.dumps({"profiles": [{"name": "incomplete"}]}))
    assert service.detect_credentials()["available"] is False


def test_target_resolution_and_log_non_string(tmp_path):
    assert (
        service._resolve_target(tmp_path, Source.CloudFormation, Target.Auto)[1]
        == Target.Yaml
    )
    assert service._resolve_target(tmp_path, Source.ROS, object())[1] == Target.Yaml
    parts = []
    log = service._LogCapture(lambda line: line, parts, None)
    assert log.write(123) == 3
    log.finish()
    assert "".join(parts) == "123"
