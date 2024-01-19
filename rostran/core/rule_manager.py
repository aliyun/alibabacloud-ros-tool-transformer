import os
from typing import Dict

import typer
from ruamel.yaml import YAML
from .exceptions import (
    InvalidRuleSchema,
    RuleVersionNotSupport,
    RuleTypeNotSupport,
    RuleAlreadyExist,
)
from rostran.core.settings import RULES_DIR
import rostran.handlers.resource as resource_handler_module

yaml = YAML()


class RuleClassifier:
    TerraformAliCloud = "terraform/alicloud"
    TerraformAWS = "terraform/aws"
    CloudFormation = "cloudformation"


class RuleManager:
    def __init__(
        self,
        rule_classifier: str,
        resource_rules: Dict[str, "ResourceRule"] = None,
        pseudo_parameters_rule: "PseudoParametersRule" = None,
        function_rule: "FunctionRule" = None,
        meta_data_rule: "MetaDataRule" = None,
        association_property_rule: "AssociationPropertyRule" = None,
    ):
        self.rule_classifier = rule_classifier
        self.resource_rules = resource_rules or {}
        self.function_rule = function_rule
        self.pseudo_parameters_rule = pseudo_parameters_rule
        self.meta_data_rule = meta_data_rule
        self.association_property_rule = association_property_rule

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
                elif rule.type == Rule.FUNCTION:
                    if self.function_rule:
                        raise RuleAlreadyExist(id=rule.rule_id, path=filepath)
                    self.function_rule = rule
                elif rule.type == Rule.META_DATA:
                    if self.meta_data_rule:
                        raise RuleAlreadyExist(id=rule.rule_id, path=filepath)
                    self.meta_data_rule = rule
                elif rule.type == Rule.ASSOCIATION_PROPERTY:
                    if self.association_property_rule:
                        raise RuleAlreadyExist(id=rule.rule_id, path=filepath)
                    self.association_property_rule = rule

    def show(self, markdown=False, with_link=False):
        typer.secho(f"# Rules for {self.rule_classifier}", fg=typer.colors.GREEN)
        newline = False

        def sorted_echo(d, getter, from_link_func=None, to_link_func=None):
            if markdown:
                typer.echo("| From |  To  |")
                typer.echo("| ---- | ---- |")

            for from_ in sorted(d):
                to = getter(d[from_])
                if not to:
                    continue
                if markdown:
                    if with_link:
                        if from_link_func:
                            from_link = from_link_func(from_)
                            if from_link:
                                from_ = f"[{from_}]({from_link})"
                        if to_link_func:
                            to_link = to_link_func(to)
                            if to_link:
                                to = f"[{to}]({to_link})"
                    typer.echo(f"| {from_} | {to} |")
                else:
                    typer.echo(f"{from_} -> {to}")

        def resource_from_link_func(rt: str):
            if self.rule_classifier == RuleClassifier.TerraformAliCloud:
                rt = rt.replace("alicloud_", "")
                return f"https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/{rt}"
            elif self.rule_classifier == RuleClassifier.CloudFormation:
                rt = rt.replace("AWS::", "").replace("::", "-").lower()
                return f"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-{rt}"
            else:
                return None

        def resource_to_link_func(rt: str):
            rt = rt.replace("::", "-").lower()
            return f"https://www.alibabacloud.com/help/ros/developer-reference/{rt}"

        if self.resource_rules:
            typer.secho("## Resources", fg=typer.colors.GREEN)
            newline = True
            sorted_echo(
                self.resource_rules,
                getter=lambda x: x.target_resource_type,
                from_link_func=resource_from_link_func,
                to_link_func=resource_to_link_func,
            )

        if self.pseudo_parameters_rule:
            if newline:
                typer.echo("")
            typer.secho("## Pseudo Parameters", fg=typer.colors.GREEN)
            newline = True
            sorted_echo(
                self.pseudo_parameters_rule.pseudo_parameters,
                getter=lambda x: x.get("To"),
            )

        if self.function_rule:
            if newline:
                typer.echo("")
            typer.secho("## Function", fg=typer.colors.GREEN)
            newline = True
            sorted_echo(self.function_rule.function, getter=lambda d: d.get("To"))

        if self.association_property_rule:
            if newline:
                typer.echo("")
            typer.secho("## Association Property", fg=typer.colors.GREEN)
            newline = True
            sorted_echo(
                self.association_property_rule.association_property,
                getter=lambda x: x.get("To"),
            )

        if self.meta_data_rule:
            if newline:
                typer.echo("")
            typer.secho("## Metadata", fg=typer.colors.GREEN)
            sorted_echo(self.meta_data_rule.meta_data, getter=lambda x: x.get("To"))


class Rule:
    TYPES = (RESOURCE, PSEUDO_PARAMETERS, FUNCTION, META_DATA, ASSOCIATION_PROPERTY) = (
        "Resource",
        "PseudoParameters",
        "Function",
        "Metadata",
        "AssociationProperty",
    )

    _PROPERTIES = (
        VERSION,
        TYPE,
        RESOURCE_TYPE,
        PROPERTIES,
        ATTRIBUTES,
        HANDLER,
    ) = (
        "Version",
        "Type",
        "ResourceType",
        "Properties",
        "Attributes",
        "Handler",
    )

    SUPPORTED_VERSIONS = ("2020-06-01",)

    def __init__(self, version, type, rule_id=None, *args, **kwargs):
        self.version = version
        self.type = type
        self.rule_id = rule_id

    @classmethod
    def initialize(cls, path: str):
        with open(path) as f:
            data = yaml.load(f)

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
        elif type_ == cls.FUNCTION:
            return FunctionRule.initialize_from_info(path, data, version, type_)
        elif type_ == cls.META_DATA:
            return MetaDataRule.initialize_from_info(path, data, version, type_)
        elif type_ == cls.ASSOCIATION_PROPERTY:
            return AssociationPropertyRule.initialize_from_info(
                path, data, version, type_
            )


class ResourceRule(Rule):
    def __init__(
        self,
        version,
        type,
        rule_id,
        properties,
        attributes,
        target_resource_type=None,
        handler=None,
    ):
        super().__init__(version, type, rule_id)
        self.properties = properties
        self.attributes = attributes
        self.target_resource_type = target_resource_type
        self.handler = handler

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        resource_type = data.get(cls.RESOURCE_TYPE, {})
        if not isinstance(resource_type, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.RESOURCE} type should be dict")
        rule_id = resource_type["From"]
        target_resource_type = resource_type.get("To")

        properties = data.get(cls.PROPERTIES, {})
        if not isinstance(properties, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.PROPERTIES} type should be dict")

        attributes = data.get(cls.ATTRIBUTES, {})
        if not isinstance(attributes, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.ATTRIBUTES} type should be dict")

        handler_name = data.get(cls.HANDLER)
        handler_func = (
            getattr(resource_handler_module, handler_name) if handler_name else None
        )
        return cls(
            version,
            type,
            rule_id,
            properties,
            attributes,
            target_resource_type,
            handler_func,
        )


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


class FunctionRule(Rule):
    def __init__(self, version, type, rule_id, function):
        super().__init__(version, type, rule_id)
        self.function = function
        self.ignored = self.ignored_function()

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        function = data.get(cls.FUNCTION, {})
        if not isinstance(function, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.FUNCTION} type should be dict")

        rule_id = cls.FUNCTION
        return cls(version, type, rule_id, function)

    def ignored_function(self):
        return [aws for aws, ros in self.function.items() if ros.get("Ignore")]


class MetaDataRule(Rule):
    def __init__(self, version, type, rule_id, meta_data):
        super().__init__(version, type, rule_id)
        self.meta_data = meta_data

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        meta_data = data.get(cls.META_DATA, {})
        if not isinstance(meta_data, dict):
            InvalidRuleSchema(path=path, reason=f"{cls.META_DATA} type should be dict")

        rule_id = cls.META_DATA
        return cls(version, type, rule_id, meta_data)


class AssociationPropertyRule(Rule):
    def __init__(self, version, type, rule_id, association_property):
        super().__init__(version, type, rule_id)
        self.association_property = association_property

    @classmethod
    def initialize_from_info(cls, path, data, version, type):
        association_property = data.get(cls.ASSOCIATION_PROPERTY, {})
        if not isinstance(association_property, dict):
            InvalidRuleSchema(
                path=path, reason=f"{cls.ASSOCIATION_PROPERTY} type should be dict"
            )

        rule_id = cls.ASSOCIATION_PROPERTY
        return cls(version, type, rule_id, association_property)
