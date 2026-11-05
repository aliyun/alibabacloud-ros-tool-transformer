import { defineConfig } from "vitest/config";
import react from "@vitejs/plugin-react";
import { fileURLToPath } from "node:url";

export default defineConfig({
  plugins: [react()],
  test: {
    coverage: {
      provider: "v8",
      include: ["src/**/*.{ts,tsx}"],
      exclude: ["src/**/*.d.ts"],
      reporter: [
        "text",
        "json",
        ["cobertura", { projectRoot: fileURLToPath(new URL("..", import.meta.url)) }],
      ],
    },
  },
});
