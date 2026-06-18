"""Subprocess worker that runs a single transform in an isolated process.

Invoked by the web service only (never directly by users), either as a module::

    python -m rostran.web._worker '<json-spec>'

or, inside a frozen binary, via the ``__web_worker__`` argv sentinel handled in
``rostran.cli.__main__``.

Running each transform in its own process keeps libterraform (a Go shared
library whose runtime hijacks process-wide signal handlers), working-directory
changes, and native crashes out of the long-lived web server process. Progress
is written to stdout (consumed live for streaming); a final ``__ROSTRAN_ERROR__``
line carries a structured failure.
"""

import json
import sys

ERROR_MARKER = "__ROSTRAN_ERROR__"


def _emit_error(error_type: str, message: str) -> None:
    sys.stdout.flush()
    print(
        ERROR_MARKER + " " + json.dumps({"type": error_type, "message": message}),
        flush=True,
    )


def run_spec(spec: dict) -> int:
    from rostran.core import exceptions
    from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat
    from rostran.cli.__main__ import transform as cli_transform

    restore = None
    ros_template_cls = None
    if spec.get("skip_ros_validation"):
        # ROS -> Terraform validation calls the Alibaba Cloud API (needs an
        # AccessKey); skip it when no credentials were supplied.
        from rostran.providers.ros.template import ROS2TerraformTemplate

        ros_template_cls = ROS2TerraformTemplate
        restore = ros_template_cls.__dict__["validate_ros_template"]
        setattr(
            ros_template_cls,
            "validate_ros_template",
            staticmethod(lambda *a, **k: None),
        )

    try:
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
        _emit_error(type(e).__name__, str(e))
        return 1
    except Exception as e:  # noqa: BLE001 - surface any failure to the parent
        _emit_error(e.__class__.__name__, str(e) or e.__class__.__name__)
        return 1
    finally:
        if restore is not None and ros_template_cls is not None:
            setattr(ros_template_cls, "validate_ros_template", restore)
    return 0


def main() -> int:
    if len(sys.argv) < 2:
        _emit_error("InvalidRequest", "missing transform spec")
        return 2
    return run_spec(json.loads(sys.argv[1]))


if __name__ == "__main__":
    sys.exit(main())
