from rostran.core.exceptions import InvalidTemplateMapping


class Mapping:
    def __init__(self, name, value):
        self.name = name
        self.value = value


class Mappings(dict):
    def add(self, mapping: Mapping):
        if mapping.name is None:
            raise InvalidTemplateMapping(
                name=mapping.name, reason="Mapping name should not be None"
            )
        self[mapping.name] = mapping

    def as_dict(self) -> dict:
        data = {}
        for name, mapping in self.items():
            if mapping.value is not None:
                data[name] = mapping.value

        return data
