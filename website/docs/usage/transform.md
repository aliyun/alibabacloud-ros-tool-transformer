---
sidebar_position: 1
title: Transform Templates
---

# Transform Templates

## Command

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

## Parameters

### SOURCE_PATH

[Required] The path of the source template file, which can be a template file in Excel, Terraform, AWS CloudFormation
or AlibabaCloud ROS format.

## Options

The following options are supported:

- `--source-format`/`-S`: The format of the source template file, valid values: `auto` (default value) | `terraform`
  | `excel`| `cloudformation` | `ros` |`rosTerraform`, the source file format is determined by the suffix of `SOURCE_PATH` by default.
- `--target-path`/`-t`: The file path of the generated template. Default to current directory. If the path is a
  directory, the generated file name is a ROS template of `template` in this directory or Terraform files with file
  names `main.tf`, `variables.tf`, `outputs.tf`, etc. If the path is a file (must be
  in json or yaml format), a ROS template with the specified file name will be generated, and there is no need to
  specify `--target-format` option.
- `--target-format`/`-T`: The generated ROS template format. Valid value: `auto` (default value) | `json` | `yaml`. When
  the value is `auto` and `--target-path` is the file path, the generated ROS The template format is the same as
  the `--target-path` file format. When the value is `auto` and `--target-path` is a directory, the generated ROS
  template is named `template.yml`. If it is a ROS template to a Terraform template, the secondary parameters will not
  take effect.
- `--compatible`: Whether to use compatible mode when transforming Terraform to ROS template. If compatible, keep the
  Terraform file content in the generated ROS template, files only ending with `.tf`, `.tftpl`, `.tfvars`, `.metadata`,
  `.mappings`, `.conditions`, `.rules` are retained by default, `--extra-files` supports more files.
  Otherwise, it is transformed to a template using ROS syntax.
  **This option is only available for Terraform template files.**
- `--extra-files`: Specify additional files to retain when converting Terraform to ROS templates using compatibility
  mode, `*` means retain all files. By default, only files ending with `.tf`, `.tftpl`, `.tfvars`, `.metadata`,
  `.mappings`, `.conditions`, `.rules` will be retained during conversion. Use this parameter to retain more files.
- `--force`: Whether a generated file can overwrite an existing file. If supported, the generated file
  overwrites the existing file. Otherwise, an error will be reported when existing files exist.

:::warning
If you want to convert Terraform templates, please configure the following environment variables:

```bash
export ALICLOUD_ACCESS_KEY="access_key"
export ALICLOUD_SECRET_KEY="secret_key"
export ALICLOUD_REGION="region_id"
```
:::
