// Bundle Monaco locally (instead of the default CDN loader) so the editor works
// offline when served by `rostran serve`. Only the JSON language service and
// YAML highlighting are pulled in; HCL/Terraform is registered manually below.
import { loader } from "@monaco-editor/react";
import * as monaco from "monaco-editor/esm/vs/editor/editor.api";
import "monaco-editor/esm/vs/language/json/monaco.contribution";
import "monaco-editor/esm/vs/basic-languages/yaml/yaml.contribution";
import editorWorker from "monaco-editor/esm/vs/editor/editor.worker?worker";
import jsonWorker from "monaco-editor/esm/vs/language/json/json.worker?worker";

self.MonacoEnvironment = {
  getWorker(_workerId: string, label: string) {
    if (label === "json") {
      return new jsonWorker();
    }
    return new editorWorker();
  },
};

// Register an HCL / Terraform language with a Monarch tokenizer so .tf files
// get proper syntax highlighting (Monaco ships no HCL grammar).
if (!monaco.languages.getLanguages().some((l) => l.id === "hcl")) {
  monaco.languages.register({ id: "hcl", extensions: [".tf", ".hcl"] });
  monaco.languages.setMonarchTokensProvider("hcl", {
    defaultToken: "",
    tokenPostfix: ".hcl",
    keywords: [
      "resource",
      "data",
      "provider",
      "variable",
      "output",
      "module",
      "locals",
      "terraform",
      "for",
      "in",
      "if",
    ],
    constants: ["true", "false", "null"],
    tokenizer: {
      root: [
        [/#.*$/, "comment"],
        [/\/\/.*$/, "comment"],
        [/\/\*/, "comment", "@comment"],
        [
          /[a-zA-Z_]\w*/,
          {
            cases: {
              "@keywords": "keyword",
              "@constants": "constant",
              "@default": "identifier",
            },
          },
        ],
        [/[{}()[\]]/, "@brackets"],
        [/"/, "string", "@string"],
        [/\b\d+(\.\d+)?\b/, "number"],
        [/[=:,.]/, "operator"],
      ],
      comment: [
        [/[^/*]+/, "comment"],
        [/\*\//, "comment", "@pop"],
        [/[/*]/, "comment"],
      ],
      string: [
        [/\$\{/, { token: "delimiter.interpolation", next: "@interp" }],
        [/[^"\\$]+/, "string"],
        [/\\./, "string.escape"],
        [/"/, "string", "@pop"],
      ],
      interp: [
        [/\}/, { token: "delimiter.interpolation", next: "@pop" }],
        [/[a-zA-Z_]\w*/, "variable"],
        [/[.[\]()]/, "operator"],
        [/"/, "string", "@string"],
      ],
    },
  });
  monaco.languages.setLanguageConfiguration("hcl", {
    comments: { lineComment: "#", blockComment: ["/*", "*/"] },
    brackets: [
      ["{", "}"],
      ["[", "]"],
      ["(", ")"],
    ],
    autoClosingPairs: [
      { open: "{", close: "}" },
      { open: "[", close: "]" },
      { open: "(", close: ")" },
      { open: '"', close: '"' },
    ],
  });
}

// A clean light theme to match the overall UI.
monaco.editor.defineTheme("ros-light", {
  base: "vs",
  inherit: true,
  rules: [],
  colors: {
    "editor.background": "#ffffff",
    "editorLineNumber.foreground": "#c7c7d1",
    "editor.lineHighlightBackground": "#f6f7f9",
  },
});

loader.config({ monaco });
