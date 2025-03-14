# 使用

## 转换模版

### 命令

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

### 参数

#### SOURCE_PATH

【必填】源模板文件的路径，可以是 Excel、Terraform、 AWS CloudFormation 或 AlibabaCloud ROS 格式的模板文件。

### OPTIONS

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

> :warning: 如果要转换 Terraform 模板，请配置如下环境变量：
>
> ```bash
> $ export ALICLOUD_ACCESS_KEY="access_key"
> $ export ALICLOUD_SECRET_KEY="secret_key"
> $ export ALICLOUD_REGION="region_id"
> ```

## 格式化模板

### 命令

```bash
rostran format [OPTIONS] PATH...
```

### 参数

#### PATH

【必填】需要格式化的 ROS 模板文件路径。支持指定多个。

#### OPTIONS

支持如下可选项：

- `--replace`: 将源文件内容替换为格式化后的内容。
- `--no-replace`: 【默认】仅输出格式化内容。
- `--skip PATH`: 需要跳过格式化的 ROS 模板文件路径。支持指定多个。

#### 格式化规则

- 模板区块按照 `ROSTemplateFormatVersion`、`Transform`、`Description`、`Conditions`、`Mappings`、`Parameters`、`Resources`、`Outputs`
  、`Metadata`、`Workspace` 排序。
- `Conditions` 区块按照字母升序排序。
- `Mappings` 区块按照字母升序排序。
- `Parameters` 区块以 `Metadata.ALIYUN::ROS::Interface.ParameterGroups.Parameters`（若存在）中定义的顺序排序；每个参数的属性以类型、描述、约束等顺序排序。
- `Resources` 区块以资源依赖顺序排序，其中被依赖的资源放在前面。每个资源属性按照一定规则排序。
- `Outputs` 区块的输出属性按照 `Description`、`Condition`、`Value` 排序。
- `Metadata` 区块按照 `ALIYUN::ROS::Interface`、`ALIYUN::ROS::Designer`、`PredefinedParameters` 排序；每项值属性按照一定规则排序。
- `Workspace` 区块按照字母升序排序，其中 `main.tf` 永远会放在第一个。

## 查看转换规则

### 命令

```bash
rostran rules [OPTIONS]
```

#### OPTIONS

支持如下可选项：

- `--terraform`: 【默认】展示 Terraform 转换规则。
- `--no-terraform`: 不展示 Terraform 转换规则。
- `--cloudformation`: 【默认】展示 CloudFormation 转换规则。
- `--no-cloudformation`: 不展示 CloudFormation 转换规则。
- `--markdown`: 以 markdown 格式展示规则。
- `--no-markdown`: 【默认】以普通方式展示规则。
- `--with-link`: 以 markdown 格式展示规则时附加链接。
- `--no-with-link`: 【默认】以 markdown 格式展示规则时不附加链接。

## 查看帮助信息

### 命令

```bash
rostran --help
```
