import os
from pathlib import Path
import subprocess

import pytest
import yaml


@pytest.mark.parametrize("job", ["frontend-coverage", "test"])
@pytest.mark.parametrize("event", ["push", "force-push", "new-branch", "empty", "pr"])
def test_workflow_selects_an_available_coverage_base(tmp_path, job, event):
    workflow = yaml.safe_load(
        (Path(__file__).resolve().parents[1] / ".github/workflows/test.yml").read_text()
    )
    script = next(
        step["run"]
        for step in workflow["jobs"][job]["steps"]
        if "PR_BASE" in step.get("env", {})
    )

    def git(*args):
        return subprocess.check_output(["git", *args], cwd=tmp_path).decode().strip()

    git("init", "-q")
    git(
        "-c",
        "user.name=Test",
        "-c",
        "user.email=test@example.com",
        "commit",
        "--allow-empty",
        "-qm",
        "base",
    )
    sha = git("rev-parse", "HEAD")
    git("update-ref", "refs/remotes/origin/main", sha)
    bins = tmp_path / "bin"
    bins.mkdir()
    for name in ("python3", "uv"):
        executable = bins / name
        executable.write_text('#!/bin/sh\nprintf "%s\\n" "$@" > "$COVERAGE_ARGS"\n')
        executable.chmod(0o755)
    missing = "1" * 40
    push_base = {
        "push": sha,
        "force-push": missing,
        "new-branch": "0" * 40,
        "empty": "",
        "pr": missing,
    }[event]
    args_path = tmp_path / "args"
    env = dict(
        os.environ,
        PR_BASE=sha if event == "pr" else "",
        PUSH_BASE=push_base,
        DEFAULT_BRANCH="main",
        PATH=f"{bins}{os.pathsep}{os.environ['PATH']}",
        COVERAGE_ARGS=str(args_path),
    )
    subprocess.run(["bash", "-e", "-c", script], cwd=tmp_path, env=env, check=True)
    expected = sha if event in ("push", "pr") else "origin/main"
    assert args_path.read_text().splitlines()[-2:] == ["--base", expected]
