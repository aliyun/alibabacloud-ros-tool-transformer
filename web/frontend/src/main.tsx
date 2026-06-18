import React from "react";
import ReactDOM from "react-dom/client";
import "@mantine/core/styles.css";
import { MantineProvider, createTheme } from "@mantine/core";
import "./monaco";
import { App } from "./App";
import "./styles.css";

const theme = createTheme({
  primaryColor: "brand",
  defaultRadius: "md",
  fontFamily:
    '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
  colors: {
    // ChatGPT-style green accent.
    brand: [
      "#e6f7f1",
      "#c7ebe0",
      "#9fdcc9",
      "#6fccae",
      "#46be97",
      "#22b186",
      "#10a37f",
      "#0a8f6e",
      "#02795d",
      "#00644c",
    ] as unknown as [
      string,
      string,
      string,
      string,
      string,
      string,
      string,
      string,
      string,
      string,
    ],
  },
});

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <MantineProvider theme={theme} defaultColorScheme="light">
      <App />
    </MantineProvider>
  </React.StrictMode>,
);
