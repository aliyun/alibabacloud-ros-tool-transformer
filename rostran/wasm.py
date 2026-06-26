"""Browser-safe entrypoint for the documentation playground.

The public docs run this module inside Pyodide. Keep imports narrow and lazy so
the browser bundle never pulls optional native dependencies such as
``libterraform`` or ``openpyxl``.
"""

from __future__ import annotations

import contextlib
import io
import json
import sys
import types
from importlib import import_module
from typing import Any


class PlaygroundError(Exception):
    def __init__(self, message: str, error_type: str = "PlaygroundError"):
        super().__init__(message)
        self.message = message
        self.error_type = error_type


def _install_browser_stubs() -> None:
    """Install tiny stand-ins for optional CLI/Excel dependencies.

    The CloudFormation and ROS-format paths only need ``typer.secho`` for logs
    and the ``openpyxl.cell.cell.Cell`` type at import time. Providing stubs
    keeps the Pyodide package small and avoids native wheels.
    """

    if "typer" not in sys.modules:
        typer = types.ModuleType("typer")

        def echo(message: Any = "", **_: Any) -> None:
            print(message)

        setattr(typer, "echo", echo)
        setattr(typer, "secho", echo)
        setattr(
            typer,
            "colors",
            types.SimpleNamespace(
                BLUE="blue",
                BRIGHT_BLACK="bright_black",
                GREEN="green",
                RED="red",
                YELLOW="yellow",
            ),
        )
        sys.modules["typer"] = typer

    if "openpyxl.cell.cell" not in sys.modules:
        openpyxl = types.ModuleType("openpyxl")
        cell_pkg = types.ModuleType("openpyxl.cell")
        cell_mod = types.ModuleType("openpyxl.cell.cell")

        class Cell:
            value: Any = None

        setattr(cell_mod, "Cell", Cell)
        setattr(cell_pkg, "cell", cell_mod)
        setattr(openpyxl, "cell", cell_pkg)
        sys.modules.setdefault("openpyxl", openpyxl)
        sys.modules.setdefault("openpyxl.cell", cell_pkg)
        sys.modules.setdefault("openpyxl.cell.cell", cell_mod)


def _detect_input_format(content: str, requested: str | None) -> str:
    if requested and requested != "auto":
        return requested
    stripped = content.lstrip()
    return "json" if stripped.startswith(("{", "[")) else "yaml"


def _target_filename(target_format: str) -> str:
    return "template.json" if target_format == "json" else "template.yml"


def _dump_ros(data: dict, target_format: str) -> str:
    if target_format == "json":
        return json.dumps(data, indent=2, ensure_ascii=False) + "\n"
    yaml = import_module("rostran.providers.ros.yaml_util").yaml
    out = io.StringIO()
    yaml.dump(data, out)
    return out.getvalue()


def _load_cloudformation(content: str, input_format: str) -> dict:
    if input_format == "json":
        return json.loads(content)
    if input_format in {"yaml", "yml"}:
        cf_mod = import_module("rostran.providers.cloudformation.template")
        return cf_mod.yaml.load(content)
    raise PlaygroundError(
        f"Unsupported CloudFormation input format: {input_format}",
        "UnsupportedInputFormat",
    )


def _load_ros(content: str, input_format: str) -> dict:
    if input_format == "json":
        return json.loads(content)
    if input_format in {"yaml", "yml"}:
        yaml = import_module("rostran.providers.ros.yaml_util").yaml
        return yaml.load(content)
    raise PlaygroundError(
        f"Unsupported ROS input format: {input_format}", "UnsupportedInputFormat"
    )


def _transform_cloudformation(
    content: str, input_format: str, target_format: str
) -> dict:
    cf_mod = import_module("rostran.providers.cloudformation.template")
    rm_mod = import_module("rostran.core.rule_manager")

    source = _load_cloudformation(content, input_format)
    rule_manager = rm_mod.RuleManager.initialize(rm_mod.RuleClassifier.CloudFormation)
    template = cf_mod.CloudFormationTemplate(source=source, rule_manager=rule_manager)
    transformed = template.transform().as_dict(format=True)
    return {
        "targets": [
            {
                "filename": _target_filename(target_format),
                "content": _dump_ros(transformed, target_format),
            }
        ]
    }


def _format_ros(content: str, input_format: str, target_format: str) -> dict:
    template_mod = import_module("rostran.core.template")
    source = _load_ros(content, input_format)
    template = template_mod.RosTemplate.initialize(source)
    formatted = template.as_dict(format=True)
    return {
        "targets": [
            {
                "filename": _target_filename(target_format),
                "content": _dump_ros(formatted, target_format),
            }
        ]
    }


def _unsupported_source(source_format: str) -> None:
    raise PlaygroundError(
        (
            f"{source_format} conversion is not available in the static playground. "
            "Run `rostran server start` for Terraform, Excel, ROS-to-Terraform, "
            "and other full web-service features."
        ),
        "UnsupportedSourceFormat",
    )


def run(payload: dict) -> dict:
    _install_browser_stubs()

    operation = payload.get("operation")
    source_format = payload.get("sourceFormat")
    target_format = payload.get("targetFormat") or "yaml"
    content = payload.get("content") or ""
    input_format = _detect_input_format(content, payload.get("inputFormat"))

    if target_format == "auto":
        target_format = "yaml"
    if target_format not in {"json", "yaml"}:
        raise PlaygroundError(
            f"Unsupported target format: {target_format}", "UnsupportedTargetFormat"
        )
    if not content.strip():
        raise PlaygroundError("Source template is empty.", "InvalidRequest")

    if operation == "transform" and source_format == "cloudformation":
        return _transform_cloudformation(content, input_format, target_format)
    if operation == "format" and source_format == "ros":
        return _format_ros(content, input_format, target_format)
    if source_format in {"terraform", "excel", "ros", "rosTerraform"}:
        _unsupported_source(source_format)

    raise PlaygroundError(
        "The static playground supports CloudFormation to ROS conversion and "
        "ROS formatting only.",
        "UnsupportedOperation",
    )


def handle(payload_json: str) -> str:
    log = io.StringIO()
    try:
        payload = json.loads(payload_json)
        with contextlib.redirect_stdout(log):
            result = run(payload)
        return json.dumps({"ok": True, "log": log.getvalue(), **result})
    except PlaygroundError as exc:
        return json.dumps(
            {
                "ok": False,
                "log": log.getvalue(),
                "error": {"type": exc.error_type, "message": exc.message},
            }
        )
    except Exception as exc:  # noqa: BLE001 - surfaced to the browser UI
        return json.dumps(
            {
                "ok": False,
                "log": log.getvalue(),
                "error": {"type": exc.__class__.__name__, "message": str(exc)},
            }
        )
