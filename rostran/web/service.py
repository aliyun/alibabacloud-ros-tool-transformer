"""Service layer bridging HTTP requests to the rostran library.

Transformation reuses the existing CLI ``transform`` function directly (called
as a plain Python function, not through Typer) so that all format-detection and
orchestration logic is shared with the command line, and real exceptions
propagate instead of being swallowed by the CLI ``main()`` wrapper.

All work happens inside a per-request temporary directory; nothing is persisted.
A module-level lock serializes transformations because the underlying library
relies on process-global state (rule manager, ``typer.secho`` output capture).
"""

import io
import json
import os
import tempfile
import threading
from contextlib import redirect_stdout, redirect_stderr
from dataclasses import dataclass, field
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import List, Optional, Tuple

from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat

# Underlying library uses process-global state; serialize to keep it consistent.
_transform_lock = threading.Lock()

# Captured while the working directory is guaranteed valid (at import time).
# libterraform runs terraform with `-chdir=<tmp>`, which calls os.Chdir on the
# whole process; if that temp dir is later removed the process is left with an
# invalid cwd and os.getcwd() raises. This lets us recover to a stable place.
_STABLE_CWD = os.getcwd()


def _ensure_valid_cwd() -> str:
    """Return the current working directory, recovering to a stable directory
    if the process is sitting in one that no longer exists."""
    try:
        return os.getcwd()
    except OSError:
        for fallback in (_STABLE_CWD, tempfile.gettempdir()):
            try:
                os.chdir(fallback)
                return fallback
            except OSError:
                continue
        raise


def _restore_cwd(target: str) -> None:
    """Restore the working directory, falling back to a stable directory."""
    for candidate in (target, _STABLE_CWD, tempfile.gettempdir()):
        try:
            os.chdir(candidate)
            return
        except OSError:
            continue


# Source formats that consume a directory of files (e.g. multiple .tf files).
_DIRECTORY_SOURCES = {SourceTemplateFormat.Terraform}


@dataclass
class TargetFile:
    filename: str
    content: str
    is_binary: bool = False


@dataclass
class TransformResult:
    targets: List[TargetFile] = field(default_factory=list)
    log: str = ""


class TransformError(Exception):
    """Raised when a transformation fails; ``error_type`` mirrors the exception class."""

    def __init__(self, message: str, error_type: str = "TransformError", log: str = ""):
        super().__init__(message)
        self.message = message
        self.error_type = error_type
        self.log = log


def _guess_extension(content: bytes) -> str:
    text = content.lstrip()
    if text[:1] == b"{":
        return ".json"
    return ".yml"


def _normalize_input_filename(
    name: str, source_format: SourceTemplateFormat, content: bytes
) -> str:
    """Ensure the written file has an extension the library can recognize."""
    name = os.path.basename(name or "").strip() or "source"
    lower = name.lower()
    if source_format == SourceTemplateFormat.Terraform:
        return name if lower.endswith(".tf") else f"{name}.tf"
    if source_format == SourceTemplateFormat.Excel:
        return name if lower.endswith(".xlsx") else f"{name}.xlsx"
    # CloudFormation / ROS / ROSTerraform: need json/yaml extension.
    if lower.endswith((".json", ".yml", ".yaml")):
        return name
    base = os.path.splitext(name)[0]
    return f"{base}{_guess_extension(content)}"


def _resolve_target(
    out_dir: Path,
    source_format: SourceTemplateFormat,
    target_format: TargetTemplateFormat,
) -> Tuple[str, TargetTemplateFormat]:
    """Pick an explicit (target_path, target_format) rooted under ``out_dir``.

    Mirrors the CLI defaults but always uses an explicit path so the CLI never
    falls back to writing relative to the current working directory.
    """
    if target_format == TargetTemplateFormat.Auto:
        if source_format == SourceTemplateFormat.ROS:
            target_format = TargetTemplateFormat.Terraform
        elif source_format == SourceTemplateFormat.ROSTerraform:
            # Wrap output uses a basename and produces multiple files.
            return str(out_dir / "template"), TargetTemplateFormat.Auto
        else:
            target_format = TargetTemplateFormat.Yaml

    if target_format == TargetTemplateFormat.Terraform:
        return str(out_dir), TargetTemplateFormat.Terraform
    if target_format == TargetTemplateFormat.Json:
        return str(out_dir / "template.json"), TargetTemplateFormat.Json
    if target_format == TargetTemplateFormat.Yaml:
        return str(out_dir / "template.yml"), TargetTemplateFormat.Yaml

    return str(out_dir / "template.yml"), TargetTemplateFormat.Yaml


def _collect_outputs(out_dir: Path) -> List[TargetFile]:
    targets: List[TargetFile] = []
    for path in sorted(out_dir.rglob("*")):
        if not path.is_file():
            continue
        rel = path.relative_to(out_dir).as_posix()
        try:
            content = path.read_text(encoding="utf-8")
            targets.append(TargetFile(filename=rel, content=content))
        except UnicodeDecodeError:
            import base64

            data = base64.b64encode(path.read_bytes()).decode("ascii")
            targets.append(TargetFile(filename=rel, content=data, is_binary=True))
    return targets


def transform(
    files: List[Tuple[str, bytes]],
    source_format: SourceTemplateFormat,
    target_format: TargetTemplateFormat = TargetTemplateFormat.Auto,
    compatible: bool = False,
    extra_files: Optional[List[str]] = None,
    credentials: Optional[dict] = None,
) -> TransformResult:
    """Transform uploaded template ``files`` and return the produced files.

    ``files`` is a list of ``(filename, content_bytes)``. ``credentials`` may
    carry Alibaba Cloud ``access_key_id`` / ``access_key_secret`` used only for
    ROS template validation (ROS -> Terraform); they are scoped to this call and
    never persisted.
    """
    if not files:
        raise TransformError("No source file provided.", "InvalidRequest")

    # Import here so importing this module never requires the optional CLI deps
    # to already be wired up, and to keep the heavy import out of startup.
    from rostran.cli.__main__ import transform as cli_transform
    from rostran.core import exceptions

    with _transform_lock:
        with TemporaryDirectory(prefix="rostran-web-") as tmp:
            work_dir = Path(tmp)
            in_dir = work_dir / "in"
            out_dir = work_dir / "out"
            in_dir.mkdir()
            out_dir.mkdir()

            written: List[Path] = []
            for name, content in files:
                safe = _normalize_input_filename(name, source_format, content)
                dest = in_dir / safe
                dest.write_bytes(content)
                written.append(dest)

            if source_format in _DIRECTORY_SOURCES:
                source_path = str(in_dir)
            else:
                source_path = str(written[0])

            target_path, resolved_target = _resolve_target(
                out_dir, source_format, target_format
            )

            # Scope optional Alibaba Cloud credentials to this transformation.
            saved_env = {}
            cred_env = {}
            if credentials:
                if credentials.get("access_key_id"):
                    cred_env["ALIBABA_CLOUD_ACCESS_KEY_ID"] = credentials[
                        "access_key_id"
                    ]
                if credentials.get("access_key_secret"):
                    cred_env["ALIBABA_CLOUD_ACCESS_KEY_SECRET"] = credentials[
                        "access_key_secret"
                    ]
            for key, value in cred_env.items():
                saved_env[key] = os.environ.get(key)
                os.environ[key] = value

            # Terraform parsing (via libterraform) runs terraform in-process
            # with `-chdir=<tmp>`, which changes the whole process's working
            # directory. Recover the cwd if a previous run left it invalid, and
            # restore it afterwards so os.getcwd() keeps working once this
            # temporary directory has been removed.
            saved_cwd = _ensure_valid_cwd()

            log_buf = io.StringIO()
            try:
                with redirect_stdout(log_buf), redirect_stderr(log_buf):
                    cli_transform(
                        source_path=source_path,
                        source_format=source_format,
                        target_path=target_path,
                        target_format=resolved_target,
                        compatible=compatible,
                        force=True,
                        extra_files=extra_files or [],
                    )
            except exceptions.RosTranWarning as e:
                raise TransformError(str(e), type(e).__name__, log_buf.getvalue())
            except exceptions.RosTranException as e:
                raise TransformError(str(e), type(e).__name__, log_buf.getvalue())
            except Exception as e:  # noqa: BLE001 - surface any failure to the client
                raise TransformError(
                    str(e) or e.__class__.__name__,
                    e.__class__.__name__,
                    log_buf.getvalue(),
                )
            finally:
                # Restore the working directory before the temp dir is removed.
                _restore_cwd(saved_cwd)
                for key, value in saved_env.items():
                    if value is None:
                        os.environ.pop(key, None)
                    else:
                        os.environ[key] = value

            targets = _collect_outputs(out_dir)
            if not targets:
                raise TransformError(
                    "Transformation produced no output.",
                    "EmptyOutput",
                    log_buf.getvalue(),
                )
            return TransformResult(targets=targets, log=log_buf.getvalue())


def format_template(content: str, file_format: str) -> str:
    """Format a single ROS template string and return the formatted content."""
    from rostran.core.template import RosTemplate
    from rostran.core import exceptions
    from rostran.providers.ros.yaml_util import yaml as ros_yaml

    fmt = (file_format or "").lower()
    try:
        if fmt == "json":
            source = json.loads(content)
        elif fmt in ("yaml", "yml"):
            source = ros_yaml.load(content)
        else:
            raise TransformError(
                f"Unsupported format: {file_format}", "UnsupportedFormat"
            )
    except (json.JSONDecodeError, Exception) as e:  # noqa: BLE001
        if isinstance(e, TransformError):
            raise
        raise TransformError(f"Invalid {fmt} template: {e}", "InvalidTemplate")

    try:
        template = RosTemplate.initialize(source)
        data = template.as_dict(format=True)
    except exceptions.RosTranException as e:
        raise TransformError(str(e), type(e).__name__)

    if fmt == "json":
        return json.dumps(data, indent=2, ensure_ascii=False)
    out = io.StringIO()
    ros_yaml.dump(data, out)
    return out.getvalue()


def get_rules(classifier: str, markdown: bool = True, with_link: bool = False) -> str:
    """Return transform rules for a classifier as captured text/markdown."""
    from rostran.core.rule_manager import RuleManager, RuleClassifier

    valid = {
        "terraform/alicloud": RuleClassifier.TerraformAliCloud,
        "terraform/aws": RuleClassifier.TerraformAWS,
        "cloudformation": RuleClassifier.CloudFormation,
        "ros": RuleClassifier.ROS,
    }
    key = valid.get(classifier)
    if key is None:
        raise TransformError(f"Unknown rules classifier: {classifier}", "UnknownRules")

    buf = io.StringIO()
    with _transform_lock:
        with redirect_stdout(buf):
            manager = RuleManager.initialize(key)
            manager.show(markdown, with_link)
    return buf.getvalue()


def rules_classifiers() -> List[str]:
    return ["terraform/alicloud", "terraform/aws", "cloudformation", "ros"]
