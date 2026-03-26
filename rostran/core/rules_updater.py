"""
Dynamic rules updater: downloads rules from the GitHub repository and
caches them locally under ``~/.rostran/rules/``.

Version convention
------------------
- ``rostran/rules/VERSIONS.json`` holds the current ``latest`` semantic version and
  maps each version to a commit SHA::

      {
        "latest": "1.2.0",
        "versions": {
          "1.2.0": {"commit": "abc123...", "date": "2024-06-01", "description": "..."},
          "1.1.0": {"commit": "def456...", "date": "2024-05-01", "description": "..."}
        }
      }

- Maintainers update the yml files, bump ``latest`` / ``versions`` in
  ``VERSIONS.json``, and push to main.  No git tags needed.
- ``rostran rules update`` pulls the latest version.
- ``rostran rules update -v 1.1.0`` pulls a specific version by its
  recorded commit SHA.
- ``rostran rules list`` lists available versions from remote.
- ``rostran rules reset`` removes the local cache and reverts to built-in rules.
"""

import errno
import json
import logging
import os
import shutil
import socket
import tarfile
import tempfile
import time
from datetime import datetime, timezone
from io import BytesIO
from typing import Dict, List, Optional
from urllib import request, error

from rostran.core.settings import (
    USER_DATA_DIR,
    USER_RULES_DIR,
    USER_RULES_META_FILE,
    RULES_VERSIONS_JSON_FILE,
    RULES_REPO_OWNER,
    RULES_REPO_NAME,
    RULES_REPO_BRANCH,
    RULES_RAW_URL_TEMPLATE,
    RULES_ARCHIVE_URL_TEMPLATE,
    RULES_ARCHIVE_INNER_PATH,
)

logger = logging.getLogger(__name__)

# Single HTTP attempt timeout (seconds). Large archives may need a long read.
_REQUEST_TIMEOUT = 180
# After a network timeout, retry this many additional times (1 + N total attempts).
_HTTP_TIMEOUT_RETRIES = 5


class RulesUpdateError(Exception):
    pass


# ---------------------------------------------------------------------------
# Local metadata / version helpers
# ---------------------------------------------------------------------------

def _read_meta() -> dict:
    if os.path.isfile(USER_RULES_META_FILE):
        with open(USER_RULES_META_FILE) as f:
            try:
                return json.load(f)
            except json.JSONDecodeError:
                return {}
    return {}


def _write_meta(meta: dict) -> None:
    os.makedirs(USER_DATA_DIR, exist_ok=True)
    with open(USER_RULES_META_FILE, "w") as f:
        json.dump(meta, f, indent=2)


def get_local_rules_version() -> Optional[str]:
    """Return the semantic version of locally cached rules, or None."""
    meta = _read_meta()
    return meta.get("version")


def _read_latest_from_versions_json(path: str) -> Optional[str]:
    """Return the ``latest`` field from a VERSIONS.json file, or None."""
    if not os.path.isfile(path):
        return None
    try:
        with open(path) as f:
            data = json.load(f)
        latest = data.get("latest")
        return str(latest).strip() if latest is not None else None
    except (json.JSONDecodeError, OSError, TypeError):
        return None


def get_builtin_rules_version() -> Optional[str]:
    """Read ``latest`` from the VERSIONS.json shipped inside the package."""
    return _read_latest_from_versions_json(RULES_VERSIONS_JSON_FILE)


# ---------------------------------------------------------------------------
# HTTP helpers
# ---------------------------------------------------------------------------

def _urlerror_is_timeout(exc: error.URLError) -> bool:
    """True if this error is worth retrying (connection timed out, read timeout)."""
    r = exc.reason
    if isinstance(r, socket.timeout):
        return True
    if isinstance(r, TimeoutError):
        return True
    if isinstance(r, OSError) and getattr(r, "errno", None) == errno.ETIMEDOUT:
        return True
    return False


def _http_get(url: str, headers: dict = None, decode: bool = True):
    hdrs = {"User-Agent": "rostran-rules-updater"}
    if headers:
        hdrs.update(headers)
    req = request.Request(url, headers=hdrs)
    max_attempts = 1 + _HTTP_TIMEOUT_RETRIES

    for attempt in range(max_attempts):
        try:
            with request.urlopen(req, timeout=_REQUEST_TIMEOUT) as resp:
                data = resp.read()
                return data.decode() if decode else data
        except error.HTTPError as exc:
            raise RulesUpdateError(
                f"HTTP request failed ({exc.code}): {url}"
            ) from exc
        except error.URLError as exc:
            if _urlerror_is_timeout(exc) and attempt < max_attempts - 1:
                logger.warning(
                    "HTTP timeout (%s), retry %s/%s: %s",
                    exc.reason,
                    attempt + 1,
                    max_attempts,
                    url,
                )
                time.sleep(min(2**attempt, 8))
                continue
            raise RulesUpdateError(
                f"Cannot reach remote: {exc.reason}"
            ) from exc


# ---------------------------------------------------------------------------
# Remote version discovery
# ---------------------------------------------------------------------------

def _fetch_remote_versions_json() -> dict:
    """Fetch the VERSIONS.json from the remote main branch."""
    url = RULES_RAW_URL_TEMPLATE.format(
        owner=RULES_REPO_OWNER,
        repo=RULES_REPO_NAME,
        ref=RULES_REPO_BRANCH,
        file="VERSIONS.json",
    )
    body = _http_get(url)
    try:
        return json.loads(body)
    except json.JSONDecodeError as exc:
        raise RulesUpdateError("Invalid VERSIONS.json from remote") from exc


def fetch_remote_latest_version() -> str:
    """Get the latest rules version string from the remote."""
    versions_data = _fetch_remote_versions_json()
    latest = versions_data.get("latest")
    if not latest:
        raise RulesUpdateError("No 'latest' field in remote VERSIONS.json")
    return latest


def fetch_available_versions() -> List[Dict]:
    """List all available rules versions with their metadata.

    Returns a list of dicts: ``[{"version": "1.2.0", "date": "...", "description": "..."}, ...]``
    sorted by version key (newest first based on insertion order in JSON).
    """
    versions_data = _fetch_remote_versions_json()
    result = []
    for ver, info in versions_data.get("versions", {}).items():
        result.append({
            "version": ver,
            "commit": info.get("commit", ""),
            "date": info.get("date", ""),
            "description": info.get("description", ""),
        })
    return result


def _resolve_commit_for_version(version: str) -> str:
    """Look up the commit SHA for a given version string."""
    versions_data = _fetch_remote_versions_json()
    versions = versions_data.get("versions", {})
    if version not in versions:
        available = ", ".join(versions.keys()) or "none"
        raise RulesUpdateError(
            f"Version '{version}' not found. Available versions: {available}"
        )
    commit = versions[version].get("commit")
    if not commit:
        raise RulesUpdateError(
            f"Version '{version}' has no commit SHA in VERSIONS.json"
        )
    return commit


# ---------------------------------------------------------------------------
# Download & extraction
# ---------------------------------------------------------------------------

def _download_and_extract_rules(ref: str) -> str:
    """Download the repo archive for *ref* (branch or commit SHA) and
    extract the ``rostran/rules/`` subtree into a temp directory."""
    archive_url = RULES_ARCHIVE_URL_TEMPLATE.format(
        owner=RULES_REPO_OWNER,
        repo=RULES_REPO_NAME,
        ref=ref,
    )
    logger.info("Downloading rules from %s ...", archive_url)
    raw = _http_get(archive_url, decode=False)

    tmpdir = tempfile.mkdtemp(prefix="rostran_rules_")
    try:
        with tarfile.open(fileobj=BytesIO(raw), mode="r:gz") as tf:
            top_dirs = {m.name.split("/")[0] for m in tf.getmembers()}
            archive_prefix = top_dirs.pop() if len(top_dirs) == 1 else ""

            rules_prefix = (
                f"{archive_prefix}/{RULES_ARCHIVE_INNER_PATH}"
                if archive_prefix
                else RULES_ARCHIVE_INNER_PATH
            )
            rules_prefix_slash = rules_prefix + "/"

            for member in tf.getmembers():
                if not (member.name == rules_prefix or member.name.startswith(rules_prefix_slash)):
                    continue
                rel = os.path.relpath(member.name, archive_prefix) if archive_prefix else member.name
                inner_rel = os.path.relpath(rel, RULES_ARCHIVE_INNER_PATH)
                if inner_rel == ".":
                    continue
                if member.isdir():
                    os.makedirs(os.path.join(tmpdir, inner_rel), exist_ok=True)
                else:
                    fobj = tf.extractfile(member)
                    if fobj is None:
                        continue
                    dest = os.path.join(tmpdir, inner_rel)
                    os.makedirs(os.path.dirname(dest), exist_ok=True)
                    with open(dest, "wb") as out:
                        out.write(fobj.read())
    except (tarfile.TarError, OSError) as exc:
        shutil.rmtree(tmpdir, ignore_errors=True)
        raise RulesUpdateError(f"Failed to extract rules archive: {exc}") from exc
    return tmpdir


def _read_version_from_dir(rules_dir: str) -> Optional[str]:
    """Read ``latest`` from VERSIONS.json in an extracted rules directory."""
    vj = os.path.join(rules_dir, "VERSIONS.json")
    return _read_latest_from_versions_json(vj)


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def update_rules(version: Optional[str] = None, force: bool = False) -> str:
    """Download rules for a given version (or the latest) and cache locally.

    Parameters
    ----------
    version:
        Semantic version to install (e.g. ``"1.2.0"``).
        ``None`` means "fetch the latest from the main branch".
    force:
        Re-download even if local version matches.

    Returns
    -------
    str
        Human-readable status message.
    """
    if version is None:
        target_version = fetch_remote_latest_version()
        ref = RULES_REPO_BRANCH
    else:
        target_version = version
        ref = _resolve_commit_for_version(version)

    local_version = get_local_rules_version()

    if not force and local_version == target_version:
        return f"Rules are already up-to-date (version: {target_version})."

    tmpdir = _download_and_extract_rules(ref)
    try:
        downloaded_version = _read_version_from_dir(tmpdir)
        if downloaded_version and downloaded_version != target_version:
            logger.warning(
                "VERSIONS.json latest mismatch: expected %s, got %s",
                target_version,
                downloaded_version,
            )

        if os.path.exists(USER_RULES_DIR):
            shutil.rmtree(USER_RULES_DIR)
        shutil.copytree(tmpdir, USER_RULES_DIR)
    finally:
        shutil.rmtree(tmpdir, ignore_errors=True)

    actual_version = downloaded_version or target_version
    _write_meta(
        {
            "version": actual_version,
            "updated_at": datetime.now(timezone.utc).isoformat(),
            "ref": ref,
        }
    )
    old_info = f" (was: {local_version})" if local_version else ""
    return f"Rules updated to version {actual_version}{old_info}."


def has_user_rules() -> bool:
    """Return True if user-level cached rules exist."""
    return os.path.isdir(USER_RULES_DIR)


def clean_user_rules() -> str:
    """Remove the local rules cache, reverting to built-in rules."""
    if os.path.isdir(USER_RULES_DIR):
        shutil.rmtree(USER_RULES_DIR)
    if os.path.isfile(USER_RULES_META_FILE):
        os.remove(USER_RULES_META_FILE)
    return "Local rules cache cleared. Built-in rules will be used."
