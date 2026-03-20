import os

CUR_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(CUR_DIR)
ROOT = os.path.dirname(BASE_DIR)
RULES_DIR = os.path.join(BASE_DIR, "rules")
BIN_DIR = os.path.join(BASE_DIR, "bin")

# User-level rules directory for dynamic updates (overrides built-in rules)
USER_DATA_DIR = os.path.join(os.path.expanduser("~"), ".rostran")
USER_RULES_DIR = os.path.join(USER_DATA_DIR, "rules")
USER_RULES_META_FILE = os.path.join(USER_DATA_DIR, "rules_meta.json")

# Remote rules source (GitHub repo)
RULES_REPO_OWNER = os.environ.get("ROSTRAN_RULES_REPO_OWNER", "aliyun")
RULES_REPO_NAME = os.environ.get(
    "ROSTRAN_RULES_REPO_NAME", "alibabacloud-ros-tool-transformer"
)
RULES_REPO_BRANCH = os.environ.get("ROSTRAN_RULES_BRANCH", "main")

# Built-in rules version files
RULES_VERSION_FILE = os.path.join(RULES_DIR, "VERSION")
RULES_VERSIONS_JSON_FILE = os.path.join(RULES_DIR, "VERSIONS.json")

# GitHub raw content URL templates
RULES_RAW_URL_TEMPLATE = (
    "https://raw.githubusercontent.com/{owner}/{repo}/{ref}/rostran/rules/{file}"
)
# GitHub archive URL pattern (supports branch names and commit SHAs)
RULES_ARCHIVE_URL_TEMPLATE = (
    "https://github.com/{owner}/{repo}/archive/{ref}.tar.gz"
)
# Path inside the archive where rules live
RULES_ARCHIVE_INNER_PATH = "rostran/rules"
