import { useEffect, useMemo, useRef, useState } from "react";
import Editor from "@monaco-editor/react";
import {
  formatTemplate,
  getExample,
  getMeta,
  listExamples,
  transform,
  TransformApiError,
} from "./api";
import type {
  ApiError,
  ExampleMeta,
  Meta,
  TransformOptions,
  TransformResponse,
} from "./types";
import { ResultPane } from "./components/ResultPane";
import { RulesView } from "./components/RulesView";
import { SOURCE_FORMATS, TARGET_FORMATS, sourceInfo } from "./util";

type View = "playground" | "rules";

export function App() {
  const [meta, setMeta] = useState<Meta | null>(null);
  const [view, setView] = useState<View>("playground");
  const [examples, setExamples] = useState<ExampleMeta[]>([]);

  const [sourceFormat, setSourceFormat] = useState("cloudformation");
  const [targetFormat, setTargetFormat] = useState("auto");
  const [content, setContent] = useState("");
  const [uploads, setUploads] = useState<File[]>([]);

  const [compatible, setCompatible] = useState(false);
  const [validate, setValidate] = useState(false);
  const [akId, setAkId] = useState("");
  const [akSecret, setAkSecret] = useState("");

  const [busy, setBusy] = useState(false);
  const [result, setResult] = useState<TransformResponse | null>(null);
  const [error, setError] = useState<ApiError | null>(null);

  const fileInput = useRef<HTMLInputElement>(null);
  const info = useMemo(() => sourceInfo(sourceFormat), [sourceFormat]);

  useEffect(() => {
    getMeta().then(setMeta).catch(() => undefined);
    listExamples().then(setExamples).catch(() => undefined);
  }, []);

  const isTerraform = sourceFormat === "terraform";
  const isRosSource =
    sourceFormat === "ros" || sourceFormat === "rosTerraform";
  const canValidate = sourceFormat === "ros" && targetFormat === "tf";

  const onSourceFormatChange = (value: string) => {
    setSourceFormat(value);
    setUploads([]);
    setResult(null);
    setError(null);
    if (sourceInfo(value).uploadOnly) setContent("");
  };

  const onFiles = (files: FileList | null) => {
    if (!files || files.length === 0) return;
    const arr = Array.from(files);
    setUploads(arr);
    setError(null);
    // Show the first text file in the editor for reference.
    const first = arr[0];
    if (!info.uploadOnly) {
      first.text().then((t) => setContent(t)).catch(() => undefined);
    }
  };

  const loadExample = async (id: string) => {
    if (!id) return;
    try {
      const ex = await getExample(id);
      setSourceFormat(ex.source_format);
      setUploads([]);
      setContent(ex.content);
      setResult(null);
      setError(null);
    } catch {
      /* ignore */
    }
  };

  const buildFiles = (): File[] | null => {
    if (uploads.length > 0) return uploads;
    if (info.uploadOnly) {
      setError({
        type: "InvalidRequest",
        message: `${info.label} input must be uploaded as a file.`,
      });
      return null;
    }
    if (!content.trim()) {
      setError({ type: "InvalidRequest", message: "Source template is empty." });
      return null;
    }
    return [new File([content], info.filename, { type: "text/plain" })];
  };

  const runTransform = async () => {
    const files = buildFiles();
    if (!files) return;
    const options: TransformOptions = {};
    if (isTerraform && compatible) options.compatible = true;
    if (canValidate && validate && akId && akSecret) {
      options.credentials = {
        access_key_id: akId,
        access_key_secret: akSecret,
      };
    }
    setBusy(true);
    setError(null);
    setResult(null);
    try {
      const res = await transform(files, sourceFormat, targetFormat, options);
      setResult(res);
    } catch (e) {
      if (e instanceof TransformApiError) {
        setError({ type: e.type, message: e.message, log: e.log });
      } else {
        setError({ type: "Error", message: String(e) });
      }
    } finally {
      setBusy(false);
    }
  };

  const runFormat = async () => {
    if (!content.trim()) {
      setError({ type: "InvalidRequest", message: "Source template is empty." });
      return;
    }
    const fmt = content.trimStart().startsWith("{") ? "json" : "yaml";
    setBusy(true);
    setError(null);
    setResult(null);
    try {
      const formatted = await formatTemplate(content, fmt);
      setResult({
        targets: [
          {
            filename: fmt === "json" ? "template.json" : "template.yml",
            content: formatted,
            is_binary: false,
          },
        ],
        log: "",
      });
    } catch (e) {
      if (e instanceof TransformApiError) {
        setError({ type: e.type, message: e.message });
      } else {
        setError({ type: "Error", message: String(e) });
      }
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="app">
      <header className="topbar">
        <div className="brand">
          <span className="logo">ROS</span>
          <span className="title">Template Transformer</span>
        </div>
        <nav className="nav">
          <button
            className={view === "playground" ? "nav-item active" : "nav-item"}
            onClick={() => setView("playground")}
          >
            Playground
          </button>
          <button
            className={view === "rules" ? "nav-item active" : "nav-item"}
            onClick={() => setView("rules")}
          >
            Rules
          </button>
        </nav>
        <div className="version">{meta ? `v${meta.version}` : ""}</div>
      </header>

      {view === "rules" ? (
        <RulesView classifiers={meta?.rules_classifiers ?? ["cloudformation"]} />
      ) : (
        <div className="playground">
          <div className="toolbar">
            <div className="field">
              <label>Source</label>
              <select
                value={sourceFormat}
                onChange={(e) => onSourceFormatChange(e.target.value)}
              >
                {SOURCE_FORMATS.map((s) => (
                  <option key={s.value} value={s.value}>
                    {s.label}
                  </option>
                ))}
              </select>
            </div>
            <span className="arrow">→</span>
            <div className="field">
              <label>Target</label>
              <select
                value={targetFormat}
                onChange={(e) => setTargetFormat(e.target.value)}
              >
                {TARGET_FORMATS.map((t) => (
                  <option key={t.value} value={t.value}>
                    {t.label}
                  </option>
                ))}
              </select>
            </div>

            <div className="field">
              <label>Example</label>
              <select
                value=""
                onChange={(e) => {
                  void loadExample(e.target.value);
                  e.target.value = "";
                }}
              >
                <option value="">Load…</option>
                {examples.map((ex) => (
                  <option key={ex.id} value={ex.id}>
                    {ex.title}
                  </option>
                ))}
              </select>
            </div>

            <button
              className="btn-ghost"
              onClick={() => fileInput.current?.click()}
            >
              Upload
            </button>
            <input
              ref={fileInput}
              type="file"
              hidden
              accept={info.accept}
              multiple={info.multiple}
              onChange={(e) => onFiles(e.target.files)}
            />

            <div className="toolbar-spacer" />

            {isRosSource && (
              <button className="btn" onClick={runFormat} disabled={busy}>
                Format
              </button>
            )}
            <button className="btn primary" onClick={runTransform} disabled={busy}>
              Transform
            </button>
          </div>

          <div className="options">
            {isTerraform && (
              <label className="check">
                <input
                  type="checkbox"
                  checked={compatible}
                  onChange={(e) => setCompatible(e.target.checked)}
                />
                Compatible mode (keep Terraform content)
              </label>
            )}
            {canValidate && (
              <label className="check">
                <input
                  type="checkbox"
                  checked={validate}
                  onChange={(e) => setValidate(e.target.checked)}
                />
                Validate template (needs AccessKey)
              </label>
            )}
            {canValidate && validate && (
              <div className="creds">
                <input
                  placeholder="AccessKey ID"
                  value={akId}
                  onChange={(e) => setAkId(e.target.value)}
                />
                <input
                  placeholder="AccessKey Secret"
                  type="password"
                  value={akSecret}
                  onChange={(e) => setAkSecret(e.target.value)}
                />
                <span className="hint">Used only for this request; never stored.</span>
              </div>
            )}
            {uploads.length > 0 && (
              <span className="uploads">
                {uploads.length} file(s): {uploads.map((f) => f.name).join(", ")}
                <button className="link" onClick={() => setUploads([])}>
                  clear
                </button>
              </span>
            )}
          </div>

          {error && (
            <div className="banner error">
              <strong>{error.type}:</strong> {error.message}
              {error.log && <pre className="log-body">{error.log}</pre>}
            </div>
          )}

          <div className="panes">
            <div className="pane">
              <div className="pane-head">Source ({info.label})</div>
              <div className="editor-wrap">
                <Editor
                  height="100%"
                  theme="vs-dark"
                  language={info.language}
                  value={content}
                  onChange={(v) => setContent(v ?? "")}
                  options={{
                    readOnly: info.uploadOnly,
                    minimap: { enabled: false },
                    fontSize: 13,
                    scrollBeyondLastLine: false,
                  }}
                />
              </div>
            </div>
            <div className="pane">
              <div className="pane-head">Result</div>
              <ResultPane result={result} busy={busy} />
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
