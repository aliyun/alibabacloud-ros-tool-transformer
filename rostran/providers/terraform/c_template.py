import os

import typer
from ruamel.yaml.scalarstring import LiteralScalarString

from rostran.core.exceptions import TemplateFormatNotSupport
from rostran.core.template import Template, RosTemplate
from rostran.core.format import FileFormat
from rostran.core.workspace import Workspace


class CompatibleTerraformTemplate(Template):
    @classmethod
    def initialize(
        cls,
        path: str,
        format: FileFormat = FileFormat.Terraform,
    ):
        if format != FileFormat.Terraform:
            raise TemplateFormatNotSupport(path=path, format=format)

        source = {}
        if os.path.isdir(path):
            for dirpath, dirnames, filenames in os.walk(path):
                for filename in filenames:
                    if filename.endswith(
                        (
                            ".tf",
                            ".tftpl",
                            ".tfvars",
                            ".metadata",
                            ".mappings",
                            ".conditions",
                            ".rules",
                        )
                    ):
                        filepath = os.path.join(dirpath, filename)
                        with open(filepath) as f:
                            content = f.read()
                        key = os.path.relpath(filepath, path).replace(os.path.sep, "/")
                        source[key] = LiteralScalarString(content)
        else:
            with open(path) as f:
                content = f.read()
            source["main.tf"] = LiteralScalarString(content)

        return cls(source=source)

    def transform(self) -> RosTemplate:
        typer.secho(f"Transforming terraform template to ROS template...")

        template = RosTemplate()
        template.transform = "Aliyun::Terraform-v1.5"
        template.workspace = Workspace.initialize(self.source)

        typer.secho(
            f"Transform terraform template to ROS template successful.",
            fg="green",
        )
        return template
