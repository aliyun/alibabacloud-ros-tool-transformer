import re

from openpyxl.cell.cell import Cell

from .exceptions import InvalidTemplateParameter
from .utils import get_and_validate_cell


class Parameter:
    TYPES = (
        STRING, NUMBER, LIST, MAP, BOOLEAN
    ) = (
        'String', 'Number', 'CommaDelimitedList', 'Json', 'Boolean'
    )

    def __init__(self, name, type, default=None):
        self.name = name
        self.type = type
        self.default = default

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        param_name = get_and_validate_cell(
            header_cell, InvalidTemplateParameter)
        result = re.findall(r'(\S+)\((\S+)\)', param_name)
        if result:
            param_name, param_type = result[0]
            if param_type not in cls.TYPES:
                raise InvalidTemplateParameter(
                    name=param_name,
                    reason=f'Type {param_type} of {header_cell} is not supported. Allowed types: {cls.TYPES}')
        else:
            param_name, param_type = param_name, cls.STRING

        return cls(name=param_name, type=param_type, default=data_cell.value)

    def validate(self):
        if self.type not in self.TYPES:
            raise InvalidTemplateParameter(
                name=self.name, reason=f'Type {self.type} is not supported. Allowed types: {self.TYPES}')


class Parameters(dict):

    def add(self, param: Parameter):
        if param.name is None:
            raise InvalidTemplateParameter(
                name=param.name, reason='Parameter name should not be None')

        self[param.name] = param

    def as_dict(self) -> dict:
        data = {}
        for key, param in self.items():
            value = {'Type': param.type}
            if param.default is not None:
                value.update({'Default': param.default})
            data[key] = value

        return data
