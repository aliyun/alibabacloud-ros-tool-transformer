import json
import os
from pathlib import Path
from typing import List

import typer
from ruamel.yaml.scalarstring import LiteralScalarString

from rostran.core.conditions import Conditions
from rostran.core.exceptions import TemplateFormatNotSupport, InvalidTargetFile
from rostran.core.mappings import Mappings
from rostran.core.metadata import MetaData
from rostran.core.outputs import Outputs
from rostran.core.parameters import Parameters
from rostran.core.rules import Rules
from rostran.core.template import Template, RosTemplate
from rostran.core.format import FileFormat
from rostran.core.workspace import Workspace
from rostran.providers.ros.yaml_util import yaml


class CompatibleTerraformTemplate(Template):

    DEFAULT_FILE_PATTERNS = ("*.tf", "*.tftpl", "*.tfvars", "*.metadata", "*.mappings", "*.conditions", "*.rules")

    def __init__(self, source, *args, **kwargs):
        super().__init__(source, args, kwargs)
        self.exist_content = kwargs.get("exist_content") or {}
        self.force_overwrite = kwargs.get("force_overwrite")

    @classmethod
    def initialize(
        cls,
        path: str,
        format: FileFormat = FileFormat.Terraform,
        extra_files: List[str] = None,
        exist_file_path: str = None,
        force_overwrite: bool = False,
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

        if exist_file_path:
            exist_content = cls.read_exist_file(exist_file_path)
        else:
            exist_content = None
        return cls(source=source, exist_content=exist_content, force_overwrite=force_overwrite)

    @staticmethod
    def read_exist_file(exist_file_path):
        if not os.path.exists(exist_file_path):
            raise InvalidTargetFile(
                target_file=exist_file_path, reason="the file is not exists.")
        if not os.path.isfile(exist_file_path):
            raise InvalidTargetFile(
                target_file=exist_file_path, reason="it is not a file.")
        try:
            with open(exist_file_path) as f:
                try:
                    exist_content = json.load(f)
                except json.JSONDecodeError:
                    f.seek(0)
                    exist_content = yaml.load(f)
        except Exception as ex:
            raise InvalidTargetFile(
                target_file=exist_file_path,
                reason="the file needs to be in json or yaml format. Error: {}".format(str(ex)))
        return exist_content

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
        if self.exist_content:
            template.outputs =  Outputs.initialize(self.exist_content.pop("Outputs", None) or {})
            template.metadata = MetaData.initialize(self.exist_content.pop("Metadata", None) or {})
            template.parameters = Parameters.initialize(self.exist_content.pop("Parameters", None) or {})
            template.rules = Rules.initialize(self.exist_content.pop("Rules", None) or {})
            template.mappings = Mappings.initialize(self.exist_content.pop("Mappings", None) or {})
            template.conditions = Conditions.initialize(self.exist_content.pop("Conditions", None) or {})
            transform = self.exist_content.pop("Transform", None)
            if transform:
                template.transform = transform
            description = self.exist_content.pop("Description", None)
            if description:
                template.description = description
            workspace = self.exist_content.pop("Workspace", None) or {}
            if workspace and not self.force_overwrite:
                template.workspace = Workspace.initialize(workspace)

            if self.exist_content:
                template.additional_data = self.exist_content

        typer.secho(
            f"Transform terraform template to ROS template successful.",
            fg="green",
        )
        return template
