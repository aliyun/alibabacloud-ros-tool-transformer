# Usage
## Command
### View Help Information
```bash
rostran --help
```
### Transform Template
```bash
rostran transform SOURCE_PATH [OPTIONS] 
```
## Parameter
### SOURCE_PATH
Required parameter, the path of the source template file, which can be a template file in Excel, Terraform, or AWS CloudFormation format.
### OPTIONS
Optional parameters, you can use the following three valid parameters:
- `--source-format`: The format of the source template file, valid values: `auto` (default value) | `terraform` | `excel`| `cloudformation`, the source file format is determined by the suffix of `SOURCE_PATH` by default.
- `--target-path`: The file path of the generated ROS template. Default to current directory. If the value is a directory, the file name generated in the directory is the ROS template of `template`. If the value is the file path (must be in json or yaml format), the specified file is generated Name of the ROS template, there is no need to specify the `--target-format` parameter at this time.
- `--target-format`: The generated ROS template format. Valid value: `auto` (default value) | `json` | `yaml`, when the value is `auto` and `--target-path` is a file path, the generated ROS template format and `--target-path` The `file format is the same; when the value is `auto` and `--target-path` is the directory, the generated ROS template name is `template.yml`.

