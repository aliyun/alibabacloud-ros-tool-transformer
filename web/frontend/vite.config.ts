import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

// Build output is written straight into the Python package so it ships in the
// wheel and is served by `rostran serve`.
export default defineConfig({
  plugins: [react()],
  base: "/",
  build: {
    outDir: "../../rostran/web/static",
    emptyOutDir: true,
    assetsDir: "assets",
    // Monaco's editor core is legitimately large; keep it in its own chunk for
    // caching and lift the warning threshold above its real size.
    chunkSizeWarningLimit: 3000,
    rollupOptions: {
      output: {
        manualChunks(id) {
          if (id.includes("monaco-editor")) return "monaco";
        },
      },
    },
  },
  server: {
    port: 5173,
    proxy: {
      "/api": {
        target: "http://127.0.0.1:8080",
        changeOrigin: true,
      },
    },
  },
});
