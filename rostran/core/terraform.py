import asyncio
from dataclasses import dataclass
from typing import Optional

from libterraform import (
    AsyncTerraformCommand,
    CommandResult,
    PlanResult,
    TerraformCommand,
    TerraformPool,
)


@dataclass
class _StreamCommand:
    cmd: str
    options: dict
    json: bool = False


_STREAM_COMMANDS = {
    "fmt": _StreamCommand("fmt", {"no_color": True}),
    "init": _StreamCommand("init", {"input": False, "no_color": True}),
    "plan": _StreamCommand("plan", {"input": False, "no_color": True}),
}


class TerraformRunner:
    """Small adapter around libterraform's pool and streaming APIs."""

    def __init__(
        self,
        max_workers: Optional[int] = None,
        stream_output: bool = False,
    ):
        self.max_workers = max_workers
        self.stream_output = stream_output
        self._pool: Optional[TerraformPool] = None

    def __enter__(self) -> "TerraformRunner":
        if not self.stream_output:
            self._pool = TerraformPool(max_workers=self.max_workers)
        return self

    def __exit__(self, exc_type, exc_val, exc_tb) -> bool:
        if self._pool is not None:
            self._pool.shutdown(wait=True)
            self._pool = None
        return False

    def run(self, cwd: str, method: str, /, *args, **kwargs):
        if self.stream_output and method in _STREAM_COMMANDS:
            return self._run_stream(cwd, method, *args, **kwargs)
        try:
            asyncio.get_running_loop()
        except RuntimeError:
            return asyncio.run(self.run_async(cwd, method, *args, **kwargs))
        raise RuntimeError("Use TerraformRunner.run_async() from async code.")

    async def run_async(self, cwd: str, method: str, /, *args, **kwargs):
        if self.stream_output and method in _STREAM_COMMANDS:
            return await asyncio.to_thread(
                self._run_stream, cwd, method, *args, **kwargs
            )
        if self._pool is None and not self.stream_output:
            raise RuntimeError("TerraformRunner must be used as a context manager.")
        command = AsyncTerraformCommand(cwd, pool=self._pool)
        return await getattr(command, method)(*args, **kwargs)

    def _run_stream(self, cwd: str, method: str, /, *args, **kwargs):
        stream_command = _STREAM_COMMANDS[method]
        check = bool(kwargs.pop("check", False))
        options = {**stream_command.options, **kwargs}
        if "no_color" in options:
            options["no_color"] = ... if options["no_color"] else None
        command = TerraformCommand(cwd)
        print(f"Running terraform {method}...", flush=True)
        output = []
        stream = command.stream(
            stream_command.cmd,
            args=args or None,
            options=options,
            chdir=cwd,
            json=stream_command.json,
            check=check,
        )
        for event in stream:
            text = str(event)
            output.append(text)
            print(text, flush=True)
        value = "".join(f"{line}\n" for line in output)
        retcode = getattr(stream, "retcode", 0)
        error = getattr(stream, "stderr", "")
        if method == "plan":
            return PlanResult(retcode, value, error, json=False)
        return CommandResult(retcode, value, error, json=False)
