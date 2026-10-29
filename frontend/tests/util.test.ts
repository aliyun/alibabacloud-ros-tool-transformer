import JSZip from "jszip";
import { afterEach, describe, expect, it, vi } from "vitest";
import {
  buildTree,
  downloadText,
  downloadZip,
  isTerraformSourceFile,
  languageForFilename,
  readUploadedFiles,
  sourceInfo,
  uploadPath,
} from "../src/util";

afterEach(() => { vi.restoreAllMocks(); vi.unstubAllGlobals(); });

describe("source and file helpers", () => {
  it("finds formats and detects file languages", () => {
    expect(sourceInfo("terraform").language).toBe("hcl");
    expect(sourceInfo("unknown").value).toBe("cloudformation");
    expect(["A.JSON", "a.yml", "a.yaml", "a.tf", "a.hcl", "a.txt"].map(languageForFilename))
      .toEqual(["json", "yaml", "yaml", "hcl", "hcl", "plaintext"]);
  });

  it("only accepts Terraform source files outside provider caches", () => {
    expect(isTerraformSourceFile("module/main.tf")).toBe(true);
    expect(isTerraformSourceFile("main.tfvars.json")).toBe(true);
    expect(isTerraformSourceFile("main.tfvars")).toBe(true);
    expect(isTerraformSourceFile(".terraform\\cache\\main.tf")).toBe(false);
    expect(isTerraformSourceFile("terraform.tfstate")).toBe(false);
  });

  it("builds a sorted nested file tree", () => {
    const blob = new Blob();
    const files = ["z.tf", "nested/b.tf", "nested/a.tf"].map((path) => ({
      path, content: path, isText: true, blob,
    }));
    const tree = buildTree(files);
    expect(tree.map((node) => node.name)).toEqual(["nested", "z.tf"]);
    expect(tree[0].children?.map((node) => node.name)).toEqual(["a.tf", "b.tf"]);
    expect(tree[0].children?.[0].file?.content).toBe("nested/a.tf");
    expect(buildTree([])).toEqual([]);
    const reversed = ["dir/file.tf", "root.tf"].map((path) => ({ path, content: path, isText: true, blob }));
    expect(buildTree(reversed).map((node) => node.name)).toEqual(["dir", "root.tf"]);
  });

  it("reads text, retains binary content, and handles read failures", async () => {
    const text = new File(["content"], "main.tf");
    Object.defineProperty(text, "webkitRelativePath", { value: "/project/main.tf" });
    const binary = new File(["binary"], "input.XLSX");
    const broken = new File([], "broken.tf");
    vi.spyOn(broken, "text").mockRejectedValue(new Error("unreadable"));
    expect(uploadPath(text, true)).toBe("project/main.tf");
    expect(uploadPath(text, false)).toBe("main.tf");
    const result = await readUploadedFiles([text, binary, broken], true);
    expect(result.map(({ path, content, isText }) => ({ path, content, isText }))).toEqual([
      { path: "project/main.tf", content: "content", isText: true },
      { path: "input.XLSX", content: "", isText: false },
      { path: "broken.tf", content: "", isText: true },
    ]);
  });

  it("downloads text and archives with text and binary targets", async () => {
    const anchors: any[] = [];
    const appendChild = vi.fn();
    const removeChild = vi.fn();
    vi.stubGlobal("document", {
      body: { appendChild, removeChild },
      createElement: () => {
        const anchor = { click: vi.fn(), href: "", download: "" };
        anchors.push(anchor);
        return anchor;
      },
    });
    const blobs: Blob[] = [];
    vi.spyOn(URL, "createObjectURL").mockImplementation((blob) => {
      blobs.push(blob as Blob);
      return "blob:test";
    });
    const revoke = vi.spyOn(URL, "revokeObjectURL").mockImplementation(() => {});
    downloadText("nested/file.yml", "text");
    expect(anchors[0].download).toBe("nested_file.yml");
    expect(await blobs[0].text()).toBe("text");
    await downloadZip("output.zip", [
      { filename: "template.yml", content: "text", is_binary: false },
      { filename: "binary.dat", content: "aGVsbG8=", is_binary: true },
    ]);
    const zip = await JSZip.loadAsync(await blobs[1].arrayBuffer());
    expect(await zip.file("template.yml")?.async("string")).toBe("text");
    expect(await zip.file("binary.dat")?.async("string")).toBe("hello");
    expect(anchors[1].download).toBe("output.zip");
    expect(appendChild).toHaveBeenCalledTimes(2);
    expect(removeChild).toHaveBeenCalledTimes(2);
    expect(revoke).toHaveBeenCalledTimes(2);
  });
});
