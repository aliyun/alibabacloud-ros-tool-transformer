import re

from openpyxl.cell.cell import Cell

from .exceptions import InvalidTemplateParameter
from .utils import get_and_validate_cell


class Parameter:
    TYPES = (STRING, NUMBER, LIST, MAP, BOOLEAN) = (
        "String",
        "Number",
        "CommaDelimitedList",
        "Json",
        "Boolean",
    )

    def __init__(
        self,
        name,
        type,
        default=None,
        association_property=None,
        description=None,
        constraint_description=None,
        allowed_values=None,
        min_length=None,
        max_length=None,
        allowed_pattern=None,
        no_echo=None,
        min_value=None,
        max_value=None,
        label=None,
    ):
        self.name = name
        self.type = type
        self.default = default
        self.association_property = association_property
        self.description = description
        self.constraint_description = constraint_description
        self.allowed_values = allowed_values
        self.allowed_pattern = allowed_pattern
        self.min_length = min_length
        self.max_length = max_length
        self.no_echo = no_echo
        self.min_value = min_value
        self.max_value = max_value
        self.label = label

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        param_name = get_and_validate_cell(header_cell, InvalidTemplateParameter)
        result = re.findall(r"(\S+)\((\S+)\)", param_name)
        if result:
            param_name, param_type = result[0]
            if param_type not in cls.TYPES:
                raise InvalidTemplateParameter(
                    name=param_name,
                    reason=f"Type {param_type} of {header_cell} is not supported. Allowed types: {cls.TYPES}",
                )
        else:
            param_name, param_type = param_name, cls.STRING

        return cls(name=param_name, type=param_type, default=data_cell.value)

    def validate(self):
        if self.type not in self.TYPES:
            raise InvalidTemplateParameter(
                name=self.name,
                reason=f"Type {self.type} is not supported. Allowed types: {self.TYPES}",
            )


class Parameters(dict):
    def add(self, param: Parameter):
        if param.name is None:
            raise InvalidTemplateParameter(
                name=param.name, reason="Parameter name should not be None"
            )

        self[param.name] = param

    def as_dict(self) -> dict:
        data = {}
        for key, param in self.items():
            value = {"Type": param.type}
            if param.default is not None:
                value.update({"Default": param.default})
            if param.association_property is not None:
                value.update({"AssociationProperty": param.association_property})
            if param.description is not None:
                value.update({"Description": param.description})
            if param.constraint_description is not None:
                value.update({"ConstraintDescription": param.constraint_description})
            if param.allowed_values is not None:
                value.update({"AllowedValues": param.allowed_values})
            if param.min_length is not None:
                value.update({"MinLength": param.min_length})
            if param.max_length is not None:
                value.update({"MaxLength": param.max_length})
            if param.allowed_pattern is not None:
                value.update({"AllowedPattern": param.allowed_pattern})
            if param.no_echo is not None:
                value.update({"NoEcho": param.no_echo})
            if param.min_value is not None:
                value.update({"MinValue": param.min_value})
            if param.max_value is not None:
                value.update({"MaxValue": param.max_value})
            if param.label is not None:
                value.update({"Label": param.label})

            data[key] = value

        return data
