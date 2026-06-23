---
sidebar_position: 4
title: Web Service
---

# Web Service

Start a local web service to use the transformer from a browser. It provides a
dual-pane editor for converting CloudFormation / Terraform / Excel / ROS
templates and formatting ROS templates without the command line.

This feature requires the optional `serve` dependencies:

```bash
pip install "alibabacloud-ros-tran[serve]"
```

## Command

```bash
rostran server start [OPTIONS]   # start the web service
rostran server status            # show whether it is running
rostran server stop              # stop the web service
```

By default `start` runs the service in the background at `http://127.0.0.1:8080`
and opens it in your browser. Manage it later with `status` and `stop`.

## Options

`rostran server start` supports:

- `--host`/`-h`: The host to bind the web service to. Defaults to `127.0.0.1`.
  Use `0.0.0.0` to expose it on the network.
- `--port`/`-p`: The port to bind the web service to. Defaults to `8080`.
- `--open`: [Default] Open the web UI in a browser after starting.
- `--no-open`: Do not open a browser after starting.
- `--foreground`/`-f`: Run in the foreground (blocking) instead of in the
  background.

## Terraform Project Cache

When the web service converts Terraform templates, it keeps a bounded project
cache so repeated conversions of the same template can reuse provider
initialization and cached transform results. The conversion log prints the cache
path used for each Terraform project.

By default the cache lives at `~/.cache/rostran/terraform-projects` and keeps up
to 20 projects. Configure it with:

- `ROSTRAN_TERRAFORM_CACHE_DIR`: Directory used for cached Terraform projects.
- `ROSTRAN_TERRAFORM_CACHE_MAX_PROJECTS`: Maximum cached projects to keep.
  Defaults to `20`.

## Examples

```bash
# Start in the background (binds 127.0.0.1:8080 and opens the browser)
rostran server start

# Bind a custom host and port
rostran server start --host 0.0.0.0 --port 9000

# Run in the foreground without opening a browser
rostran server start --foreground --no-open

# Check status and stop
rostran server status
rostran server stop
```
