import type {
  ApiError,
  Example,
  ExampleMeta,
  Meta,
  TransformResponse,
} from "./types";

type Options = Record<string, unknown>;

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

export interface Credentials {
  available: boolean;
  source: string | null;
}

export async function getCredentials(): Promise<Credentials> {
  try {
    const resp = await fetch("/api/credentials");
    if (!resp.ok) return { available: false, source: null };
    return await resp.json();
  } catch {
    return { available: false, source: null };
  }
}

export interface UploadFile {
  path: string;
  blob: Blob;
}

export interface StreamHandlers {
  onLog: (text: string) => void;
  onResult: (result: TransformResponse) => void;
  onError: (error: ApiError) => void;
}

function buildForm(
  files: UploadFile[],
  sourceFormat: string,
  targetFormat: string,
  options: Options,
): FormData {
  const form = new FormData();
  form.append("source_format", sourceFormat);
  form.append("target_format", targetFormat);
  form.append("options", JSON.stringify(options));
  for (const f of files) {
    form.append("files", f.blob, f.path);
  }
  return form;
}

/** POST to the SSE streaming endpoint and dispatch events as they arrive. */
export async function transformStream(
  files: UploadFile[],
  sourceFormat: string,
  targetFormat: string,
  options: Options,
  handlers: StreamHandlers,
): Promise<void> {
  let resp: Response;
  try {
    resp = await fetch("/api/transform/stream", {
      method: "POST",
      body: buildForm(files, sourceFormat, targetFormat, options),
    });
  } catch (e) {
    handlers.onError({ type: "NetworkError", message: String(e) });
    return;
  }
  if (!resp.ok || !resp.body) {
    handlers.onError({
      type: "Error",
      message: `Request failed (${resp.status})`,
    });
    return;
  }

  const reader = resp.body.getReader();
  const decoder = new TextDecoder();
  let buffer = "";

  const dispatch = (raw: string) => {
    let event = "message";
    const dataLines: string[] = [];
    for (const line of raw.split("\n")) {
      if (line.startsWith("event:")) event = line.slice(6).trim();
      else if (line.startsWith("data:")) dataLines.push(line.slice(5).replace(/^ /, ""));
    }
    if (dataLines.length === 0) return;
    let data: unknown;
    try {
      data = JSON.parse(dataLines.join("\n"));
    } catch {
      return;
    }
    if (event === "log") handlers.onLog((data as { text: string }).text);
    else if (event === "result") handlers.onResult(data as TransformResponse);
    else if (event === "error") handlers.onError(data as ApiError);
  };

  for (;;) {
    const { done, value } = await reader.read();
    if (done) break;
    buffer += decoder.decode(value, { stream: true });
    let idx: number;
    while ((idx = buffer.indexOf("\n\n")) >= 0) {
      const raw = buffer.slice(0, idx);
      buffer = buffer.slice(idx + 2);
      dispatch(raw);
    }
  }
  if (buffer.trim()) dispatch(buffer);
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
