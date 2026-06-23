---
sidebar_position: 3
title: Manage Transform Rules
---

# Manage Transform Rules

## Show Transform Rules

### Command

```bash
rostran rules [OPTIONS]
```

### Options

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

## Show Rules Version

```bash
rostran rules --version
```

When using locally cached rules (after running `rostran rules update`):

```text
Rules source : local cache (~/.rostran/rules/)
Rules version: 1.2.0
Built-in ver : 1.0.0
```

When using built-in rules (default):

```text
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

### `rules update` Options

- `--version`/`-v`: Specific rules version to install (e.g. `1.2.0`). Defaults to the latest version on the main branch.
- `--force`: Force re-download even if the local rules are already up-to-date.

## Examples

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
