from rostran.core.exceptions import InvalidTemplateCondition


class Condition:
    def __init__(self, name, value):
        self.name = name
        self.value = value


class Conditions(dict):
    def add(self, condition: Condition):
        if condition.name is None:
            raise InvalidTemplateCondition(
                name=condition.name, reason="Condition name should not be None"
            )
        self[condition.name] = condition

    def as_dict(self) -> dict:
        data = {}
        for name, condition in self.items():
            if condition.value is not None:
                data[name] = condition.value

        return data
