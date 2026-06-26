import {useMemo, useRef, useState} from 'react';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import '@mantine/core/styles.css';
import {
  ActionIcon,
  Alert,
  Button,
  MantineProvider,
  Select,
  Tooltip,
  createTheme,
} from '@mantine/core';
import Editor, {type Monaco} from '@monaco-editor/react';
import {
  IconAlertTriangle,
  IconArrowRight,
  IconBolt,
  IconCheck,
  IconCopy,
  IconDownload,
  IconFileText,
  IconSparkles,
  IconUpload,
} from '@tabler/icons-react';
import styles from './styles.module.css';

type SourceFormat = 'cloudformation' | 'ros';
type TargetFormat = 'auto' | 'yaml' | 'json';
type StatusKind = 'idle' | 'loading' | 'ready' | 'running' | 'error';

interface PlaygroundManifest {
  pyodideVersion: string;
  pyodideIndexUrl: string;
  pythonPackage: string;
}

interface PyodideRuntime {
  FS: {
    mkdirTree(path: string): void;
    writeFile(path: string, data: Uint8Array): void;
  };
  globals: {
    set(name: string, value: unknown): void;
    delete(name: string): void;
  };
  loadPackage(packages: string | string[]): Promise<void>;
  runPythonAsync(code: string): Promise<unknown>;
}

interface PlaygroundPayload {
  operation: 'transform' | 'format';
  sourceFormat: SourceFormat;
  inputFormat: 'auto';
  targetFormat: TargetFormat;
  content: string;
}

interface PlaygroundResult {
  ok: boolean;
  log?: string;
  targets?: Array<{filename: string; content: string}>;
  error?: {type: string; message: string};
}

declare global {
  interface Window {
    loadPyodide?: (config: {indexURL: string}) => Promise<PyodideRuntime>;
  }
}

const scriptLoads = new Map<string, Promise<void>>();

const CF_SAMPLE = `{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "A VPC with a subnet and a security group that allows SSH.",
  "Parameters": {
    "VpcCidr": {
      "Type": "String",
      "Default": "192.168.0.0/16",
      "Description": "CIDR block for the VPC."
    },
    "SubnetCidr": {
      "Type": "String",
      "Default": "192.168.1.0/24"
    }
  },
  "Resources": {
    "Vpc": {
      "Type": "AWS::EC2::VPC",
      "Properties": {
        "CidrBlock": {"Ref": "VpcCidr"}
      }
    },
    "Subnet": {
      "Type": "AWS::EC2::Subnet",
      "Properties": {
        "VpcId": {"Ref": "Vpc"},
        "CidrBlock": {"Ref": "SubnetCidr"}
      }
    },
    "SecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "Allow SSH",
        "VpcId": {"Ref": "Vpc"},
        "SecurityGroupIngress": [
          {
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIp": "0.0.0.0/0"
          }
        ]
      }
    }
  },
  "Outputs": {
    "VpcId": {
      "Value": {"Ref": "Vpc"}
    },
    "SubnetId": {
      "Value": {"Ref": "Subnet"}
    }
  }
}
`;

// Deliberately scrambled (keys and sections out of canonical order, Properties
// before Type) so formatting produces a visibly reordered, normalized template.
const ROS_SAMPLE = `Outputs:
  SecurityGroupId:
    Value:
      Ref: SecurityGroup
  VpcId:
    Value:
      Ref: Vpc
Resources:
  SecurityGroup:
    Properties:
      SecurityGroupName: web-sg
      VpcId:
        Ref: Vpc
    Type: ALIYUN::ECS::SecurityGroup
  VSwitch:
    Properties:
      ZoneId:
        Ref: ZoneId
      VpcId:
        Ref: Vpc
      CidrBlock: 192.168.1.0/24
    Type: ALIYUN::ECS::VSwitch
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      CidrBlock: 192.168.0.0/16
      VpcName: playground-vpc
Parameters:
  ZoneId:
    Description: The zone to deploy the VSwitch in.
    Type: String
  VpcCidr:
    Default: 192.168.0.0/16
    Type: String
    Description: CIDR block for the VPC.
Description: A VPC with a VSwitch and a security group.
ROSTemplateFormatVersion: '2015-09-01'
`;

const STRINGS = {
  en: {
    source: 'Source',
    target: 'Target',
    example: 'Example',
    loadExample: 'Load…',
    upload: 'Upload',
    transform: 'Transform',
    format: 'Format',
    running: 'Running…',
    loading: 'Loading…',
    cloudformation: 'AWS CloudFormation',
    ros: 'ROS',
    auto: 'Auto',
    rosYaml: 'ROS YAML',
    rosJson: 'ROS JSON',
    sourceHead: 'Source',
    resultHead: 'Result',
    copy: 'Copy',
    copied: 'Copied',
    download: 'Download',
    emptyOutput: 'The transformed template will appear here.',
    converting: 'Converting…',
    transformed: 'Converted',
    formatted: 'Formatted',
    failed: 'Failed',
    empty: 'Source template is empty.',
  },
  zh: {
    source: '源格式',
    target: '目标格式',
    example: '示例',
    loadExample: '加载…',
    upload: '上传',
    transform: '转换',
    format: '格式化',
    running: '运行中…',
    loading: '加载中…',
    cloudformation: 'AWS CloudFormation',
    ros: 'ROS',
    auto: '自动',
    rosYaml: 'ROS YAML',
    rosJson: 'ROS JSON',
    sourceHead: '源',
    resultHead: '结果',
    copy: '复制',
    copied: '已复制',
    download: '下载',
    emptyOutput: '转换后的模板将显示在这里。',
    converting: '转换中…',
    transformed: '转换完成',
    formatted: '格式化完成',
    failed: '失败',
    empty: '源模板为空。',
  },
} as const;

const mantineTheme = createTheme({
  primaryColor: 'brand',
  defaultRadius: 'md',
  fontFamily:
    '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
  colors: {
    // ChatGPT-style green accent, matching the local web UI.
    brand: [
      '#e6f7f1',
      '#c7ebe0',
      '#9fdcc9',
      '#6fccae',
      '#46be97',
      '#22b186',
      '#10a37f',
      '#0a8f6e',
      '#02795d',
      '#00644c',
    ],
  },
});

function loadScript(src: string): Promise<void> {
  const cached = scriptLoads.get(src);
  if (cached) return cached;
  const promise = new Promise<void>((resolve, reject) => {
    const existing = document.querySelector<HTMLScriptElement>(`script[src="${src}"]`);
    if (existing) {
      resolve();
      return;
    }
    const script = document.createElement('script');
    script.src = src;
    script.async = true;
    script.onload = () => resolve();
    script.onerror = () => reject(new Error(`Failed to load ${src}`));
    document.head.appendChild(script);
  });
  scriptLoads.set(src, promise);
  return promise;
}

function staticAssetBase(baseUrl: string, currentLocale: string, defaultLocale: string): string {
  let base = baseUrl;
  if (currentLocale !== defaultLocale && base.endsWith(`/${currentLocale}/`)) {
    base = base.slice(0, base.length - currentLocale.length - 1);
  }
  return `${base}playground/`;
}

async function loadRuntime(assetBase: string): Promise<PyodideRuntime> {
  const manifestResp = await fetch(`${assetBase}manifest.json`);
  if (!manifestResp.ok) {
    throw new Error(`Failed to load playground manifest (${manifestResp.status})`);
  }
  const manifest = (await manifestResp.json()) as PlaygroundManifest;

  await loadScript(`${manifest.pyodideIndexUrl}pyodide.js`);
  if (!window.loadPyodide) {
    throw new Error('Pyodide loader is not available');
  }

  const pyodide = await window.loadPyodide({indexURL: manifest.pyodideIndexUrl});
  await pyodide.loadPackage('ruamel.yaml');

  const packageResp = await fetch(`${assetBase}${manifest.pythonPackage}`);
  if (!packageResp.ok) {
    throw new Error(`Failed to load playground package (${packageResp.status})`);
  }
  const packageBytes = new Uint8Array(await packageResp.arrayBuffer());
  const zipPath = '/home/pyodide/rostran-playground.zip';
  pyodide.FS.mkdirTree('/home/pyodide');
  pyodide.FS.writeFile(zipPath, packageBytes);
  await pyodide.runPythonAsync(`
import os
import sys
import zipfile

target = "/home/pyodide/rostran-playground"
os.makedirs(target, exist_ok=True)
with zipfile.ZipFile("${zipPath}") as package:
    package.extractall(target)
if target not in sys.path:
    sys.path.insert(0, target)
`);
  return pyodide;
}

async function runPython(pyodide: PyodideRuntime, payload: PlaygroundPayload): Promise<PlaygroundResult> {
  pyodide.globals.set('payload_json', JSON.stringify(payload));
  try {
    const raw = await pyodide.runPythonAsync(`
import rostran.wasm as wasm
wasm.handle(payload_json)
`);
    return JSON.parse(String(raw)) as PlaygroundResult;
  } finally {
    pyodide.globals.delete('payload_json');
  }
}

const EDITOR_OPTIONS = {
  minimap: {enabled: false},
  fontSize: 13,
  scrollBeyondLastLine: false,
  padding: {top: 10},
  automaticLayout: true,
} as const;

function defineTheme(monaco: Monaco) {
  monaco.editor.defineTheme('ros-light', {
    base: 'vs',
    inherit: true,
    rules: [],
    colors: {
      'editor.background': '#ffffff',
      'editorLineNumber.foreground': '#c7c7d1',
      'editor.lineHighlightBackground': '#f6f7f9',
    },
  });
}

export default function Playground() {
  const {i18n, siteConfig} = useDocusaurusContext();
  const lang = i18n.currentLocale.startsWith('zh') ? 'zh' : 'en';
  const t = STRINGS[lang];
  const assetBase = useMemo(
    () => staticAssetBase(siteConfig.baseUrl, i18n.currentLocale, i18n.defaultLocale),
    [siteConfig.baseUrl, i18n.currentLocale, i18n.defaultLocale],
  );

  const runtimeRef = useRef<Promise<PyodideRuntime> | null>(null);
  const fileInput = useRef<HTMLInputElement>(null);

  const [sourceFormat, setSourceFormat] = useState<SourceFormat>('cloudformation');
  const [targetFormat, setTargetFormat] = useState<TargetFormat>('auto');
  const [selectedExample, setSelectedExample] = useState<string | null>(null);
  const [content, setContent] = useState(CF_SAMPLE);
  const [result, setResult] = useState<PlaygroundResult | null>(null);
  const [status, setStatus] = useState<{kind: StatusKind; text: string}>({kind: 'idle', text: ''});
  const [copied, setCopied] = useState(false);

  // Layout: resizable source/result split.
  const [sourceWidth, setSourceWidth] = useState(50); // percent

  const isRos = sourceFormat === 'ros';
  const operation: 'transform' | 'format' = isRos ? 'format' : 'transform';
  const target = result?.targets?.[0];
  const output = target?.content ?? '';
  const filename = target?.filename ?? 'template.yml';
  const error = result && !result.ok ? result.error : undefined;

  const sourceLabel = isRos ? t.ros : t.cloudformation;
  const targetLabel = targetFormat === 'json' ? t.rosJson : targetFormat === 'yaml' ? t.rosYaml : 'ROS';
  const editorLanguage = content.trimStart().startsWith('{') ? 'json' : 'yaml';
  const outputLanguage = filename.endsWith('.json') ? 'json' : 'yaml';

  const resetIO = () => {
    setResult(null);
    setStatus({kind: 'idle', text: ''});
  };

  const onSourceChange = (value: string | null) => {
    if (!value) return;
    const next = value as SourceFormat;
    setSourceFormat(next);
    setTargetFormat('auto');
    setSelectedExample(null);
    setContent(next === 'ros' ? ROS_SAMPLE : CF_SAMPLE);
    resetIO();
  };

  const loadExample = (id: string) => {
    setSelectedExample(id);
    if (id === 'ros') {
      setSourceFormat('ros');
      setContent(ROS_SAMPLE);
    } else {
      setSourceFormat('cloudformation');
      setContent(CF_SAMPLE);
    }
    setTargetFormat('auto');
    resetIO();
  };

  const onUpload = async (file: File | undefined) => {
    if (!file) return;
    const text = await file.text();
    setContent(text);
    setSelectedExample(null);
    resetIO();
  };

  const ensureRuntime = async () => {
    if (!runtimeRef.current) {
      setStatus({kind: 'loading', text: t.loading});
      runtimeRef.current = loadRuntime(assetBase);
    }
    return runtimeRef.current;
  };

  const run = async () => {
    if (!content.trim()) {
      setResult({ok: false, error: {type: 'InvalidRequest', message: t.empty}});
      return;
    }
    setStatus({kind: 'running', text: t.running});
    setResult(null);
    const started = performance.now();
    try {
      const runtime = await ensureRuntime();
      const response = await runPython(runtime, {
        operation,
        sourceFormat,
        inputFormat: 'auto',
        targetFormat,
        content,
      });
      setResult(response);
      const secs = ((performance.now() - started) / 1000).toFixed(1);
      setStatus(
        response.ok
          ? {
              kind: 'ready',
              text: isRos ? t.formatted : `${t.transformed} · ${secs}s`,
            }
          : {kind: 'error', text: response.error?.message ?? t.failed},
      );
    } catch (err) {
      const message = err instanceof Error ? err.message : String(err);
      setResult({ok: false, error: {type: 'Error', message}});
      setStatus({kind: 'error', text: t.failed});
    }
  };

  const copyOutput = async () => {
    if (!output) return;
    await navigator.clipboard.writeText(output);
    setCopied(true);
    setTimeout(() => setCopied(false), 1200);
  };

  const downloadOutput = () => {
    if (!output) return;
    const blob = new Blob([output], {type: 'text/plain;charset=utf-8'});
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = filename;
    link.click();
    URL.revokeObjectURL(url);
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
      document.removeEventListener('mousemove', onMove);
      document.removeEventListener('mouseup', stop);
      document.body.style.cursor = '';
    };
    document.addEventListener('mousemove', onMove);
    document.addEventListener('mouseup', stop);
    document.body.style.cursor = 'col-resize';
  };

  const busy = status.kind === 'loading' || status.kind === 'running';

  return (
    <MantineProvider theme={mantineTheme} forceColorScheme="light">
      <div className={styles.app}>
        <div className={styles.controls}>
          <Select
            label={t.source}
            data={[
              {value: 'cloudformation', label: t.cloudformation},
              {value: 'ros', label: t.ros},
            ]}
            value={sourceFormat}
            onChange={onSourceChange}
            allowDeselect={false}
            w={185}
            comboboxProps={{withinPortal: true}}
          />
          <IconArrowRight className={styles.ctlArrow} size={18} />
          <Select
            label={t.target}
            data={[
              {value: 'auto', label: t.auto},
              {value: 'yaml', label: t.rosYaml},
              {value: 'json', label: t.rosJson},
            ]}
            value={targetFormat}
            onChange={(v) => {
              setTargetFormat((v as TargetFormat) ?? 'auto');
              resetIO();
            }}
            allowDeselect={false}
            w={145}
            comboboxProps={{withinPortal: true}}
          />
          <Select
            label={t.example}
            placeholder={t.loadExample}
            data={[
              {value: 'cloudformation', label: 'CloudFormation · VPC + Subnet + SG'},
              {value: 'ros', label: 'ROS · VPC + VSwitch + SG'},
            ]}
            value={selectedExample}
            onChange={(v) => v && loadExample(v)}
            w={225}
            comboboxProps={{withinPortal: true}}
          />
          <Button
            className={styles.ctlUploads}
            variant="default"
            leftSection={<IconUpload size={15} />}
            onClick={() => fileInput.current?.click()}
          >
            {t.upload}
          </Button>
          <input
            ref={fileInput}
            type="file"
            hidden
            accept=".json,.yml,.yaml"
            onChange={(e) => {
              void onUpload(e.target.files?.[0]);
              e.target.value = '';
            }}
          />

          <div className={styles.ctlSpacer} />

          {(status.kind === 'ready' || status.kind === 'error') && (
            <span
              className={`${styles.statusChip} ${
                status.kind === 'error' ? styles.err : styles.ok
              }`}
            >
              {status.kind === 'error' ? <IconAlertTriangle size={14} /> : <IconCheck size={14} />}
              {status.text}
            </span>
          )}
          <Button
            leftSection={isRos ? <IconSparkles size={16} /> : <IconBolt size={16} />}
            onClick={run}
            loading={busy}
          >
            {isRos ? t.format : t.transform}
          </Button>
        </div>

        {error && (
          <Alert
            variant="light"
            color="red"
            icon={<IconAlertTriangle size={16} />}
            title={error.type}
            className={styles.errorAlert}
            withCloseButton
            onClose={() => setResult(null)}
          >
            {error.message}
          </Alert>
        )}

        <div className={styles.main}>
          <div className={styles.panes}>
            <div className={`${styles.pane}`} style={{width: `${sourceWidth}%`}}>
              <div className={styles.paneHead}>
                {t.sourceHead} · {sourceLabel}
              </div>
              <div className={styles.editorWrap}>
                <Editor
                  height="100%"
                  theme="ros-light"
                  language={editorLanguage}
                  value={content}
                  onChange={(v) => setContent(v ?? '')}
                  beforeMount={defineTheme}
                  options={EDITOR_OPTIONS}
                />
              </div>
            </div>

            <div className={styles.colSplit} onMouseDown={startColDrag} />

            <div className={`${styles.pane} ${styles.resultPane}`}>
              <div className={styles.paneHead}>
                {t.resultHead} · {targetLabel}
              </div>
              {result?.ok && target ? (
                <div className={styles.result}>
                  <div className={styles.resultToolbar}>
                    <span className={styles.resultTitle}>
                      <IconFileText size={14} />
                      {filename}
                    </span>
                    <div className={styles.resultActions}>
                      <Tooltip label={copied ? t.copied : t.copy} withArrow>
                        <ActionIcon variant="subtle" color="gray" onClick={copyOutput}>
                          {copied ? <IconCheck size={16} /> : <IconCopy size={16} />}
                        </ActionIcon>
                      </Tooltip>
                      <Button
                        size="xs"
                        variant="light"
                        color="gray"
                        leftSection={<IconDownload size={14} />}
                        onClick={downloadOutput}
                      >
                        {t.download}
                      </Button>
                    </div>
                  </div>
                  <div className={styles.editorWrap}>
                    <Editor
                      height="100%"
                      theme="ros-light"
                      language={outputLanguage}
                      value={output}
                      path={filename}
                      beforeMount={defineTheme}
                      options={{...EDITOR_OPTIONS, readOnly: true}}
                    />
                  </div>
                </div>
              ) : (
                <div className={styles.resultEmpty}>
                  {busy ? t.converting : t.emptyOutput}
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </MantineProvider>
  );
}
