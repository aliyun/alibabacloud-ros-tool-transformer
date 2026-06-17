#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Build rostran with PyInstaller and package its onedir bundle."""

import os
import platform
import shutil
import subprocess
import sys
import tarfile
from pathlib import Path

from rostran import __version__

PYINSTALLER_REQUIRED_VERSION = "6.11.1"
BUILD_VERSION = os.environ.get("ROSTRAN_BUILD_VERSION", "").strip() or __version__
SUPPORTED_SYSTEMS = {"darwin", "linux"}
HIDDENIMPORT_PACKAGES = [
    "rostran",
    "libterraform",
    "openpyxl",
    "ruamel",
    "alibabacloud_ros20190910",
    "alibabacloud_credentials",
    "alibabacloud_tea_openapi",
    "alibabacloud_tea_util",
    "Tea",
]
EXPLICIT_HIDDENIMPORTS = [
    "tools",
    "tools.settings",
    "tools.utils",
    "xml.dom.minidom",
    "configparser",
    "cgi",
]
# Optional web service packages; only bundled when installed (the `serve` extra).
WEB_HIDDENIMPORT_PACKAGES = [
    "fastapi",
    "starlette",
    "uvicorn",
    "multipart",
    "anyio",
]


class UnsupportedBuildPlatform(Exception):
    pass


def main():
    root = Path(__file__).parent
    dist_dir = root / "dist"
    build_dir = root / "build"
    system = platform.system().lower()

    try:
        _validate_system(system)
    except UnsupportedBuildPlatform as exc:
        print(f"Error: {exc}", file=sys.stderr)
        sys.exit(1)

    try:
        import PyInstaller
    except ImportError:
        print(
            "Error: PyInstaller is required. Install with: "
            f"pip install pyinstaller=={PYINSTALLER_REQUIRED_VERSION}",
            file=sys.stderr,
        )
        sys.exit(1)

    if PyInstaller.__version__ != PYINSTALLER_REQUIRED_VERSION:
        print(
            f"Warning: PyInstaller {PyInstaller.__version__} detected; "
            f"recommended version is {PYINSTALLER_REQUIRED_VERSION}. "
            "Build artifacts may differ from those produced by CI.",
            file=sys.stderr,
        )

    if build_dir.exists():
        shutil.rmtree(build_dir)
    if dist_dir.exists():
        shutil.rmtree(dist_dir)

    machine = _normalize_arch(platform.machine())

    print(f"Building rostran on {system} {machine}...")
    hiddenimports = _collect_hiddenimports()
    subprocess.check_call(
        _build_pyinstaller_args(root, dist_dir, build_dir, hiddenimports)
    )

    bundle_name = "rostran"
    binary_name = "rostran"
    bundle_dir = dist_dir / bundle_name
    binary_path = bundle_dir / binary_name

    if not binary_path.exists():
        print(f"\nBuild failed: binary not found at {binary_path}.", file=sys.stderr)
        sys.exit(1)

    if not bundle_dir.is_dir():
        print(
            f"\nBuild failed: bundle directory not found at {bundle_dir}.",
            file=sys.stderr,
        )
        sys.exit(1)

    size_mb = _directory_size(bundle_dir) / (1024 * 1024)
    print(f"\nBuild succeeded: {bundle_dir} ({size_mb:.1f} MB)")

    archive_path = _create_archive(dist_dir, bundle_dir, system, machine)
    archive_size_mb = archive_path.stat().st_size / (1024 * 1024)
    print(f"Archive created: {archive_path} ({archive_size_mb:.1f} MB)")

    version_file = dist_dir / "version.txt"
    version_file.write_text(BUILD_VERSION, encoding="utf-8")
    print(f"Version file created: {version_file}")


def _normalize_arch(machine):
    mapping = {
        "x86_64": "amd64",
        "amd64": "amd64",
        "i386": "i386",
        "i686": "i386",
        "aarch64": "arm64",
        "arm64": "arm64",
    }
    return mapping.get(machine.lower(), machine.lower())


def _validate_system(system):
    if system not in SUPPORTED_SYSTEMS:
        supported = ", ".join(sorted(SUPPORTED_SYSTEMS))
        raise UnsupportedBuildPlatform(
            f"Windows binary builds are not supported. Supported systems: {supported}."
        )


def _collect_hiddenimports():
    import importlib.util

    from PyInstaller.utils.hooks import collect_submodules

    hiddenimports = []
    for package in HIDDENIMPORT_PACKAGES:
        hiddenimports += collect_submodules(package)

    # Bundle the web stack only when it is available in the build environment.
    for package in WEB_HIDDENIMPORT_PACKAGES:
        if importlib.util.find_spec(package) is not None:
            hiddenimports += collect_submodules(package)

    return hiddenimports + EXPLICIT_HIDDENIMPORTS


def _build_pyinstaller_args(root, dist_dir, build_dir, hiddenimports):
    args = [
        sys.executable,
        "-m",
        "PyInstaller",
        str(root / "rostran/cli/__main__.py"),
        "--name",
        "rostran",
        "--distpath",
        str(dist_dir),
        "--workpath",
        str(build_dir),
        "--clean",
        "--noconfirm",
        "--onedir",
        "--console",
        "--contents-directory",
        "_internal",
        "--add-data",
        f"{root / 'rostran/rules'}{os.pathsep}rostran/rules",
    ]
    # Bundle the built web UI when it exists so the binary can `serve` it.
    static_dir = root / "rostran/web/static"
    if (static_dir / "index.html").exists():
        args.extend(["--add-data", f"{static_dir}{os.pathsep}rostran/web/static"])
    for hiddenimport in hiddenimports:
        args.extend(["--hidden-import", hiddenimport])
    return args


def _directory_size(path):
    return sum(item.stat().st_size for item in path.rglob("*") if item.is_file())


def _create_archive(dist_dir, bundle_dir, system, machine):
    archive_name = f"rostran-{BUILD_VERSION}-{system}-{machine}"
    archive_path = dist_dir / f"{archive_name}.tar.gz"
    with tarfile.open(archive_path, "w:gz") as tf:
        tf.add(bundle_dir, arcname=bundle_dir.name)

    return archive_path


if __name__ == "__main__":
    main()
