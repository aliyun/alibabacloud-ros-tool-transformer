# ROS Template Transformer

[![alibabacloud-ros-tran](https://img.shields.io/pypi/v/alibabacloud-ros-tran.svg)](https://pypi.python.org/pypi/alibabacloud-ros-tran)
[![alibabacloud-ros-tran](https://img.shields.io/pypi/pyversions/alibabacloud-ros-tran.svg)](https://pypi.python.org/pypi/alibabacloud-ros-tran)


[ROS(Resource Orchestration Service)](https://www.alibabacloud.com/help/resource-orchestration-service) 
Template Transformer is a tool for transforming and formatting.

- Transforms **AWS CloudFormation/Terraform/Excel** template to **ROS** template.
- Formats ROS template.

## Requirements

- Python 3.9+ (tested with Python 3.9 through 3.14)

## Installation

```bash
pip install alibabacloud-ros-tran
```

## Web UI

A browser-based playground is available for transforming and formatting
templates without the command line. Install the optional `serve` extra and
start the local web service:

```bash
pip install "alibabacloud-ros-tran[serve]"
rostran serve
```

This opens `http://127.0.0.1:8080` with a dual-pane editor for converting
CloudFormation / Terraform / Excel / ROS templates, formatting ROS templates,
and browsing transform rules. Use `rostran serve --help` for host, port and
other options.

## Document

Fantastic documentation is available at:
[English](https://aliyun.github.io/alibabacloud-ros-tool-transformer/) |
[中文版](https://aliyun.github.io/alibabacloud-ros-tool-transformer/zh-cn/).
