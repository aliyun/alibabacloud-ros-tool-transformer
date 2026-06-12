import os
from pathlib import Path
import tarfile

import build


def test_normalize_arch_uses_release_platform_names():
    assert build._normalize_arch("x86_64") == "amd64"
    assert build._normalize_arch("AMD64") == "amd64"
    assert build._normalize_arch("aarch64") == "arm64"
    assert build._normalize_arch("arm64") == "arm64"
    assert build._normalize_arch("riscv64") == "riscv64"


def test_create_archive_preserves_rostran_bundle_directory(tmp_path, monkeypatch):
    monkeypatch.setattr(build, "BUILD_VERSION", "9.9.9")
    bundle_dir = tmp_path / "rostran"
    internal_dir = bundle_dir / "_internal"
    internal_dir.mkdir(parents=True)
    binary_path = bundle_dir / "rostran"
    binary_path.write_text("binary")
    (internal_dir / "libpython.so").write_text("runtime")

    archive_path = build._create_archive(tmp_path, bundle_dir, "linux", "amd64")

    assert archive_path == tmp_path / "rostran-9.9.9-linux-amd64.tar.gz"
    with tarfile.open(archive_path, "r:gz") as tf:
        assert sorted(tf.getnames()) == [
            "rostran",
            "rostran/_internal",
            "rostran/_internal/libpython.so",
            "rostran/rostran",
        ]


def test_validate_system_rejects_windows():
    assert build._validate_system("linux") is None
    assert build._validate_system("darwin") is None

    try:
        build._validate_system("windows")
    except build.UnsupportedBuildPlatform as exc:
        assert "Windows binary builds are not supported" in str(exc)
    else:
        raise AssertionError("Windows should not be supported")


def test_pyinstaller_args_include_cli_entrypoint_rules_data_and_hiddenimports(tmp_path):
    root = Path(__file__).parents[1]
    args = build._build_pyinstaller_args(
        root,
        tmp_path / "dist",
        tmp_path / "build",
        ["tools.utils", "xml.dom.minidom"],
    )

    assert str(root / "rostran/cli/__main__.py") in args
    assert "rostran.spec" not in " ".join(args)
    assert args[args.index("--name") + 1] == "rostran"
    assert args[args.index("--contents-directory") + 1] == "_internal"
    assert args[args.index("--add-data") + 1] == (
        f"{root / 'rostran/rules'}{os.pathsep}rostran/rules"
    )
    assert args.count("--hidden-import") == 2
    assert "tools.utils" in args
    assert "xml.dom.minidom" in args
