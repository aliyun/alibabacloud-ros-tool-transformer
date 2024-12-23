import os
from pathlib import Path
from typing import List

import typer
from ruamel.yaml.scalarstring import LiteralScalarString

from rostran.core.exceptions import TemplateFormatNotSupport
from rostran.core.template import Template, RosTemplate
from rostran.core.format import FileFormat
from rostran.core.workspace import Workspace


class CompatibleTerraformTemplate(Template):

    DEFAULT_FILE_PATTERNS = ("*.tf", "*.tftpl", "*.tfvars", "*.metadata", "*.mappings", "*.conditions", "*.rules")

    @classmethod
    def initialize(
        cls,
        path: str,
        format: FileFormat = FileFormat.Terraform,
        extra_files: List[str] = None
    ):
        if format != FileFormat.Terraform:
            raise TemplateFormatNotSupport(path=path, format=format)

        source = {}
        if os.path.isdir(path):
            for dirpath, dirnames, filenames in os.walk(path):
                matched_files = cls.get_matched_files(dirpath, extra_files)
                for filepath in matched_files:
                    with open(filepath) as f:
                        content = f.read()
                    key = os.path.relpath(filepath, path).replace(os.path.sep, "/")
                    source[key] = LiteralScalarString(content)
        else:
            with open(path) as f:
                content = f.read()
            source["main.tf"] = LiteralScalarString(content)

        return cls(source=source)

    @classmethod
    def get_matched_files(cls, dirpath: str, extra_files: List[str] = None) -> list:
        dir_path = Path(dirpath)

        def file_absolutes(p: str) -> list:
            return [str(f.absolute()) for f in dir_path.rglob(p) if f.is_file()]
        if extra_files and "*" in extra_files:
            return file_absolutes("*")

        matched_files = []
        for pattern in cls.DEFAULT_FILE_PATTERNS:
            matched_files.extend(file_absolutes(pattern))
        if extra_files:
            for pattern in set(extra_files):
                matched_files.extend(file_absolutes(pattern))
        return matched_files

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
