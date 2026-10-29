from pathlib import Path
import json
import sys

import pytest

from tools.check_frontend_coverage import check


def sample():
    return {
        str(Path("frontend/src/example.ts").resolve()): {
            "statementMap": {
                "0": {"start": {"line": 1}, "end": {"line": 1}},
                "1": {"start": {"line": 2}, "end": {"line": 3}},
                "2": {"start": {"line": 2}, "end": {"line": 2}},
            },
            "s": {"0": 1, "1": 0, "2": 1},
            "branchMap": {
                "0": {"line": 1, "loc": {"start": {"line": 1}, "end": {"line": 1}}}
            },
            "b": {"0": [1, 0]},
        }
    }


def test_incremental_checks_count_lines_and_branches_independently():
    data = sample()
    assert check(data, {})
    assert check(data, {"frontend/src/example.ts": {2}})
    assert not check(data, {"frontend/src/example.ts": {1}})
    data[next(iter(data))]["s"]["2"] = 0
    assert not check(data, {"frontend/src/example.ts": {2}})
    assert not check(data, {"frontend/src/example.ts": {3}})


def test_incremental_check_rejects_missing_file():
    with pytest.raises(ValueError, match="missing from coverage"):
        check(sample(), {"frontend/src/missing.ts": {1}})


def test_modified_multiline_branch_is_checked():
    data = sample()
    file = data[next(iter(data))]
    file["branchMap"]["0"]["loc"]["end"]["line"] = 2
    assert not check(data, {"frontend/src/example.ts": {2}})


def test_main_checks_changes_and_reports_invalid_report(tmp_path, monkeypatch, capsys):
    from tools import check_frontend_coverage

    path = tmp_path / "coverage.json"
    path.write_text(json.dumps(sample()))
    monkeypatch.setattr(
        check_frontend_coverage, "changed_lines", lambda base, include: {}
    )
    monkeypatch.setattr(
        sys, "argv", ["check_frontend_coverage", str(path), "--base", "HEAD"]
    )
    assert check_frontend_coverage.main() == 0
    assert "前端增量行" in capsys.readouterr().out
    path.write_text("invalid")
    assert check_frontend_coverage.main() == 2
    assert "Frontend coverage check failed" in capsys.readouterr().err


def test_overlapping_statements_choose_narrowest_and_merge_equal_spans():
    data = sample()
    file = data[next(iter(data))]
    file["statementMap"]["3"] = {"start": {"line": 2}, "end": {"line": 2}}
    file["s"]["3"] = 0
    file["statementMap"]["4"] = {"start": {"line": 1}, "end": {"line": 3}}
    file["s"]["4"] = 0
    assert check(data, {"frontend/src/example.ts": {2}})


def test_frontend_executable_entrypoint(tmp_path, monkeypatch):
    import runpy
    from tools import check_coverage

    path = tmp_path / "coverage.json"
    path.write_text(json.dumps(sample()))
    monkeypatch.setattr(check_coverage, "changed_lines", lambda base, include: {})
    monkeypatch.setattr(
        sys, "argv", ["tools.check_frontend_coverage", str(path), "--base", "HEAD"]
    )
    with pytest.raises(SystemExit) as exc:
        runpy.run_path(
            str(
                Path(__file__).resolve().parents[1] / "tools/check_frontend_coverage.py"
            ),
            run_name="__main__",
        )
    assert exc.value.code == 0


def test_condition_ranges_use_parser_output_and_propagate_failures(monkeypatch):
    from tools import check_frontend_coverage as module
    import subprocess

    data = sample()
    file = data[next(iter(data))]
    file["branchMap"]["0"]["type"] = "if"
    file["branchMap"]["0"]["loc"]["end"]["line"] = 3

    def parse(command, input):
        assert command[0] == "node"
        assert json.loads(input)["frontend/src/example.ts"]["0"]["type"] == "if"
        return json.dumps(
            {
                "frontend/src/example.ts": {
                    "0": [{"start": {"line": 1}, "end": {"line": 1}}]
                }
            }
        ).encode()

    monkeypatch.setattr(module.subprocess, "check_output", parse)
    assert check(data, {"frontend/src/example.ts": {2}})
    assert not check(data, {"frontend/src/example.ts": {1}})

    def fail(*args, **kwargs):
        raise subprocess.CalledProcessError(1, "node")

    monkeypatch.setattr(module.subprocess, "check_output", fail)
    with pytest.raises(subprocess.CalledProcessError):
        check(data, {"frontend/src/example.ts": {2}})
