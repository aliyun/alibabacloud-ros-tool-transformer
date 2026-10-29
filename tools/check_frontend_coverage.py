"""Check coverage of changed frontend lines and branches in an Istanbul report."""

import argparse
import json
import os
from pathlib import Path
import subprocess
import sys

from tools.check_coverage import THRESHOLD, changed_lines


def decision_ranges(files, changes):
    """Trim branch ranges to their conditions using the frontend's TS parser."""
    branches = {
        path: {
            key: branch
            for key, branch in files[path]["branchMap"].items()
            if branch.get("type") in ("if", "cond-expr", "switch")
        }
        for path, lines in changes.items()
        if lines and path in files
    }
    branches = {path: values for path, values in branches.items() if values}
    if not branches:
        return {}
    script = Path(__file__).resolve().parents[1] / "frontend/coverage-conditions.cjs"
    return json.loads(
        subprocess.check_output(
            ["node", str(script)], input=json.dumps(branches).encode()
        )
    )


def check(report, changes):
    files = {os.path.relpath(path): data for path, data in report.items()}
    conditions = decision_ranges(files, changes)
    covered_lines = total_lines = covered_branches = total_branches = 0
    for path, lines in changes.items():
        if path not in files:
            raise ValueError(
                f"Changed source file missing from coverage report: {path}"
            )
        file = files[path]
        line_hits = {}
        for key, location in file["statementMap"].items():
            start = location["start"]["line"]
            end = location["end"]["line"]
            span = end - start
            for line in lines:
                if start <= line <= end:
                    previous = line_hits.get(line)
                    hits = file["s"][key]
                    if previous is None or span < previous[0]:
                        line_hits[line] = (span, hits)
                    elif span == previous[0]:
                        line_hits[line] = (span, max(previous[1], hits))
        changed_hits = [hits for _, hits in line_hits.values()]
        covered_lines += sum(hits > 0 for hits in changed_hits)
        total_lines += len(changed_hits)
        for key, branch in file["branchMap"].items():
            locations = conditions.get(path, {}).get(key, [branch["loc"]])
            if any(
                location["start"]["line"] <= line <= location["end"]["line"]
                for location in locations
                for line in lines
            ):
                hits = file["b"][key]
                covered_branches += sum(hit > 0 for hit in hits)
                total_branches += len(hits)
    passed = True
    for name, covered, total in (
        ("前端增量行", covered_lines, total_lines),
        ("前端增量分支", covered_branches, total_branches),
    ):
        percent = covered * 100 / total if total else 100
        ok = not total or covered * 100 >= THRESHOLD * total
        print(f"{name}: {covered}/{total} ({percent:.2f}%) {'PASS' if ok else 'FAIL'}")
        passed &= ok
    return passed


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("report")
    parser.add_argument("--base", required=True)
    args = parser.parse_args()
    try:
        with open(args.report, encoding="utf-8") as stream:
            report = json.load(stream)
        changes = changed_lines(
            args.base,
            lambda path: (
                path.startswith("frontend/src/")
                and path.endswith((".ts", ".tsx"))
                and not path.endswith(".d.ts")
                and ".test." not in path
            ),
        )
        return 0 if check(report, changes) else 1
    except (ValueError, KeyError, OSError, subprocess.CalledProcessError) as exc:
        print(f"Frontend coverage check failed: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
