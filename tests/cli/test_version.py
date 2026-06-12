from typer.testing import CliRunner

from rostran import __version__
from rostran.cli.__main__ import app, get_program_name


runner = CliRunner()


def test_global_version_option_shows_package_version():
    result = runner.invoke(app, ["--version"])

    assert result.exit_code == 0
    assert result.output == f"rostran {__version__}\n"


def test_get_program_name_uses_compat_mode_prefix(monkeypatch):
    monkeypatch.setenv("ALIBABA_CLOUD_ROSTRAN_COMPAT_MODE", "aliyun")

    assert get_program_name() == "aliyun rostran"


def test_global_version_option_uses_compat_program_name():
    result = runner.invoke(
        app,
        ["--version"],
        env={"ALIBABA_CLOUD_ROSTRAN_COMPAT_MODE": "aliyun"},
    )

    assert result.exit_code == 0
    assert result.output == f"aliyun rostran {__version__}\n"


def test_help_uses_compat_program_name(monkeypatch):
    monkeypatch.setenv("ALIBABA_CLOUD_ROSTRAN_COMPAT_MODE", "aliyun")

    result = runner.invoke(app, ["--help"], prog_name=get_program_name())

    assert result.exit_code == 0
    assert "aliyun rostran" in result.output
