import json
import logging
from typing import Optional, Union
from functools import partial

import typer
from ruamel.yaml import YAML

from .exceptions import InvalidRosTemplateFormatVersion
from .format import FileFormat, TargetTemplateFormat
from .parameters import Parameters
from .resources import Resources
from .outputs import Outputs
from .metadata import MetaData
from .rules import Rules
from .conditions import Conditions
from .mappings import Mappings
from .workspace import Workspace

logger = logging.getLogger(__name__)

yaml = YAML()
yaml.preserve_quotes = True


class Template:
    def __init__(self, source, *args, **kwargs):
        self.source = source

    @classmethod
    def initialize(cls, path: str, format: FileFormat):
        pass

    def transform(self):
        pass


class RosTemplate:
    (
        ROS_TEMPLATE_FORMAT_VERSION,
        TRANSFORM,
        DESCRIPTION,
        CONDITIONS,
        MAPPINGS,
        PARAMETERS,
        RESOURCES,
        OUTPUTS,
        RULES,
        METADATA,
        WORKSPACE,
    ) = (
        "ROSTemplateFormatVersion",
        "Transform",
        "Description",
        "Conditions",
        "Mappings",
        "Parameters",
        "Resources",
        "Outputs",
        "Rules",
        "Metadata",
        "Workspace",
    )

    def __init__(
        self,
        description: Optional[Union[str, dict]] = None,
        metadata: Optional[MetaData] = None,
        mappings: Optional[Mappings] = None,
        conditions: Optional[Conditions] = None,
        parameters: Optional[Parameters] = None,
        resources: Optional[Resources] = None,
        outputs: Optional[Outputs] = None,
        rules: Optional[Rules] = None,
        transform: Optional[str] = None,
        workspace: Optional[Workspace] = None,
    ):
        self.description = description
        self.metadata = metadata if metadata is not None else MetaData()
        self.mappings = mappings if mappings is not None else Mappings()
        self.conditions = conditions if conditions is not None else Conditions()
        self.parameters = parameters if parameters is not None else Parameters()
        self.resources = resources if resources is not None else Resources()
        self.outputs = outputs if outputs is not None else Outputs()
        self.rules = rules if rules is not None else Rules()
        self.transform = transform
        self.workspace = workspace

    @classmethod
    def initialize(cls, data: dict):
        if cls.ROS_TEMPLATE_FORMAT_VERSION not in data:
            raise InvalidRosTemplateFormatVersion(
                reason=f"{cls.ROS_TEMPLATE_FORMAT_VERSION} is required"
            )
        if data.get(cls.ROS_TEMPLATE_FORMAT_VERSION) != "2015-09-01":
            raise InvalidRosTemplateFormatVersion(
                reason=f"{cls.ROS_TEMPLATE_FORMAT_VERSION} can only be 2015-09-01"
            )

        metadata = mappings = conditions = parameters = resources = outputs = rules = (
            workspace
        ) = None
        transform = data.get(cls.TRANSFORM)
        description = data.get(cls.DESCRIPTION)
        if cls.CONDITIONS in data:
            conditions = Conditions.initialize(data[cls.CONDITIONS])
        if cls.MAPPINGS in data:
            mappings = Mappings.initialize(data[cls.MAPPINGS])
        if cls.PARAMETERS in data:
            parameters = Parameters.initialize(data[cls.PARAMETERS])
        if cls.RESOURCES in data:
            resources = Resources.initialize(data[cls.RESOURCES])
        if cls.OUTPUTS in data:
            outputs = Outputs.initialize(data[cls.OUTPUTS])
        if cls.RULES in data:
            rules = Rules.initialize(data[cls.RULES])
        if cls.METADATA in data:
            metadata = MetaData.initialize(data[cls.METADATA])
        if cls.WORKSPACE in data:
            workspace = Workspace.initialize(data[cls.WORKSPACE])

        return cls(
            description,
            metadata,
            mappings,
            conditions,
            parameters,
            resources,
            outputs,
            rules,
            transform,
            workspace,
        )

    def as_dict(self, format=False):
        data = {self.ROS_TEMPLATE_FORMAT_VERSION: "2015-09-01"}
        if self.transform:
            data[self.TRANSFORM] = self.transform
        if self.description:
            data[self.DESCRIPTION] = self.description
        if self.conditions:
            data[self.CONDITIONS] = self.conditions.as_dict(format)
        if self.mappings:
            data[self.MAPPINGS] = self.mappings.as_dict(format)
        if self.parameters:
            data[self.PARAMETERS] = self.parameters.as_dict(format, self.metadata)
        if self.resources:
            data[self.RESOURCES] = self.resources.as_dict(format)
        if self.outputs:
            data[self.OUTPUTS] = self.outputs.as_dict(format)
        if self.rules:
            data[self.RULES] = self.rules.as_dict(format)
        if self.metadata:
            data[self.METADATA] = self.metadata.as_dict(format)
        if self.workspace:
            data[self.WORKSPACE] = self.workspace.as_dict(format)
        return data

    def save(self, target_path, target_format: TargetTemplateFormat):
        typer.secho(f"Save template to {target_path}.", fg="green")

        if target_format == TargetTemplateFormat.Yaml:
            dump = partial(yaml.dump)
            kwargs = {}
        else:
            dump = json.dump
            kwargs = {"indent": 2}

        data = self.as_dict(format=True)
        with open(target_path, "w") as f:
            dump(data, f, **kwargs)
