// @vitest-environment jsdom
import { beforeEach, expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({
  languages: vi.fn(), register: vi.fn(), tokens: vi.fn(), configure: vi.fn(),
  theme: vi.fn(), loader: vi.fn(),
}));
vi.mock("@monaco-editor/react", () => ({ loader: { config: mocks.loader } }));
vi.mock("monaco-editor/esm/vs/editor/editor.api", () => ({
  languages: { getLanguages: mocks.languages, register: mocks.register, setMonarchTokensProvider: mocks.tokens, setLanguageConfiguration: mocks.configure },
  editor: { defineTheme: mocks.theme },
}));
vi.mock("monaco-editor/esm/vs/language/json/monaco.contribution", () => ({}));
vi.mock("monaco-editor/esm/vs/basic-languages/yaml/yaml.contribution", () => ({}));
vi.mock("monaco-editor/esm/vs/editor/editor.worker?worker", () => ({ default: class EditorWorker {} }));
vi.mock("monaco-editor/esm/vs/language/json/json.worker?worker", () => ({ default: class JsonWorker {} }));

beforeEach(() => { vi.resetModules(); vi.clearAllMocks(); });

it("registers HCL, configures the theme and selects workers", async () => {
  mocks.languages.mockReturnValue([]);
  await import("../src/monaco");
  expect(mocks.register).toHaveBeenCalledWith({ id: "hcl", extensions: [".tf", ".hcl"] });
  expect(mocks.tokens).toHaveBeenCalledOnce();
  expect(mocks.configure).toHaveBeenCalledOnce();
  expect(mocks.theme).toHaveBeenCalledWith("ros-light", expect.any(Object));
  expect(mocks.loader).toHaveBeenCalledOnce();
  const env = (self as any).MonacoEnvironment;
  expect(env.getWorker("id", "json").constructor.name).toBe("JsonWorker");
  expect(env.getWorker("id", "hcl").constructor.name).toBe("EditorWorker");
});

it("does not register HCL twice", async () => {
  mocks.languages.mockReturnValue([{ id: "hcl" }]);
  await import("../src/monaco");
  expect(mocks.register).not.toHaveBeenCalled();
  expect(mocks.theme).toHaveBeenCalledOnce();
});
