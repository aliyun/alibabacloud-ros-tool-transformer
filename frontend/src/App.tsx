import { useEffect, useMemo, useRef, useState } from "react";
import Editor from "@monaco-editor/react";
import { Alert, Button, Checkbox, Menu, Select } from "@mantine/core";
import {
  IconAlertTriangle,
  IconArrowRight,
  IconBolt,
  IconBook,
  IconBrandGithub,
  IconCheck,
  IconChevronDown,
  IconFile,
  IconFolderUp,
  IconSparkles,
  IconUpload,
  IconX,
} from "@tabler/icons-react";
import logoUrl from "./assets/logo.svg";
import {
  formatTemplate,
  getCredentials,
  getExample,
  getMeta,
  listExamples,
  transformStream,
  type Credentials,
  type UploadFile,
} from "./api";
import type { ApiError, ExampleMeta, Meta, TransformResponse } from "./types";
import { FileTree } from "./components/FileTree";
import { LogConsole } from "./components/LogConsole";
import { ResultPane } from "./components/ResultPane";
import {
  SOURCE_FORMATS,
  TARGET_FORMATS,
  buildTree,
  isTerraformSourceFile,
  languageForFilename,
  readUploadedFiles,
  sourceInfo,
  uploadPath,
  type TreeNode,
  type UploadedFile,
} from "./util";

const DOCS_URL = "https://aliyun.github.io/alibabacloud-ros-tool-transformer/";
const GITHUB_URL = "https://github.com/aliyun/alibabacloud-ros-tool-transformer";

const EDITOR_OPTIONS = {
  minimap: { enabled: false },
  fontSize: 13,
  scrollBeyondLastLine: false,
  padding: { top: 10 },
  automaticLayout: true,
} as const;

type Status = { kind: "ok" | "err"; text: string };

export function App() {
  const [meta, setMeta] = useState<Meta | null>(null);
  const [examples, setExamples] = useState<ExampleMeta[]>([]);

  const [sourceFormat, setSourceFormat] = useState("cloudformation");
  const [targetFormat, setTargetFormat] = useState("auto");
  const [selectedExample, setSelectedExample] = useState<string | null>(null);
  const [content, setContent] = useState("");
  const [uploads, setUploads] = useState<UploadedFile[]>([]);
  const [selectedPath, setSelectedPath] = useState<string | null>(null);

  const [compatible, setCompatible] = useState(false);
  const [validate, setValidate] = useState(false);
  const [creds, setCreds] = useState<Credentials | null>(null);

  const [running, setRunning] = useState(false);
  const [logs, setLogs] = useState("");
  const [result, setResult] = useState<TransformResponse | null>(null);
  const [error, setError] = useState<ApiError | null>(null);
  const [status, setStatus] = useState<Status | null>(null);

  // Layout: resizable source/result split and a collapsible bottom log drawer.
  const [sourceWidth, setSourceWidth] = useState(50); // percent
  const [logHeight, setLogHeight] = useState(200); // px
  const [logCollapsed, setLogCollapsed] = useState(true);

  const fileInput = useRef<HTMLInputElement>(null);
  const folderInput = useRef<HTMLInputElement>(null);
  const info = useMemo(() => sourceInfo(sourceFormat), [sourceFormat]);

  useEffect(() => {
    getMeta()
      .then(setMeta)
      .catch(() => undefined);
    listExamples()
      .then(setExamples)
      .catch(() => undefined);
    getCredentials()
      .then(setCreds)
      .catch(() => undefined);
  }, []);

  // Expand the log drawer whenever a conversion starts.
  useEffect(() => {
    if (running) setLogCollapsed(false);
  }, [running]);

  const isTerraform = sourceFormat === "terraform";
  const isRosSource = sourceFormat === "ros" || sourceFormat === "rosTerraform";
  // Only ROS converts to Terraform; every other source converts to a ROS
  // template (JSON/YAML). Constrain targets so invalid combinations (e.g.
  // CloudFormation -> Terraform) can't be selected.
  const availableTargets = useMemo(
    () =>
      sourceFormat === "ros"
        ? TARGET_FORMATS.filter((t) => t.value === "auto" || t.value === "tf")
        : TARGET_FORMATS.filter((t) => t.value !== "tf"),
    [sourceFormat],
  );
  const canValidate = sourceFormat === "ros";

  const targetLabel = useMemo(() => {
    if (targetFormat === "tf") return "Terraform";
    if (targetFormat === "yaml") return "ROS YAML";
    if (targetFormat === "json") return "ROS JSON";
    return sourceFormat === "ros" ? "Terraform" : "ROS";
  }, [targetFormat, sourceFormat]);

  const tree = useMemo(() => buildTree(uploads), [uploads]);
  // Show the tree for multi-file or folder uploads (paths carry a directory).
  const showTree =
    uploads.length > 1 || uploads.some((u) => u.path.includes("/"));
  const selectedFile =
    uploads.find((u) => u.path === selectedPath) ?? uploads[0] ?? null;

  const resetIO = () => {
    setResult(null);
    setError(null);
    setLogs("");
    setStatus(null);
  };

  const onSourceFormatChange = (value: string | null) => {
    if (!value) return;
    setSourceFormat(value);
    setTargetFormat("auto");
    setSelectedExample(null);
    setUploads([]);
    setSelectedPath(null);
    resetIO();
    if (sourceInfo(value).uploadOnly) setContent("");
  };

  const ingest = async (fileList: FileList | null, usePath: boolean) => {
    if (!fileList || fileList.length === 0) return;
    let picked = Array.from(fileList);
    if (sourceFormat === "terraform") {
      // Folder uploads include .terraform/ provider binaries, plans, etc.
      const kept = picked.filter((f) =>
        isTerraformSourceFile(uploadPath(f, usePath)),
      );
      if (kept.length) picked = kept;
    }
    if (!picked.length) {
      setError({
        type: "InvalidRequest",
        message: "No Terraform source files (.tf) found in the selection.",
      });
      return;
    }
    const files = await readUploadedFiles(picked, usePath);
    setSelectedExample(null);
    setUploads(files);
    setSelectedPath(files.find((f) => f.isText)?.path ?? files[0].path);
    resetIO();
  };

  const clearUploads = () => {
    setUploads([]);
    setSelectedPath(null);
  };

  const loadExample = async (id: string) => {
    if (!id) return;
    try {
      const ex = await getExample(id);
      setSelectedExample(id);
      setSourceFormat(ex.source_format);
      setTargetFormat("auto");
      clearUploads();
      setContent(ex.content);
      resetIO();
    } catch {
      /* ignore */
    }
  };

  const buildFiles = (): UploadFile[] | null => {
    if (uploads.length > 0) {
      return uploads.map((u) => ({ path: u.path, blob: u.blob }));
    }
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
    return [
      { path: info.filename, blob: new Blob([content], { type: "text/plain" }) },
    ];
  };

  const runTransform = async () => {
    const files = buildFiles();
    if (!files) return;
    const options: Record<string, unknown> = {};
    if (isTerraform && compatible) options.compatible = true;
    if (canValidate && validate) options.validate = true;
    setRunning(true);
    resetIO();
    const started = performance.now();
    let ok = false;
    await transformStream(files, sourceFormat, targetFormat, options, {
      onLog: (text) => setLogs((prev) => prev + text),
      onResult: (res) => {
        setResult(res);
        ok = true;
      },
      onError: (err) => setError(err),
    });
    setRunning(false);
    const secs = ((performance.now() - started) / 1000).toFixed(1);
    setStatus(
      ok
        ? { kind: "ok", text: `Converted in ${secs}s` }
        : { kind: "err", text: "Conversion failed" },
    );
  };

  const editorValue = uploads.length ? (selectedFile?.content ?? "") : content;
  const editorLanguage = uploads.length
    ? languageForFilename(selectedFile?.path ?? "")
    : info.language;

  const runFormat = async () => {
    const text = editorValue;
    if (!text.trim()) {
      setError({ type: "InvalidRequest", message: "Source template is empty." });
      return;
    }
    const fmt = text.trimStart().startsWith("{") ? "json" : "yaml";
    setRunning(true);
    resetIO();
    try {
      const formatted = await formatTemplate(text, fmt);
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
      setStatus({ kind: "ok", text: "Formatted" });
    } catch (e) {
      const err = e as { type?: string; message?: string };
      setError({ type: err.type ?? "Error", message: err.message ?? String(e) });
      setStatus({ kind: "err", text: "Format failed" });
    } finally {
      setRunning(false);
    }
  };

  // Drag the vertical divider between the source and result panes.
  const startColDrag = (e: React.MouseEvent) => {
    e.preventDefault();
    const row = (e.currentTarget as HTMLElement).parentElement;
    if (!row) return;
    const rect = row.getBoundingClientRect();
    const onMove = (ev: MouseEvent) => {
      const pct = ((ev.clientX - rect.left) / rect.width) * 100;
      setSourceWidth(Math.min(80, Math.max(20, pct)));
    };
    const stop = () => {
      document.removeEventListener("mousemove", onMove);
      document.removeEventListener("mouseup", stop);
      document.body.style.cursor = "";
    };
    document.addEventListener("mousemove", onMove);
    document.addEventListener("mouseup", stop);
    document.body.style.cursor = "col-resize";
  };

  // Drag the horizontal divider between the panes and the log drawer.
  const startRowDrag = (e: React.MouseEvent) => {
    e.preventDefault();
    const startY = e.clientY;
    const startH = logHeight;
    const onMove = (ev: MouseEvent) => {
      setLogHeight(Math.min(600, Math.max(90, startH + (startY - ev.clientY))));
    };
    const stop = () => {
      document.removeEventListener("mousemove", onMove);
      document.removeEventListener("mouseup", stop);
      document.body.style.cursor = "";
    };
    document.addEventListener("mousemove", onMove);
    document.addEventListener("mouseup", stop);
    document.body.style.cursor = "row-resize";
  };

  return (
    <div className="app">
      <header className="topbar">
        <div className="brand">
          <img className="logo" src={logoUrl} alt="ROS Template Transformer logo" />
          <div className="brand-text">
            <span className="title">ROS Template Transformer</span>
            <span className="tagline">
              Convert CloudFormation · Terraform · Excel to ROS
            </span>
          </div>
        </div>
        <div className="topbar-links">
          <a href={DOCS_URL} target="_blank" rel="noreferrer" className="topbar-link">
            <IconBook size={16} /> Docs
          </a>
          <a
            href={GITHUB_URL}
            target="_blank"
            rel="noreferrer"
            className="topbar-link"
            aria-label="GitHub"
          >
            <IconBrandGithub size={16} />
          </a>
          <span className="version">{meta ? `v${meta.version}` : ""}</span>
        </div>
      </header>

      <div className="controls">
        <Select
          label="Source"
          data={SOURCE_FORMATS.map((s) => ({ value: s.value, label: s.label }))}
          value={sourceFormat}
          onChange={onSourceFormatChange}
          allowDeselect={false}
          w={185}
          comboboxProps={{ withinPortal: true }}
        />
        <IconArrowRight className="ctl-arrow" size={18} />
        <Select
          label="Target"
          data={availableTargets}
          value={targetFormat}
          onChange={(v) => {
            setTargetFormat(v ?? "auto");
            resetIO();
          }}
          allowDeselect={false}
          w={145}
          comboboxProps={{ withinPortal: true }}
        />
        <Select
          label="Example"
          placeholder="Load…"
          data={examples.map((e) => ({ value: e.id, label: e.title }))}
          value={selectedExample}
          onChange={(v) => {
            setSelectedExample(v);
            if (v) void loadExample(v);
          }}
          w={225}
          comboboxProps={{ withinPortal: true }}
        />
        {info.multiple ? (
          <Menu shadow="md" position="bottom-start" withinPortal>
            <Menu.Target>
              <Button
                className="ctl-uploads"
                variant="default"
                leftSection={<IconUpload size={15} />}
                rightSection={<IconChevronDown size={14} />}
              >
                Upload
              </Button>
            </Menu.Target>
            <Menu.Dropdown>
              <Menu.Item
                leftSection={<IconFile size={15} />}
                onClick={() => fileInput.current?.click()}
              >
                Files…
              </Menu.Item>
              <Menu.Item
                leftSection={<IconFolderUp size={15} />}
                onClick={() => folderInput.current?.click()}
              >
                Folder…
              </Menu.Item>
            </Menu.Dropdown>
          </Menu>
        ) : (
          <Button
            className="ctl-uploads"
            variant="default"
            leftSection={<IconUpload size={15} />}
            onClick={() => fileInput.current?.click()}
          >
            Upload
          </Button>
        )}
        <input
          ref={fileInput}
          type="file"
          hidden
          accept={info.accept}
          multiple={info.multiple}
          onChange={(e) => {
            void ingest(e.target.files, false);
            e.target.value = "";
          }}
        />
        <input
          ref={folderInput}
          type="file"
          hidden
          // @ts-expect-error non-standard directory upload attribute
          webkitdirectory=""
          onChange={(e) => {
            void ingest(e.target.files, true);
            e.target.value = "";
          }}
        />

        <div className="ctl-spacer" />

        {status && (
          <span className={`status-chip ${status.kind}`}>
            {status.kind === "ok" ? (
              <IconCheck size={14} />
            ) : (
              <IconAlertTriangle size={14} />
            )}
            {status.text}
          </span>
        )}
        {isRosSource && (
          <Button
            variant="default"
            leftSection={<IconSparkles size={15} />}
            onClick={runFormat}
            disabled={running}
          >
            Format
          </Button>
        )}
        <Button
          leftSection={<IconBolt size={16} />}
          onClick={runTransform}
          loading={running}
        >
          Transform
        </Button>
      </div>

      {(isTerraform || canValidate || uploads.length > 0) && (
        <div className="options">
          {isTerraform && (
            <Checkbox
              size="xs"
              label="Compatible mode (keep Terraform content)"
              checked={compatible}
              onChange={(e) => setCompatible(e.currentTarget.checked)}
            />
          )}
          {canValidate && (
            <Checkbox
              size="xs"
              label="Validate template"
              checked={validate}
              onChange={(e) => setValidate(e.currentTarget.checked)}
            />
          )}
          {canValidate && validate && creds?.available && (
            <span className="hint ok">
              <IconCheck size={13} /> Using credentials from {creds.source}
            </span>
          )}
          {canValidate && validate && creds && !creds.available && (
            <span className="hint warn">
              <IconAlertTriangle size={13} /> No Alibaba Cloud credentials found —
              run <code>aliyun configure</code> to enable validation.
            </span>
          )}
          {uploads.length > 0 && (
            <span className="uploads-info">
              {uploads.length} file(s) loaded
              <button className="link" onClick={clearUploads}>
                <IconX size={12} /> clear
              </button>
            </span>
          )}
        </div>
      )}

      {error && (
        <Alert
          variant="light"
          color="red"
          icon={<IconAlertTriangle size={16} />}
          title={error.type}
          className="error-alert"
          withCloseButton
          onClose={() => setError(null)}
        >
          {error.message}
        </Alert>
      )}

      <div className="main">
        <div className="panes">
          <div className="pane source-pane" style={{ width: `${sourceWidth}%` }}>
            <div className="pane-head">Source · {info.label}</div>
            <div className="source-body">
              {showTree && (
                <div className="tree-panel">
                  <FileTree
                    nodes={tree}
                    selected={selectedFile?.path ?? null}
                    onSelect={(n: TreeNode) => n.file && setSelectedPath(n.path)}
                  />
                </div>
              )}
              <div className="editor-wrap">
                {info.uploadOnly && uploads.length === 0 ? (
                  <div className="result-empty">
                    Paste, upload, or load an example to get started.
                    <br />
                    {info.label} input must be uploaded as a file.
                  </div>
                ) : selectedFile && !selectedFile.isText ? (
                  <div className="result-empty">
                    Binary file — {selectedFile.path}
                  </div>
                ) : (
                  <Editor
                    height="100%"
                    theme="ros-light"
                    language={editorLanguage}
                    value={editorValue}
                    onChange={(v) => !uploads.length && setContent(v ?? "")}
                    options={{
                      ...EDITOR_OPTIONS,
                      readOnly: uploads.length > 0 || info.uploadOnly,
                    }}
                  />
                )}
              </div>
            </div>
          </div>

          <div className="col-split" onMouseDown={startColDrag} />

          <div className="pane result-pane">
            <div className="pane-head">Result · {targetLabel}</div>
            <ResultPane result={result} running={running} />
          </div>
        </div>

        {!logCollapsed && (
          <div className="row-split" onMouseDown={startRowDrag} />
        )}
        <LogConsole
          text={logs}
          running={running}
          collapsed={logCollapsed}
          height={logHeight}
          onToggle={() => setLogCollapsed((v) => !v)}
          onClear={() => setLogs("")}
        />
      </div>
    </div>
  );
}
