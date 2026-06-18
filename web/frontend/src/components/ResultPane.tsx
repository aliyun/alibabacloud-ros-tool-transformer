import { useEffect, useMemo, useState } from "react";
import Editor from "@monaco-editor/react";
import { ActionIcon, Button, Tooltip } from "@mantine/core";
import { IconCheck, IconCopy, IconDownload, IconFileText } from "@tabler/icons-react";
import type { TransformResponse } from "../types";
import { FileTree } from "./FileTree";
import {
  buildTree,
  downloadText,
  downloadZip,
  languageForFilename,
  type TreeNode,
  type UploadedFile,
} from "../util";

interface Props {
  result: TransformResponse | null;
  running: boolean;
}

export function ResultPane({ result, running }: Props) {
  const [selected, setSelected] = useState<string | null>(null);
  const [copied, setCopied] = useState(false);

  const targets = result?.targets ?? [];

  const treeFiles = useMemo<UploadedFile[]>(
    () =>
      targets.map((t) => ({
        path: t.filename,
        content: t.content,
        isText: !t.is_binary,
        blob: new Blob([t.content]),
      })),
    [targets],
  );
  const tree = useMemo(() => buildTree(treeFiles), [treeFiles]);

  useEffect(() => {
    // Prefer main.tf as the default view for Terraform output.
    const main = targets.find(
      (t) => t.filename === "main.tf" || t.filename.endsWith("/main.tf"),
    );
    setSelected(main?.filename ?? targets[0]?.filename ?? null);
  }, [result]);

  if (!result) {
    return (
      <div className="result-empty">
        {running ? "Converting…" : "The transformed template will appear here."}
      </div>
    );
  }

  const showTree = targets.length > 1;
  const current = targets.find((t) => t.filename === selected) ?? targets[0];

  const copy = async () => {
    await navigator.clipboard.writeText(current.content);
    setCopied(true);
    setTimeout(() => setCopied(false), 1200);
  };

  const download = () => {
    if (targets.length === 1) downloadText(targets[0].filename, targets[0].content);
    else void downloadZip("ros-transform.zip", targets);
  };

  return (
    <div className="result">
      <div className="result-toolbar">
        <span className="result-title">
          <IconFileText size={14} />
          {current.filename}
        </span>
        <div className="result-actions">
          <Tooltip label={copied ? "Copied" : "Copy"} withArrow>
            <ActionIcon
              variant="subtle"
              color="gray"
              onClick={copy}
              disabled={current.is_binary}
            >
              {copied ? <IconCheck size={16} /> : <IconCopy size={16} />}
            </ActionIcon>
          </Tooltip>
          <Button
            size="xs"
            variant="light"
            color="gray"
            leftSection={<IconDownload size={14} />}
            onClick={download}
          >
            {targets.length > 1 ? "Download .zip" : "Download"}
          </Button>
        </div>
      </div>
      <div className="result-body">
        {showTree && (
          <div className="tree-panel">
            <FileTree
              nodes={tree}
              selected={current.filename}
              onSelect={(n: TreeNode) => n.file && setSelected(n.path)}
            />
          </div>
        )}
        <div className="editor-wrap">
          {current.is_binary ? (
            <div className="result-empty">
              Binary output — use Download to save {current.filename}.
            </div>
          ) : (
            <Editor
              height="100%"
              theme="ros-light"
              language={languageForFilename(current.filename)}
              value={current.content}
              path={current.filename}
              options={{
                readOnly: true,
                minimap: { enabled: false },
                fontSize: 13,
                scrollBeyondLastLine: false,
                padding: { top: 10 },
                automaticLayout: true,
              }}
            />
          )}
        </div>
      </div>
    </div>
  );
}
