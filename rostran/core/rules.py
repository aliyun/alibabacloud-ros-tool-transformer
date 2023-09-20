from rostran.core.exceptions import (
    InvalidTemplateMetaDataItem,
    InvalidTemplateRules,
    InvalidTemplateRule,
)
from rostran.core.utils import sorted_data


class Rule:
    RULE_KEYS = (
        RULE_CONDITION,
        ASSERTIONS,
    ) = ("RuleCondition", "Assertions")
    RULE_KEY_SCORES = {RULE_CONDITION: 0, ASSERTIONS: 1}

    def __init__(self, name, value):
        self.name = name
        self.value = value

    @classmethod
    def initialize(cls, name: str, value: dict):
        rule = cls(name, value)
        rule.validate()
        return rule

    def validate(self):
        if not isinstance(self.name, str):
            raise InvalidTemplateRule(
                name=self.name,
                reason=f"The type should be str",
            )
        if not isinstance(self.value, dict):
            raise InvalidTemplateRule(
                name=self.name,
                reason=f"The type of value ({self.value}) should be dict",
            )

        # validate value key
        for key, value in self.value.items():
            if not isinstance(key, str):
                raise InvalidTemplateRule(
                    name=f"{self.name}.{key}",
                    reason=f"The type should be str",
                )
            if key not in self.RULE_KEYS:
                raise InvalidTemplateRule(
                    name=self.name,
                    reason=f"Rule key {key} is not supported. Allowed functions: {self.RULE_KEYS}",
                )

            if not isinstance(value, (dict, list)):
                raise InvalidTemplateRule(
                    name=f"{self.name}.{key}",
                    reason=f"The type of value ({self.value}) should be dict or list",
                )
        if self.ASSERTIONS not in self.value:
            raise InvalidTemplateRule(
                name=self.name,
                reason=f"Rule key {self.ASSERTIONS} is required.",
            )

    def as_dict(self, format=False):
        data = {self.name: self.value}
        keys = self.value.keys()
        if format:
            keys = sorted_data(keys, scores=self.RULE_KEY_SCORES)
            value = {}
            for key in keys:
                value[key] = self.value[key]
            data[self.name] = value
        return data


class Rules(dict):
    @classmethod
    def initialize(cls, data: dict):
        if not isinstance(data, dict):
            raise InvalidTemplateRules(
                reason=f"The type of rules ({data}) should be dict"
            )

        rules = cls()
        for name, value in data.items():
            rule = Rule.initialize(name, value)
            rules.add(rule)
        return rules

    def add(self, rule: Rule):
        self[rule.name] = rule

    def as_dict(self, format=False) -> dict:
        data = {}
        keys = self.keys()
        if format:
            keys = sorted_data(keys)
        for key in keys:
            rule: Rule = self[key]
            if rule.value is not None:
                data.update(rule.as_dict(format))
        return data
