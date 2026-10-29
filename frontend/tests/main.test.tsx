// @vitest-environment jsdom
import { expect, it, vi } from "vitest";

const mocks = vi.hoisted(() => ({ render: vi.fn(), createRoot: vi.fn(), createTheme: vi.fn() }));
vi.mock("react-dom/client", () => ({ default: { createRoot: mocks.createRoot } }));
vi.mock("@mantine/core", () => ({ MantineProvider: () => null, createTheme: mocks.createTheme }));
vi.mock("../src/monaco", () => ({}));
vi.mock("../src/App", () => ({ App: () => null }));

it("renders the application into the root element", async () => {
  document.body.innerHTML = '<div id="root"></div>';
  mocks.createTheme.mockReturnValue({});
  mocks.createRoot.mockReturnValue({ render: mocks.render });
  await import("../src/main");
  expect(mocks.createRoot).toHaveBeenCalledWith(document.getElementById("root"));
  expect(mocks.render).toHaveBeenCalledOnce();
  expect(mocks.createTheme).toHaveBeenCalledWith(expect.objectContaining({ primaryColor: "brand" }));
});
