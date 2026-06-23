---
sidebar_position: 2
title: 格式化模板
---

# 格式化模板

## 命令

```bash
rostran format [OPTIONS] PATH...
```

## 参数

### PATH

【必填】需要格式化的 ROS 模板文件路径。支持指定多个。

## 可选项

支持如下可选项：

- `--replace`: 将源文件内容替换为格式化后的内容。
- `--no-replace`: 【默认】仅输出格式化内容。
- `--skip PATH`: 需要跳过格式化的 ROS 模板文件路径。支持指定多个。

## 格式化规则

- 模板区块按照 `ROSTemplateFormatVersion`、`Transform`、`Description`、`Conditions`、`Mappings`、`Parameters`、`Resources`、`Outputs`
  、`Metadata`、`Workspace` 排序。
- `Conditions` 区块按照字母升序排序。
- `Mappings` 区块按照字母升序排序。
- `Parameters` 区块以 `Metadata.ALIYUN::ROS::Interface.ParameterGroups.Parameters`（若存在）中定义的顺序排序；每个参数的属性以类型、描述、约束等顺序排序。
- `Resources` 区块以资源依赖顺序排序，其中被依赖的资源放在前面。每个资源属性按照一定规则排序。
- `Outputs` 区块的输出属性按照 `Description`、`Condition`、`Value` 排序。
- `Metadata` 区块按照 `ALIYUN::ROS::Interface`、`ALIYUN::ROS::Designer`、`PredefinedParameters` 排序；每项值属性按照一定规则排序。
- `Workspace` 区块按照字母升序排序，其中 `main.tf` 永远会放在第一个。
