import { afterEach, describe, expect, it, vi } from "vitest";
import {
  formatTemplate, getCredentials, getExample, getMeta, listExamples, transformStream,
  TransformApiError,
} from "../src/api";

afterEach(() => vi.unstubAllGlobals());

describe("API requests", () => {
  it("loads metadata, examples, and a formatted template", async () => {
    const fetch = vi.fn()
      .mockResolvedValueOnce(Response.json({ version: "1" }))
      .mockResolvedValueOnce(Response.json({ examples: [{ id: "one" }] }))
      .mockResolvedValueOnce(Response.json({ id: "one", content: "template" }))
      .mockResolvedValueOnce(Response.json({ content: "formatted" }));
    vi.stubGlobal("fetch", fetch);
    expect((await getMeta()).version).toBe("1");
    expect(await listExamples()).toEqual([{ id: "one" }]);
    expect((await getExample("one")).content).toBe("template");
    expect(await formatTemplate("input", "yaml")).toBe("formatted");
    expect(fetch.mock.calls[2][0]).toBe("/api/examples/one");
    expect(fetch.mock.calls[3][1].body.get("format")).toBe("yaml");
  });

  it("converts structured, detail, and non-JSON errors", async () => {
    const fetch = vi.fn()
      .mockResolvedValueOnce(Response.json({ error: { type: "BadTemplate", message: "bad", log: "trace" } }, { status: 400 }))
      .mockResolvedValueOnce(Response.json({ detail: "denied" }, { status: 403 }))
      .mockResolvedValueOnce(new Response("oops", { status: 500 }));
    vi.stubGlobal("fetch", fetch);
    await expect(getMeta()).rejects.toMatchObject({ type: "BadTemplate", message: "bad", log: "trace" });
    await expect(listExamples()).rejects.toMatchObject({ type: "Error", message: "denied" });
    await expect(getExample("bad")).rejects.toBeInstanceOf(TransformApiError);
  });

  it("uses fallback error details and handles failed formatting", async () => {
    const fetch = vi.fn()
      .mockResolvedValueOnce(Response.json({ error: {} }, { status: 400 }))
      .mockResolvedValueOnce(Response.json({ detail: "bad format" }, { status: 422 }));
    vi.stubGlobal("fetch", fetch);
    await expect(getMeta()).rejects.toMatchObject({ type: "Error", message: "Request failed (400)" });
    await expect(formatTemplate("{", "json")).rejects.toMatchObject({ message: "bad format" });
  });

  it("treats unavailable credentials as unavailable", async () => {
    const fetch = vi.fn()
      .mockResolvedValueOnce(Response.json({ available: true, source: "environment" }))
      .mockResolvedValueOnce(new Response("error", { status: 500 }))
      .mockRejectedValueOnce(new Error("offline"));
    vi.stubGlobal("fetch", fetch);
    expect(await getCredentials()).toEqual({ available: true, source: "environment" });
    expect(await getCredentials()).toEqual({ available: false, source: null });
    expect(await getCredentials()).toEqual({ available: false, source: null });
  });

  it("dispatches split streaming events and a final event without a delimiter", async () => {
    const encoder = new TextEncoder();
    const stream = new ReadableStream({
      start(controller) {
        for (const chunk of [
          'event: log\ndata: {"text":"hel',
          'lo"}\n\nevent: result\ndata: {"targets":[],"log":""}\n\n',
          'event: error\ndata: {"type":"Error","message":"bad"}',
        ]) controller.enqueue(encoder.encode(chunk));
        controller.close();
      },
    });
    const fetch = vi.fn().mockResolvedValue(new Response(stream));
    vi.stubGlobal("fetch", fetch);
    const handlers = { onLog: vi.fn(), onResult: vi.fn(), onError: vi.fn() };
    await transformStream([{ path: "input.yml", blob: new Blob(["text"]) }], "ros", "tf", {}, handlers);
    expect(handlers.onLog).toHaveBeenCalledWith("hello");
    expect(handlers.onResult).toHaveBeenCalledWith({ targets: [], log: "" });
    expect(handlers.onError).toHaveBeenCalledWith({ type: "Error", message: "bad" });
    expect(fetch.mock.calls[0][1].body.get("source_format")).toBe("ros");
  });

  it("reports network and HTTP failures without throwing", async () => {
    const fetch = vi.fn().mockRejectedValueOnce(new Error("offline"))
      .mockResolvedValueOnce(new Response("failed", { status: 503 }));
    vi.stubGlobal("fetch", fetch);
    const handlers = { onLog: vi.fn(), onResult: vi.fn(), onError: vi.fn() };
    await transformStream([], "ros", "tf", {}, handlers);
    expect(handlers.onError).toHaveBeenLastCalledWith({ type: "NetworkError", message: "Error: offline" });
    await transformStream([], "ros", "tf", {}, handlers);
    expect(handlers.onError).toHaveBeenLastCalledWith({ type: "Error", message: "Request failed (503)" });
  });

  it("ignores unknown, malformed and empty stream events", async () => {
    const events = 'event: log\n\nevent: log\ndata: not-json\n\nevent: other\ndata: {}\n\n';
    vi.stubGlobal("fetch", vi.fn().mockResolvedValue(new Response(events)));
    const handlers = { onLog: vi.fn(), onResult: vi.fn(), onError: vi.fn() };
    await transformStream([], "ros", "tf", {}, handlers);
    expect(handlers.onLog).not.toHaveBeenCalled();
    expect(handlers.onResult).not.toHaveBeenCalled();
    expect(handlers.onError).not.toHaveBeenCalled();
  });
});
