"""Service layer bridging HTTP requests to the rostran library.

Transformations run in a short-lived child process (see ``_worker``) rather than
in the web server: the underlying ``libterraform`` is a Go shared library whose
runtime hijacks process signal handlers and changes the working directory, and a
malformed template can crash it natively. Running each transform out-of-process
keeps all of that isolated from the long-lived server.

All work happens inside a per-request temporary directory; nothing is persisted.
``format`` and ``rules`` are lightweight and stay in-process.
"""

import io
import json
import os
import subprocess
import sys
import threading
from contextlib import redirect_stdout
from dataclasses import dataclass, field
from pathlib import Path
from tempfile import TemporaryDirectory
from typing import Callable, List, Optional, Tuple

from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat

from ._worker import ERROR_MARKER

# Serializes the in-process rules rendering (it redirects process stdout).
_rules_lock = threading.Lock()

# Source formats that consume a directory of files (e.g. multiple .tf files).
_DIRECTORY_SOURCES = {SourceTemplateFormat.Terraform}


def detect_credentials() -> dict:
    """Detect locally configured Alibaba Cloud credentials for ROS validation.

    Looks, in order, at environment variables, the Aliyun CLI config
    (``~/.aliyun/config.json``), and the Alibaba Cloud credentials file. Returns
    ``{available, source, env}`` where ``env`` holds any access keys that must be
    injected into the child process (the SDK reads env vars and the credentials
    file itself, but not the Aliyun CLI config).
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


def _worker_command(spec_json: str) -> List[str]:
    if getattr(sys, "frozen", False):
        # Frozen binary: re-invoke itself (python -m is unavailable).
        return [sys.executable, "__web_worker__", spec_json]
    return [sys.executable, "-m", "rostran.web._worker", spec_json]


def transform(
    files: List[Tuple[str, bytes]],
    source_format: SourceTemplateFormat,
    target_format: TargetTemplateFormat = TargetTemplateFormat.Auto,
    compatible: bool = False,
    extra_files: Optional[List[str]] = None,
    validate: bool = False,
    on_log: Optional[Callable[[str], None]] = None,
) -> TransformResult:
    """Transform uploaded template ``files`` in a child process and return the
    produced files.

    ``files`` is a list of ``(filename, content_bytes)``. When ``validate`` is
    set (ROS -> Terraform) and local Alibaba Cloud credentials are detected, the
    ROS template is validated against the ROS API; otherwise validation is
    skipped. ``on_log``, if given, is called with each line of output as the
    child process produces it, for live log streaming.
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
        # inject detected keys (e.g. from the Aliyun CLI) into the child's env.
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

        env = os.environ.copy()
        env["PYTHONUNBUFFERED"] = "1"
        env.update(cred_env)

        cleaner = _make_log_cleaner(str(work_dir))
        log_parts: List[str] = []
        error: Optional[dict] = None

        # cwd in the temp dir so any stray relative output stays contained.
        proc = subprocess.Popen(
            _worker_command(json.dumps(spec)),
            cwd=str(work_dir),
            env=env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1,
        )
        assert proc.stdout is not None
        for raw in proc.stdout:
            if raw.startswith(ERROR_MARKER):
                payload = raw[len(ERROR_MARKER) :].strip()
                try:
                    error = json.loads(payload)
                except json.JSONDecodeError:
                    error = {"type": "TransformError", "message": payload}
                continue
            line = cleaner(raw)
            if line is None:
                continue
            log_parts.append(line)
            if on_log is not None:
                try:
                    on_log(line)
                except Exception:  # noqa: BLE001 - never let logging break a transform
                    pass
        proc.wait()

        log = "".join(log_parts)
        if error is not None or proc.returncode != 0:
            message = (error or {}).get("message") or "Transformation failed."
            etype = (error or {}).get("type") or "TransformError"
            raise TransformError(message, etype, log)

        targets = _collect_outputs(out_dir)
        if not targets:
            raise TransformError(
                "Transformation produced no output.", "EmptyOutput", log
            )
        return TransformResult(targets=targets, log=log)


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
