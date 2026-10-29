import runpy
import subprocess
import sys
from types import SimpleNamespace
from unittest.mock import Mock

import pytest
import setuptools

import build


def test_setup_build_frontend_handles_missing_assets_and_failures(
    tmp_path, monkeypatch, capsys
):
    setup_call = Mock()
    monkeypatch.setattr(setuptools, "setup", setup_call)
    setup = runpy.run_path("setup.py")
    assert setup_call.call_args.kwargs["name"] == "alibabacloud_ros_tran"
    build_frontend = setup["_build_frontend"]
    monkeypatch.setitem(build_frontend.__globals__, "HERE", tmp_path)
    build_frontend()  # no frontend directory
    frontend = tmp_path / "frontend"
    frontend.mkdir()
    (frontend / "package.json").write_text("{}")
    monkeypatch.setattr(setup["shutil"], "which", lambda command: None)
    build_frontend()
    assert "npm not found" in capsys.readouterr().err
    monkeypatch.setattr(setup["shutil"], "which", lambda command: "npm")
    calls = []
    monkeypatch.setattr(
        setup["subprocess"], "check_call", lambda args, cwd: calls.append(args)
    )
    build_frontend()
    assert calls == [["npm", "ci"], ["npm", "run", "build"]]

    def fail(*args, **kwargs):
        raise subprocess.CalledProcessError(1, "npm")

    monkeypatch.setattr(setup["subprocess"], "check_call", fail)
    build_frontend()
    assert "web UI build failed" in capsys.readouterr().err
    static = tmp_path / "rostran" / "web" / "static"
    static.mkdir(parents=True)
    (static / "index.html").touch()
    build_frontend()


def test_build_main_packages_a_fake_bundle(tmp_path, monkeypatch):
    monkeypatch.setattr(build, "__file__", str(tmp_path / "build.py"))
    monkeypatch.setattr(build.platform, "system", lambda: "Linux")
    monkeypatch.setattr(build.platform, "machine", lambda: "x86_64")
    monkeypatch.setattr(build, "_collect_hiddenimports", lambda: ["example"])
    monkeypatch.setitem(
        sys.modules, "PyInstaller", SimpleNamespace(__version__="6.11.1")
    )
    (tmp_path / "build").mkdir()
    (tmp_path / "dist").mkdir()
    (tmp_path / "dist" / "old").write_text("old")

    def fake_build(args):
        binary = tmp_path / "dist" / "rostran" / "rostran"
        binary.parent.mkdir(parents=True)
        binary.write_bytes(b"binary")

    monkeypatch.setattr(build.subprocess, "check_call", fake_build)
    build.main()
    assert (tmp_path / "dist" / "version.txt").read_text() == build.BUILD_VERSION
    assert list((tmp_path / "dist").glob("rostran-*-linux-amd64.tar.gz"))
    assert not (tmp_path / "dist" / "old").exists()


def test_build_main_rejects_unsupported_system_and_missing_output(
    tmp_path, monkeypatch, capsys
):
    monkeypatch.setattr(build, "__file__", str(tmp_path / "build.py"))
    monkeypatch.setattr(build.platform, "system", lambda: "Windows")
    with pytest.raises(SystemExit):
        build.main()
    assert "Windows" in capsys.readouterr().err
    monkeypatch.setattr(build.platform, "system", lambda: "Linux")
    monkeypatch.setitem(sys.modules, "PyInstaller", SimpleNamespace(__version__="old"))
    monkeypatch.setattr(build, "_collect_hiddenimports", lambda: [])
    monkeypatch.setattr(build.subprocess, "check_call", lambda args: None)
    with pytest.raises(SystemExit):
        build.main()
    assert "binary not found" in capsys.readouterr().err


def test_build_requires_pyinstaller(tmp_path, monkeypatch, capsys):
    monkeypatch.setattr(build, "__file__", str(tmp_path / "build.py"))
    monkeypatch.setattr(build.platform, "system", lambda: "Linux")
    monkeypatch.setitem(sys.modules, "PyInstaller", None)
    with pytest.raises(SystemExit):
        build.main()
    assert "PyInstaller is required" in capsys.readouterr().err


def test_collect_hidden_imports_includes_only_available_optional_packages(monkeypatch):
    import importlib.util
    import types

    hooks = types.ModuleType("PyInstaller.utils.hooks")
    hooks.collect_submodules = lambda package: [f"{package}.submodule"]
    monkeypatch.setitem(sys.modules, "PyInstaller", types.ModuleType("PyInstaller"))
    monkeypatch.setitem(
        sys.modules, "PyInstaller.utils", types.ModuleType("PyInstaller.utils")
    )
    monkeypatch.setitem(sys.modules, "PyInstaller.utils.hooks", hooks)
    monkeypatch.setattr(build, "HIDDENIMPORT_PACKAGES", ["required"])
    monkeypatch.setattr(build, "WEB_HIDDENIMPORT_PACKAGES", ["present", "missing"])
    monkeypatch.setattr(
        importlib.util,
        "find_spec",
        lambda name: object() if name == "present" else None,
    )
    result = build._collect_hiddenimports()
    assert "required.submodule" in result and "present.submodule" in result
    assert "missing.submodule" not in result
    assert "tools.utils" in result
