class RosTranException(Exception):
    msg = 'Internal error'

    def __init__(self, **kwargs):
        self.kwargs = kwargs
        self.message = self.msg.format(**kwargs)

    def __str__(self):
        return self.message


class RosTranWarning(RosTranException):
    msg = '{message}.'


class PathNotExist(RosTranException):
    msg = 'Path "{path}" not exists.'


class TemplateNotExist(RosTranException):
    msg = 'Template "{path}" not exists.'


class TemplateAlreadyExist(RosTranException):
    msg = 'Template "{path}" already exists.'


class TemplateNotSupport(RosTranException):
    msg = 'Template "{path}" is not supported.'


class TemplateFormatNotSupport(RosTranException):
    msg = 'Template "{path}"(format: {format}) is not supported.'


class InvalidTemplateParameter(RosTranException):
    msg = 'Invalid template parameter {name}. {reason}.'


class InvalidTemplateResource(RosTranException):
    msg = 'Invalid template resource {name}. {reason}.'


class InvalidTemplateProperty(RosTranException):
    msg = 'Invalid template property {name}. {reason}.'


class InvalidExcelTemplate(RosTranException):
    msg = 'Invalid excel template. {reason}.'


class InvalidExpression(RosTranException):
    msg = 'Invalid expression {expression}.'


class ConflictDataTypeInExpression(RosTranException):
    msg = 'Conflict data type in expression {expression}.'


class DiscontinuousIndexInExpression(RosTranException):
    msg = 'Discontinuous index {index} in expression {expression}.'


class InvalidIndexInExpression(RosTranException):
    msg = 'Invalid index {index} in expression {expression}.'
