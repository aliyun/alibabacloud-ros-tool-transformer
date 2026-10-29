// @vitest-environment jsdom
import React from "react";
import { afterEach, describe, expect, it, vi } from "vitest";
import { cleanup, fireEvent, render, screen } from "@testing-library/react";
import { FileTree } from "../src/components/FileTree";
import { LogConsole } from "../src/components/LogConsole";
import { ResultPane } from "../src/components/ResultPane";
import * as util from "../src/util";

vi.mock("@mantine/core", () => ({
  ActionIcon: ({ children, onClick, disabled }: any) => <button onClick={onClick} disabled={disabled}>{children}</button>,
  Button: ({ children, onClick }: any) => <button onClick={onClick}>{children}</button>,
  Tooltip: ({ children }: any) => children,
  Loader: () => <span>Loading</span>,
}));
vi.mock("@monaco-editor/react", () => ({ default: ({ value }: any) => <div data-testid="editor">{value}</div> }));

afterEach(() => { cleanup(); vi.restoreAllMocks(); vi.unstubAllGlobals(); });

describe("file tree", () => {
  it("opens and closes folders and selects files", () => {
    const file = { name: "main.tf", path: "dir/main.tf", isDir: false };
    const select = vi.fn();
    render(<FileTree nodes={[{ name: "dir", path: "dir", isDir: true, children: [file] }]} selected={file.path} onSelect={select} />);
    expect(screen.getByText("main.tf").parentElement?.className).toContain("active");
    fireEvent.click(screen.getByText("main.tf"));
    expect(select).toHaveBeenCalledWith(file);
    fireEvent.click(screen.getByText("dir"));
    expect(screen.queryByText("main.tf")).toBeNull();
    fireEvent.click(screen.getByText("dir"));
    expect(screen.getByText("main.tf")).toBeTruthy();
  });
});

describe("log console", () => {
  it("shows progress, clears logs without toggling, and collapses", () => {
    const toggle = vi.fn();
    const clear = vi.fn();
    const { rerender } = render(<LogConsole text="first" running collapsed={false} height={100} onToggle={toggle} onClear={clear} />);
    expect(screen.getByText("first")).toBeTruthy();
    expect(screen.getByText("Loading")).toBeTruthy();
    fireEvent.click(screen.getByRole("button"));
    expect(clear).toHaveBeenCalledOnce();
    expect(toggle).not.toHaveBeenCalled();
    fireEvent.click(screen.getByText("Logs"));
    expect(toggle).toHaveBeenCalledOnce();
    rerender(<LogConsole text="" running={false} collapsed height={100} onToggle={toggle} onClear={clear} />);
    expect(screen.queryByText("first")).toBeNull();
  });

  it("shows empty running and idle placeholders", () => {
    const props = { text: "", collapsed: false, height: 100, onToggle: vi.fn(), onClear: vi.fn() };
    const { rerender } = render(<LogConsole {...props} running />);
    expect(screen.getByText("Starting…")).toBeTruthy();
    rerender(<LogConsole {...props} running={false} />);
    expect(screen.getByText("Conversion logs will appear here.")).toBeTruthy();
  });
});

describe("result pane", () => {
  it("shows empty and running states", () => {
    const { rerender } = render(<ResultPane result={null} running={false} />);
    expect(screen.getByText("The transformed template will appear here.")).toBeTruthy();
    rerender(<ResultPane result={null} running />);
    expect(screen.getByText("Converting…")).toBeTruthy();
  });

  it("prefers main.tf, switches files and downloads multiple targets", () => {
    const zip = vi.spyOn(util, "downloadZip").mockResolvedValue(undefined);
    const targets = [
      { filename: "notes.txt", content: "notes", is_binary: false },
      { filename: "main.tf", content: "terraform", is_binary: false },
      { filename: "binary.xlsx", content: "data", is_binary: true },
    ];
    render(<ResultPane result={{ targets, log: "" }} running={false} />);
    expect(screen.getByTestId("editor").textContent).toBe("terraform");
    fireEvent.click(screen.getByText("notes.txt"));
    expect(screen.getByTestId("editor").textContent).toBe("notes");
    fireEvent.click(screen.getByText("binary.xlsx"));
    expect(screen.getByText(/Binary output/)).toBeTruthy();
    expect(screen.getByRole("button", { name: "" }).hasAttribute("disabled")).toBe(true);
    fireEvent.click(screen.getByText("Download .zip"));
    expect(zip).toHaveBeenCalledWith("ros-transform.zip", targets);
  });

  it("copies and downloads a single text result", async () => {
    const writeText = vi.fn().mockResolvedValue(undefined);
    Object.defineProperty(navigator, "clipboard", { value: { writeText }, configurable: true });
    const download = vi.spyOn(util, "downloadText").mockImplementation(() => {});
    render(<ResultPane result={{ targets: [{ filename: "template.yml", content: "body", is_binary: false }], log: "" }} running={false} />);
    fireEvent.click(screen.getByRole("button", { name: "" }));
    expect(writeText).toHaveBeenCalledWith("body");
    fireEvent.click(screen.getByText("Download"));
    expect(download).toHaveBeenCalledWith("template.yml", "body");
  });
});
