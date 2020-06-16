from rostran.core.exceptions import RosTranWarning
from rostran.core.exceptions import TemplateFormatNotSupport
from rostran.core.format import FileFormat
from rostran.core.template import Template


class TerraformTemplate(Template):

    @classmethod
    def initialize(cls, path: str, format: FileFormat = FileFormat.Terraform):
        if format != FileFormat.Terraform:
            raise TemplateFormatNotSupport(path=path, format=format)

        with open(path) as f:
            source = f.read()

        return cls(source=source)

    def transform(self):
        raise RosTranWarning(
            message='Terraform transformation will be supported soon')
