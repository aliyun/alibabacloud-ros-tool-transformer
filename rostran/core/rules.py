import os
import yaml
from .exceptions import (
    InvalidRuleSchema,
    RuleVersionNotSupport,
    RuleTypeNotSupport,
    RuleAlreadyExist,
)
from rostran.core.settings import RULES_DIR


class RuleClassifier:
    TerraformAliCloud = "terraform/alicloud"
    TerraformAWS = "terraform/aws"
    CloudFormation = "cloudformation"


class RuleManager:
    def __init__(
        self,
        rule_classifier: str,
        resource_rules=None,
        pseudo_parameters_rule=None,
        function_rules=None,
    ):
        self.rule_classifier = rule_classifier
        self.resource_rules = resource_rules or {}
        self.function_rules = function_rules or {}
        self.pseudo_parameters_rule = pseudo_parameters_rule

    @classmethod
    def initialize(cls, rule_classifier):
        rule_manager = cls(rule_classifier)
        rule_manager.load()
        return rule_manager

    def load(self):
        rules_dir = os.path.join(RULES_DIR, self.rule_classifier)
        if not os.path.exists(rules_dir):
            return

        for root, dirs, files in os.walk(rules_dir):
            for filename in files:
                if not filename.endswith(".yml"):
                    continue

                filepath = os.path.join(root, filename)
                if not os.path.isfile(filepath):
                    continue

                rule = Rule.initialize(filepath)
                if rule.type == Rule.RESOURCE:
                    if rule.rule_id in self.resource_rules:
                        raise RuleAlreadyExist(id=rule.rule_id, path=filepath)
                    self.resource_rules[rule.rule_id] = rule
                elif rule.type == Rule.PSEUDO_PARAMETERS:
                    if self.pseudo_parameters_rule:
                        raise RuleAlreadyExist(id=rule.rule_id, path=filepath)
                    self.pseudo_parameters_rule = rule


class Rule:

    TYPES = (RESOURCE, PSEUDO_PARAMETERS) = (
        "Resource",
        "PseudoParameters",
    )

    _PROPERTIES = (VERSION, TYPE, RESOURCE_TYPE, PROPERTIES, ATTRIBUTES,) = (
        "Version",
        "Type",
        "ResourceType",
        "Properties",
        "Attributes",
    )

    SUPPORTED_VERSIONS = ("2020-06-01",)

    def __init__(self, version, type, rule_id=None, *args, **kwargs):
        self.version = version
        self.type = type
        self.rule_id = rule_id

    @classmethod
    def initialize(cls, path: str):
        with open(path) as f:
            data = yaml.safe_load(f)

        if not isinstance(data, dict):
            raise InvalidRuleSchema(path=path, reason="rule data type should be dict")

        version = str(data.get(cls.VERSION))
        if version not in cls.SUPPORTED_VERSIONS:
            raise RuleVersionNotSupport(path=path, version=version)

        type_ = data.get(cls.TYPE)
        if type_ not in cls.TYPES:
            raise RuleTypeNotSupport(path=path, type=type_)

        if type_ == cls.RESOURCE:
            return ResourceRule.initialize_from_info(path, data, version, type_)
        elif type_ == cls.PSEUDO_PARAMETERS:
            return PseudoParametersRule.initialize_from_info(path, data, version, type_)


class ResourceRule(Rule):
    def __init__(
        self, version, type, rule_id, properties, attributes, target_resource_type
    ):
        super().__init__(version, type, rule_id)
        self.properties = properties
        self.attributes = attributes
        self.target_resource_type = target_resource_type

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        resource_type = data.get(cls.RESOURCE_TYPE, {})
        if not isinstance(resource_type, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.RESOURCE} type should be dict")
        rule_id = resource_type["From"]
        target_resource_type = resource_type["To"]

        properties = data.get(cls.PROPERTIES, {})
        if not isinstance(properties, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.PROPERTIES} type should be dict")

        attributes = data.get(cls.ATTRIBUTES, {})
        if not isinstance(attributes, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.ATTRIBUTES} type should be dict")

        return cls(version, type, rule_id, properties, attributes, target_resource_type)


class PseudoParametersRule(Rule):
    def __init__(self, version, type, rule_id, pseudo_parameters):
        super().__init__(version, type, rule_id)
        self.pseudo_parameters = pseudo_parameters

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        pseudo_parameters = data.get(cls.PSEUDO_PARAMETERS, {})
        if not isinstance(pseudo_parameters, dict):
            InvalidRuleSchema(
                path=path, reason=f"{cls.PSEUDO_PARAMETERS} type should be dict"
            )

        rule_id = cls.PSEUDO_PARAMETERS
        return cls(version, type, rule_id, pseudo_parameters)
