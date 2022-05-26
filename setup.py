#!/usr/bin/python3
import os

from setuptools import setup, find_packages

from rostran import __version__

NAME = "alibabacloud-ros-tran"
DESCRIPTION = "Resource Orchestration Service Template Transformer."
AUTHOR = "AlibabaCloud"
AUTHOR_EMAIL = "aliyun-developers-efficiency@list.alibaba-inc.com"
URL = "https://www.alibabacloud.com/product/ros"

# description
desc_file = open("README.md")
try:
    LONG_DESCRIPTION = desc_file.read()
finally:
    desc_file.close()

# requirements
requirements = []
for line in open("requirements.txt"):
    requirement = line.strip()
    if requirement:
        requirements.append(requirement)

setup(
    name=NAME,
    version=__version__,
    description=DESCRIPTION,
    long_description=LONG_DESCRIPTION,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license="Apache License 2.0",
    url=URL,
    keywords=["alibabacloud", "aliyun", "ros", "transformer", "template"],
    packages=find_packages(exclude=["tests*"]),
    include_package_data=True,
    platforms="any",
    install_requires=requirements,
    classifiers=[
        "Intended Audience :: Developers",
        "License :: OSI Approved :: Apache Software License",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
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
