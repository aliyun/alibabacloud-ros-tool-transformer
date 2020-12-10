# 使用
## 命令
### 查看帮助信息
```bash
rostran --help
```

### 模版转换
```bash
rostran transform SOURCE_PATH [OPTIONS] 
```

## 参数
### SOURCE_PATH
必填参数，源模板文件的路径，可以是 Excel、Terraform 或 AWS CloudFormation 格式的模板文件。
### OPTIONS
非必填参数，支持以下三个参数：
- `--source-format`：源模板文件的格式，取值：`auto`（默认值）| `terraform` | `excel`| `cloudformation`，默认根据`SOURCE_PATH`后缀确定源文件格式。
- `--target-path`：生成 ROS 模板的文件路径，默认为当前目录，如果值为目录，则在该目录下生成的文件名为 `template` 的 ROS 模板，如果值为文件路径（必须是 json 或 yaml 格式），则生成指定文件名的 ROS 模板，此时无需指定`--target-format`参数。
- `--target-format`：生成的 ROS 模板格式。取值：`auto`（默认值）| `json` | `yaml`，取值为`auto`且`--target-path`为文件路径时，生成的 ROS 模版格式与`--target-path`文件格式相同；取值为`auto`且`--target-path`为目录时，生成的 ROS 模板名为`template.yml`。


