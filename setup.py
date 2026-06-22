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

    The built assets are committed, so this is a no-op for normal builds (and for
    release/CI, which may lack a recent Node.js). It only rebuilds when the assets
    are missing and a usable npm is available, and never fails the build.
    """
    static_index = HERE / "rostran" / "web" / "static" / "index.html"
    frontend = HERE / "frontend"
    if static_index.exists():
        return
    if not (frontend / "package.json").exists():
        return
    npm = shutil.which("npm")
    if not npm:
        print(
            "WARNING: web UI not built and npm not found; shipping API only. "
            "Run `make web-build` to bundle the UI.",
            file=sys.stderr,
        )
        return
    print("Building web frontend (npm ci && npm run build)...")
    try:
        subprocess.check_call([npm, "ci"], cwd=str(frontend))
        subprocess.check_call([npm, "run", "build"], cwd=str(frontend))
    except subprocess.CalledProcessError as exc:
        print(
            f"WARNING: web UI build failed ({exc}); shipping API only. "
            "Build it with `make web-build`.",
            file=sys.stderr,
        )


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
