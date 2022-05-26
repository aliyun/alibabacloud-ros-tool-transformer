from rostran.core.exceptions import InvalidTemplateMapping, InvalidTemplateMappings
from rostran.core.utils import sorted_data


class Mapping:
    def __init__(self, name: str, value: dict):
        self.name = name
        self.value = value

    @classmethod
    def initialize(cls, name: str, value: dict):
        mapping = cls(name, value)
        mapping.validate()
        return mapping

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateMapping(
                name=self.name,
                reason=f"The type should be str",
            )
        if not isinstance(self.value, dict):
            raise InvalidTemplateMapping(
                name=self.name,
                reason=f"The type of value ({self.value}) should be dict",
            )

        # validate value key
        for key, value in self.value.items():
            if not isinstance(key, str):
                raise InvalidTemplateMapping(
                    name=f"{self.name}.{key}",
                    reason=f"The type should be str",
                )
            if not isinstance(value, dict):
                raise InvalidTemplateMapping(
                    name=f"{self.name}.{key}",
                    reason=f"The type of value ({self.value}) should be dict",
                )

    def as_dict(self, format=False):
        data = {self.name: self.value}
        if format:
            data[self.name] = sorted_data(self.value, traverse=True)
        return data


class Mappings(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateMappings(
                reason=f"The type of data ({data}) should be dict"
            )

        mappings = cls()
        for name, value in data.items():
            mapping = Mapping.initialize(name, value)
            mappings.add(mapping)
        return mappings

    def add(self, mapping: Mapping):
        self[mapping.name] = mapping

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted_data(keys)
        for key in keys:
            mapping: Mapping = self[key]
            if mapping.value is not None:
                data.update(mapping.as_dict(format))
        return data
