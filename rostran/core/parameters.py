import re
from typing import Union, List, Iterable

from openpyxl.cell.cell import Cell

from .exceptions import InvalidTemplateParameter, InvalidTemplateParameters
from .metadata import MetaData, MetaItem
from .utils import get_and_validate_cell, sorted_data


class Parameter:
    TYPES = (STRING, NUMBER, LIST, MAP, BOOLEAN) = (
        "String",
        "Number",
        "CommaDelimitedList",
        "Json",
        "Boolean",
    )
    PROPERTIES = (
        TYPE,
        LABEL,
        DESCRIPTION,
        CONSTRAINT_DESCRIPTION,
        ASSOCIATION_PROPERTY,
        ASSOCIATION_PROPERTY_METADATA,
        DEFAULT,
        ALLOWED_VALUES,
        ALLOWED_PATTERN,
        MIN_LENGTH,
        MAX_LENGTH,
        MIN_VALUE,
        MAX_VALUE,
        NO_ECHO,
        CONFIRM,
        TEXT_AREA,
    ) = (
        "Type",
        "Label",
        "Description",
        "ConstraintDescription",
        "AssociationProperty",
        "AssociationPropertyMetadata",
        "Default",
        "AllowedValues",
        "AllowedPattern",
        "MinLength",
        "MaxLength",
        "MinValue",
        "MaxValue",
        "NoEcho",
        "Confirm",
        "TextArea",
    )
    NULL = ...

    def __init__(
        self,
        name: str,
        type: str,
        default=None,
        association_property: str = None,
        association_property_metadata: dict = None,
        description: str = None,
        constraint_description: str = None,
        allowed_values: list = None,
        min_length: int = None,
        max_length: int = None,
        allowed_pattern: str = None,
        min_value: Union[int, float] = None,
        max_value: Union[int, float] = None,
        label=None,
        no_echo: bool = None,
        confirm: bool = None,
        text_area: bool = None,
        orig_data: dict = None,
    ):
        self.name = name
        self.type = type
        self.default = default
        self.association_property = association_property
        self.association_property_metadata = association_property_metadata
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
        self.confirm = confirm
        self.text_area = text_area
        self.orig_data = orig_data

    @classmethod
    def initialize(cls, name: str, value: dict):
        if not isinstance(value, dict):
            raise InvalidTemplateParameter(
                name=name,
                reason=f"The type of value ({value}) should be dict",
            )

        if cls.DEFAULT in value:
            default = cls.NULL if value[cls.DEFAULT] is None else value[cls.DEFAULT]
        else:
            default = None
        param = cls(
            name,
            type=value.get(cls.TYPE),
            default=default,
            association_property=value.get(cls.ASSOCIATION_PROPERTY),
            association_property_metadata=value.get(cls.ASSOCIATION_PROPERTY_METADATA),
            description=value.get(cls.DESCRIPTION),
            constraint_description=value.get(cls.CONSTRAINT_DESCRIPTION),
            allowed_values=value.get(cls.ALLOWED_VALUES),
            min_length=value.get(cls.MIN_LENGTH),
            max_length=value.get(cls.MAX_LENGTH),
            allowed_pattern=value.get(cls.ALLOWED_PATTERN),
            min_value=value.get(cls.MIN_VALUE),
            max_value=value.get(cls.MAX_VALUE),
            label=value.get(cls.LABEL),
            no_echo=value.get(cls.NO_ECHO),
            confirm=value.get(cls.CONFIRM),
            text_area=value.get(cls.TEXT_AREA),
            orig_data=value,
        )
        param.validate()
        return param

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        param_name = get_and_validate_cell(header_cell, InvalidTemplateParameter)
        result = re.findall(r"(\S+)\((\S+)\)", param_name)
        if result:
            param_name, param_type = result[0]
            if param_type not in cls.TYPES:
                raise InvalidTemplateParameter(
                    name=param_name,
                    reason=f"Parameter type {param_type} of {header_cell} is not supported. Allowed types: {cls.TYPES}",
                )
        else:
            param_name, param_type = param_name, cls.STRING

        param = cls(name=param_name, type=param_type, default=data_cell.value)
        param.validate()
        return param

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateParameter(
                name=self.name,
                reason=f"The type should be str",
            )

        if self.type not in self.TYPES:
            raise InvalidTemplateParameter(
                name=self.name,
                reason=f"Parameter type {self.type} is not supported. Allowed types: {self.TYPES}",
            )

        if self.association_property is not None and not isinstance(
            self.association_property, str
        ):
            raise InvalidTemplateParameter(
                name=self.name,
                reason=f"The type of {self.ASSOCIATION_PROPERTY} should be str",
            )

        if self.association_property_metadata is not None and not isinstance(
            self.association_property_metadata, dict
        ):
            raise InvalidTemplateParameter(
                name=self.name,
                reason=f"The type of {self.ASSOCIATION_PROPERTY_METADATA} should be dict",
            )

    def as_dict(self, format=False):
        if not format and self.orig_data:
            data = {k: v for k, v in self.orig_data.items() if v is not None}
        else:
            data = {self.TYPE: self.type}
            if self.label is not None:
                data.update({self.LABEL: self.label})
            if self.description is not None:
                data.update({self.DESCRIPTION: self.description})
            if self.constraint_description is not None:
                data.update({self.CONSTRAINT_DESCRIPTION: self.constraint_description})
            if self.association_property is not None:
                data.update({self.ASSOCIATION_PROPERTY: self.association_property})
            if self.association_property_metadata is not None:
                data.update(
                    {
                        self.ASSOCIATION_PROPERTY_METADATA: self.association_property_metadata
                    }
                )
            if self.default is not None:
                default = None if self.default is self.NULL else self.default
                data.update({self.DEFAULT: default})
            if self.allowed_values is not None:
                data.update({self.ALLOWED_VALUES: self.allowed_values})
            if self.allowed_pattern is not None:
                data.update({self.ALLOWED_PATTERN: self.allowed_pattern})
            if self.min_length is not None:
                data.update({self.MIN_LENGTH: self.min_length})
            if self.max_length is not None:
                data.update({self.MAX_LENGTH: self.max_length})
            if self.min_value is not None:
                data.update({self.MIN_VALUE: self.min_value})
            if self.max_value is not None:
                data.update({self.MAX_VALUE: self.max_value})
            if self.no_echo is not None:
                data.update({self.NO_ECHO: self.no_echo})
            if self.confirm is not None:
                data.update({self.CONFIRM: self.confirm})
            if self.text_area is not None:
                data.update({self.TEXT_AREA: self.text_area})
        return {self.name: data}


class Parameters(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateParameters(
                reason=f"The type of data ({data}) should be dict"
            )

        params = cls()
        for name, value in data.items():
            param = Parameter.initialize(name, value)
            params.add(param)
        return params

    def add(self, param: Parameter):
        self[param.name] = param

    def as_dict(self, format=False, metadata: MetaData = None) -> dict:
        data = {}
        keys = self.keys()
        if format and metadata:
            ros_interface = metadata.get(MetaData.ROS_INTERFACE)
            if ros_interface:
                param_groups = ros_interface.value.get(MetaItem.PARAMETER_GROUPS)
                score = 0
                key_scores = {}
                if param_groups:
                    for param_group in param_groups:
                        parameters = param_group[MetaItem.PARAMETERS]
                        for parameter in parameters:
                            key_scores[parameter] = score
                            score += 1
                if key_scores:
                    keys = sorted_data(keys, scores=key_scores)

        for key in keys:
            param: Parameter = self[key]
            data.update(param.as_dict(format))
        return data
