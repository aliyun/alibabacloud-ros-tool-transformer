import os

import typer
import json
import yaml

from rostran.core.exceptions import TemplateFormatNotSupport, InvalidTemplateWorkspace
from rostran.core.template import Template
from rostran.core.format import FileFormat


class WrapTerraformTemplate(Template):
    @classmethod
    def initialize(
        cls,
        path: str,
        format: FileFormat = FileFormat.Terraform,
    ):

        if format == FileFormat.Json:
            with open(path) as f:
                source = json.load(f)
        elif format == FileFormat.Yaml:
            with open(path) as f:
                source = yaml.load(f)
        else:
            raise TemplateFormatNotSupport(path=path, format=format)

        return cls(source=source)

    def transform(self, target_path=None):
        typer.secho(f"Transforming ROS template to terraform template...")

        workspace = self.source.get("Workspace")
        if not isinstance(workspace, dict):
            raise InvalidTemplateWorkspace(
                reason=f"The type of data ({workspace}) should be dict"
            )

        for file_name, file_content in workspace.items():
            file_path = target_path + "/" + file_name
            dir_path = "/".join(file_path.split("/")[:-1])
            if not os.path.exists(dir_path):
                os.makedirs(dir_path)
            with open(file_path, "w") as f:
                f.write(file_content)
        typer.secho(
            f"Transform ROS template to terraform template successful.",
            fg="green",
        )
