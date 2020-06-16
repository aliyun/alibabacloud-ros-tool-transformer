import json
import logging
from typing import Optional

import yaml

from .format import FileFormat, TargetTemplateFormat
from .parameters import Parameters
from .resources import Resources

logger = logging.getLogger(__name__)


class Template:

    def __init__(self, source):
        self.source = source

    @classmethod
    def initialize(cls, path: str, format: FileFormat):
        pass

    def transform(self):
        pass


class RosTemplate:

    def __init__(self,
                 parameters: Optional[Parameters] = None,
                 resources: Optional[Resources] = None):
        self.parameters = parameters if parameters is not None else Parameters()
        self.resources = resources if resources is not None else Resources()

    def as_dict(self):
        data = {
            'ROSTemplateFormatVersion': '2015-09-01'
        }
        if self.parameters:
            data['Parameters'] = self.parameters.as_dict()

        if self.resources:
            data['Resources'] = self.resources.as_dict()

        return data

    def save(self, target_path, target_format: TargetTemplateFormat):
        logger.info(f'Save template to {target_path}')

        if target_format == TargetTemplateFormat.Yaml:
            dump = yaml.dump
        else:
            dump = json.dump

        data = self.as_dict()
        with open(target_path, 'w') as f:
            dump(data, f, indent=2)
