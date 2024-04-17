from enum import Enum


class SourceTemplateFormat(str, Enum):
    Auto = "auto"
    CloudFormation = "cloudformation"
    Terraform = "terraform"
    Excel = "excel"
    ROS = "ros"


class TargetTemplateFormat(str, Enum):
    Auto = "auto"
    Json = "json"
    Yaml = "yaml"


class GeneratorFileFormat(str, Enum):
    Excel = "excel"


class FileFormat(Enum):
    Json = "json"
    Yaml = "yaml"
    Excel = "excel"
    Terraform = "terraform"


def convert_template_to_file_format(template_format, template_path: str = None):
    if isinstance(template_format, SourceTemplateFormat):
        if template_format == SourceTemplateFormat.Excel:
            return FileFormat.Excel
        elif template_format == SourceTemplateFormat.Terraform:
            return FileFormat.Terraform
        elif template_format in (
            SourceTemplateFormat.CloudFormation,
            SourceTemplateFormat.ROS,
        ):
            if template_path:
                if template_path.endswith((".yml", ".yaml")):
                    return FileFormat.Yaml
                elif template_path.endswith(".json"):
                    return FileFormat.Json
            else:
                raise ValueError(
                    f"template_path is required when template_format is {template_format}"
                )
    elif isinstance(template_format, TargetTemplateFormat):
        if template_format == TargetTemplateFormat.Yaml:
            return FileFormat.Yaml
        elif template_format == TargetTemplateFormat.Json:
            return FileFormat.Json

    raise ValueError(f"Unsupported template_format {template_format}")
