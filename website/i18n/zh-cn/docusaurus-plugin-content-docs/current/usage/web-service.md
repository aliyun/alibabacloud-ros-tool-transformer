---
sidebar_position: 4
title: Web 服务
---

# Web 服务

启动本地 Web 服务，即可在浏览器中使用转换器。它提供了双栏编辑器，可用于转换
CloudFormation / Terraform / Excel / ROS 模板、格式化 ROS 模板，全程无需使用命令行。

该功能需要安装可选的 `serve` 依赖：

```bash
pip install "alibabacloud-ros-tran[serve]"
```

## 命令

```bash
rostran server start [OPTIONS]   # 启动 Web 服务
rostran server status            # 查看是否在运行
rostran server stop              # 停止 Web 服务
```

`start` 默认在后台启动服务（`http://127.0.0.1:8080`）并自动在浏览器中打开，之后可用 `status` / `stop` 管理。

## 可选项

`rostran server start` 支持如下可选项：

- `--host`/`-h`：Web 服务绑定的主机地址，默认为 `127.0.0.1`。使用 `0.0.0.0` 可将其暴露到网络中。
- `--port`/`-p`：Web 服务绑定的端口，默认为 `8080`。
- `--open`：【默认】启动后在浏览器中打开 Web UI。
- `--no-open`：启动后不打开浏览器。
- `--foreground`/`-f`：在前台（阻塞）运行，而非后台服务。

## Terraform 项目缓存

Web 服务转换 Terraform 模板时，会维护一个有界项目缓存。相同模板再次转换时，可以复用
provider 初始化结果和已缓存的转换结果。每次 Terraform 转换的日志都会打印本次使用的缓存路径。

默认缓存目录为 `~/.cache/rostran/terraform-projects`，最多保留 20 个项目。可通过如下环境变量配置：

- `ROSTRAN_TERRAFORM_CACHE_DIR`：Terraform 项目缓存目录。
- `ROSTRAN_TERRAFORM_CACHE_MAX_PROJECTS`：最多保留的缓存项目数，默认值为 `20`。

## 示例

```bash
# 后台启动（绑定 127.0.0.1:8080 并打开浏览器）
rostran server start

# 绑定自定义主机和端口
rostran server start --host 0.0.0.0 --port 9000

# 前台运行且不打开浏览器
rostran server start --foreground --no-open

# 查看状态并停止
rostran server status
rostran server stop
```
