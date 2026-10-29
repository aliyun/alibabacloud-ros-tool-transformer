"""Check line and branch coverage globally and on changed Python lines."""

import argparse
import ast
import json
import re
import subprocess
import sys
import tokenize


HUNK = re.compile(r"^@@ -\d+(?:,\d+)? \+(\d+)(?:,(\d+))? @@")
THRESHOLD = 95


def git(*args):
    return subprocess.check_output(["git", *args])


def changed_lines(base, include=None):
    base = git("merge-base", base, "HEAD").decode().strip()
    paths = git("diff", "--name-only", "-z", "--diff-filter=ACMRT", base, "HEAD")
    changes = {}
    for path in paths.decode().split("\0"):
        if include is not None:
            in_scope = include(path)
        else:
            in_scope = (
                path.endswith(".py")
                and not path.startswith(("tests/", "website/", ".venv/"))
                and path != "rostran/wasm.py"
            )
        if not in_scope:
            continue
        diff = git(
            "diff",
            "--no-ext-diff",
            "--no-color",
            "--no-renames",
            "-U0",
            base,
            "HEAD",
            "--",
            path,
        )
        lines = set()
        for line in diff.decode().splitlines():
            match = HUNK.match(line)
            if match:
                start = int(match.group(1))
                count = int(match.group(2) or "1")
                lines.update(range(start, start + count))
        changes[path] = lines
    return changes


def statement_source_lines(changes):
    """Map edits inside a logical statement to its executable starting line."""
    result = {}
    ignored = {
        tokenize.NL,
        tokenize.INDENT,
        tokenize.DEDENT,
        tokenize.COMMENT,
        tokenize.ENDMARKER,
    }
    for path, lines in changes.items():
        mapped = set(lines)
        start = None
        touched = False
        with tokenize.open(path) as stream:
            for token in tokenize.generate_tokens(stream.readline):
                if token.type == tokenize.NEWLINE:
                    if touched:
                        mapped.add(start)
                    start, touched = None, False
                elif token.type not in ignored:
                    if start is None:
                        start = token.start[0]
                    touched |= any(
                        token.start[0] <= line <= token.end[0] for line in lines
                    )
        result[path] = mapped
    return result


def branch_source_lines(changes):
    """Include a branch's source line when its multi-line condition changes."""
    result = {}
    for path, lines in changes.items():
        branch_lines = set(lines)
        with open(path, encoding="utf-8") as stream:
            tree = ast.parse(stream.read(), filename=path)
        for node in ast.walk(tree):
            if isinstance(node, (ast.If, ast.While, ast.IfExp)):
                end = node.test.end_lineno
            elif isinstance(node, (ast.For, ast.AsyncFor)):
                end = node.iter.end_lineno
            else:
                continue
            if any(node.lineno <= line <= end for line in lines):
                branch_lines.add(node.lineno)
        result[path] = branch_lines
    return result


def check(report, changes=None, branch_changes=None):
    if not report.get("meta", {}).get("branch_coverage"):
        raise ValueError("Coverage report must include branch data")
    files = report["files"]
    totals = report["totals"]
    if not totals["num_statements"] or not totals["num_branches"]:
        raise ValueError("Coverage report contains no statements or branches")
    counts = {
        "全量行": (totals["covered_lines"], totals["num_statements"]),
        "全量分支": (totals["covered_branches"], totals["num_branches"]),
    }
    if changes is not None:
        covered_lines = total_lines = covered_branches = total_branches = 0
        for path, changed in changes.items():
            if path not in files:
                raise ValueError(
                    f"Changed source file missing from coverage report: {path}"
                )
            file = files[path]
            executed = set(file["executed_lines"]) & changed
            missing = set(file["missing_lines"]) & changed
            covered_lines += len(executed)
            total_lines += len(executed) + len(missing)
            changed_branch = (
                branch_changes[path] if branch_changes is not None else changed
            )
            covered = [
                arc for arc in file["executed_branches"] if arc[0] in changed_branch
            ]
            missing_arcs = [
                arc for arc in file["missing_branches"] if arc[0] in changed_branch
            ]
            covered_branches += len(covered)
            total_branches += len(covered) + len(missing_arcs)
        counts.update(
            {
                "增量行": (covered_lines, total_lines),
                "增量分支": (covered_branches, total_branches),
            }
        )
    passed = True
    for name, (covered, total) in counts.items():
        percent = covered * 100 / total if total else 100
        ok = not total or covered * 100 >= THRESHOLD * total
        print(f"{name}: {covered}/{total} ({percent:.2f}%) {'PASS' if ok else 'FAIL'}")
        passed &= ok
    return passed


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("report")
    parser.add_argument("--base", help="Git revision to compare with HEAD")
    args = parser.parse_args()
    try:
        with open(args.report, encoding="utf-8") as stream:
            report = json.load(stream)
        changes = changed_lines(args.base) if args.base else None
        branch_changes = branch_source_lines(changes) if changes is not None else None
        line_changes = statement_source_lines(changes) if changes is not None else None
        return 0 if check(report, line_changes, branch_changes) else 1
    except (
        ValueError,
        KeyError,
        OSError,
        SyntaxError,
        tokenize.TokenError,
        subprocess.CalledProcessError,
    ) as exc:
        print(f"Coverage check failed: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
