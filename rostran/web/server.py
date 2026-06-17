"""FastAPI application and uvicorn launcher for ``rostran serve``.

The app serves a JSON API under ``/api`` and the pre-built single-page frontend
(bundled in ``rostran/web/static``) for everything else.
"""

import json
from pathlib import Path
from typing import List

from rostran.core.format import SourceTemplateFormat, TargetTemplateFormat

from . import examples as examples_mod
from . import service

STATIC_DIR = Path(__file__).parent / "static"
MAX_UPLOAD_BYTES = 5 * 1024 * 1024  # 5 MiB per request


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
    from fastapi.responses import JSONResponse, FileResponse
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
            # Offload to a worker thread: the transform is synchronous and may
            # run terraform (slow, native) for seconds. Running it inline would
            # block the event loop and stall every other request.
            result = await run_in_threadpool(
                service.transform,
                files=payload,
                source_format=src_fmt,
                target_format=tgt_fmt,
                compatible=bool(opts.get("compatible", False)),
                extra_files=opts.get("extra_files"),
                credentials=opts.get("credentials"),
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


def run(
    host: str = "127.0.0.1",
    port: int = 8080,
    reload: bool = False,
    open_browser: bool = False,
):
    """Start the uvicorn server hosting the web service."""
    _require_web_deps()
    import uvicorn

    if open_browser and not reload:
        import threading
        import webbrowser

        url = f"http://{host if host != '0.0.0.0' else '127.0.0.1'}:{port}"
        threading.Timer(1.0, lambda: webbrowser.open(url)).start()

    if reload:
        # Reload requires an import string rather than an app instance.
        uvicorn.run(
            "rostran.web.server:build_app",
            factory=True,
            host=host,
            port=port,
            reload=True,
        )
    else:
        uvicorn.run(build_app(), host=host, port=port)


# Convenience for `uvicorn rostran.web.server:app`
def _lazy_app():
    return build_app()
