# 使用

## 转换模版

### 命令

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

### 参数

#### SOURCE_PATH

【必填】源模板文件的路径，可以是 Excel、Terraform 或 AWS CloudFormation 格式的模板文件。

### OPTIONS

支持如下可选项：

- `--source-format`：源模板文件的格式，取值：`auto`（默认值）| `terraform` | `excel`| `cloudformation`，默认根据`SOURCE_PATH`后缀确定源文件格式。
- `--target-path`：生成 ROS 模板的文件路径，默认为当前目录，如果值为目录，则在该目录下生成的文件名为 `template` 的 ROS 模板，如果值为文件路径（必须是 json 或 yaml 格式），则生成指定文件名的
  ROS 模板，此时无需指定`--target-format`参数。
- `--target-format`：生成的 ROS 模板格式。取值：`auto`（默认值）| `json` | `yaml`，取值为`auto`且`--target-path`为文件路径时，生成的 ROS
  模版格式与`--target-path`文件格式相同；取值为`auto`且`--target-path`为目录时，生成的 ROS 模板名为`template.yml`。

## 格式化模板

### 命令

```bash
rostran format [OPTIONS] PATH...
```

### 参数

#### PATH

【必填】需要格式化的ROS模板文件路径。支持指定多个。

#### OPTIONS

支持如下可选项：

- `--replace`: 将源文件内容替换为格式化后的内容。
- `--no-replace`: 【默认】仅输出格式化内容。
- `--skip PATH`: 需要跳过格式化的ROS模板文件路径。支持指定多个。

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

## 查看帮助信息

### 命令

```bash
rostran --help
```
