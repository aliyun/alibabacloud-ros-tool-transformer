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

- `--source-format`/`-S`: The format of the source template file, valid values: `auto` (default value) | `terraform`
  | `excel`| `cloudformation`, the source file format is determined by the suffix of `SOURCE_PATH` by default.
- `--target-path`/`-t`: The file path of the generated ROS template. Default to current directory. If the path is a
  directory, the generated file name is a ROS template of `template` in this directory. If the path is a file (must be
  in json or yaml format), a ROS template with the specified file name will be generated, and there is no need to
  specify ` --target-format` option.
- `--target-format`/`-T`: The generated ROS template format. Valid value: `auto` (default value) | `json` | `yaml`. When
  the
  value is `auto` and `--target-path` is the file path, the generated ROS The template format is the same as
  the `--target-path` file format. When the value is `auto` and `--target-path` is a directory, the generated ROS
  template is named `template.yml`.
- `--compatible`: Whether to use compatible mode when transforming Terraform to ROS template. If compatible, keep the
  Terraform file content in the generated ROS template. Otherwise, it is transformed to a template using ROS syntax.
  **This option is only available for Terraform template files.**

## Format Template

### Command

```bash
rostran format [OPTIONS] PATH...
```

### Parameters

#### PATH

[Required] The path of ROS template file to format. Support to specify multiple.

#### OPTIONS

The following options are supported:

- `--replace`: Replace the content of the source file with the formatted content.
- `--no-replace`: [Default] Only print formatted content.
- `--skip PATH`: The path of ROS Template file that need to skip formatting. Support to specify multiple.

#### Formatting rules

- The sections of template are sorted according to `ROSTemplateFormatVersion`, `Transform`, `Description`, `Conditions`
  , `Mappings`, `Parameters`, `Resources`, `Outputs`, `Metadata`, `Workspace`.
- The `Conditions` section is sorted in ascending alphabetical order.
- The `Mappings` section is sorted in ascending alphabetical order.
- The `Parameters` section is sorted in the order defined
  in `Metadata.ALIYUN::ROS::Interface.ParameterGroups.Parameters` (if present). The properties of each parameter are
  sorted in the order of type, description, constraints, etc.
- The `Resources` section is sorted in resource dependency order, with dependent resources first. Each resource
  attribute
  is sorted according to certain rules.
- The output properties of the `Outputs` section are sorted by `Description`, `Condition`, `Value`.
- The `Metadata` section are sorted according to `ALIYUN::ROS::Interface`, `ALIYUN::ROS::Designer`
  , `PredefinedParameters`. The attributes of each Metadata value are sorted according to certain rules.
- The `Workspace` section is sorted in ascending alphabetical order, where `main.tf` is always placed first.

### View Help Information

### Command

```bash
rostran --help
```