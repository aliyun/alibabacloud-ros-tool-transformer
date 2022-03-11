import json
import logging
from typing import Optional
from functools import partial

import typer
import yaml

from .format import FileFormat, TargetTemplateFormat
from .parameters import Parameters
from .resources import Resources
from .outputs import Outputs
from .meta_data import MetaData
from .conditions import Conditions
from .mappings import Mappings

logger = logging.getLogger(__name__)


class Template:
    def __init__(self, source, *args, **kwargs):
        self.source = source

    @classmethod
    def initialize(cls, path: str, format: FileFormat):
        pass

    def transform(self):
        pass


class RosTemplate:
    def __init__(
        self,
        description: Optional[str] = None,
        meta_data: Optional[MetaData] = None,
        mappings: Optional[Mappings] = None,
        conditions: Optional[Conditions] = None,
        parameters: Optional[Parameters] = None,
        resources: Optional[Resources] = None,
        outputs: Optional[Outputs] = None,
    ):
        self.description = description
        self.meta_data = meta_data if meta_data is not None else MetaData()
        self.mappings = mappings if mappings is not None else Mappings()
        self.conditions = conditions if conditions is not None else Conditions()
        self.parameters = parameters if parameters is not None else Parameters()
        self.resources = resources if resources is not None else Resources()
        self.outputs = outputs if outputs is not None else Outputs()

    def as_dict(self):
        data = {"ROSTemplateFormatVersion": "2015-09-01"}
        if self.description:
            data["Description"] = self.description
        if self.meta_data:
            data["Metadata"] = self.meta_data.as_dict()
        if self.conditions:
            data["Conditions"] = self.conditions.as_dict()
        if self.mappings:
            data["Mappings"] = self.mappings.as_dict()
        if self.parameters:
            data["Parameters"] = self.parameters.as_dict()

        if self.resources:
            data["Resources"] = self.resources.as_dict()

        if self.outputs:
            data["Outputs"] = self.outputs.as_dict()

        return data

    def save(self, target_path, target_format: TargetTemplateFormat):
        typer.secho(f"Save template to {target_path}.", fg="green")

        if target_format == TargetTemplateFormat.Yaml:
            dump = partial(yaml.dump, sort_keys=False)
        else:
            dump = json.dump

        data = self.as_dict()
        with open(target_path, "w") as f:
            dump(data, f, indent=2)
