const fs = require("node:fs");
const ts = require("typescript");

function conditionRanges(filename, branches) {
  const source = ts.createSourceFile(
    filename, fs.readFileSync(filename, "utf8"), ts.ScriptTarget.Latest, true,
  );
  const conditions = new Map();
  function range(startNode, endNode = startNode) {
    const start = source.getLineAndCharacterOfPosition(startNode.getStart(source));
    const end = source.getLineAndCharacterOfPosition(endNode.getEnd());
    return {
      start: { line: start.line + 1, column: start.character },
      end: { line: end.line + 1, column: end.character },
    };
  }
  function visit(node) {
    const condition = ts.isIfStatement(node) || ts.isSwitchStatement(node) ? node.expression
      : ts.isConditionalExpression(node) ? node.condition : null;
    if (condition) {
      const locations = [range(node, condition)];
      if (ts.isSwitchStatement(node)) {
        for (const clause of node.caseBlock.clauses) {
          if (ts.isCaseClause(clause)) locations.push(range(clause, clause.expression));
        }
      }
      const start = locations[0].start;
      conditions.set(`${start.line}:${start.column}`, locations);
    }
    ts.forEachChild(node, visit);
  }
  visit(source);
  return Object.fromEntries(Object.entries(branches).map(([key, branch]) => {
    const start = branch.loc.start;
    const ranges = conditions.get(`${start.line}:${start.column}`);
    if (!ranges) throw new Error(`Cannot locate branch condition: ${filename}:${start.line}:${start.column}`);
    return [key, ranges];
  }));
}

module.exports = { conditionRanges };
if (require.main === module) {
  const files = JSON.parse(fs.readFileSync(0, "utf8"));
  console.log(JSON.stringify(Object.fromEntries(
    Object.entries(files).map(([path, branches]) => [path, conditionRanges(path, branches)]),
  )));
}
