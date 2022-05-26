from rostran.core.exceptions import InvalidTemplateCondition, InvalidTemplateConditions
from rostran.core.utils import sorted_data


class Condition:
    CONDITION_FUNCS = ("Fn::And", "Fn::Or", "Fn::Not", "Fn::Equals")

    def __init__(self, name, value):
        self.name = name
        self.value = value

    @classmethod
    def initialize(cls, name: str, value: dict):
        condition = cls(name, value)
        condition.validate()
        return condition

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateCondition(
                name=self.name,
                reason=f"The type should be str",
            )
        if not isinstance(self.value, dict):
            raise InvalidTemplateCondition(
                name=self.name,
                reason=f"The type of value ({self.value}) should be dict",
            )

        # validate value key
        for key, value in self.value.items():
            if not isinstance(key, str):
                raise InvalidTemplateCondition(
                    name=f"{self.name}.{key}",
                    reason=f"The type should be str",
                )
            if key not in self.CONDITION_FUNCS:
                raise InvalidTemplateCondition(
                    name=self.name,
                    reason=f"Condition function {key} is not supported. Allowed functions: {self.CONDITION_FUNCS}",
                )

            if not isinstance(value, (dict, list)):
                raise InvalidTemplateCondition(
                    name=f"{self.name}.{key}",
                    reason=f"The type of value ({self.value}) should be dict or list",
                )

    def as_dict(self, format=False):
        data = {self.name: self.value}
        if format:
            data[self.name] = sorted_data(self.value)
        return data


class Conditions(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateConditions(
                reason=f"The type of data ({data}) should be dict"
            )

        conditions = cls()
        for name, value in data.items():
            condition = Condition.initialize(name, value)
            conditions.add(condition)
        return conditions

    def add(self, condition: Condition):
        self[condition.name] = condition

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted_data(keys)
        for key in keys:
            condition: Condition = self[key]
            if condition.value is not None:
                data.update(condition.as_dict(format))
        return data
