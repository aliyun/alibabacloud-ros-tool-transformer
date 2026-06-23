---
sidebar_position: 2
title: Format Templates
---

# Format Templates

## Command

```bash
rostran format [OPTIONS] PATH...
```

## Parameters

### PATH

[Required] The path of ROS template file to format. Support to specify multiple.

## Options

The following options are supported:

- `--replace`: Replace the content of the source file with the formatted content.
- `--no-replace`: [Default] Only print formatted content.
- `--skip PATH`: The path of ROS Template file that need to skip formatting. Support to specify multiple.

## Formatting Rules

- The sections of template are sorted according to `ROSTemplateFormatVersion`, `Transform`, `Description`, `Conditions`
  , `Mappings`, `Parameters`, `Resources`, `Outputs`, `Metadata`, `Workspace`.
- The `Conditions` section is sorted in ascending alphabetical order.
- The `Mappings` section is sorted in ascending alphabetical order.
- The `Parameters` section is sorted in the order defined
  in `Metadata.ALIYUN::ROS::Interface.ParameterGroups.Parameters` (if present). The properties of each parameter are
  sorted in the order of type, description, constraints, etc.
- The `Resources` section is sorted in resource dependency order, with dependent resources first. Each resource
  attribute is sorted according to certain rules.
- The output properties of the `Outputs` section are sorted by `Description`, `Condition`, `Value`.
- The `Metadata` section are sorted according to `ALIYUN::ROS::Interface`, `ALIYUN::ROS::Designer`
  , `PredefinedParameters`. The attributes of each Metadata value are sorted according to certain rules.
- The `Workspace` section is sorted in ascending alphabetical order, where `main.tf` is always placed first.
