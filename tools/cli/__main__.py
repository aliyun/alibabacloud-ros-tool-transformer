"""
ROS tool for generating and formatting rules.
"""

import logging
import os
import traceback

import typer

from tools import exceptions
from tools.formatter import RuleFormatter
from tools.generator import TerraformRuleGenerator, CloudFormationRuleGenerator, ROS2TerraformRuleGenerator
from tools.settings import TF_ALI_ROS_GENERATE_MAPPINGS, CF_ROS_GENERATE_MAPPINGS

from tools.settings import TF_ALI_RULES_DIR, CF_RESOURCE_RULES_DIR

# cli
app = typer.Typer(help=__doc__)


@app.command()
def generate(
    ros: str = typer.Option(
        "",
        help="The resource type of ROS. 'all' represents all types of resources.",
    ),
    tf: str = typer.Option(
        "",
        help="The resource type of Terraform. 'all' represents all types of resources.",
    ),
    cf: str = typer.Option(
        "",
        help="The resource type of Cloud Formation. 'all' represents all types of resources.",
    ),

    ros2tf: bool = typer.Option(
        False,
        '--ros2tf',
        '-R',
        help="Generate rules from Terraform to ROS.",
    ),
):
    """
    Generate rules from Terraform/CloudFormation to ROS.
    Generate rules from ROS to Terraform (the value of --cf will be ignored) if ros2tf is set.
    By default, rules are generated from Terraform to ROS.
    """
    if not any((ros, tf, cf)):
        ros = tf = cf = "all"

    if ros2tf:
        cf = None
        if not ros:
            ros = 'all'
        if not tf:
            tf = 'all'
    if not ros:
        raise exceptions.RosToolException(message="Please supply --ros")
    elif not any((tf, cf)):
        raise exceptions.RosToolException(message="Please supply --tf/--cf")
    elif all((tf, cf)) and tf != 'all' and cf != 'all':
        raise exceptions.RosToolException(
            message="Please supply --tf or --cf, but not both"
        )

    if tf:
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

        if tf == 'all' and ros == 'all':
            generate_mapping = TF_ALI_ROS_GENERATE_MAPPINGS
        elif tf == 'all' and ros != 'all':
            generate_mapping = {t: r for t, r in TF_ALI_ROS_GENERATE_MAPPINGS.items() if r == ros}
        else:
            r = TF_ALI_ROS_GENERATE_MAPPINGS.get(tf)
            if not r:
                raise exceptions.RosToolException(
                    message=f"The resource type {tf} is not supported."
                )
            generate_mapping = {tf: r}

        for tf, ros in generate_mapping.items():
            tf_filename = None
            if isinstance(ros, (list, tuple)):
                tf_filename, ros = ros
            msg = "Generating Terraform rule: {} -> {}".format
            if ros2tf:
                typer.echo(msg(ros, tf))
                generator = ROS2TerraformRuleGenerator.initialize(ros, tf)
            else:
                typer.echo(msg(tf, ros))
                generator = TerraformRuleGenerator.initialize(tf, ros, tf_filename)

            generator.generate()
            msg = "Generate Terraform rule success: {} -> {}".format
            if ros2tf:
                typer.echo(msg(ros, tf))
            else:
                typer.echo(msg(tf, ros))
    if cf:
        generate_mapping = CF_ROS_GENERATE_MAPPINGS if cf == "all" else {cf: ros}
        for cf, ros in generate_mapping.items():
            typer.echo(f"Generating CloudFormation rule: {cf} -> {ros}")
            generator = CloudFormationRuleGenerator.initialize(cf, ros)
            generator.generate()
            typer.echo(f"Generate CloudFormation rule success: {cf} -> {ros}")


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
