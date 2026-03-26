# Usage

## Transform Template

### Command

```bash
rostran transform [OPTIONS] SOURCE_PATH
```

### Parameters

#### SOURCE_PATH

[Required] The path of the source template file, which can be a template file in Excel, Terraform, AWS CloudFormation 
or AlibabaCloud ROS format.

#### OPTIONS

The following options are supported:

- `--source-format`/`-S`: The format of the source template file, valid values: `auto` (default value) | `terraform`
  | `excel`| `cloudformation` | `ros` |`rosTerraform`, the source file format is determined by the suffix of `SOURCE_PATH` by default.
- `--target-path`/`-t`: The file path of the generated template. Default to current directory. If the path is a
  directory, the generated file name is a ROS template of `template` in this directory or Terraform files with file 
  names `main.tf`, `variables.tf`, `outputs.tf`, etc. If the path is a file (must be
  in json or yaml format), a ROS template with the specified file name will be generated, and there is no need to
  specify ` --target-format` option.
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


> :warning: If you want to convert Terraform templates, please configure the following environment variables:
>
> ```bash
> $ export ALICLOUD_ACCESS_KEY="access_key"
> $ export ALICLOUD_SECRET_KEY="secret_key"
> $ export ALICLOUD_REGION="region_id"
> ```

## Format Template

### Command

```bash
rostran format [OPTIONS] PATH...
```

### Parameters

#### PATH

[Required] The path of ROS template file to format. Support to specify multiple.

#### OPTIONS

The following options are supported:

- `--replace`: Replace the content of the source file with the formatted content.
- `--no-replace`: [Default] Only print formatted content.
- `--skip PATH`: The path of ROS Template file that need to skip formatting. Support to specify multiple.

#### Formatting rules

- The sections of template are sorted according to `ROSTemplateFormatVersion`, `Transform`, `Description`, `Conditions`
  , `Mappings`, `Parameters`, `Resources`, `Outputs`, `Metadata`, `Workspace`.
- The `Conditions` section is sorted in ascending alphabetical order.
- The `Mappings` section is sorted in ascending alphabetical order.
- The `Parameters` section is sorted in the order defined
  in `Metadata.ALIYUN::ROS::Interface.ParameterGroups.Parameters` (if present). The properties of each parameter are
  sorted in the order of type, description, constraints, etc.
- The `Resources` section is sorted in resource dependency order, with dependent resources first. Each resource
  attribute
  is sorted according to certain rules.
- The output properties of the `Outputs` section are sorted by `Description`, `Condition`, `Value`.
- The `Metadata` section are sorted according to `ALIYUN::ROS::Interface`, `ALIYUN::ROS::Designer`
  , `PredefinedParameters`. The attributes of each Metadata value are sorted according to certain rules.
- The `Workspace` section is sorted in ascending alphabetical order, where `main.tf` is always placed first.

## Show Transform Rules

### Command

```bash
rostran rules [OPTIONS]
```

#### OPTIONS

The following options are supported:

- `--terraform`: [Default] Show Terraform transform rules.
- `--no-terraform`: Do not show Terraform transform rules.
- `--cloudformation`: [Default] Show CloudFormation transform rules.
- `--no-cloudformation`: Do not show CloudFormation transform rules.
- `--markdown`: Show rules in markdown format.
- `--no-markdown`: [Default] Show rules in normal way.
- `--with-link`: Append a link when showing rules in markdown format.
- `--no-with-link`: [Default] No link is attached when showing rules in markdown format.
- `--version`/`-V`: Show the version and source of the currently active rules.

### Show Rules Version

```bash
rostran rules --version
```

When using locally cached rules (after running `rostran rules update`):

```
Rules source : local cache (~/.rostran/rules/)
Rules version: 1.2.0
Built-in ver : 1.0.0
```

When using built-in rules (default):

```
Rules source : built-in (shipped with package)
Rules version: 1.0.0
```

## Update Transform Rules

Update transform rules from the remote repository without upgrading the package.
Downloaded rules are cached locally at `~/.rostran/rules/` and take precedence over the built-in rules shipped with the package.

### Command

```bash
rostran rules update [OPTIONS]
rostran rules list
rostran rules reset
```

#### `rules update` options

- `--version`/`-v`: Specific rules version to install (e.g. `1.2.0`). Defaults to the latest version on the main branch.
- `--force`: Force re-download even if the local rules are already up-to-date.

#### Examples

```bash
# Update to the latest rules version
rostran rules update

# Install a specific rules version
rostran rules update --version 1.2.0

# List all available rules versions
rostran rules list

# Force re-download
rostran rules update --force

# Remove local cache and revert to built-in rules
rostran rules reset
```

## View Help Information

### Command

```bash
rostran --help
```
