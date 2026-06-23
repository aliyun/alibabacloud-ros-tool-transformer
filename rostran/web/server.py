"""FastAPI application and uvicorn launcher for ``rostran server start``.

The app serves a JSON API under ``/api`` and the pre-built single-page frontend
(bundled in ``rostran/web/static``) for everything else.
"""

import asyncio
import json
import os
from pathlib import Path
from typing import List

from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat

from . import examples as examples_mod
from . import service

STATIC_DIR = Path(__file__).parent / "static"
MAX_UPLOAD_BYTES = 16 * 1024 * 1024  # 16 MiB per request


class MissingDependencies(RuntimeError):
    """Raised when the optional web dependencies are not installed."""


def _require_web_deps():
    try:
        import fastapi  # noqa: F401
        import uvicorn  # noqa: F401
    except ImportError as e:
        raise MissingDependencies(
            "The web service requires extra dependencies. Install them with:\n"
            '    pip install "alibabacloud-ros-tran[serve]"'
        ) from e


def build_app():
    """Construct and return the FastAPI application."""
    _require_web_deps()

    from fastapi import FastAPI, File, Form, HTTPException, UploadFile
    from fastapi.middleware.cors import CORSMiddleware
    from fastapi.responses import JSONResponse, FileResponse, StreamingResponse
    from fastapi.staticfiles import StaticFiles
    from starlette.concurrency import run_in_threadpool

    from rostran import __version__

    app = FastAPI(
        title="ROS Template Transformer",
        version=__version__,
        docs_url="/api/docs",
        openapi_url="/api/openapi.json",
    )

    # Permit cross-origin calls from the Vite dev server during development.
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"],
    )

    api = FastAPI(title="ROS Transformer API", version=__version__)

    def _error(status: int, message: str, error_type: str, log: str = ""):
        return JSONResponse(
            status_code=status,
            content={"error": {"type": error_type, "message": message, "log": log}},
        )

    @api.get("/meta")
    def meta():
        return {
            "version": __version__,
            "source_formats": [f.value for f in SourceTemplateFormat],
            "target_formats": [f.value for f in TargetTemplateFormat],
            "rules_classifiers": service.rules_classifiers(),
        }

    @api.get("/health")
    def health():
        return {"status": "ok"}

    @api.get("/credentials")
    def credentials():
        info = service.detect_credentials()
        return {"available": info["available"], "source": info["source"]}

    @api.post("/transform")
    async def transform(
        source_format: str = Form(...),
        target_format: str = Form("auto"),
        options: str = Form("{}"),
        files: List[UploadFile] = File(...),
    ):
        try:
            src_fmt = SourceTemplateFormat(source_format)
        except ValueError:
            return _error(
                400, f"Invalid source format: {source_format}", "InvalidRequest"
            )
        try:
            tgt_fmt = TargetTemplateFormat(target_format)
        except ValueError:
            return _error(
                400, f"Invalid target format: {target_format}", "InvalidRequest"
            )

        try:
            opts = json.loads(options or "{}")
        except json.JSONDecodeError:
            return _error(400, "Invalid options JSON.", "InvalidRequest")

        payload: List = []
        total = 0
        for upload in files:
            data = await upload.read()
            total += len(data)
            if total > MAX_UPLOAD_BYTES:
                return _error(413, "Upload too large.", "PayloadTooLarge")
            payload.append((upload.filename or "source", data))

        try:
            result = await service.transform_async(
                files=payload,
                source_format=src_fmt,
                target_format=tgt_fmt,
                compatible=bool(opts.get("compatible", False)),
                extra_files=opts.get("extra_files"),
                validate=bool(opts.get("validate", False)),
            )
        except service.TransformError as e:
            return _error(422, e.message, e.error_type, e.log)

        return {
            "targets": [
                {
                    "filename": t.filename,
                    "content": t.content,
                    "is_binary": t.is_binary,
                }
                for t in result.targets
            ],
            "log": result.log,
        }

    def _sse(event: str, data: dict) -> str:
        return f"event: {event}\ndata: {json.dumps(data)}\n\n"

    def _result_payload(result) -> dict:
        return {
            "targets": [
                {
                    "filename": t.filename,
                    "content": t.content,
                    "is_binary": t.is_binary,
                }
                for t in result.targets
            ],
            "log": result.log,
        }

    @api.post("/transform/stream")
    async def transform_stream(
        source_format: str = Form(...),
        target_format: str = Form("auto"),
        options: str = Form("{}"),
        files: List[UploadFile] = File(...),
    ):
        """Same as /transform but streams log output live via Server-Sent
        Events: `log` events while running, then a final `result` or `error`."""
        early_error = None
        src_fmt = tgt_fmt = None
        opts: dict = {}
        payload: List = []
        try:
            src_fmt = SourceTemplateFormat(source_format)
            tgt_fmt = TargetTemplateFormat(target_format)
        except ValueError:
            early_error = ("InvalidRequest", "Invalid source or target format.")
        if early_error is None:
            try:
                opts = json.loads(options or "{}")
            except json.JSONDecodeError:
                early_error = ("InvalidRequest", "Invalid options JSON.")
        if early_error is None:
            total = 0
            for upload in files:
                data = await upload.read()
                total += len(data)
                if total > MAX_UPLOAD_BYTES:
                    early_error = ("PayloadTooLarge", "Upload too large.")
                    break
                payload.append((upload.filename or "source", data))

        loop = asyncio.get_running_loop()
        queue: asyncio.Queue = asyncio.Queue()

        def on_log(text: str):
            loop.call_soon_threadsafe(queue.put_nowait, ("log", text))

        async def event_gen():
            if early_error is not None:
                yield _sse("error", {"type": early_error[0], "message": early_error[1]})
                return

            async def worker():
                assert src_fmt is not None and tgt_fmt is not None
                try:
                    result = await service.transform_async(
                        files=payload,
                        source_format=src_fmt,
                        target_format=tgt_fmt,
                        compatible=bool(opts.get("compatible", False)),
                        extra_files=opts.get("extra_files"),
                        validate=bool(opts.get("validate", False)),
                        on_log=on_log,
                    )
                    await queue.put(("result", result))
                except service.TransformError as e:
                    await queue.put(("error", e))
                except Exception as e:  # noqa: BLE001
                    await queue.put(
                        ("error", service.TransformError(str(e), e.__class__.__name__))
                    )

            task = asyncio.create_task(worker())
            try:
                while True:
                    kind, item = await queue.get()
                    if kind == "log":
                        yield _sse("log", {"text": item})
                    elif kind == "result":
                        yield _sse("result", _result_payload(item))
                        break
                    else:
                        yield _sse(
                            "error",
                            {
                                "type": item.error_type,
                                "message": item.message,
                                "log": item.log,
                            },
                        )
                        break
            finally:
                await task

        return StreamingResponse(
            event_gen(),
            media_type="text/event-stream",
            headers={"Cache-Control": "no-cache", "X-Accel-Buffering": "no"},
        )

    @api.post("/format")
    async def format_template(
        content: str = Form(...),
        format: str = Form(...),
    ):
        try:
            formatted = await run_in_threadpool(
                service.format_template, content, format
            )
        except service.TransformError as e:
            return _error(422, e.message, e.error_type)
        return {"content": formatted}

    @api.get("/rules/classifiers")
    def rules_classifiers():
        return {"classifiers": service.rules_classifiers()}

    @api.get("/rules")
    def rules(classifier: str, markdown: bool = True, with_link: bool = False):
        try:
            content = service.get_rules(classifier, markdown, with_link)
        except service.TransformError as e:
            return _error(400, e.message, e.error_type)
        return {"classifier": classifier, "content": content}

    @api.get("/examples")
    def list_examples():
        return {"examples": examples_mod.list_examples()}

    @api.get("/examples/{example_id}")
    def get_example(example_id: str):
        ex = examples_mod.get_example(example_id)
        if ex is None:
            raise HTTPException(status_code=404, detail="Example not found")
        return ex

    app.mount("/api", api)

    # Serve the bundled SPA. Fall back to index.html for client-side routes.
    index_file = STATIC_DIR / "index.html"
    if index_file.exists():
        app.mount(
            "/assets",
            StaticFiles(directory=str(STATIC_DIR / "assets")),
            name="assets",
        )

        @app.get("/")
        def index():
            return FileResponse(str(index_file))

        @app.get("/{full_path:path}")
        def spa(full_path: str):
            candidate = STATIC_DIR / full_path
            if candidate.is_file():
                return FileResponse(str(candidate))
            return FileResponse(str(index_file))
    else:

        @app.get("/")
        def no_frontend():
            return {
                "message": (
                    "Web UI is not bundled in this build. The JSON API is "
                    "available under /api. Build the frontend with "
                    "`make web-build` to enable the UI."
                ),
                "api_docs": "/api/docs",
            }

    return app


def _preload_libterraform():
    """Initialize the libterraform Go runtime before uvicorn installs its signal
    handlers.

    libterraform is a Go c-shared library; the Go runtime hijacks the SIGINT
    handler the first time it is loaded, which would stop Ctrl+C from ever
    reaching uvicorn once a transform has used Terraform. Forcing the load now
    (the runtime only hijacks once) lets uvicorn install its handler afterwards
    so Ctrl+C keeps working.
    """
    import tempfile

    try:
        from libterraform import TerraformConfig

        try:
            TerraformConfig.load_config_dir(tempfile.gettempdir())
        except Exception:  # noqa: BLE001 - we only care about triggering the load
            pass
    except Exception:  # noqa: BLE001 - libterraform optional / load best-effort
        pass


def run(
    host: str = "127.0.0.1",
    port: int = 8080,
    open_browser: bool = False,
):
    """Start the uvicorn server hosting the web service."""
    _require_web_deps()
    import uvicorn

    _preload_libterraform()

    if open_browser:
        import threading
        import webbrowser

        url = f"http://{host if host != '0.0.0.0' else '127.0.0.1'}:{port}"
        # Daemon timer so it never keeps the process alive at shutdown.
        timer = threading.Timer(1.0, lambda: webbrowser.open(url))
        timer.daemon = True
        timer.start()

    # Bound the graceful-shutdown wait so a long-running streaming request (e.g.
    # a Terraform transform whose SSE connection is still open) cannot make
    # Ctrl+C hang. Once the server stops, force-exit so any background transform
    # orchestration or TerraformPool workers cannot keep the interpreter alive.
    try:
        uvicorn.run(
            build_app(),
            host=host,
            port=port,
            timeout_graceful_shutdown=3,
        )
    finally:
        os._exit(0)


# Convenience for `uvicorn rostran.web.server:app`
def _lazy_app():
    return build_app()
