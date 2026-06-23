---
sidebar_position: 3
title: 管理转换规则
---

# 管理转换规则

## 查看转换规则

### 命令

```bash
rostran rules [OPTIONS]
```

### 可选项

支持如下可选项：

- `--terraform`: 【默认】展示 Terraform 转换规则。
- `--no-terraform`: 不展示 Terraform 转换规则。
- `--cloudformation`: 【默认】展示 CloudFormation 转换规则。
- `--no-cloudformation`: 不展示 CloudFormation 转换规则。
- `--markdown`: 以 markdown 格式展示规则。
- `--no-markdown`: 【默认】以普通方式展示规则。
- `--with-link`: 以 markdown 格式展示规则时附加链接。
- `--no-with-link`: 【默认】以 markdown 格式展示规则时不附加链接。
- `--version`/`-V`: 显示当前使用的规则版本和来源。

## 查看规则版本

```bash
rostran rules --version
```

使用本地缓存规则时（执行过 `rostran rules update` 后）：

```text
Rules source : local cache (~/.rostran/rules/)
Rules version: 1.2.0
Built-in ver : 1.0.0
```

使用内置规则时（默认）：

```text
Rules source : built-in (shipped with package)
Rules version: 1.0.0
```

## 更新转换规则

从远程仓库更新转换规则，无需升级整个软件包。
下载的规则会缓存在本地 `~/.rostran/rules/` 目录中，优先于软件包内置的规则使用。

### 命令

```bash
rostran rules update [OPTIONS]
rostran rules list
rostran rules reset
```

### `rules update` 可选项

- `--version`/`-v`：指定要安装的规则版本（如 `1.2.0`）。默认安装 main 分支上的最新版本。
- `--force`：即使本地规则已是最新版本，也强制重新下载。

## 示例

```bash
# 更新到最新规则版本
rostran rules update

# 安装指定版本的规则
rostran rules update --version 1.2.0

# 列出所有可用的规则版本
rostran rules list

# 强制重新下载
rostran rules update --force

# 清除本地缓存，恢复使用内置规则
rostran rules reset
```
