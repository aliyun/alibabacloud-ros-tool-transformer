---
sidebar_position: 1
title: 转换模板
---

# 转换模板

## 命令

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

## 参数

### SOURCE_PATH

【必填】源模板文件的路径，可以是 Excel、Terraform、 AWS CloudFormation 或 AlibabaCloud ROS 格式的模板文件。

## 可选项

支持如下可选项：

- `--source-format`/`-S`：源模板文件的格式，取值：`auto`（默认值）| `terraform` | `excel`| `cloudformation` | `ros` |
  `rosTerraform`，默认根据`SOURCE_PATH`后缀确定源文件格式。
- `--target-path`/`-t`：生成模板的文件路径，默认为当前目录，如果值为目录，则在该目录下生成的文件名为 `template` 的 ROS 模板或文件
  名为 `main.tf`、`variables.tf`、`outputs.tf`等的 Terraform 文件，如果值为文件路径，则生成指定文件名的 ROS 或 Terraform 模板，
  此时无需指定`--target-format`参数。
- `--target-format`/`-T`：生成的 ROS 模板格式。取值：`auto`（默认值）| `json` | `yaml`，取值为`auto`且`--target-path`为文件
  路径时，生成的 ROS 模版格式与`--target-path`文件格式相同；取值为`auto`且`--target-path`为目录时，生成的 ROS 模板名
  为`template.yml`。如果是 ROS 模板转 Terraform 模板，则次参数不生效。
- `--compatible`：Terraform 转换为 ROS 模板时是否使用兼容模式。 如果兼容，则将 Terraform 文件内容保留在生成的 ROS 模板中，
  默认仅保留以`.tf`、`.tftpl`、`.tfvars`、`.metadata`、`.mappings`、`.conditions`、`.rules` 结尾的文件，
  `--extra-files`支持更多文件。 否则，转换为使用 ROS 语法的模板。**此选项仅适用于 Terraform 模板文件**。
- `--extra-files`: 当使用兼容模式将 Terraform 转换为 ROS 模板时，指定额外保留的文件, `*` 表示保留所有文件。转换时默认仅保留
  以`.tf`、`.tftpl`、`.tfvars`、`.metadata`、`.mappings`、`.conditions`、`.rules` 结尾的文件，使用此参数可保留更多文件。
- `--force`：是否支持生成的文件覆盖已有文件。如果支持，则将生成的文件覆盖已有文件。否则，存在已有文件时会报错。

:::warning
如果要转换 Terraform 模板，请配置如下环境变量：

```bash
export ALICLOUD_ACCESS_KEY="access_key"
export ALICLOUD_SECRET_KEY="secret_key"
export ALICLOUD_REGION="region_id"
```
:::
