// Bundle Monaco locally (instead of the default CDN loader) so the editor works
// offline when served by `rostran serve`. Only the JSON language service and
// YAML highlighting are pulled in — importing the full `monaco-editor` entry
// would bundle ~80 languages and several language services we never use.
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

loader.config({ monaco });
