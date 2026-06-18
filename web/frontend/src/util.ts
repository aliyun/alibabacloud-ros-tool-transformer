import JSZip from "jszip";
import type { TargetFile } from "./types";

export interface SourceFormatInfo {
  value: string;
  label: string;
  language: string;
  filename: string;
  /** Whether this source must be uploaded as a file (cannot be pasted). */
  uploadOnly?: boolean;
  accept?: string;
  /** Whether multiple files / a folder can be uploaded (e.g. several .tf files). */
  multiple?: boolean;
}

export const SOURCE_FORMATS: SourceFormatInfo[] = [
  {
    value: "cloudformation",
    label: "AWS CloudFormation",
    language: "json",
    filename: "template.json",
    accept: ".json,.yml,.yaml",
  },
  {
    value: "terraform",
    label: "Terraform",
    language: "hcl",
    filename: "main.tf",
    accept: ".tf",
    multiple: true,
  },
  {
    value: "excel",
    label: "Excel",
    language: "plaintext",
    filename: "template.xlsx",
    uploadOnly: true,
    accept: ".xlsx",
  },
  {
    value: "ros",
    label: "ROS",
    language: "yaml",
    filename: "template.yml",
    accept: ".json,.yml,.yaml",
  },
  {
    value: "rosTerraform",
    label: "ROS + Terraform",
    language: "yaml",
    filename: "template.yml",
    accept: ".json,.yml,.yaml",
  },
];

export const TARGET_FORMATS = [
  { value: "auto", label: "Auto" },
  { value: "yaml", label: "ROS YAML" },
  { value: "json", label: "ROS JSON" },
  { value: "tf", label: "Terraform" },
];

export function sourceInfo(value: string): SourceFormatInfo {
  return SOURCE_FORMATS.find((s) => s.value === value) ?? SOURCE_FORMATS[0];
}

export function languageForFilename(name: string): string {
  const lower = name.toLowerCase();
  if (lower.endsWith(".json")) return "json";
  if (lower.endsWith(".yml") || lower.endsWith(".yaml")) return "yaml";
  if (lower.endsWith(".tf") || lower.endsWith(".hcl")) return "hcl";
  return "plaintext";
}

export interface UploadedFile {
  path: string;
  content: string;
  isText: boolean;
  blob: Blob;
}

export interface TreeNode {
  name: string;
  path: string;
  isDir: boolean;
  children?: TreeNode[];
  file?: UploadedFile;
}

/** Build a nested tree from flat file paths. */
export function buildTree(files: UploadedFile[]): TreeNode[] {
  const roots: Record<string, TreeNode> = {};
  const ensure = (
    bucket: Record<string, TreeNode>,
    name: string,
    path: string,
    isDir: boolean,
  ): TreeNode => {
    if (!bucket[name]) {
      bucket[name] = { name, path, isDir, children: isDir ? [] : undefined };
    }
    return bucket[name];
  };

  const childMaps = new WeakMap<TreeNode, Record<string, TreeNode>>();
  for (const f of files) {
    const parts = f.path.split("/").filter(Boolean);
    let bucket = roots;
    parts.forEach((part, i) => {
      const isLeaf = i === parts.length - 1;
      const path = parts.slice(0, i + 1).join("/");
      const node = ensure(bucket, part, path, !isLeaf);
      if (isLeaf) {
        node.file = f;
      } else {
        let m = childMaps.get(node);
        if (!m) {
          m = {};
          childMaps.set(node, m);
        }
        bucket = m;
      }
    });
  }

  const collect = (bucket: Record<string, TreeNode>): TreeNode[] => {
    const nodes = Object.values(bucket).map((n) => {
      const m = childMaps.get(n);
      return m ? { ...n, children: collect(m) } : n;
    });
    return nodes.sort((a, b) => {
      if (a.isDir !== b.isDir) return a.isDir ? -1 : 1;
      return a.name.localeCompare(b.name);
    });
  };
  return collect(roots);
}

/**
 * Keep only real Terraform source files from a folder upload, dropping the
 * `.terraform/` provider cache (huge plugin binaries), plans, state, locks, and
 * unrelated files. The conversion re-runs `terraform init/plan` itself.
 */
export function isTerraformSourceFile(path: string): boolean {
  const segments = path.replace(/\\/g, "/").split("/");
  if (segments.includes(".terraform")) return false;
  const base = (segments.pop() ?? "").toLowerCase();
  return (
    base.endsWith(".tf") ||
    base.endsWith(".tfvars") ||
    base.endsWith(".tfvars.json")
  );
}

export function uploadPath(file: File, usePath: boolean): string {
  const rawPath =
    (usePath && (file as File & { webkitRelativePath?: string }).webkitRelativePath) ||
    file.name;
  return rawPath.replace(/^\/+/, "");
}

export async function readUploadedFiles(
  files: File[],
  usePath: boolean,
): Promise<UploadedFile[]> {
  const out: UploadedFile[] = [];
  for (const file of files) {
    const path = uploadPath(file, usePath);
    const isText = !path.toLowerCase().endsWith(".xlsx");
    let content = "";
    if (isText) {
      try {
        content = await file.text();
      } catch {
        content = "";
      }
    }
    out.push({ path, content, isText, blob: file });
  }
  return out;
}

export function downloadText(filename: string, content: string) {
  const blob = new Blob([content], { type: "text/plain;charset=utf-8" });
  triggerDownload(blob, filename.replace(/\//g, "_"));
}

export async function downloadZip(name: string, targets: TargetFile[]) {
  const zip = new JSZip();
  for (const t of targets) {
    if (t.is_binary) {
      zip.file(t.filename, t.content, { base64: true });
    } else {
      zip.file(t.filename, t.content);
    }
  }
  const blob = await zip.generateAsync({ type: "blob" });
  triggerDownload(blob, name);
}

function triggerDownload(blob: Blob, filename: string) {
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
}
