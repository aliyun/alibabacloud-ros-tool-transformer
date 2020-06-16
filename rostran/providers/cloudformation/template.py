import json

import yaml

from rostran.core.exceptions import RosTranWarning, TemplateFormatNotSupport
from rostran.core.format import FileFormat
from rostran.core.template import Template


class CloudFormationTemplate(Template):

    @classmethod
    def initialize(cls, path: str, format: FileFormat):
        if format == FileFormat.Json:
            with open(path) as f:
                source = json.load(f)
        elif format == FileFormat.Yaml:
            with open(path) as f:
                source = yaml.load(f)
        else:
            raise TemplateFormatNotSupport(path=path, format=format)

        return cls(source=source)

    def transform(self):
        raise RosTranWarning(
            message='CloudFormation transformation will be supported soon')
