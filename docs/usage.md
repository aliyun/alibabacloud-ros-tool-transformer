# Usage

## Transform Template

### Command

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

### Parameters

#### SOURCE_PATH

[Required] The path of the source template file, which can be a template file in Excel, Terraform, or AWS CloudFormation
format.

#### OPTIONS

The following options are supported:

- `--source-format`: The format of the source template file, valid values: `auto` (default value) | `terraform`
  | `excel`| `cloudformation`, the source file format is determined by the suffix of `SOURCE_PATH` by default.
- `--target-path`: The file path of the generated ROS template. Default to current directory. If the value is a
  directory, the file name generated in the directory is the ROS template of `template`. If the value is the file path (
  must be in json or yaml format), the specified file is generated Name of the ROS template, there is no need to specify
  the `--target-format` parameter at this time.
- `--target-format`: The generated ROS template format. Valid value: `auto` (default value) | `json` | `yaml`, when the
  value is `auto` and `--target-path` is a file path, the generated ROS template format and `--target-path`
  The `file format is the same; when the value is `auto` and `
  --target-path` is the directory, the generated ROS template name is `template.yml`.

## Format Template

### Command

```bash
rostran format [OPTIONS] PATH
```

### Parameters

#### PATH

[Required] The path of ROS template file to format.

#### OPTIONS

The following options are supported:

- `--replace`: Replace the content of the source file with the formatted content.
- `--no-replace`: [Default] Only print formatted content.

### View Help Information

### Command

```bash
rostran --help
```