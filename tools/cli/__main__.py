"""
ROS tool for generating and formatting rules.
"""
import logging
import os
import traceback

import typer

from tools import exceptions
from tools.formatter import RuleFormatter
from tools.generator import RuleGenerator
from tools.settings import TF_ALI_ROS_GENERATE_MAPPING

from tools.settings import TF_ALI_RULES_DIR, CF_RESOURCE_RULES_DIR

# cli
app = typer.Typer(help=__doc__)


@app.command()
def generate(
    ros: str = typer.Option(
        "",
        help="The resource type of ROS.",
    ),
    tf: str = typer.Option(
        "",
        help="The resource type of Terraform",
    ),
):
    """
    Generate rules from Terraform to ROS.
    """
    if not ros and not tf:
        generate_mapping = TF_ALI_ROS_GENERATE_MAPPING
    elif ros and tf:
        generate_mapping = {tf: ros}
    else:
        raise exceptions.RosToolException(message="Please supply --ros and --terraform")

    alicloud_local = os.getenv("TERRAFORM_PROVIDER_ALICLOUD")
    if alicloud_local:
        typer.echo(
            f"Found env TERRAFORM_PROVIDER_ALICLOUD={alicloud_local}. "
            f"The rule generator will use local alicloud provider as the source to parse."
        )
    else:
        typer.echo(
            f"Env TERRAFORM_PROVIDER_ALICLOUD not found. "
            f"The rule generator will use the alicloud provider on github as the source to parse."
        )
    for tf, ros in generate_mapping.items():
        tf_filename = None
        if isinstance(ros, (list, tuple)):
            tf_filename, ros = ros
        typer.echo(f"Generating rule: {tf} -> {ros}")
        generator = RuleGenerator.initialize(tf, ros, tf_filename)
        generator.generate()
        typer.echo(f"Generate rule success: {tf} -> {ros}")


@app.command()
def format():
    """
    Format rules.
    """
    for rule_dir in (TF_ALI_RULES_DIR, CF_RESOURCE_RULES_DIR):
        typer.echo(f"Formatting rules: {rule_dir}")
        formatter = RuleFormatter(rule_dir)
        formatter.format()
        typer.echo(f"Format rules success: {rule_dir}")


def main():
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    try:
        typer.main.get_command(app)(prog_name="rostool")
    except exceptions.RosToolWarning as e:
        typer.secho(f"{e}", fg=typer.colors.YELLOW)
        typer.Exit(1)
    except exceptions.RosToolException as e:
        typer.secho(f"{e}", fg=typer.colors.RED)
        typer.Exit(2)
    except Exception:
        typer.secho(traceback.format_exc(), fg=typer.colors.RED)
        typer.Exit(3)


if __name__ == "__main__":
    main()
