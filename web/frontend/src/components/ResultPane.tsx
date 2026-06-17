import { useEffect, useState } from "react";
import Editor from "@monaco-editor/react";
import type { TransformResponse } from "../types";
import { downloadText, downloadZip, languageForFilename } from "../util";

interface Props {
  result: TransformResponse | null;
  busy: boolean;
}

export function ResultPane({ result, busy }: Props) {
  const [active, setActive] = useState(0);
  const [copied, setCopied] = useState(false);
  const [showLog, setShowLog] = useState(false);

  useEffect(() => {
    setActive(0);
  }, [result]);

  if (busy) {
    return (
      <div className="result empty">
        <div className="spinner" />
        <p>Transforming…</p>
      </div>
    );
  }

  if (!result) {
    return (
      <div className="result empty">
        <p>The transformed template will appear here.</p>
      </div>
    );
  }

  const targets = result.targets;
  const current = targets[Math.min(active, targets.length - 1)];

  const copy = async () => {
    await navigator.clipboard.writeText(current.content);
    setCopied(true);
    setTimeout(() => setCopied(false), 1200);
  };

  const download = () => {
    if (targets.length === 1) {
      downloadText(targets[0].filename, targets[0].content);
    } else {
      void downloadZip("ros-transform.zip", targets);
    }
  };

  return (
    <div className="result">
      <div className="tabs">
        {targets.map((t, i) => (
          <button
            key={t.filename}
            className={i === active ? "tab active" : "tab"}
            onClick={() => setActive(i)}
            title={t.filename}
          >
            {t.filename}
          </button>
        ))}
        <div className="tabs-spacer" />
        <button className="btn-ghost" onClick={copy} disabled={current.is_binary}>
          {copied ? "Copied" : "Copy"}
        </button>
        <button className="btn-ghost" onClick={download}>
          {targets.length > 1 ? "Download .zip" : "Download"}
        </button>
      </div>
      <div className="editor-wrap">
        {current.is_binary ? (
          <div className="result empty">
            <p>Binary output — use Download to save {current.filename}.</p>
          </div>
        ) : (
          <Editor
            height="100%"
            theme="vs-dark"
            language={languageForFilename(current.filename)}
            value={current.content}
            options={{
              readOnly: true,
              minimap: { enabled: false },
              fontSize: 13,
              scrollBeyondLastLine: false,
            }}
          />
        )}
      </div>
      {result.log?.trim() && (
        <div className="log-panel">
          <button className="log-toggle" onClick={() => setShowLog((v) => !v)}>
            {showLog ? "▾" : "▸"} Transform log
          </button>
          {showLog && <pre className="log-body">{result.log}</pre>}
        </div>
      )}
    </div>
  );
}
