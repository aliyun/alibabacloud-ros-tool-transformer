import re
from typing import Any

from openpyxl.cell.cell import Cell

from .exceptions import (
    InvalidTemplateProperty,
    InvalidExpression,
    ConflictDataTypeInExpression,
    InvalidIndexInExpression,
    DiscontinuousIndexInExpression,
    InvalidTemplateProperties,
)
from .utils import get_and_validate_cell, sorted_data

NORMAL_PATTERN = re.compile(r"^([\w\-]+)$")
LIST_PATTERN = re.compile(r"^([\w\-]+)(\[\d+\])+$")
LIST_INDEX_PATTERN = re.compile(r"\[(\d+)\]")
REF_PATTERN = re.compile(r"^!Ref ([\w\-]+)$")


class Property:
    def __init__(self, name: str, value: Any):
        self.name = name
        self.value = value

    @classmethod
    def initialize(cls, name: str, value: dict):
        prop = cls(name, value)
        prop.validate()
        return prop

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        prop_name = get_and_validate_cell(header_cell, InvalidTemplateProperty)
        prop_value = data_cell.value

        if isinstance(prop_value, str):
            value = prop_value.strip()
            result = REF_PATTERN.findall(value)
            if result:
                prop_value = {"Ref": result[0]}

        return cls(name=prop_name, value=prop_value)

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateProperty(
                name=self.name,
                reason=f"The type should be str",
            )

    def as_dict(self, format=False):
        return {self.name: self.value}

    def get_depends_on_set(self) -> set:
        depends_on_set = set()

        def resolve_depends_on(val):
            if isinstance(val, dict):
                if len(val) == 1:
                    ref_value = val.get("Ref")
                    if ref_value and isinstance(ref_value, str):
                        depends_on_set.add(ref_value)
                    get_value = val.get("Fn::GetAtt")
                    if (
                        get_value
                        and isinstance(get_value, list)
                        and len(get_value) >= 2
                    ):
                        name = get_value[0]
                        if isinstance(name, str):
                            depends_on_set.add(name)
                else:
                    for v in val.values():
                        resolve_depends_on(v)
            elif isinstance(val, list):
                for v in val:
                    resolve_depends_on(v)

        resolve_depends_on(self.value)
        return depends_on_set


class Properties(dict):
    PROPERTIES_KEY_SCORES = {
        "ZoneId": 0,
        "MasterZoneIds": 1,
        "WorkerZoneIds": 2,
        "SlaveZoneIds": 3,
        "VpcId": 4,
        "VPCId": 5,
        "VSwitchId": 6,
        "VswitchId": 7,
        "VSwitchIds": 8,
        "MasterVSwitchIds": 9,
        "WorkerVSwitchIds": 10,
        "SourceVSwitchIds": 11,
        "PodVswitchIds": 12,
        "SecurityGroupId": 13,
        "SecurityGroupIds": 14,
        "NetworkInterfaceId": 15,
        "PrimaryNetworkInterfaceId": 16,
        "InstanceId": 17,
        "InstanceIds": 18,
        "ImageId": 19,
    }

    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateProperties(
                reason=f"The type of data ({data}) should be dict"
            )

        props = cls()
        for name, value in data.items():
            prop = Property.initialize(name, value)
            props.add(prop)
        return props

    def add(self, prop: Property):
        self[prop.name] = prop

    def resolve(self) -> "Properties":
        props = Properties()
        for old_name, old_prop in self.items():
            name_parts = old_name.split(".")
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
                        cur_value = prop_value = (
                            props[prop_name].value if prop_name in props else {}
                        )
                    elif i < length - 1:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = {}
                        cur_value = cur_value[cur_name]
                    else:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(expression=old_name)
                        cur_value[cur_name] = old_prop.value
                    continue

                result = LIST_PATTERN.findall(name_part)
                if result:
                    cur_name = result[0][0]
                    if i == 0:
                        prop_name = cur_name
                        cur_value = prop_value = (
                            props[prop_name].value if prop_name in props else []
                        )
                        cur_value = _handle_list_value(
                            name_part, cur_value, expression=old_name
                        )
                    elif i < length - 1:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = []
                        cur_value = cur_value[cur_name]
                        cur_value = _handle_list_value(
                            name_part, cur_value, expression=old_name
                        )
                    else:
                        if not isinstance(cur_value, dict):
                            raise ConflictDataTypeInExpression(expression=old_name)

                        if cur_name not in cur_value:
                            cur_value[cur_name] = []
                        cur_value = cur_value[cur_name]
                        cur_value = _handle_list_value(
                            name_part,
                            cur_value,
                            expression=old_name,
                            data=old_prop.value,
                        )
                    continue

                raise InvalidExpression(expression=old_name)

            props[prop_name] = Property(prop_name, prop_value)

        return props

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted_data(keys, scores=self.PROPERTIES_KEY_SCORES)
        for key in keys:
            prop: Property = self[key]
            if prop.value is not None:
                data.update(prop.as_dict(format))
        return data

    def get_depends_on_set(self) -> set:
        depends_on_set = set()
        for prop in self.values():
            prop: Property
            depends_on_set.update(prop.get_depends_on_set())
        return depends_on_set


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
            raise DiscontinuousIndexInExpression(index=index, expression=expression)
        elif index == len(cur_value):
            if j < indexes_length - 1:
                cur_value.append([])
            elif data is None:
                cur_value.append({})
            else:
                cur_value.append(data)
        cur_value = cur_value[index]
    return cur_value
