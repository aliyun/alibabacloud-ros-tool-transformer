#!/usr/bin/python3
import re
import sys

from setuptools import setup, find_packages

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
)
