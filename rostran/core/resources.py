from typing import Union

from openpyxl.cell.cell import Cell

from .exceptions import (
    InvalidTemplateResource,
    InvalidTemplateResources,
)
from .properties import Properties
from .utils import get_and_validate_cell, sorted_data, Graph


class Resource:
    PROPERTIES_ = (
        TYPE,
        PROPERTIES,
        DEPENDS_ON,
        CONDITION,
        DELETION_POLICY,
        METADATA,
    ) = (
        "Type",
        "Properties",
        "DependsOn",
        "Condition",
        "DeletionPolicy",
        "Metadata",
    )
    DELETION_POLICIES = (RETAIN, DELETE) = ("Retain", "Delete")

    def __init__(
        self,
        resource_id: str,
        resource_type: str,
        properties: Properties = None,
        depends_on: Union[str, list] = None,
        condition: str = None,
        deletion_policy: str = None,
        metadata: dict = None,
        other_properties: dict = None,
    ):
        self.resource_id = resource_id
        self.type = resource_type
        self.properties = properties or Properties()
        self.depends_on = depends_on
        self.condition = condition
        self.deletion_policy = deletion_policy
        self.metadata = metadata
        self.other_properties = other_properties

    @classmethod
    def initialize(cls, resource_id: str, value: dict):
        if not isinstance(value, dict):
            raise InvalidTemplateResource(
                name=resource_id,
                reason=f"The type of value ({value}) should be dict",
            )

        value = value.copy()
        props = value.pop(cls.PROPERTIES, None)
        properties = Properties.initialize(props) if props else None
        resource = cls(
            resource_id,
            resource_type=value.pop(cls.TYPE, None),
            properties=properties,
            depends_on=value.pop(cls.DEPENDS_ON, None),
            condition=value.pop(cls.CONDITION, None),
            deletion_policy=value.pop(cls.DELETION_POLICY, None),
            metadata=value.pop(cls.METADATA, None),
            other_properties=value,
        )
        resource.validate()
        return resource

    @classmethod
    def initialize_from_excel(cls, header_cell: Cell, data_cell: Cell):
        # resource type
        orig_resource_type = header_cell.value
        resource_type = get_and_validate_cell(header_cell, InvalidTemplateResource)

        if not resource_type.startswith("ALIYUN::"):
            resource_type = f"ALIYUN::{resource_type}"

        if len(resource_type.split("::")) != 3:
            raise InvalidTemplateResource(
                name=orig_resource_type,
                reason=f"Value of {header_cell} must be format of "
                f"{{Product}}::{{Resource}} or ALIYUN::{{Product}}::{{Resource}}",
            )

        resource_id = data_cell.value
        resource = cls(resource_id=resource_id, resource_type=resource_type)
        resource.validate()
        return resource

    def validate(self):
        if not isinstance(self.resource_id, str):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"The type should be str",
            )
        if not self.resource_id:
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"ResourceId should not be empty",
            )
        if not isinstance(self.type, str):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"The type should be str",
            )
        if not self.type:
            raise InvalidTemplateResource(
                name=self.type,
                reason=f"ResourceType should not be empty",
            )
        if self.depends_on is not None and not isinstance(self.depends_on, (str, list)):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"The type of {self.DEPENDS_ON} should be str or list",
            )
        if self.condition is not None and not isinstance(self.condition, str):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"The type of {self.CONDITION} should be str",
            )
        if (
            self.deletion_policy is not None
            and self.deletion_policy not in self.DELETION_POLICIES
        ):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"DeletionPolicy {self.deletion_policy} is not supported. "
                f"Allowed types: {self.DELETION_POLICIES}",
            )
        if self.metadata is not None and not isinstance(self.metadata, dict):
            raise InvalidTemplateResource(
                name=self.resource_id,
                reason=f"The type of {self.METADATA} should be dict",
            )

    def as_dict(self, format=False):
        data = {Resource.TYPE: self.type}
        if self.condition:
            data[Resource.CONDITION] = self.condition
        data[Resource.PROPERTIES] = self.properties.as_dict(format=format)
        if self.depends_on:
            if format and isinstance(self.depends_on, list):
                depends_on = sorted_data(self.depends_on)
            else:
                depends_on = self.depends_on
            data[Resource.DEPENDS_ON] = depends_on
        if self.deletion_policy:
            data[Resource.DELETION_POLICY] = self.deletion_policy
        if self.metadata:
            data[Resource.METADATA] = self.metadata
        if self.other_properties:
            other_properties = (
                sorted_data(self.other_properties) if format else self.other_properties
            )
            data.update(other_properties)
        return data

    def get_depends_on_set(self):
        depends_on_set = set()
        if self.depends_on:
            if not isinstance(self.depends_on, list):
                depends_on = [self.depends_on]
            else:
                depends_on = self.depends_on
            depends_on_set.update(depends_on)
        depends_on_set.update(self.properties.get_depends_on_set())
        return depends_on_set


class Resources(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateResources(
                reason=f"The type of data ({data}) should be dict"
            )

        resources = cls()
        for resource_id, value in data.items():
            resource = Resource.initialize(resource_id, value)
            resources.add(resource)
        return resources

    def add(self, resource: Resource):
        self[resource.resource_id] = resource

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            graph = Graph()
            for key in keys:
                resource: Resource = self[key]
                depends_on_set = resource.get_depends_on_set()
                if depends_on_set:
                    for depends_on in sorted(depends_on_set):
                        if depends_on in self:
                            graph.add_edge(key, depends_on)
                    else:
                        graph.add_edge(key)
                else:
                    graph.add_edge(key)
            keys = graph.topo_sort()

        for key in keys:
            resource: Resource = self[key]
            data[key] = resource.as_dict(format)
        return data
