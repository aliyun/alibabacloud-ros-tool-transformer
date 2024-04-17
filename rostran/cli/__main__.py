"""
Transforms, generates or formats ROS template.
"""

import json
import os
import logging
import traceback
from io import StringIO
from pathlib import Path
from typing import List, Set

import typer
from ruamel.yaml import YAML, YAMLError

from rostran.core import exceptions
from rostran.core.format import (
    SourceTemplateFormat,
    TargetTemplateFormat,
    GeneratorFileFormat,
    convert_template_to_file_format,
    FileFormat,
)
from rostran.core.rule_manager import RuleManager, RuleClassifier
from rostran.core.template import RosTemplate

yaml = YAML()
yaml.preserve_quotes = True

# cli
app = typer.Typer(help=__doc__)
SOURCE_TEMPLATE_FORMAT_DEFAULT = typer.Option(
    SourceTemplateFormat.Auto, help="Source template format"
)
TARGET_TEMPLATE_FORMAT_DEFAULT = typer.Option(
    TargetTemplateFormat.Auto, help="Target template format."
)


@app.command()
def transform(
    source_path: str = typer.Argument(
        ...,
        help="The path of the source template file, which can be a template file in Excel, Terraform, "
        "or AWS CloudFormation format.",
    ),
    source_format: SourceTemplateFormat = typer.Option(
        SourceTemplateFormat.Auto,
        "--source-format",
        "-S",
        show_default=False,
        help="The format of the source template file. The source file format is determined by the suffix "
        "of SOURCE_PATH by default. [default: auto]",
    ),
    target_path: str = typer.Option(
        None,
        "--target-path",
        "-t",
        help="The file path of the generated ROS template. Default to current directory.",
    ),
    target_format: TargetTemplateFormat = typer.Option(
        TargetTemplateFormat.Auto,
        "--target-format",
        "-T",
        show_default=False,
        help="The generated ROS template format. [default: auto]",
    ),
    compatible: bool = typer.Option(
        False,
        show_default=True,
        help="Whether to use compatible mode when transforming Terraform to ROS template. If compatible, "
        "keep the Terraform file content in the generated ROS template. Otherwise, it is transformed "
        "to a template using ROS syntax. This option is only available for Terraform template files.",
    ),
    force: bool = typer.Option(
        False,
        show_default=True,
        help="Whether to overwrite existing target file.",
    ),
):
    """
    Transform AWS CloudFormation/Terraform/Excel template to ROS template.

    SOURCE represents AWS CloudFormation/Terraform/Excel template file path which will be transformed from.
    If file extension is ".json/.yml/.yaml", it will be automatically regarded as AWS CloudFormation template.
    If file extension is ".xlsx", it will be automatically regarded as Excel template.

    TARGET represents ROS template file path which will be transformed to. If not supplied, "template.yml" will be used.
    """
    # handle source template
    if not Path(source_path).exists():
        raise exceptions.TemplateNotExist(path=source_path)

    if source_format == SourceTemplateFormat.Auto:
        if source_path.endswith(".xlsx"):
            source_format = SourceTemplateFormat.Excel
        elif source_path.endswith(".tf"):
            source_format = SourceTemplateFormat.Terraform
        elif source_path.endswith((".json", ".yaml", ".yml")):
            with open(source_path, "r") as f:
                tpl = yaml.load(f)
            flag = tpl.get("Transform")
            if isinstance(flag, str) and flag.startswith("Aliyun::Terraform"):
                source_format = SourceTemplateFormat.ROS
            else:
                source_format = SourceTemplateFormat.CloudFormation
        else:
            raise exceptions.TemplateNotSupport(path=source_path)

    # handle target template
    if not target_path:
        if target_format in (TargetTemplateFormat.Auto, TargetTemplateFormat.Yaml):
            target_path = "template.yml"
            target_format = TargetTemplateFormat.Yaml
        else:
            target_path = "template.json"
        if source_format == SourceTemplateFormat.ROS:
            target_path = "template"
    elif target_format == TargetTemplateFormat.Auto:
        if target_path.endswith((".yaml", ".yml")):
            target_format = TargetTemplateFormat.Yaml
        elif target_path.endswith(".json"):
            target_format = TargetTemplateFormat.Json
        else:
            if source_format != SourceTemplateFormat.ROS:
                raise exceptions.TemplateNotSupport(path=target_path)

    target_path = os.path.abspath(target_path)
    path = Path(target_path)
    if path.exists() and not force:
        raise exceptions.TemplateAlreadyExist(path=target_path)

    if not path.parent.exists():
        raise exceptions.PathNotExist(path=path.parent)

    # initialize template
    source_file_format = convert_template_to_file_format(source_format, source_path)

    if source_format == SourceTemplateFormat.Excel:
        from ..providers import ExcelTemplate

        template = ExcelTemplate.initialize(source_path, source_file_format)
    elif source_format == SourceTemplateFormat.Terraform:
        if compatible:
            from ..providers import CompatibleTerraformTemplate

            template = CompatibleTerraformTemplate.initialize(
                source_path, source_file_format
            )
        else:
            from ..providers import TerraformTemplate

            template = TerraformTemplate.initialize(source_path, source_file_format)
    elif source_format == SourceTemplateFormat.CloudFormation:
        from ..providers import CloudFormationTemplate

        template = CloudFormationTemplate.initialize(source_path, source_file_format)

    elif source_format == SourceTemplateFormat.ROS:
        from ..providers import WrapTerraformTemplate

        template = WrapTerraformTemplate.initialize(source_path, source_file_format)

    else:
        raise exceptions.TemplateNotSupport(path=source_path)

    # transform template
    if source_format == SourceTemplateFormat.ROS:
        template.transform(target_path)
    else:
        ros_templates = template.transform()
        if not isinstance(ros_templates, list):
            ros_templates.save(target_path, target_format)
        elif len(ros_templates) == 1:
            ros_templates[0].save(target_path, target_format)
        else:
            for i, ros_template in enumerate(ros_templates):
                name_parts = os.path.splitext(target_path)
                path = f"{name_parts[0]}-{i}{name_parts[1]}"
                ros_template.save(path, target_format)


@app.command()
def format(
    path: List[Path] = typer.Argument(
        ...,
        exists=True,
        resolve_path=True,
        help="The path of ROS template file to format.",
    ),
    replace: bool = typer.Option(
        False,
        help="Whether replace the content of the source file with the formatted content.",
    ),
    skip: List[Path] = typer.Option(
        None,
        exists=True,
        resolve_path=True,
        help="The path of ROS Template file that need to skip formatting.",
    ),
):
    """
    Format and check ROS template according to the standard specification.
    """
    ps = []
    ps_set = set()
    skip_set = set(skip)
    for p in path:
        if p not in ps_set and p not in skip_set:
            ps_set.add(p)
            ps.append(p)

    formatted_paths = []
    for p in ps:
        if not p.exists():
            raise exceptions.PathNotExist(path=path)
        if p in skip_set:
            continue
        if p.is_dir():
            r = _format_directory(p, replace, skip_set)
            if r:
                formatted_paths.extend(r)
        else:
            r = _format_file(p, replace)
            if r:
                formatted_paths.append(r)

    if formatted_paths:
        typer.secho("Formatted successfully.", fg="green")
    else:
        typer.secho("No templates were found that could be formatted.", fg="yellow")


def _format_file(path: Path, replace: bool = False, check_suffix=True):
    suffix = path.suffix
    if suffix == ".json":
        file_format = FileFormat.Json
        try:
            source = json.loads(path.read_text())
        except json.JSONDecodeError:
            raise exceptions.InvalidTemplateFormat(path=path, format="json")
    elif suffix in (".yaml", ".yml"):
        file_format = FileFormat.Yaml
        try:
            source = yaml.load(path.read_text())
        except YAMLError:
            raise exceptions.InvalidTemplateFormat(path=path, format="yaml")
    else:
        if check_suffix:
            raise exceptions.TemplateFormatNotSupport(path=path, format=suffix)
        return

    typer.secho(f"Formatting {path}.", fg="green")
    template = RosTemplate.initialize(source)
    data = template.as_dict(format=True)
    if file_format == FileFormat.Json:
        content = json.dumps(data, indent=2, ensure_ascii=False)
    else:
        s = StringIO()
        yaml.dump(data, s)
        content = s.getvalue()

    if replace:
        with path.open("w") as f:
            f.write(content)
    else:
        typer.secho(content)
        typer.echo()
    return path


def _format_directory(
    path: Path, replace: bool = False, skip_paths: Set[Path] = None
) -> list:
    formatted_paths = []
    for sub_path in path.iterdir():
        if skip_paths and sub_path in skip_paths:
            continue
        if sub_path.is_dir():
            r = _format_directory(sub_path, replace, skip_paths)
            if r:
                formatted_paths.extend(r)
        else:
            r = _format_file(sub_path, replace, check_suffix=False)
            if r:
                formatted_paths.append(r)
    return formatted_paths


@app.command()
def rules(
    terraform: bool = typer.Option(
        True,
        help="Whether to show Terraform transform rules.",
    ),
    cloudformation: bool = typer.Option(
        True,
        help="Whether to show AWS CloudFormation transform rules.",
    ),
    markdown: bool = typer.Option(
        False,
        help="Whether to show rules in markdown format.",
    ),
    with_link: bool = typer.Option(
        False,
        help="Whether to include links when showing rules in markdown format.",
    ),
):
    """
    Show transform rules of Terraform and CloudFormation.
    """
    newline = False
    if terraform:
        rule_manager = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
        rule_manager.show(markdown, with_link)
        newline = True
    if cloudformation:
        if newline:
            typer.echo("")
        rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)
        rule_manager.show(markdown, with_link)


def main():
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    try:
        typer.main.get_command(app)(prog_name="rostran")
    except exceptions.RosTranWarning as e:
        typer.secho(f"{e}", fg=typer.colors.YELLOW)
        typer.Exit(1)
    except exceptions.RosTranException as e:
        typer.secho(f"{e}", fg=typer.colors.RED)
        typer.Exit(2)
    except Exception:
        typer.secho(traceback.format_exc(), fg=typer.colors.RED)
        typer.Exit(3)


if __name__ == "__main__":
    main()
