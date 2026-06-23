from types import SimpleNamespace

import pytest


def test_terraform_runner_awaits_async_command_on_pool(monkeypatch):
    import asyncio

    from rostran.core import terraform as terraform_mod

    calls = []

    class FakePool:
        def __init__(self, max_workers=None):
            calls.append(("init", max_workers))

        def shutdown(self, wait=True):
            calls.append(("shutdown", wait))

    class FakeAsyncTerraformCommand:
        def __init__(self, cwd=None, pool=None):
            calls.append(("command", cwd, pool))

        async def validate(self, **kwargs):
            calls.append(("validate", kwargs))
            return SimpleNamespace(value={"valid": True})

    monkeypatch.setattr(terraform_mod, "TerraformPool", FakePool)
    monkeypatch.setattr(
        terraform_mod, "AsyncTerraformCommand", FakeAsyncTerraformCommand
    )

    async def run():
        with terraform_mod.TerraformRunner(max_workers=2) as runner:
            return await runner.run_async("/tmp/module", "validate", check=True)

    result = asyncio.run(run())

    assert result.value == {"valid": True}
    pool = calls[0]
    assert pool == ("init", 2)
    assert calls[1][0:2] == ("command", "/tmp/module")
    assert isinstance(calls[1][2], FakePool)
    assert calls == [
        ("init", 2),
        ("command", "/tmp/module", calls[1][2]),
        ("validate", {"check": True}),
        ("shutdown", True),
    ]


def test_terraform_runner_sync_run_delegates_to_async_command(monkeypatch):
    from rostran.core import terraform as terraform_mod

    calls = []

    class FakePool:
        def __init__(self, max_workers=None):
            calls.append(("init", max_workers))

        def shutdown(self, wait=True):
            calls.append(("shutdown", wait))

    class FakeAsyncTerraformCommand:
        def __init__(self, cwd=None, pool=None):
            calls.append(("command", cwd, pool))

        async def fmt(self, **kwargs):
            calls.append(("fmt", kwargs))
            return "formatted"

    monkeypatch.setattr(terraform_mod, "TerraformPool", FakePool)
    monkeypatch.setattr(
        terraform_mod, "AsyncTerraformCommand", FakeAsyncTerraformCommand
    )

    with terraform_mod.TerraformRunner(max_workers=1) as runner:
        result = runner.run("/tmp/module", "fmt", check=True)

    assert result == "formatted"
    assert calls[0] == ("init", 1)
    assert calls[1][0:2] == ("command", "/tmp/module")
    assert calls == [
        ("init", 1),
        ("command", "/tmp/module", calls[1][2]),
        ("fmt", {"check": True}),
        ("shutdown", True),
    ]


def test_terraform_runner_shuts_pool_down_after_command_error(monkeypatch):
    import asyncio

    from rostran.core import terraform as terraform_mod

    calls = []
    error = RuntimeError("boom")

    class FakePool:
        def __init__(self, max_workers=None):
            calls.append(("init", max_workers))

        def shutdown(self, wait=True):
            calls.append(("shutdown", wait))

    class FakeAsyncTerraformCommand:
        def __init__(self, cwd=None, pool=None):
            calls.append(("command", cwd, pool))

        async def plan(self):
            calls.append(("plan",))
            raise error

    monkeypatch.setattr(terraform_mod, "TerraformPool", FakePool)
    monkeypatch.setattr(
        terraform_mod, "AsyncTerraformCommand", FakeAsyncTerraformCommand
    )

    async def run():
        with terraform_mod.TerraformRunner() as runner:
            await runner.run_async("/tmp/module", "plan")

    with pytest.raises(RuntimeError, match="boom"):
        asyncio.run(run())

    assert calls[0] == ("init", None)
    assert calls[1][0:2] == ("command", "/tmp/module")
    assert calls == [
        ("init", None),
        ("command", "/tmp/module", calls[1][2]),
        ("plan",),
        ("shutdown", True),
    ]


def test_terraform_runner_streams_command_output_to_stdout(monkeypatch, capsys):
    from rostran.core import terraform as terraform_mod

    calls = []

    class FakeTerraformCommand:
        def __init__(self, cwd=None):
            calls.append(("command", cwd))

        def stream(
            self, cmd, args=None, options=None, chdir=None, json=False, check=False
        ):
            calls.append((cmd, args, options, chdir, json, check))
            return iter(
                ["Initializing provider plugins...", "Terraform has been initialized!"]
            )

    monkeypatch.setattr(terraform_mod, "TerraformCommand", FakeTerraformCommand)

    with terraform_mod.TerraformRunner(stream_output=True) as runner:
        result = runner.run("/tmp/module", "init", check=True)

    captured = capsys.readouterr()

    assert (
        result.value
        == "Initializing provider plugins...\nTerraform has been initialized!\n"
    )
    assert "Running terraform init..." in captured.out
    assert "Initializing provider plugins..." in captured.out
    assert "Terraform has been initialized!" in captured.out
    assert calls == [
        ("command", "/tmp/module"),
        ("init", None, {"input": False, "no_color": ...}, "/tmp/module", False, True),
    ]


def test_terraform_runner_stream_mode_can_still_run_structured_commands(monkeypatch):
    from rostran.core import terraform as terraform_mod

    calls = []

    class FakeAsyncTerraformCommand:
        def __init__(self, cwd=None, pool=None):
            calls.append(("command", cwd, pool))

        async def show(self, path, **kwargs):
            calls.append(("show", path, kwargs))
            return SimpleNamespace(value={"format_version": "1.2"})

    monkeypatch.setattr(
        terraform_mod, "AsyncTerraformCommand", FakeAsyncTerraformCommand
    )

    with terraform_mod.TerraformRunner(stream_output=True) as runner:
        result = runner.run("/tmp/module", "show", "/tmp/plan", check=True)

    assert result.value == {"format_version": "1.2"}
    assert calls == [
        ("command", "/tmp/module", None),
        ("show", "/tmp/plan", {"check": True}),
    ]


def test_terraform_template_loads_json_plan_without_running_show(tmp_path, monkeypatch):
    import json

    import rostran.providers.terraform.template as terraform_template_mod

    plan = {
        "format_version": "1.2",
        "configuration": {"provider_config": {"alicloud": {}}},
        "planned_values": {"root_module": {"resources": []}, "outputs": {}},
    }
    plan_path = tmp_path / "main.tfplan.json"
    plan_path.write_text(json.dumps(plan), encoding="utf-8")

    def fail_runner(*_args, **_kwargs):
        raise AssertionError("Terraform show should not run for JSON plan files")

    monkeypatch.setattr(terraform_template_mod, "TerraformRunner", fail_runner)
    monkeypatch.setattr(
        terraform_template_mod.TerraformConfig,
        "load_config_dir",
        staticmethod(lambda _path: ({"ManagedResources": {}, "Outputs": {}}, [])),
    )

    tf_plan, tf_data = terraform_template_mod.TerraformTemplate._get_plan_data(
        str(tmp_path), str(plan_path)
    )

    assert tf_plan == plan
    assert tf_data == {"ManagedResources": {}, "Outputs": {}}


def test_terraform_template_falls_back_to_plan_configuration(tmp_path, monkeypatch):
    import json

    import rostran.providers.terraform.template as terraform_template_mod

    plan = {
        "format_version": "1.2",
        "configuration": {
            "provider_config": {"alicloud": {}},
            "root_module": {
                "resources": [
                    {
                        "address": "alicloud_vpc.main",
                        "mode": "managed",
                        "type": "alicloud_vpc",
                        "name": "main",
                        "expressions": {
                            "cidr_block": {"constant_value": "192.168.0.0/16"},
                            "vpc_name": {"constant_value": "main"},
                        },
                    }
                ],
                "outputs": {
                    "vpc_id": {
                        "expression": {
                            "references": [
                                "alicloud_vpc.main.id",
                                "alicloud_vpc.main",
                            ]
                        }
                    }
                },
            },
        },
        "planned_values": {
            "root_module": {
                "resources": [
                    {
                        "address": "alicloud_vpc.main",
                        "mode": "managed",
                        "type": "alicloud_vpc",
                        "name": "main",
                        "values": {
                            "cidr_block": "192.168.0.0/16",
                            "vpc_name": "main",
                        },
                    }
                ]
            },
            "outputs": {"vpc_id": {"sensitive": False}},
        },
    }
    plan_path = tmp_path / "main.tfplan.json"
    plan_path.write_text(json.dumps(plan), encoding="utf-8")

    monkeypatch.setattr(terraform_template_mod, "TerraformRunner", None)
    monkeypatch.setattr(
        terraform_template_mod.TerraformConfig,
        "load_config_dir",
        staticmethod(lambda _path: (_ for _ in ()).throw(RuntimeError("bad config"))),
    )

    _tf_plan, tf_data = terraform_template_mod.TerraformTemplate._get_plan_data(
        str(tmp_path), str(plan_path)
    )

    resource = tf_data["ManagedResources"]["alicloud_vpc.main"]
    assert resource["Type"] == "alicloud_vpc"
    assert set(resource["Config"]["Attributes"]) == {"cidr_block", "vpc_name"}
    assert tf_data["Outputs"]["vpc_id"]["Expr"]["Traversal"] == [
        {"Name": "alicloud_vpc"},
        {"Name": "main"},
        {"Name": "id"},
    ]
