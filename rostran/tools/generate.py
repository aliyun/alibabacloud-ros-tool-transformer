import os

import typer

from rostran.core.settings import BASE_DIR
from rostran.tools.parse_tf_ros import parse_tf_ros

app = typer.Typer(help=__doc__)


@app.command()
def parse(
    ak: str = typer.Option(..., help="Alicloud AccessKey ID"),
    sk: str = typer.Option(..., help="Alicloud AccessKey Secret"),
    ros: str = typer.Option(
        ..., help="ROS resource, for example, ALIYUN::ApiGateway::Api"
    ),
    terraform: str = typer.Option(
        None,
        "--terraform",
        "--tf",
        help="Terraform resource, for example, alicloud_api_gateway_api",
    ),
    aws: str = typer.Option(
        None, help="AWS CloudFormation resource, for example, AWS::ApiGatewayV2::Api"
    ),
):
    """
    Analyze the relationship between ROS and Terraform/AwsCloudFormation resources.
    """

    if not terraform and not aws:
        typer.secho("Please enter terraform or aws resource.", fg=typer.colors.GREEN)
        exit(1)
    if terraform:
        relative_path = os.path.join(
            "rules",
            "terraform",
            "alicloud",
            f"{terraform.replace('alicloud_', '')}.yml",
        )
        target_path = os.path.join(BASE_DIR, relative_path)
        if os.path.exists(target_path):
            typer.secho(
                f"{os.path.join('rostran', relative_path)} already exist.",
                fg=typer.colors.YELLOW,
            )
            exit(1)
        parse_tf_ros(ak, sk, ros, terraform, target_path)
    if aws:
        typer.secho("CloudFormation generate will be supported soon.")
        exit(1)


if __name__ == "__main__":
    typer.main.get_command(app)(prog_name="rostran")
