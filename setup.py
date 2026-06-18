#!/usr/bin/python3
import re
import shutil
import subprocess
import sys
from pathlib import Path

from setuptools import setup, find_packages
from setuptools.command.build_py import build_py
from setuptools.command.sdist import sdist

HERE = Path(__file__).parent.resolve()


def _build_frontend():
    """Build the web UI into rostran/web/static so `rostran serve` ships it.

    Skips when already built (e.g. by `make web-build`, or present in an sdist).
    Builds with npm when the frontend source is available; warns and ships an
    API-only service when npm is missing.
    """
    static_index = HERE / "rostran" / "web" / "static" / "index.html"
    frontend = HERE / "web" / "frontend"
    if static_index.exists():
        return
    if not (frontend / "package.json").exists():
        return
    npm = shutil.which("npm")
    if not npm:
        print(
            "WARNING: npm not found; the web UI will not be bundled. "
            "Install Node.js (or run `make web-build`) before packaging.",
            file=sys.stderr,
        )
        return
    print("Building web frontend (npm ci && npm run build)...")
    subprocess.check_call([npm, "ci"], cwd=str(frontend))
    subprocess.check_call([npm, "run", "build"], cwd=str(frontend))


class BuildPyWithFrontend(build_py):
    def run(self):
        _build_frontend()
        super().run()


class SdistWithFrontend(sdist):
    def run(self):
        _build_frontend()
        super().run()


with open("rostran/__init__.py") as f:
    __version__ = re.search(r'__version__\s*=\s*["\']([^"\']+)["\']', f.read()).group(1)

if sys.version_info >= (3, 11):
    import tomllib
else:
    try:
        import tomllib
    except ImportError:
        import tomli as tomllib

with open("pyproject.toml", "rb") as f:
    pyproject = tomllib.load(f)

requirements = pyproject["project"]["dependencies"]

NAME = "alibabacloud_ros_tran"
DESCRIPTION = "Resource Orchestration Service Template Transformer."
AUTHOR = "AlibabaCloud"
AUTHOR_EMAIL = "aliyun-developers-efficiency@list.alibaba-inc.com"
URL = "https://www.alibabacloud.com/product/ros"

# description
with open("README.md", encoding="utf-8") as f:
    LONG_DESCRIPTION = f.read()

setup(
    name=NAME,
    version=__version__,
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    long_description_content_type="text/markdown",
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license="Apache License 2.0",
    url=URL,
    keywords=["alibabacloud", "aliyun", "ros", "transformer", "template"],
    packages=find_packages(exclude=["tests*"]),
    include_package_data=True,
    platforms="any",
    install_requires=requirements,
    python_requires=">=3.9.0",
    classifiers=[
        "Intended Audience :: Developers",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Programming Language :: Python :: 3.13",
        "Programming Language :: Python :: 3.14",
        "Topic :: Software Development :: Libraries",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: POSIX",
        "Operating System :: POSIX :: BSD",
        "Operating System :: POSIX :: Linux",
        "Operating System :: Microsoft :: Windows",
    ],
    entry_points={
        "console_scripts": ["rostran=rostran.cli.__main__:main"],
    },
    cmdclass={"build_py": BuildPyWithFrontend, "sdist": SdistWithFrontend},
)
