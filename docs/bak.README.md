Alibabacloud ROS tool transformer is used to convert Excel format templates, Terraform templates, or AWS CloudFormation templates to ROS templates, which can help you use Alibaba Cloud resource orchestration services more conveniently.
# Prerequisites
1. Install Python environment, Python version is 3.6 and above.
2. When converting Terraform template to ROS template:
    - Install [Golang](https://golang.google.cn/dl/) environment.
    - Install [Terraform](https://www.terraform.io/downloads.html) and configure environment variables.
3. There are no other requirements for using Excel format template or AWS CloudFormation template to convert ROS template.

# Download Source Code
This project is an open source project, you can download it on [GitHub](https://github.com/aliyun/alibabacloud-ros-tool-transformer).

```bash
git clone https://github.com/aliyun/alibabacloud-ros-tool-transformer.git
```

# Install CLI
Enter the alibabacloud-ros-tool-transformer directory in the terminal, and then execute the following command

```bash
python setup.py install
```

# Usage
Use the following command to view the help information.

```bash
rostran --help
```

### Commands and Arguments

```bash
rostran transform SOURCE_PATH [OPTIONS] 
```

SOURCE_PATH: Required parameter, the original file path to be converted (Excel file or Terraform file or AWS CloudFormation file).
OPTIONS: The following three optional parameters can be used:


- `--source-format`: Valid value: `auto` (default) | `terraform` | `excel`, default to determine the original file format based on the `SOURCE_PATH` suffix
- `--target-path`: The path of the generated ROS template file, default to the current directory. If the value is a directory, a ROS template named `template` will be generated in the directory. If the value is the file path (must be in `json` or `yaml` format), the ROS template with the specified file name will be generated, and there is no need to specify the `--target-format` parameter at this time.
- `--target-format`: The generated ROS template format. Valid value: `auto` (default value) | `json` | `yaml`, when the value is auto and `--target-path` is the file path, the generated ROS template format is the same as the `--target-path` file format. When the value is `auto` and  `-—target-path` is a directory, the generated ROS template will be named `template.yml`.

# Examples
If you use the source template provided in the project, you can directly run the following command.
### Terraform template transform to ROS template
- Use the following command to generate ROS template `template.yml` in the current directory

```bash
rostran transform templates/terraform/alicloud/main.tf
```

- Use the following command to generate ROS template named template.json in the current directory.
<br>
Note: When converting the Terraform template, if the `--source-format` is specified, `SOURCE_PATH` can be the directory where the tf file is located.

```bash
rostran transform templates/terraform/alicloud/main.tf --target-path tests/template.json
```

- Use the following command to produce ROS template named `template.json` in the tests directory

```bash
rostran transform templates/terraform/alicloud/main.tf --target-path tests/template.json
```

### AWS CloudFormation template transform to ROS template
Use the following command to generate ROS template `template.yml` in the current directory.<br>
The remaining optional parameters are the same as the source template for transforming Terraform format.

```bash
rostran transform templates/cloudformation/vpc_sg.json
```

### Excel transform to ROS template
Use the following command to generate ROS templates `template-0.yml` and `template-1.yml` in the current directory.<br>
Each sheet in Excel is a template. If you define multiple templates in Excel,  convert up to 5  templates at the same time, and add an ordered suffix to the generated ROS template.

```bash
rostran transform templates/excel/EcsInstance.xlsx.md
```
