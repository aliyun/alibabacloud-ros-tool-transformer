# ROS Template Transformer
[ROS(Resource Orchestration Service)](https://www.alibabacloud.com/product/ros) Template Transformer
is a tool for transforming **AWS CloudFormation/Terraform/Excel** template to **ROS** template.

## Requirements
- Python 3.6+
- For transforming terraform template, `terraform` need be installed first, 
and only support MacOS currently.

## Installation
```bash
python setup.py install
```

## Usage
### Transform
Using `transform` command to transform a given template to ROS template in default format(YAML).
You can specify options below:
- `--source-format [auto|cloudformation|terraform|excel]` to tell which format of source template
- `--target-format [auto|json|yaml]` to tell which format of target template

#### Transform from AWS CloudFormation
Specifying CloudFormation file path and transforming to one YAML/JSON ROS template.

```bash
$ rostran transform templates/cloudformation/ec2_instance.json
or:
$ rostran transform --source-format cloudformation templates/cloudformation/ec2_instance.json
```

#### Transform from Terraform
Specifying terraform configuration directory and transforming to one YAML/JSON ROS template.

```bash
$ rostran transform --source-format terraform templates/terraform/alicloud
```

#### Transform from Excel
Specifying excel file path and transforming to several YAML/JSON ROS templates.

```bash
$ rostran transform templates/excel/EcsInstance.xlsx
or:
$ rostran transform --source-format excel templates/excel/EcsInstance.xlsx
```


### Help
Using `--help` to see more help information:
```bash
rostran --help
```
