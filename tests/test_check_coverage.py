import json
import subprocess
import sys
from pathlib import Path

import pytest

from tools.check_coverage import branch_source_lines, changed_lines, check


def report():
    return {
        "meta": {"branch_coverage": True},
        "totals": {
            "covered_lines": 95,
            "num_statements": 100,
            "covered_branches": 19,
            "num_branches": 20,
        },
        "files": {
            "rostran/example.py": {
                "executed_lines": list(range(1, 20)),
                "missing_lines": [20],
                "executed_branches": [[1, 2]],
                "missing_branches": [[1, 3]],
            }
        },
    }


def test_checks_each_metric_independently():
    data = report()
    assert check(data)
    data["totals"]["covered_branches"] = 18
    assert not check(data)
    data["totals"]["covered_branches"] = 19
    data["totals"]["covered_lines"] = 94
    assert not check(data)


def test_incremental_coverage_and_empty_diff():
    data = report()
    assert check(data, {})
    assert check(data, {"rostran/example.py": set(range(2, 20))})
    assert not check(data, {"rostran/example.py": {1}})
    assert not check(data, {"rostran/example.py": {20}})
    with pytest.raises(ValueError, match="missing from coverage"):
        check(data, {"rostran/missing.py": {1}})
    data["meta"]["branch_coverage"] = False
    with pytest.raises(ValueError, match="branch data"):
        check(data)
    data = report()
    data["totals"]["num_branches"] = 0
    with pytest.raises(ValueError, match="no statements or branches"):
        check(data)


def test_changed_lines_against_merge_base(tmp_path, monkeypatch):
    def git(*args):
        return subprocess.check_output(["git", *args], cwd=tmp_path).decode().strip()

    git("init", "-q")
    git("config", "user.email", "test@example.com")
    git("config", "user.name", "Test")
    source = tmp_path / "rostran" / "example.py"
    source.parent.mkdir()
    source.write_text("one\ntwo\nthree\n")
    git("add", ".")
    git("commit", "-qm", "base")
    base = git("rev-parse", "HEAD")
    source.write_text("one\nchanged\nthree\nfour\n")
    website = tmp_path / "website" / "scripts" / "generator.py"
    website.parent.mkdir(parents=True)
    website.write_text("print('not in coverage scope')\n")
    (tmp_path / "rostran" / "wasm.py").write_text("print('documentation playground')\n")
    git("add", ".")
    git("commit", "-qm", "change")
    monkeypatch.chdir(tmp_path)
    assert changed_lines(base) == {"rostran/example.py": {2, 4}}


def test_multiline_branch_conditions_are_checked(tmp_path, monkeypatch):
    source = tmp_path / "example.py"
    source.write_text("if (\n    first\n    and second\n):\n    pass\n")
    monkeypatch.chdir(tmp_path)
    changes = {"example.py": {3}}
    assert branch_source_lines(changes) == {"example.py": {1, 3}}
    data = report()
    data["files"]["example.py"] = data["files"].pop("rostran/example.py")
    assert not check(data, changes, branch_source_lines(changes))


def test_cli_rejects_missing_branch_data(tmp_path):
    data = report()
    data["meta"]["branch_coverage"] = False
    path = tmp_path / "coverage.json"
    path.write_text(json.dumps(data))
    script = Path(__file__).resolve().parents[1] / "tools/check_coverage.py"
    result = subprocess.run(
        [sys.executable, str(script), str(path)], capture_output=True, text=True
    )
    assert result.returncode == 2
    assert "branch data" in result.stderr


def test_main_checks_report_and_handles_malformed_json(tmp_path, monkeypatch, capsys):
    from tools import check_coverage

    path = tmp_path / "coverage.json"
    path.write_text(json.dumps(report()))
    monkeypatch.setattr(sys, "argv", ["check_coverage", str(path)])
    assert check_coverage.main() == 0
    assert "全量行" in capsys.readouterr().out
    path.write_text("invalid")
    assert check_coverage.main() == 2
    assert "Coverage check failed" in capsys.readouterr().err


def test_branch_source_lines_include_multiline_loop_and_conditional(
    tmp_path, monkeypatch
):
    source = tmp_path / "example.py"
    source.write_text(
        "for item in (\n    values\n):\n    result = 1 if (\n        item\n    ) else 2\n"
    )
    monkeypatch.chdir(tmp_path)
    assert branch_source_lines({"example.py": {2, 5}}) == {"example.py": {1, 2, 4, 5}}


def test_custom_change_filter_and_unchanged_branches(tmp_path, monkeypatch):
    from tools import check_coverage

    def fake_git(*args):
        if args[0] == "merge-base":
            return b"base\n"
        if "--name-only" in args:
            return b"frontend/src/app.ts\0ignored.txt\0"
        return b"@@ -1 +1 @@\n-old\n+new\n"

    monkeypatch.setattr(check_coverage, "git", fake_git)
    assert check_coverage.changed_lines("base", lambda p: p.endswith(".ts")) == {
        "frontend/src/app.ts": {1}
    }
    source = tmp_path / "example.py"
    source.write_text("if condition:\n    pass\n")
    monkeypatch.chdir(tmp_path)
    assert branch_source_lines({"example.py": {10}}) == {"example.py": {10}}


def test_executable_entrypoint_with_valid_report(tmp_path, monkeypatch):
    import runpy

    path = tmp_path / "coverage.json"
    path.write_text(json.dumps(report()))
    monkeypatch.setattr(sys, "argv", ["tools/check_coverage.py", str(path)])
    with pytest.raises(SystemExit) as exc:
        runpy.run_path(
            str(Path(__file__).resolve().parents[1] / "tools/check_coverage.py"),
            run_name="__main__",
        )
    assert exc.value.code == 0


def test_new_root_python_file_is_in_incremental_scope(tmp_path, monkeypatch):
    from tools import check_coverage

    def fake_git(*args):
        if args[0] == "merge-base":
            return b"base\n"
        if "--name-only" in args:
            return b"new_module.py\0tests/test_example.py\0website/tool.py\0"
        return b"@@ -0,0 +1 @@\n+value = 1\n"

    monkeypatch.setattr(check_coverage, "git", fake_git)
    assert check_coverage.changed_lines("base") == {"new_module.py": {1}}


def test_multiline_call_edit_fails_with_real_coverage_report(tmp_path, monkeypatch):
    from tools import check_coverage

    source = tmp_path / "example.py"
    source.write_text(
        'def untested():\n    print(\n        "changed argument"\n    )\n'
        + "for value in [True, False]:\n"
        + "    if value:\n        result = 1\n    else:\n        result = 2\n"
        + "\n".join(f"padding_{i} = {i}" for i in range(40))
    )
    monkeypatch.chdir(tmp_path)
    subprocess.run(
        [sys.executable, "-m", "coverage", "run", "--branch", str(source)],
        check=True,
        capture_output=True,
    )
    subprocess.run(
        [sys.executable, "-m", "coverage", "json", "-o", "report.json"],
        check=True,
        capture_output=True,
    )
    monkeypatch.setattr(
        check_coverage, "changed_lines", lambda base: {"example.py": {3}}
    )
    monkeypatch.setattr(
        sys, "argv", ["check_coverage", "report.json", "--base", "HEAD"]
    )
    assert check_coverage.main() == 1
    data = json.loads(Path("report.json").read_text())
    assert check(data)  # Only incremental coverage should reject this edit.


def test_statement_mapping_keeps_comments_and_body_edits_separate(tmp_path):
    from tools.check_coverage import statement_source_lines

    path = tmp_path / "example.py"
    path.write_text(
        'def f():\n    value = (\n        "first"\n        # comment\n        "second"\n'
        "    )\n    if value:\n        print(value)\n"
    )
    name = str(path)
    assert statement_source_lines({name: {5}})[name] == {2, 5}
    assert statement_source_lines({name: {4}})[name] == {4}
    assert statement_source_lines({name: {8}})[name] == {8}
