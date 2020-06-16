# ROS Template Transformer
[ROS(Resource Orchestration Service)](https://www.alibabacloud.com/product/ros) Template Transformer
is a tool for transforming **Excel** template to **ROS** template.

## Requirements
Python 3.6+

## Installation
```bash
pip3 install alibabacloud-ros-tran
```

## Usage
### Transform
Using `transform` command to transform a given template to ROS template in default format(YAML):
```bash
rostran transform templates/excel/EcsInstance.xlsx
```

You can also specify the ROS template format with `--target-format`. For example in JSON format:
```bash
rostran transform templates/excel/EcsInstance.xlsx --target-format json
```

### Help
Using `--help` to see more help information:
```bash
rostran --help
```
