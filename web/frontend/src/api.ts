import type {
  Example,
  ExampleMeta,
  Meta,
  TransformOptions,
  TransformResponse,
} from "./types";

export class TransformApiError extends Error {
  type: string;
  log?: string;
  constructor(type: string, message: string, log?: string) {
    super(message);
    this.type = type;
    this.log = log;
  }
}

async function parseError(resp: Response): Promise<never> {
  let type = "Error";
  let message = `Request failed (${resp.status})`;
  let log: string | undefined;
  try {
    const data = await resp.json();
    if (data?.error) {
      type = data.error.type ?? type;
      message = data.error.message ?? message;
      log = data.error.log;
    } else if (data?.detail) {
      message = data.detail;
    }
  } catch {
    /* ignore non-JSON bodies */
  }
  throw new TransformApiError(type, message, log);
}

export async function getMeta(): Promise<Meta> {
  const resp = await fetch("/api/meta");
  if (!resp.ok) return parseError(resp);
  return resp.json();
}

export async function transform(
  files: File[],
  sourceFormat: string,
  targetFormat: string,
  options: TransformOptions,
): Promise<TransformResponse> {
  const form = new FormData();
  form.append("source_format", sourceFormat);
  form.append("target_format", targetFormat);
  form.append("options", JSON.stringify(options));
  for (const file of files) {
    form.append("files", file, file.name);
  }
  const resp = await fetch("/api/transform", { method: "POST", body: form });
  if (!resp.ok) return parseError(resp);
  return resp.json();
}

export async function formatTemplate(
  content: string,
  format: string,
): Promise<string> {
  const form = new FormData();
  form.append("content", content);
  form.append("format", format);
  const resp = await fetch("/api/format", { method: "POST", body: form });
  if (!resp.ok) return parseError(resp);
  const data = await resp.json();
  return data.content;
}

export async function listExamples(): Promise<ExampleMeta[]> {
  const resp = await fetch("/api/examples");
  if (!resp.ok) return parseError(resp);
  return (await resp.json()).examples;
}

export async function getExample(id: string): Promise<Example> {
  const resp = await fetch(`/api/examples/${id}`);
  if (!resp.ok) return parseError(resp);
  return resp.json();
}

export async function getRules(classifier: string): Promise<string> {
  const resp = await fetch(
    `/api/rules?classifier=${encodeURIComponent(classifier)}&markdown=true`,
  );
  if (!resp.ok) return parseError(resp);
  return (await resp.json()).content;
}
