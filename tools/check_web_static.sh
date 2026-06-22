#!/usr/bin/env bash
#
# Pre-commit check: ensure the committed web UI assets in rostran/web/static are
# up to date with the frontend sources under frontend. Runs only when those
# sources change, rebuilds the UI, and fails if the result differs from what is
# committed (so a stale UI is never published).
#
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

if ! command -v npm >/dev/null 2>&1; then
  echo "WARNING: npm not found; skipping web UI build check." >&2
  echo "         Run 'make web-build' and commit rostran/web/static manually." >&2
  exit 0
fi

if [ ! -d frontend/node_modules ]; then
  echo "Installing web frontend dependencies (first build check)..." >&2
  npm --prefix frontend ci >/dev/null 2>&1
fi

npm --prefix frontend run build >/dev/null 2>&1

if [ -n "$(git status --porcelain -- rostran/web/static)" ]; then
  echo "ERROR: rostran/web/static is out of date with frontend sources." >&2
  echo "       The UI has been rebuilt for you; stage it and re-commit:" >&2
  echo "           git add rostran/web/static" >&2
  git --no-pager status --short -- rostran/web/static >&2
  exit 1
fi
