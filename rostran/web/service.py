"""Service layer bridging HTTP requests to the rostran library.

All work happens inside a per-request temporary directory; nothing is persisted.
Terraform CLI operations are isolated by libterraform's process-backed
``TerraformPool``. ``format`` and ``rules`` are lightweight and stay in-process.
"""

import asyncio
import io
import json
import os
import threading
from contextlib import contextmanager, redirect_stderr, redirect_stdout
from dataclasses import dataclass, field
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Callable, List, Optional, Tuple

from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat

# Serializes the in-process rules rendering (it redirects process stdout).
_rules_lock = threading.Lock()

# Serializes the transform stdout/cwd/env shims. Terraform itself still runs in
# libterraform's process pool; these shims touch Python process-global state.
_transform_lock = threading.RLock()

# Source formats that consume a directory of files (e.g. multiple .tf files).
_DIRECTORY_SOURCES = {SourceTemplateFormat.Terraform}


def detect_credentials() -> dict:
    """Detect locally configured Alibaba Cloud credentials for ROS validation.

    Looks, in order, at environment variables, the Aliyun CLI config
    (``~/.aliyun/config.json``), and the Alibaba Cloud credentials file. Returns
    ``{available, source, env}`` where ``env`` holds any access keys that must be
    applied while running (the SDK reads env vars and the credentials file
    itself, but not the Aliyun CLI config).
    """
    if os.environ.get("ALIBABA_CLOUD_ACCESS_KEY_ID") and os.environ.get(
        "ALIBABA_CLOUD_ACCESS_KEY_SECRET"
    ):
        return {"available": True, "source": "environment", "env": {}}

    cli_config = Path.home() / ".aliyun" / "config.json"
    if cli_config.is_file():
        try:
            data = json.loads(cli_config.read_text(encoding="utf-8"))
            current = data.get("current")
            profiles = data.get("profiles") or []
            chosen = None
            for prof in profiles:
                if current and prof.get("name") == current:
                    chosen = prof
                    break
            if chosen is None and profiles:
                chosen = profiles[0]
            if (
                chosen
                and chosen.get("access_key_id")
                and chosen.get("access_key_secret")
            ):
                env = {
                    "ALIBABA_CLOUD_ACCESS_KEY_ID": chosen["access_key_id"],
                    "ALIBABA_CLOUD_ACCESS_KEY_SECRET": chosen["access_key_secret"],
                }
                if chosen.get("sts_token"):
                    env["ALIBABA_CLOUD_SECURITY_TOKEN"] = chosen["sts_token"]
                name = chosen.get("name") or "default"
                return {
                    "available": True,
                    "source": f"Aliyun CLI (profile: {name})",
                    "env": env,
                }
        except (ValueError, OSError):
            pass

    cred_file = os.environ.get("ALIBABA_CLOUD_CREDENTIALS_FILE") or str(
        Path.home() / ".alibabacloud" / "credentials.ini"
    )
    if Path(cred_file).is_file():
        return {"available": True, "source": "credentials file", "env": {}}

    return {"available": False, "source": None, "env": {}}


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


def _make_log_cleaner(work_dir: str) -> Callable[[str], Optional[str]]:
    """Return a per-line cleaner that hides internal file I/O from users.

    The conversion runs under a throwaway temp dir; nothing is persisted. Drop
    the "Save template to <tmp>/..." notice and redact any leaked temp path so
    the UI logs read as a direct conversion.
    """

    def clean(line: str) -> Optional[str]:
        if line.lstrip().startswith("Save template to"):
            return None
        if work_dir and work_dir in line:
            line = line.replace(work_dir + os.sep, "").replace(work_dir, "")
        return line

    return clean


def _guess_extension(content: bytes) -> str:
    text = content.lstrip()
    if text[:1] == b"{":
        return ".json"
    return ".yml"


def _safe_member_path(name: str) -> str:
    """Sanitize an uploaded (possibly nested) path: forward slashes, no
    absolute paths, no ``..`` traversal."""
    parts = [
        p
        for p in (name or "").replace("\\", "/").split("/")
        if p not in ("", ".", "..")
    ]
    return "/".join(parts)


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


class _LogCapture(io.TextIOBase):
    def __init__(
        self,
        cleaner: Callable[[str], Optional[str]],
        log_parts: List[str],
        on_log: Optional[Callable[[str], None]],
    ):
        super().__init__()
        self._cleaner = cleaner
        self._log_parts = log_parts
        self._on_log = on_log
        self._buffer = ""

    def writable(self) -> bool:
        return True

    def write(self, text) -> int:
        if isinstance(text, bytes):
            text = text.decode("utf-8", errors="replace")
        if not isinstance(text, str):
            text = str(text)
        if not text:
            return 0
        self._buffer += text
        while "\n" in self._buffer:
            line, self._buffer = self._buffer.split("\n", 1)
            self._emit(f"{line}\n")
        return len(text)

    def finish(self) -> None:
        if self._buffer:
            self._emit(self._buffer)
            self._buffer = ""

    def _emit(self, raw: str) -> None:
        line = self._cleaner(raw)
        if line is None:
            return
        self._log_parts.append(line)
        if self._on_log is not None:
            try:
                self._on_log(line)
            except Exception:  # noqa: BLE001 - never let logging break a transform
                pass


@contextmanager
def _temporary_cwd(path: Path):
    previous = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(previous)


@contextmanager
def _temporary_env(overrides: dict):
    previous = {key: os.environ.get(key) for key in overrides}
    os.environ.update(overrides)
    try:
        yield
    finally:
        for key, value in previous.items():
            if value is None:
                os.environ.pop(key, None)
            else:
                os.environ[key] = value


@contextmanager
def _skip_ros_validation(enabled: bool):
    if not enabled:
        yield
        return

    from rostran.providers.ros.template import ROS2TerraformTemplate

    restore = ROS2TerraformTemplate.__dict__["validate_ros_template"]
    setattr(
        ROS2TerraformTemplate,
        "validate_ros_template",
        staticmethod(lambda *a, **k: None),
    )
    try:
        yield
    finally:
        setattr(ROS2TerraformTemplate, "validate_ros_template", restore)


def _run_transform_spec(spec: dict) -> None:
    from rostran.cli.__main__ import transform as cli_transform
    from rostran.core import exceptions

    try:
        with _skip_ros_validation(spec.get("skip_ros_validation", False)):
            cli_transform(
                source_path=spec["source_path"],
                source_format=SourceTemplateFormat(spec["source_format"]),
                target_path=spec["target_path"],
                target_format=TargetTemplateFormat(spec["target_format"]),
                compatible=spec.get("compatible", False),
                force=True,
                extra_files=spec.get("extra_files") or [],
            )
    except (exceptions.RosTranWarning, exceptions.RosTranException) as e:
        raise TransformError(str(e), type(e).__name__) from e
    except TransformError:
        raise
    except Exception as e:  # noqa: BLE001 - surface any failure to the API caller
        raise TransformError(
            str(e) or e.__class__.__name__, e.__class__.__name__
        ) from e


def transform(
    files: List[Tuple[str, bytes]],
    source_format: SourceTemplateFormat,
    target_format: TargetTemplateFormat = TargetTemplateFormat.Auto,
    compatible: bool = False,
    extra_files: Optional[List[str]] = None,
    validate: bool = False,
    on_log: Optional[Callable[[str], None]] = None,
) -> TransformResult:
    """Transform uploaded template ``files`` in-process and return the produced
    files.

    ``files`` is a list of ``(filename, content_bytes)``. When ``validate`` is
    set (ROS -> Terraform) and local Alibaba Cloud credentials are detected, the
    ROS template is validated against the ROS API; otherwise validation is
    skipped. ``on_log``, if given, is called with each line of output as the
    transform produces it, for live log streaming.
    """
    if not files:
        raise TransformError("No source file provided.", "InvalidRequest")

    with TemporaryDirectory(prefix="rostran-web-") as tmp:
        work_dir = Path(tmp)
        in_dir = work_dir / "in"
        out_dir = work_dir / "out"
        in_dir.mkdir()
        out_dir.mkdir()

        written: List[Path] = []
        multi = len(files) > 1
        for name, content in files:
            # Preserve directory structure for Terraform folder uploads so
            # multi-file / nested .tf projects parse correctly; otherwise write a
            # single normalized file.
            has_path = "/" in (name or "") or "\\" in (name or "")
            if source_format in _DIRECTORY_SOURCES and (multi or has_path):
                rel = _safe_member_path(name) or _normalize_input_filename(
                    name, source_format, content
                )
                dest = in_dir / rel
                dest.parent.mkdir(parents=True, exist_ok=True)
            else:
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

        # Validate ROS templates only when asked AND local credentials exist;
        # inject detected keys (e.g. from the Aliyun CLI) while running.
        do_validate = source_format == SourceTemplateFormat.ROS and validate
        cred_env: dict = {}
        if do_validate:
            creds = detect_credentials()
            if creds["available"]:
                cred_env = creds["env"]
            else:
                do_validate = False

        spec = {
            "source_path": source_path,
            "source_format": source_format.value,
            "target_path": target_path,
            "target_format": resolved_target.value,
            "compatible": compatible,
            "extra_files": extra_files or [],
            "skip_ros_validation": not do_validate,
        }

        cleaner = _make_log_cleaner(str(work_dir))
        log_parts: List[str] = []
        capture = _LogCapture(cleaner, log_parts, on_log)
        error: Optional[TransformError] = None

        # cwd in the temp dir so any stray relative output stays contained. The
        # shims below touch process-global state, so keep them serialized.
        with _transform_lock:
            try:
                with (
                    _temporary_env(cred_env),
                    _temporary_cwd(work_dir),
                    redirect_stdout(capture),
                    redirect_stderr(capture),
                ):
                    try:
                        _run_transform_spec(spec)
                    finally:
                        capture.finish()
            except TransformError as e:
                error = e

        log = "".join(log_parts)
        if error is not None:
            raise TransformError(error.message, error.error_type, log)

        targets = _collect_outputs(out_dir)
        if not targets:
            raise TransformError(
                "Transformation produced no output.", "EmptyOutput", log
            )
        return TransformResult(targets=targets, log=log)


async def transform_async(
    files: List[Tuple[str, bytes]],
    source_format: SourceTemplateFormat,
    target_format: TargetTemplateFormat = TargetTemplateFormat.Auto,
    compatible: bool = False,
    extra_files: Optional[List[str]] = None,
    validate: bool = False,
    on_log: Optional[Callable[[str], None]] = None,
) -> TransformResult:
    """Async web-service entrypoint for transforms.

    The rostran transformation pipeline is still synchronous Python code, so it
    runs in a worker thread to keep FastAPI's event loop responsive. Terraform
    commands executed inside that pipeline use ``AsyncTerraformCommand`` on a
    ``TerraformPool`` via ``TerraformRunner``.
    """

    return await asyncio.to_thread(
        transform,
        files=files,
        source_format=source_format,
        target_format=target_format,
        compatible=compatible,
        extra_files=extra_files,
        validate=validate,
        on_log=on_log,
    )


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
    with _rules_lock:
        with redirect_stdout(buf):
            manager = RuleManager.initialize(key)
            manager.show(markdown, with_link)
    return buf.getvalue()


def rules_classifiers() -> List[str]:
    return ["terraform/alicloud", "terraform/aws", "cloudformation", "ros"]
