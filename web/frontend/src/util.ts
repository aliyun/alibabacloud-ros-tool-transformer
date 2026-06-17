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
  /** Whether multiple files can be uploaded (e.g. several .tf files). */
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
  if (lower.endsWith(".tf") || lower.endsWith(".tf.json")) return "hcl";
  return "plaintext";
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
