import { mkdtempSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";
import { createRequire } from "node:module";
import { expect, it } from "vitest";

const { conditionRanges } = createRequire(import.meta.url)("../coverage-conditions.cjs");

it("selects multiline if and ternary conditions without including their bodies", () => {
  const dir = mkdtempSync(join(tmpdir(), "coverage-conditions-"));
  const path = join(dir, "example.tsx");
  try {
    writeFileSync(path, [
      "if (", "  flag", ") {", "  result = 1;", "} else if (other) {",
      "  result = 2;", "}", "const view = flag", "  ? <p>yes</p>", "  : <p>no</p>;", "switch (flag) {", "  case 1:", "    result = 1;",
      "  case (", "    2", "  ):", "    result = 2;", "}",
    ].join("\n"));
    const branches = {
      0: { loc: { start: { line: 1, column: 0 } } },
      1: { loc: { start: { line: 5, column: 7 } } },
      2: { loc: { start: { line: 8, column: 13 } } },
      3: { loc: { start: { line: 11, column: 0 } } },
    };
    const ranges = conditionRanges(path, branches);
    const cli = spawnSync(process.execPath, [
      fileURLToPath(new URL("../coverage-conditions.cjs", import.meta.url)),
    ], { input: JSON.stringify({ [path]: branches }), encoding: "utf8" });
    expect(cli.status, cli.stderr).toBe(0);
    expect(JSON.parse(cli.stdout)[path]).toEqual(ranges);
    expect(ranges[0][0].end.line).toBe(2);
    expect(ranges[1][0].end.line).toBe(5);
    expect(ranges[2][0].end.line).toBe(8);
    expect(ranges[3].map((range: any) => [range.start.line, range.end.line]))
      .toEqual([[11, 11], [12, 12], [14, 16]]);
    expect(() => conditionRanges(path, {
      0: { loc: { start: { line: 4, column: 0 } } },
    })).toThrow("Cannot locate branch condition");
  } finally {
    rmSync(dir, { recursive: true });
  }
});
