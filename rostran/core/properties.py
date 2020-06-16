import re
from openpyxl.cell.cell import Cell

from .exceptions import (InvalidTemplateProperty, InvalidExpression, ConflictDataTypeInExpression,
                         InvalidIndexInExpression, DiscontinuousIndexInExpression)
from .utils import get_and_validate_cell

NORMAL_PATTERN = re.compile(r'^([\w\-]+)$')
LIST_PATTERN = re.compile(r'^([\w\-]+)(\[\d+\])+$')
LIST_INDEX_PATTERN = re.compile(r'\[(\d+)\]')
REF_PATTERN = re.compile(r'^!Ref ([\w\-]+)$')


class Property:
    def __init__(self, name: str, value):
        self.name = name
        self.value = value

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        prop_name = get_and_validate_cell(header_cell, InvalidTemplateProperty)
        prop_value = data_cell.value

        if isinstance(prop_value, str):
            value = prop_value.strip()
            result = REF_PATTERN.findall(value)
            if result:
                prop_value = {'Ref': result[0]}

        return cls(name=prop_name, value=prop_value)


class Properties(dict):

    def add(self, prop: Property):
        if prop.name is None:
            raise InvalidTemplateProperty(
                name=prop.name, reason='Property name should not be None')

        self[prop.name] = prop

    def resolve(self) -> 'Properties':
        props = Properties()
        for old_name, old_prop in self.items():
            name_parts = old_name.split('.')
            if len(name_parts) == 1:
                props[old_name] = Property(old_prop.name, old_prop.value)
                continue

            prop_name = None
            cur_value = prop_value = None
            length = len(name_parts)
            for i, name_part in enumerate(name_parts):
                result = NORMAL_PATTERN.findall(name_part)
                if result:
                    cur_name = name_part
                    if i == 0:
                        prop_name = name_part
                        cur_value = prop_value = props[prop_name].value if prop_name in props else {
                        }
                    elif i < length - 1:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(
                                expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = {}
                        cur_value = cur_value[cur_name]
                    else:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(
                                expression=old_name)
                        cur_value[cur_name] = old_prop.value
                    continue

                result = LIST_PATTERN.findall(name_part)
                if result:
                    cur_name = result[0][0]
                    if i == 0:
                        prop_name = cur_name
                        cur_value = prop_value = props[prop_name].value if prop_name in props else [
                        ]
                        cur_value = _handle_list_value(
                            name_part, cur_value, expression=old_name)
                    elif i < length - 1:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(
                                expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = []
                        cur_value = cur_value[cur_name]
                        cur_value = _handle_list_value(
                            name_part, cur_value, expression=old_name)
                    else:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(
                                expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = []
                        cur_value = cur_value[cur_name]
                        cur_value = _handle_list_value(
                            name_part, cur_value, expression=old_name, data=old_prop.value)
                    continue

                raise InvalidExpression(expression=old_name)

            props[prop_name] = Property(prop_name, prop_value)

        return props

    def as_dict(self) -> dict:
        return {k: v.value for k, v in self.items()}


def _handle_list_value(name_part, cur_value, expression, data=None):
    if not isinstance(cur_value, list):
        raise ConflictDataTypeInExpression(expression=expression)

    indexes = LIST_INDEX_PATTERN.findall(name_part)
    indexes_length = len(indexes)
    for j, index in enumerate(indexes):
        index = int(index)
        if index < 0:
            raise InvalidIndexInExpression(index=index, expression=expression)
        if index > len(cur_value):
            raise DiscontinuousIndexInExpression(
                index=index, expression=expression)
        elif index == len(cur_value):
            if j < indexes_length - 1:
                cur_value.append([])
            elif data is None:
                cur_value.append({})
            else:
                cur_value.append(data)
        cur_value = cur_value[index]
    return cur_value
