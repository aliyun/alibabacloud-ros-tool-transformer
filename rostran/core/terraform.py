import asyncio
from typing import Optional

from libterraform import AsyncTerraformCommand, TerraformPool


class TerraformRunner:
    """Small adapter around libterraform's async process pool API."""

    def __init__(self, max_workers: Optional[int] = None):
        self.max_workers = max_workers
        self._pool: Optional[TerraformPool] = None

    def __enter__(self) -> "TerraformRunner":
        self._pool = TerraformPool(max_workers=self.max_workers)
        return self

    def __exit__(self, exc_type, exc_val, exc_tb) -> bool:
        if self._pool is not None:
            self._pool.shutdown(wait=True)
            self._pool = None
        return False

    def run(self, cwd: str, method: str, /, *args, **kwargs):
        try:
            asyncio.get_running_loop()
        except RuntimeError:
            return asyncio.run(self.run_async(cwd, method, *args, **kwargs))
        raise RuntimeError("Use TerraformRunner.run_async() from async code.")

    async def run_async(self, cwd: str, method: str, /, *args, **kwargs):
        if self._pool is None:
            raise RuntimeError("TerraformRunner must be used as a context manager.")
        command = AsyncTerraformCommand(cwd, pool=self._pool)
        return await getattr(command, method)(*args, **kwargs)
