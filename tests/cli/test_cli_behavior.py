import json
from pathlib import Path
from types import SimpleNamespace

import pytest
from typer.testing import CliRunner

from rostran.cli import __main__ as cli
from rostran.core import exceptions
from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat


runner = CliRunner()


@pytest.mark.parametrize(
    ("suffix", "provider"),
    [
        (".xlsx", "ExcelTemplate"),
        (".tf", "TerraformTemplate"),
        (".yaml", "CloudFormationTemplate"),
    ],
)
def test_transform_detects_source_and_saves_result(
    tmp_path, monkeypatch, suffix, provider
):
    import rostran.providers as providers

    calls = []
    output = SimpleNamespace(save=lambda path, fmt: calls.append((path, fmt)))
    fake = SimpleNamespace(
        initialize=lambda *args: SimpleNamespace(transform=lambda: output)
    )
    monkeypatch.setattr(providers, provider, fake)
    source = tmp_path / f"source{suffix}"
    source.write_text("{}")
    target = tmp_path / "out.json"
    cli.transform(
        str(source),
        SourceTemplateFormat.Auto,
        str(target),
        TargetTemplateFormat.Auto,
        False,
        False,
        None,
    )
    assert calls == [(str(target), TargetTemplateFormat.Json)]


def test_transform_saves_multiple_templates_with_distinct_names(tmp_path, monkeypatch):
    import rostran.providers as providers

    saved = []
    results = [
        SimpleNamespace(save=lambda path, fmt: saved.append(path)) for _ in range(2)
    ]
    monkeypatch.setattr(
        providers,
        "CloudFormationTemplate",
        SimpleNamespace(
            initialize=lambda *args: SimpleNamespace(transform=lambda: results)
        ),
    )
    source = tmp_path / "source.yml"
    source.write_text("{}")
    target = tmp_path / "out.yml"
    cli.transform(
        str(source),
        SourceTemplateFormat.Auto,
        str(target),
        TargetTemplateFormat.Auto,
        False,
        False,
        None,
    )
    assert saved == [str(tmp_path / "out-0.yml"), str(tmp_path / "out-1.yml")]


def test_transform_validates_paths_and_invalid_yaml(tmp_path):
    kwargs = dict(
        source_format=SourceTemplateFormat.Auto,
        target_format=TargetTemplateFormat.Auto,
        compatible=False,
        force=False,
        extra_files=None,
    )
    with pytest.raises(exceptions.TemplateNotExist):
        cli.transform(str(tmp_path / "missing"), target_path=None, **kwargs)
    source = tmp_path / "source.yml"
    source.write_text("[")
    with pytest.raises(exceptions.InvalidTemplate):
        cli.transform(str(source), target_path=None, **kwargs)
    source.write_text("{}")
    target = tmp_path / "out.yml"
    target.touch()
    with pytest.raises(exceptions.TemplateAlreadyExist):
        cli.transform(str(source), target_path=str(target), **kwargs)
    with pytest.raises(exceptions.PathNotExist):
        cli.transform(
            str(source), target_path=str(tmp_path / "missing" / "out.yml"), **kwargs
        )
    with pytest.raises(exceptions.TemplateNotSupport):
        cli.transform(str(source), target_path=str(tmp_path / "unsupported"), **kwargs)


def test_format_directory_skips_paths_and_non_templates(tmp_path):
    first = tmp_path / "first.json"
    first.write_text(json.dumps({"ROSTemplateFormatVersion": "2015-09-01"}))
    subdir = tmp_path / "nested"
    subdir.mkdir()
    skip = subdir / "skip.yml"
    skip.write_text("ROSTemplateFormatVersion: '2015-09-01'\n")
    (subdir / "readme.txt").write_text("not a template")
    assert cli._format_directory(tmp_path, replace=True, skip_paths={skip}) == [first]
    assert json.loads(first.read_text())["ROSTemplateFormatVersion"] == "2015-09-01"


@pytest.mark.parametrize(
    ("filename", "content", "error"),
    [
        ("broken.json", "{", exceptions.InvalidTemplateFormat),
        ("broken.yml", "[", exceptions.InvalidTemplateFormat),
        ("broken.txt", "content", exceptions.TemplateFormatNotSupport),
    ],
)
def test_format_rejects_bad_input(tmp_path, filename, content, error):
    path = tmp_path / filename
    path.write_text(content)
    with pytest.raises(error):
        cli._format_file(path)


def test_server_state_and_status_are_local_to_home(tmp_path, monkeypatch):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    monkeypatch.setattr(cli, "_process_alive", lambda pid: pid == 42)
    state_file = cli._server_pid_file()
    state_file.write_text("bad json")
    assert cli._read_server_state() is None
    state_file.write_text(json.dumps({"pid": 42, "host": "127.0.0.1", "port": 8080}))
    result = runner.invoke(cli.app, ["server", "status"])
    assert result.exit_code == 0
    assert "Server is running (pid 42)" in result.stdout
    state_file.write_text(json.dumps({"pid": 1}))
    result = runner.invoke(cli.app, ["server", "status"])
    assert "Server is not running" in result.stdout
    assert not state_file.exists()


def test_server_start_stop_and_duplicate_start(tmp_path, monkeypatch):
    import rostran.web.server as server

    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    monkeypatch.setattr(server, "_require_web_deps", lambda: None)
    foreground = []
    monkeypatch.setattr(server, "run", lambda **kwargs: foreground.append(kwargs))
    result = runner.invoke(cli.app, ["server", "start", "--foreground", "--no-open"])
    assert result.exit_code == 0
    assert foreground == [{"host": "127.0.0.1", "port": 8080, "open_browser": False}]

    state_file = cli._server_pid_file()
    state_file.write_text(json.dumps({"pid": 42, "host": "localhost", "port": 80}))
    monkeypatch.setattr(cli, "_process_alive", lambda pid: True)
    result = runner.invoke(cli.app, ["server", "start", "--no-open"])
    assert result.exit_code == 1
    assert "already running" in result.stdout

    monkeypatch.setattr(cli, "_process_alive", lambda pid: False)
    result = runner.invoke(cli.app, ["server", "stop"])
    assert result.exit_code == 0
    assert "not running" in result.stdout
    assert not state_file.exists()


def test_server_stop_signals_running_process(tmp_path, monkeypatch):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    state_file = cli._server_pid_file()
    state_file.write_text(json.dumps({"pid": 42}))
    alive = iter([True, False])
    monkeypatch.setattr(cli, "_process_alive", lambda pid: next(alive))
    signals = []
    monkeypatch.setattr(
        cli.os, "kill", lambda pid, signal: signals.append((pid, signal))
    )
    result = runner.invoke(cli.app, ["server", "stop"])
    assert result.exit_code == 0
    assert signals[0][0] == 42
    assert not state_file.exists()


def test_rules_list_update_and_reset_without_network(monkeypatch):
    import rostran.core.rules_updater as updater

    monkeypatch.setattr(
        updater,
        "fetch_available_versions",
        lambda: [
            {"version": "1.2.3", "date": "2026-01-01", "description": "Test rules"}
        ],
    )
    monkeypatch.setattr(updater, "get_local_rules_version", lambda: "1.2.3")
    monkeypatch.setattr(updater, "update_rules", lambda **kwargs: "Updated")
    monkeypatch.setattr(updater, "clean_user_rules", lambda: "Reset")
    result = runner.invoke(cli.app, ["rules", "list"])
    assert result.exit_code == 0
    assert "1.2.3" in result.stdout and "installed" in result.stdout
    assert "Test rules" in result.stdout
    assert "Updated" in runner.invoke(cli.app, ["rules", "update"]).stdout
    assert "Reset" in runner.invoke(cli.app, ["rules", "reset"]).stdout


def test_rules_errors_are_reported(monkeypatch):
    import rostran.core.rules_updater as updater

    def fail(*args, **kwargs):
        raise updater.RulesUpdateError("offline")

    monkeypatch.setattr(updater, "fetch_available_versions", fail)
    monkeypatch.setattr(updater, "get_local_rules_version", lambda: None)
    monkeypatch.setattr(updater, "update_rules", fail)
    result = runner.invoke(cli.app, ["rules", "list"])
    assert result.exit_code == 1 and "offline" in result.stdout
    result = runner.invoke(cli.app, ["rules", "update"])
    assert result.exit_code == 1 and "offline" in result.stdout


def test_ros_source_selects_terraform_target_and_wrap_source_uses_template_basename(
    tmp_path, monkeypatch
):
    import rostran.providers as providers
    from rostran.providers.ros import template as ros_template

    calls = []
    fake = SimpleNamespace(transform=lambda target: calls.append(target))
    monkeypatch.setattr(
        ros_template.ROS2TerraformTemplate, "initialize", lambda data: fake
    )
    monkeypatch.setattr(
        providers,
        "WrapTerraformTemplate",
        SimpleNamespace(initialize=lambda *args: fake),
    )
    monkeypatch.chdir(tmp_path)
    (tmp_path / "terraform").mkdir()
    source = tmp_path / "ros.yml"
    source.write_text("ROSTemplateFormatVersion: '2015-09-01'\n")
    cli.transform(
        str(source),
        SourceTemplateFormat.Auto,
        None,
        TargetTemplateFormat.Auto,
        False,
        False,
        None,
    )
    assert calls.pop().endswith("terraform/alicloud")
    source.write_text(
        "ROSTemplateFormatVersion: '2015-09-01'\nTransform: Aliyun::Terraform-v1.0\n"
    )
    cli.transform(
        str(source),
        SourceTemplateFormat.Auto,
        None,
        TargetTemplateFormat.Auto,
        False,
        False,
        None,
    )
    assert calls.pop() == str(tmp_path / "template")


def test_compatible_terraform_receives_extra_files_and_force(tmp_path, monkeypatch):
    import rostran.providers as providers

    initialized = []
    saved = []
    result = SimpleNamespace(save=lambda path, fmt: saved.append((path, fmt)))

    def initialize(*args):
        initialized.append(args)
        return SimpleNamespace(transform=lambda: [result])

    monkeypatch.setattr(
        providers, "CompatibleTerraformTemplate", SimpleNamespace(initialize=initialize)
    )
    source = tmp_path / "main.tf"
    source.write_text("source")
    target = tmp_path / "template.yml"
    target.write_text("existing")
    cli.transform(
        str(source),
        SourceTemplateFormat.Terraform,
        str(target),
        TargetTemplateFormat.Yaml,
        True,
        False,
        ["*.txt"],
    )
    assert initialized[0][2:] == (["*.txt"], str(target), False)
    assert saved == [(str(target), TargetTemplateFormat.Yaml)]


def test_format_command_handles_duplicate_and_skipped_inputs(tmp_path):
    source = tmp_path / "template.yml"
    source.write_text("ROSTemplateFormatVersion: '2015-09-01'\n")
    skipped = tmp_path / "skip.yml"
    skipped.write_text("not a valid template")
    result = runner.invoke(
        cli.app,
        ["format", str(source), str(source), str(skipped), "--skip", str(skipped)],
    )
    assert result.exit_code == 0
    assert result.stdout.count("Formatting ") == 1
    assert "Formatted successfully" in result.stdout


def test_server_background_start_records_state_and_opens_browser(tmp_path, monkeypatch):
    import subprocess
    import threading
    import webbrowser
    import rostran.web.server as server

    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    monkeypatch.setattr(server, "_require_web_deps", lambda: None)
    calls = []
    monkeypatch.setattr(
        subprocess,
        "Popen",
        lambda args, **kwargs: calls.append(args) or SimpleNamespace(pid=4321),
    )
    monkeypatch.setattr(webbrowser, "open", lambda url: calls.append(url))

    class ImmediateTimer:
        def __init__(self, delay, callback):
            self.callback = callback

        def start(self):
            self.callback()

    monkeypatch.setattr(threading, "Timer", ImmediateTimer)
    result = runner.invoke(
        cli.app, ["server", "start", "--host", "0.0.0.0", "--port", "8123"]
    )
    assert result.exit_code == 0, result.stdout
    assert json.loads(cli._server_pid_file().read_text())["pid"] == 4321
    assert "http://127.0.0.1:8123" in calls
    assert "--foreground" in calls[0]


def test_server_start_reports_missing_dependencies(monkeypatch):
    import rostran.web.server as server

    def missing():
        raise server.MissingDependencies("install web dependencies")

    monkeypatch.setattr(server, "_require_web_deps", missing)
    result = runner.invoke(cli.app, ["server", "start"])
    assert result.exit_code == 1
    assert "install web dependencies" in result.stdout


def test_server_stop_reports_signal_failure(tmp_path, monkeypatch):
    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    cli._server_pid_file().write_text(json.dumps({"pid": 42}))
    monkeypatch.setattr(cli, "_process_alive", lambda pid: True)

    def fail(pid, sig):
        raise OSError("permission denied")

    monkeypatch.setattr(cli.os, "kill", fail)
    result = runner.invoke(cli.app, ["server", "stop"])
    assert result.exit_code == 1
    assert "permission denied" in result.stdout


def test_rule_version_display_handles_local_and_builtin_sources(monkeypatch, capsys):
    import rostran.core.rules_updater as updater

    monkeypatch.setattr(updater, "get_local_rules_version", lambda: "1.0")
    monkeypatch.setattr(updater, "get_builtin_rules_version", lambda: "2.0")
    monkeypatch.setattr(updater, "has_user_rules", lambda: True)
    cli._show_rules_version()
    output = capsys.readouterr().out
    assert "local cache" in output and "1.0" in output and "2.0" in output
    monkeypatch.setattr(updater, "has_user_rules", lambda: False)
    monkeypatch.setattr(updater, "get_builtin_rules_version", lambda: None)
    cli._show_rules_version()
    assert "Package ver" in capsys.readouterr().out


def test_rule_listing_empty_remote_and_selected_classifiers(monkeypatch):
    import rostran.core.rules_updater as updater

    monkeypatch.setattr(updater, "fetch_available_versions", lambda: [])
    assert "No rules versions" in runner.invoke(cli.app, ["rules", "list"]).stdout
    shown = []
    monkeypatch.setattr(
        cli.RuleManager,
        "initialize",
        lambda classifier: SimpleNamespace(
            show=lambda *args: shown.append((classifier, args))
        ),
    )
    result = runner.invoke(cli.app, ["rules", "--markdown", "--with-link"])
    assert result.exit_code == 0
    assert [entry[0] for entry in shown] == [
        cli.RuleClassifier.TerraformAliCloud,
        cli.RuleClassifier.CloudFormation,
    ]


def test_program_name_process_state_and_frozen_command(monkeypatch):
    monkeypatch.setenv(cli.COMPAT_MODE_ENV, "  wrapper  ")
    assert cli.get_program_name() == "wrapper rostran"
    monkeypatch.setattr(cli.os, "kill", lambda pid, signal: None)
    assert cli._process_alive(123)

    def fail(pid, signal):
        raise OSError("missing")

    monkeypatch.setattr(cli.os, "kill", fail)
    assert not cli._process_alive(123)
    monkeypatch.setattr(cli.sys, "frozen", True, raising=False)
    assert cli._self_command(["server", "status"]) == [
        cli.sys.executable,
        "server",
        "status",
    ]
    monkeypatch.setattr(cli.sys, "frozen", False, raising=False)
    assert cli._self_command(["server", "status"])[1:3] == [
        "-m",
        "rostran.cli.__main__",
    ]


@pytest.mark.parametrize(
    "error",
    [
        exceptions.RosTranWarning(message="warning"),
        exceptions.TemplateNotExist(path="missing"),
        ValueError("unexpected"),
    ],
)
def test_main_reports_cli_errors(monkeypatch, capsys, error):
    def command(**kwargs):
        raise error

    monkeypatch.setattr(cli.typer.main, "get_command", lambda app: command)
    cli.main()
    assert str(error) in capsys.readouterr().out


def test_format_empty_directory_reports_no_templates(tmp_path):
    (tmp_path / "readme.txt").write_text("not a template")
    result = runner.invoke(cli.app, ["format", str(tmp_path)])
    assert result.exit_code == 0
    assert "No templates were found" in result.stdout


def test_server_stop_escalates_if_process_does_not_exit(tmp_path, monkeypatch):
    import signal
    import time

    monkeypatch.setattr(Path, "home", lambda: tmp_path)
    cli._server_pid_file().write_text(json.dumps({"pid": 42}))
    monkeypatch.setattr(cli, "_process_alive", lambda pid: True)
    signals = []
    monkeypatch.setattr(cli.os, "kill", lambda pid, sig: signals.append(sig))
    monkeypatch.setattr(time, "sleep", lambda seconds: None)
    result = runner.invoke(cli.app, ["server", "stop"])
    assert result.exit_code == 0
    assert signals == [signal.SIGTERM, signal.SIGKILL]
    assert not cli._server_pid_file().exists()


def test_invalid_source_suffix_and_explicit_default_targets(tmp_path, monkeypatch):
    import rostran.providers as providers

    source = tmp_path / "source.unknown"
    source.write_text("source")
    with pytest.raises(exceptions.TemplateNotSupport):
        cli.transform(
            str(source),
            SourceTemplateFormat.Auto,
            None,
            TargetTemplateFormat.Auto,
            False,
            False,
            None,
        )
    source = tmp_path / "source.yml"
    source.write_text("{}")
    saved = []
    result = SimpleNamespace(save=lambda path, fmt: saved.append((path, fmt)))
    monkeypatch.setattr(
        providers,
        "CloudFormationTemplate",
        SimpleNamespace(
            initialize=lambda *args: SimpleNamespace(transform=lambda: result)
        ),
    )
    monkeypatch.chdir(tmp_path)
    cli.transform(
        str(source),
        SourceTemplateFormat.Auto,
        None,
        TargetTemplateFormat.Json,
        False,
        False,
        None,
    )
    assert saved == [(str(tmp_path / "template.json"), TargetTemplateFormat.Json)]


def test_explicit_ros_source_loads_yaml_and_accepts_directory_target(
    tmp_path, monkeypatch
):
    from rostran.providers.ros import template as ros_template

    seen = []
    monkeypatch.setattr(
        ros_template.ROS2TerraformTemplate,
        "initialize",
        lambda source: SimpleNamespace(
            transform=lambda path: seen.append((source, path))
        ),
    )
    source = tmp_path / "ros.yml"
    source.write_text("ROSTemplateFormatVersion: '2015-09-01'\n")
    target = tmp_path / "out"
    cli.transform(
        str(source),
        SourceTemplateFormat.ROS,
        str(target),
        TargetTemplateFormat.Auto,
        False,
        False,
        None,
    )
    assert seen[0][0]["ROSTemplateFormatVersion"] == "2015-09-01"
    assert seen[0][1] == str(target)
    source.write_text("[")
    with pytest.raises(exceptions.TemplateNotSupport):
        cli.transform(
            str(source),
            SourceTemplateFormat.ROS,
            str(target),
            TargetTemplateFormat.Auto,
            False,
            False,
            None,
        )


def test_rules_display_builtin_version_and_empty_selection(monkeypatch, capsys):
    import rostran.core.rules_updater as updater

    monkeypatch.setattr(updater, "get_local_rules_version", lambda: None)
    monkeypatch.setattr(updater, "get_builtin_rules_version", lambda: "1.0")
    monkeypatch.setattr(updater, "has_user_rules", lambda: False)
    cli._show_rules_version()
    assert "Rules version: 1.0" in capsys.readouterr().out
    context = SimpleNamespace(invoked_subcommand=None)
    cli.rules(
        context,
        terraform=False,
        cloudformation=False,
        markdown=False,
        with_link=False,
        version=False,
    )
    assert capsys.readouterr().out == ""
