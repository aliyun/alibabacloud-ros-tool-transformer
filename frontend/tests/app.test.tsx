// @vitest-environment jsdom
import React from "react";
import { afterEach, beforeEach, expect, it, vi } from "vitest";
import { cleanup, fireEvent, render, screen, waitFor } from "@testing-library/react";
import { App } from "../src/App";
import * as api from "../src/api";

vi.mock("../src/api", () => ({
  getMeta: vi.fn(), listExamples: vi.fn(), getCredentials: vi.fn(),
  getExample: vi.fn(), formatTemplate: vi.fn(), transformStream: vi.fn(),
}));
vi.mock("@monaco-editor/react", () => ({
  default: ({ value, onChange, options }: any) => (
    <textarea aria-label="editor" value={value} readOnly={options?.readOnly} onChange={(e) => onChange?.(e.target.value)} />
  ),
}));
vi.mock("@mantine/core", () => {
  const Menu: any = ({ children }: any) => <div>{children}</div>;
  Menu.Target = Menu.Dropdown = ({ children }: any) => <div>{children}</div>;
  Menu.Item = ({ children, onClick }: any) => <button onClick={onClick}>{children}</button>;
  return {
    Alert: ({ children, title, onClose }: any) => <div role="alert">{title}: {children}<button onClick={onClose}>Dismiss</button></div>,
    Button: ({ children, onClick, disabled }: any) => <button onClick={onClick} disabled={disabled}>{children}</button>,
    Checkbox: ({ label, checked, onChange }: any) => <label><input type="checkbox" checked={checked} onChange={onChange} />{label}</label>,
    Select: ({ label, data, value, onChange }: any) => <label>{label}<select aria-label={label} value={value ?? ""} onChange={(e) => onChange(e.target.value)}><option value="" />{data.map((item: any) => <option key={item.value} value={item.value}>{item.label}</option>)}</select></label>,
    Menu,
  };
});
vi.mock("../src/components/ResultPane", () => ({ ResultPane: ({ result }: any) => <div data-testid="result">{result?.targets?.[0]?.content ?? "empty"}</div> }));
vi.mock("../src/components/LogConsole", () => ({ LogConsole: ({ text, onToggle, onClear }: any) => <div><button onClick={onToggle}>Logs</button><button onClick={onClear}>Clear logs</button>{text}</div> }));

beforeEach(() => {
  vi.mocked(api.getMeta).mockResolvedValue({ version: "1.2", source_formats: [], target_formats: [], rules_classifiers: [] });
  vi.mocked(api.listExamples).mockResolvedValue([{ id: "example", title: "Example one", source_format: "ros", filename: "a.yml", language: "yaml" }]);
  vi.mocked(api.getCredentials).mockResolvedValue({ available: true, source: "environment" });
  vi.mocked(api.getExample).mockResolvedValue({ id: "example", title: "Example one", source_format: "ros", filename: "a.yml", language: "yaml", content: "example template" });
});
afterEach(() => { cleanup(); vi.resetAllMocks(); });

it("reports an empty source and converts editor content with streamed output", async () => {
  vi.mocked(api.transformStream).mockImplementation(async (_files, _source, _target, _options, handlers) => {
    handlers.onLog("starting");
    handlers.onResult({ targets: [{ filename: "template.yml", content: "converted", is_binary: false }], log: "" });
  });
  render(<App />);
  await screen.findByText("v1.2");
  fireEvent.click(screen.getByText("Transform"));
  expect(screen.getByRole("alert").textContent).toContain("Source template is empty");
  fireEvent.click(screen.getByText("Dismiss"));
  fireEvent.change(screen.getByLabelText("editor"), { target: { value: "template" } });
  fireEvent.click(screen.getByText("Transform"));
  await waitFor(() => expect(screen.getByTestId("result").textContent).toBe("converted"));
  expect(screen.getByText(/Converted in/)).toBeTruthy();
  expect(screen.getByText("starting")).toBeTruthy();
  expect(vi.mocked(api.transformStream).mock.calls[0][1]).toBe("cloudformation");
});

it("loads ROS examples, validates and formats JSON and YAML", async () => {
  vi.mocked(api.formatTemplate).mockResolvedValue("formatted");
  vi.mocked(api.transformStream).mockImplementation(async (_files, _source, _target, _options, handlers) => {
    handlers.onError({ type: "Failure", message: "bad template" });
  });
  render(<App />);
  await screen.findByRole("option", { name: "Example one" });
  fireEvent.change(screen.getByLabelText("Example"), { target: { value: "example" } });
  await waitFor(() => expect((screen.getByLabelText("editor") as HTMLTextAreaElement).value).toBe("example template"));
  fireEvent.click(screen.getByLabelText("Validate template"));
  expect(screen.getByText(/Using credentials from environment/)).toBeTruthy();
  fireEvent.click(screen.getByText("Format"));
  await waitFor(() => expect(screen.getByTestId("result").textContent).toBe("formatted"));
  expect(api.formatTemplate).toHaveBeenCalledWith("example template", "yaml");
  fireEvent.change(screen.getByLabelText("editor"), { target: { value: '{"x": 1}' } });
  fireEvent.click(screen.getByText("Format"));
  await waitFor(() => expect(api.formatTemplate).toHaveBeenLastCalledWith('{"x": 1}', "json"));
  fireEvent.click(screen.getByText("Transform"));
  await screen.findByText(/Conversion failed/);
  expect(vi.mocked(api.transformStream).mock.calls[0][3]).toEqual({ validate: true });
  expect(screen.getByRole("alert").textContent).toContain("bad template");
});

it("requires Excel uploads and handles a binary file and clear", async () => {
  const { container } = render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "excel" } });
  fireEvent.click(screen.getByText("Transform"));
  expect(screen.getByRole("alert").textContent).toContain("must be uploaded");
  const input = container.querySelector('input[type="file"]')!;
  fireEvent.change(input, { target: { files: [new File(["binary"], "sample.xlsx")] } });
  await screen.findByText("Binary file — sample.xlsx");
  expect(screen.getByText(/1 file\(s\) loaded/)).toBeTruthy();
  fireEvent.click(screen.getByText("clear"));
  expect(screen.getByText(/Excel input must be uploaded/)).toBeTruthy();
});

it("shows a formatting error and allows changing the target", async () => {
  vi.mocked(api.formatTemplate).mockRejectedValue({ type: "Invalid", message: "bad" });
  render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "ros" } });
  fireEvent.change(screen.getByLabelText("Target"), { target: { value: "tf" } });
  expect(screen.getByText("Result · Terraform")).toBeTruthy();
  fireEvent.change(screen.getByLabelText("editor"), { target: { value: "content" } });
  fireEvent.click(screen.getByText("Format"));
  await screen.findByText("Format failed");
  expect(screen.getByRole("alert").textContent).toContain("Invalid: bad");
});

it("filters Terraform folder uploads, switches files, and sends compatibility mode", async () => {
  vi.mocked(api.transformStream).mockImplementation(async (_files, _source, _target, _options, handlers) => {
    handlers.onResult({ targets: [{ filename: "output.yml", content: "done", is_binary: false }], log: "" });
  });
  const { container } = render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "terraform" } });
  fireEvent.click(screen.getByLabelText("Compatible mode (keep Terraform content)"));
  const makeFile = (name: string, path: string, content: string) => {
    const file = new File([content], name);
    Object.defineProperty(file, "webkitRelativePath", { value: path });
    Object.defineProperty(file, "text", { value: () => Promise.resolve(content) });
    return file;
  };
  const inputs = container.querySelectorAll('input[type="file"]');
  fireEvent.change(inputs[1], { target: { files: [
    makeFile("main.tf", "project/main.tf", "first"),
    makeFile("extra.tfvars", "project/extra.tfvars", "second"),
    makeFile("cache.tf", "project/.terraform/cache.tf", "ignored"),
  ] } });
  await screen.findByText(/2 file\(s\) loaded/);
  fireEvent.click(screen.getByText("extra.tfvars"));
  expect((screen.getByLabelText("editor") as HTMLTextAreaElement).value).toBe("second");
  fireEvent.click(screen.getByText("Transform"));
  await screen.findByText(/Converted in/);
  const [files, source, , options] = vi.mocked(api.transformStream).mock.calls[0];
  expect(source).toBe("terraform");
  expect(files.map((file) => file.path)).toEqual(["project/main.tf", "project/extra.tfvars"]);
  expect(options).toEqual({ compatible: true });
});

it("handles absent credentials, empty format input and resizable panes", async () => {
  vi.mocked(api.getCredentials).mockResolvedValue({ available: false, source: null });
  const { container } = render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "ros" } });
  await waitFor(() => expect(api.getCredentials).toHaveResolved());
  fireEvent.click(screen.getByLabelText("Validate template"));
  await screen.findByText(/No Alibaba Cloud credentials found/);
  fireEvent.click(screen.getByText("Format"));
  expect(screen.getByRole("alert").textContent).toContain("Source template is empty");
  const splitter = container.querySelector(".col-split")!;
  fireEvent.mouseDown(splitter, { clientX: 30 });
  fireEvent.mouseMove(document, { clientX: 200 });
  fireEvent.mouseUp(document);
  fireEvent.click(screen.getByText("Logs"));
  const row = container.querySelector(".row-split")!;
  fireEvent.mouseDown(row, { clientY: 200 });
  fireEvent.mouseMove(document, { clientY: 100 });
  fireEvent.mouseUp(document);
  expect(document.body.style.cursor).toBe("");
});

it("selects JSON and YAML targets and ignores empty selections and uploads", () => {
  const { container } = render(<App />);
  fireEvent.change(screen.getByLabelText("Target"), { target: { value: "yaml" } });
  expect(screen.getByText("Result · ROS YAML")).toBeTruthy();
  fireEvent.change(screen.getByLabelText("Target"), { target: { value: "json" } });
  expect(screen.getByText("Result · ROS JSON")).toBeTruthy();
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "" } });
  fireEvent.change(screen.getByLabelText("Example"), { target: { value: "" } });
  fireEvent.change(container.querySelector('input[type="file"]')!, { target: { files: [] } });
  expect(screen.getByText("Source · AWS CloudFormation")).toBeTruthy();
});

it("uses generic formatting errors when fields are absent", async () => {
  vi.mocked(api.formatTemplate).mockRejectedValue({});
  render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "ros" } });
  fireEvent.change(screen.getByLabelText("editor"), { target: { value: "content" } });
  fireEvent.click(screen.getByText("Format"));
  await screen.findByText("Format failed");
  expect(screen.getByRole("alert").textContent).toContain("Error: [object Object]");
});

it("keeps a selected Terraform file if no source file matches the filter", async () => {
  const { container } = render(<App />);
  fireEvent.change(screen.getByLabelText("Source"), { target: { value: "terraform" } });
  const file = new File(["data"], "other.txt");
  Object.defineProperty(file, "text", { value: () => Promise.resolve("data") });
  fireEvent.change(container.querySelector('input[type="file"]')!, { target: { files: [file] } });
  await screen.findByText(/1 file\(s\) loaded/);
  expect((screen.getByLabelText("editor") as HTMLTextAreaElement).value).toBe("data");
});
