#!/usr/bin/env python3
"""Build static Python assets for the browser playground."""

from __future__ import annotations

import json
import shutil
import zipfile
from pathlib import Path

PYODIDE_VERSION = "314.0.0"
PACKAGE_NAME = "rostran-playground.zip"

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUT_DIR = Path(__file__).resolve().parents[1] / "static" / "playground"

PYTHON_FILES = [
    "rostran/__init__.py",
    "rostran/wasm.py",
    "rostran/core/conditions.py",
    "rostran/core/exceptions.py",
    "rostran/core/format.py",
    "rostran/core/mappings.py",
    "rostran/core/metadata.py",
    "rostran/core/outputs.py",
    "rostran/core/parameters.py",
    "rostran/core/properties.py",
    "rostran/core/resources.py",
    "rostran/core/rule_manager.py",
    "rostran/core/rules.py",
    "rostran/core/settings.py",
    "rostran/core/template.py",
    "rostran/core/utils.py",
    "rostran/core/workspace.py",
    "rostran/handlers/basic.py",
    "rostran/handlers/merge.py",
    "rostran/handlers/resource.py",
    "rostran/providers/__init__.py",
    "rostran/providers/cloudformation/__init__.py",
    "rostran/providers/cloudformation/template.py",
    "rostran/providers/ros/__init__.py",
    "rostran/providers/ros/yaml_util.py",
]

RULE_DIRS = [
    "rostran/rules/cloudformation",
]

RULE_FILES = [
    "rostran/rules/VERSIONS.json",
    "rostran/rules/ros/__init__.py",
]


def _write_file(package: zipfile.ZipFile, rel_path: str) -> None:
    package.write(ROOT / rel_path, rel_path)


def build(out_dir: Path = DEFAULT_OUT_DIR) -> dict[str, str]:
    out_dir = Path(out_dir)
    if out_dir.exists():
        shutil.rmtree(out_dir)
    out_dir.mkdir(parents=True)

    package_path = out_dir / PACKAGE_NAME
    with zipfile.ZipFile(
        package_path, "w", compression=zipfile.ZIP_DEFLATED
    ) as package:
        for rel_path in PYTHON_FILES + RULE_FILES:
            _write_file(package, rel_path)
        for rel_dir in RULE_DIRS:
            for path in sorted((ROOT / rel_dir).rglob("*")):
                if path.is_file():
                    package.write(path, path.relative_to(ROOT).as_posix())

    manifest = {
        "pyodideVersion": PYODIDE_VERSION,
        "pyodideIndexUrl": f"https://cdn.jsdelivr.net/pyodide/v{PYODIDE_VERSION}/full/",
        "pythonPackage": PACKAGE_NAME,
    }
    (out_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
    )
    return manifest


def main() -> None:
    manifest = build()
    print(
        "Built playground assets: "
        f"{DEFAULT_OUT_DIR / manifest['pythonPackage']} "
        f"(Pyodide {manifest['pyodideVersion']})"
    )


if __name__ == "__main__":
    main()
