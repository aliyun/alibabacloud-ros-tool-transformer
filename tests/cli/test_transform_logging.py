from typer.testing import CliRunner
from pathlib import Path

from rostran.cli.__main__ import app


runner = CliRunner()


def test_transform_command_streams_terraform_runner_logs(tmp_path, monkeypatch):
    import rostran.providers as providers
    from rostran.core import terraform as terraform_mod

    calls = []

    class FakeTerraformCommand:
        def __init__(self, cwd=None):
            calls.append(("command", cwd))

        def stream(
            self, cmd, args=None, options=None, chdir=None, json=False, check=False
        ):
            calls.append((cmd, args, options, chdir, json, check))
            return iter(["Initializing provider plugins..."])

    class FakeRosTemplate:
        def save(self, target_path, target_format):
            calls.append(("save", target_path, target_format))
            Path(target_path).write_text("ok: true\n", encoding="utf-8")

    class FakeTerraformTemplate:
        @classmethod
        def initialize(cls, source_path, source_file_format):
            calls.append(("initialize", source_path, source_file_format))
            return cls()

        def transform(self):
            with terraform_mod.TerraformRunner(stream_output=True) as tf_runner:
                tf_runner.run("/tmp/module", "init", check=True)
            return FakeRosTemplate()

    source = tmp_path / "main.tf"
    source.write_text('resource "x" "y" {}\n', encoding="utf-8")
    target = tmp_path / "template.yml"

    monkeypatch.setattr(terraform_mod, "TerraformCommand", FakeTerraformCommand)
    monkeypatch.setattr(providers, "TerraformTemplate", FakeTerraformTemplate)

    result = runner.invoke(
        app,
        [
            "transform",
            str(source),
            "--target-path",
            str(target),
            "--target-format",
            "yaml",
            "--force",
        ],
    )

    assert result.exit_code == 0, result.output
    assert "Running terraform init..." in result.output
    assert "Initializing provider plugins..." in result.output
    assert target.read_text(encoding="utf-8") == "ok: true\n"
