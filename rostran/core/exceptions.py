class RosTranException(Exception):
    msg = "Internal error"

    def __init__(self, **kwargs):
        self.kwargs = kwargs
        self.message = self.msg.format(**kwargs)

    def __str__(self):
        return self.message


class RosTranWarning(RosTranException):
    msg = "{message}."


class PathNotExist(RosTranException):
    msg = 'Path "{path}" not exists.'


class TemplateNotExist(RosTranException):
    msg = 'Template "{path}" not exists.'


class TemplateAlreadyExist(RosTranException):
    msg = (
        'Template "{path}" already exists. Please remove it or '
        "add the '--force' parameter to overwrite it before transform template."
    )


class TemplateNotSupport(RosTranException):
    msg = 'Template "{path}" is not supported.'


class TemplateFormatNotSupport(RosTranException):
    msg = 'Template "{path}"(format: {format}) is not supported.'


class InvalidTemplateFormat(RosTranException):
    msg = 'Template "{path}"(format: {format}) is not valid.'


class InvalidTemplateParameter(RosTranException):
    msg = "Invalid template parameter {name}. {reason}."


class InvalidRosTemplateFormatVersion(RosTranException):
    msg = "Invalid ROSTemplateFormatVersion. {reason}."


class InvalidTemplateParameters(RosTranException):
    msg = "Invalid template parameters. {reason}."


class InvalidTemplateMetaDataItem(RosTranException):
    msg = "Invalid template meta data {name}. {reason}."


class InvalidTemplateMetaData(RosTranException):
    msg = "Invalid template meta data. {reason}."


class InvalidTemplateRule(RosTranException):
    msg = "Invalid template rule {name}. {reason}."


class InvalidTemplateRules(RosTranException):
    msg = "Invalid template rules. {reason}."


class InvalidTemplateMapping(RosTranException):
    msg = "Invalid template mapping {name}. {reason}."


class InvalidTemplateMappings(RosTranException):
    msg = "Invalid template mappings. {reason}."


class InvalidTemplateCondition(RosTranException):
    msg = "Invalid template condition {name}. {reason}."


class InvalidTemplateConditions(RosTranException):
    msg = "Invalid template conditions. {reason}."


class InvalidTemplateResource(RosTranException):
    msg = "Invalid template resource {name}. {reason}."


class InvalidTemplateResources(RosTranException):
    msg = "Invalid template resources. {reason}."


class InvalidTemplateProperty(RosTranException):
    msg = "Invalid template property {name}. {reason}."


class InvalidTemplateProperties(RosTranException):
    msg = "Invalid template properties. {reason}."


class InvalidTemplateOutput(RosTranException):
    msg = "Invalid template output {name}. {reason}."


class InvalidTemplateOutputs(RosTranException):
    msg = "Invalid template outputs. {reason}."


class InvalidTemplateWorkspace(RosTranException):
    msg = "Invalid template workspace. {reason}."


class InvalidYamlTemplateTag(RosTranException):
    msg = "Invalid yaml template tag. {reason}."


class InvalidExcelTemplate(RosTranException):
    msg = "Invalid excel template. {reason}."


class InvalidExpression(RosTranException):
    msg = "Invalid expression {expression}."


class ConflictDataTypeInExpression(RosTranException):
    msg = "Conflict data type in expression {expression}."


class DiscontinuousIndexInExpression(RosTranException):
    msg = "Discontinuous index {index} in expression {expression}."


class InvalidIndexInExpression(RosTranException):
    msg = "Invalid index {index} in expression {expression}."


class CommandNotFound(RosTranException):
    msg = "Command {cmd} not found."


class RunCommandFailed(RosTranException):
    msg = "Run command {cmd} failed. Reason: {reason}."


class TerraformPlanFormatVersionNotSupported(RosTranException):
    msg = "Terraform plan format version {version} not supported."


class TerraformMultiProvidersNotSupported(RosTranException):
    msg = "Terraform multiple providers transformation is not supported."


class TerraformProviderNotFound(RosTranException):
    msg = "Terraform provider not found."


class InvalidRuleSchema(RosTranException):
    msg = 'Invalid rule file "{path}". Reason: {reason}.'


class RuleVersionNotSupport(RosTranException):
    msg = 'Rule file "{path}"(version: {version}) is not supported.'


class RuleTypeNotSupport(RosTranException):
    msg = 'Rule file "{path}"(type: {type}) is not supported.'


class RuleAlreadyExist(RosTranException):
    msg = 'Rule "{id}"(path: {path}) already exists.'


class SystemNotSupport(RosTranException):
    msg = "Current system {name} is not supported."


class CloudFormationTransformNotSupported(RosTranException):
    msg = "CloudFormation transform is not supported."
