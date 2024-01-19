import re
import os
import json
import importlib

import typer
from ruamel.yaml import YAML

from rostran.core.exceptions import (
    TemplateFormatNotSupport,
    CloudFormationTransformNotSupported,
    InvalidRuleSchema,
    InvalidYamlTemplateTag,
)
from rostran.core.format import FileFormat
from rostran.core.template import Template, RosTemplate
from rostran.core.settings import RULES_DIR
from rostran.core.rule_manager import (
    RuleClassifier,
    RuleManager,
    ResourceRule,
    PseudoParametersRule,
    FunctionRule,
)
from rostran.core.outputs import Output, Outputs
from rostran.core.resources import Resource, Resources
from rostran.core.properties import Property
from rostran.core.parameters import Parameter, Parameters
from rostran.core.metadata import MetaItem, MetaData
from rostran.core.conditions import Condition, Conditions
from rostran.core.mappings import Mapping, Mappings
import rostran.handlers.basic as basic_handler_module
import rostran.handlers.merge as merge_handler_module

RULES_DIR = os.path.join(RULES_DIR, "cloudformation")
BUILTIN_RULES = os.path.join(RULES_DIR, "builtin")
RESOURCE_RULES = os.path.join(RULES_DIR, "resource")

yaml = YAML()
yaml.preserve_quotes = True


def short_handler_for_getatt(val):
    if isinstance(val, str):
        return val.split(".")
    return val


short_mappings = {
    "!Ref": ("Ref", None),
    "!Transform": ("Fn::Transform", None),
    "!Sub": ("Fn::Sub", None),
    "!Split": ("Fn::Split", None),
    "!Select": ("Fn::Select", None),
    "!Join": ("Fn::Join", None),
    "!ImportValue": ("Fn::ImportValue", None),
    "!GetAZs": ("Fn::GetAZs", None),
    "!GetAtt": ("Fn::GetAtt", short_handler_for_getatt),
    "!FindInMap": ("Fn::FindInMap", None),
    "!Cidr": ("Fn::Cidr", None),
    "!Base64": ("Fn::Base64", None),
}


def short_constructor(loader, node):
    tag = node.tag
    if tag in short_mappings:
        key, handler = short_mappings[tag]
        value = loader.construct_scalar(node)
        if handler:
            value = handler(value)
        return {key: value}
    raise InvalidYamlTemplateTag(reason=f"Unknown tag: {tag}")


yaml.constructor.add_constructor(None, short_constructor)


class CloudFormationTemplate(Template):
    def __init__(self, source, rule_manager: RuleManager, *args, **kwargs):
        super().__init__(source, *args, **kwargs)
        self.rule_manager = rule_manager
        self.rules = {}

    @classmethod
    def initialize(cls, path: str, format: FileFormat):
        if format == FileFormat.Json:
            with open(path) as f:
                source = json.load(f)
        elif format == FileFormat.Yaml:
            with open(path) as f:
                source = yaml.load(f)
        else:
            raise TemplateFormatNotSupport(path=path, format=format)

        rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)

        return cls(source=source, rule_manager=rule_manager)

    def transform(self):
        typer.secho(f"Transforming CloudFormation template to ROS template...")

        if self.source.get("Transform"):
            raise CloudFormationTransformNotSupported()

        template = RosTemplate()

        template.description = self.source.get("Description")
        self._transform_parameters(template.parameters)
        self._transform_conditions(template.conditions)
        self._transform_mappings(template.mappings)
        self._transform_resources(template.resources)
        self._transform_outputs(template.outputs)
        self._transform_meta_data(template.metadata)

        typer.secho(
            f"Transform CloudFormation template to ROS template successful.",
            fg="green",
        )
        return template

    def _transform_parameters(self, out_parameters: Parameters):
        cf_params = self.source.get("Parameters")
        if not cf_params:
            return

        association_property_rule = (
            self.rule_manager.association_property_rule.association_property
        )
        cf_param_labels = (
            self.source.get("Metadata", {})
            .get("AWS::CloudFormation::Interface", {})
            .pop("ParameterLabels", {})
        )

        for name, value in cf_params.items():
            cf_param_type = value["Type"]
            typer.secho(f"Transforming parameter {name}<{cf_param_type}>")
            association_property = None
            param_type = "String"
            if cf_param_type in Parameter.TYPES:
                param_type = cf_param_type
            elif cf_param_type == "List<Number>":
                param_type = "CommaDelimitedList"
            elif cf_param_type in association_property_rule:
                rule = association_property_rule[cf_param_type]
                if rule.get("Ignore") or not rule.get("To"):
                    typer.secho(
                        f"  Parameter type {cf_param_type!r} of {name!r} is not supported and will be ignored.",
                        fg="yellow",
                    )
                else:
                    association_property = rule["To"]
                    param_type = rule.get("Type") or param_type
            else:
                typer.secho(
                    f"  Parameter type {cf_param_type!r} of {name!r} is not supported and will be ignored.",
                    fg="yellow",
                )

            parameter = Parameter(
                name=name,
                type=param_type,
                association_property=association_property,
                default=value.get("Default"),
                description=value.get("Description"),
                constraint_description=value.get("ConstraintDescription"),
                allowed_values=value.get("AllowedValues"),
                allowed_pattern=value.get("AllowedPattern"),
                min_length=value.get("MinLength"),
                max_length=value.get("MaxLength"),
                no_echo=value.get("NoEcho"),
                min_value=value.get("MinValue"),
                max_value=value.get("MaxValue"),
                label=cf_param_labels.get(name, {}).get("default"),
            )
            out_parameters.add(parameter)

    def _transform_conditions(self, out_conditions: Conditions):
        conditions = self.source.get("Conditions", {})
        for name, value in conditions.items():
            value, _ = self._transform_value(value)
            condition = Condition(name=name, value=value)
            out_conditions.add(condition)

    def _transform_mappings(self, out_mappings: Mappings):
        mappings = self.source.get("Mappings", {})
        for name, value in mappings.items():
            value, _ = self._transform_value(value)
            mapping = Mapping(name=name, value=value)
            out_mappings.add(mapping)

    def _transform_resources(self, out_resources: Resources):
        cf_resources = self.source.get("Resources", {})

        resources_to_handle = []
        for resource_id, cf_resource in cf_resources.items():
            cf_resource_type = cf_resource["Type"]
            cf_resource_props = cf_resource.get("Properties") or {}
            typer.secho(f"Transforming resource {resource_id}<{cf_resource_type}>")

            # Get rule by resource type
            resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
                cf_resource_type
            )
            if resource_rule is None:
                typer.secho(
                    f"  Resource type {cf_resource_type!r} is not supported and will be ignored.",
                    fg="yellow",
                )
                continue

            self.rules[resource_id] = resource_rule

            resource = Resource(
                resource_id=resource_id,
                resource_type=resource_rule.target_resource_type,
                depends_on=cf_resource.get("DependsOn"),
                condition=cf_resource.get("Condition"),
                deletion_policy=cf_resource.get("DeletionPolicy"),
            )
            if resource.type:
                props = self._transform_resource_props(
                    cf_resource_type,
                    cf_resource_props,
                    resource_rule.properties,
                    resource_rule.rule_id,
                )
                for k, v in props.items():
                    p = Property.initialize(k, v)
                    resource.properties.add(p)
                out_resources.add(resource)
            else:
                resource.type = cf_resource_type
                for k, v in cf_resource_props.items():
                    p = Property.initialize(k, v)
                    resource.properties.add(p)

            if resource_rule.handler:
                resources_to_handle.append((resource, resource_rule.handler))

        for resource, handler in resources_to_handle:
            handler(resource, out_resources)

    def _transform_resource_props(
        self, resource_type, resource_props, resource_rule_props, rule_id
    ):
        final_props = {}
        for name, value in resource_props.items():
            # Ignore not support prop
            prop_rule = resource_rule_props.get(name)
            if prop_rule is None or prop_rule.get("Ignore"):
                typer.secho(
                    f"  Resource property {name!r} of {resource_type!r} is not supported and will be ignored.",
                    fg="yellow",
                )
                continue

            # Warn if specify Warning
            warn_msg = prop_rule.get("Warning")
            if warn_msg:
                if not warn_msg.endswith("."):
                    warn_msg += "."
                typer.secho("  " + warn_msg, fg="yellow")

            transformed_value, resolved = self._transform_value(value)
            final_name = prop_rule.get("To")
            prop_type = prop_rule.get("Type")
            prop_schema = prop_rule.get("Schema")

            if final_name is None and prop_type != "Map":
                raise InvalidRuleSchema(
                    path=rule_id,
                    reason=f"{name} is invalid. The Type should be 'Map' when To is None",
                )
            if prop_type == "List" and prop_schema:
                final_value = []
                for each in transformed_value:
                    val = self._transform_resource_props(
                        resource_type,
                        each,
                        prop_schema,
                        rule_id,
                    )
                    final_value.append(val)
            elif prop_type == "Map" and prop_schema:
                if isinstance(transformed_value, list):
                    transformed_value = transformed_value[0]
                final_value = self._transform_resource_props(
                    resource_type, transformed_value, prop_schema, rule_id
                )
            else:
                final_value = transformed_value

            handler_name = prop_rule.get("Handler")
            if handler_name is not None:
                handler_func = getattr(basic_handler_module, handler_name)
                final_value = handler_func(final_value, resolved)

            if final_value is not None:
                if final_name is None:
                    assert isinstance(final_value, dict)
                    final_props.update(final_value)
                else:
                    # If To is duplicated, merge it
                    if final_name in final_props:
                        merged_value = final_props[final_name]
                        merge_handler_name = prop_rule.get("MergeHandler")
                        if merge_handler_name is not None:
                            merge_handler_func = getattr(
                                merge_handler_module, merge_handler_name
                            )
                            final_value = merge_handler_func(
                                final_value, merged_value, resolved
                            )

                    # If To is a multi-level attribute, it needs to be converted level by level.
                    # For example, if To is RuleList.0.Url, it should be converted to
                    # final_props["RuleList"][0]["Url"] = value.
                    self._handle_props_and_value(
                        final_props, final_name.split("."), final_value, rule_id
                    )

        return final_props

    def _handle_props_and_value(self, data, names: list, value, rule_id, _name_path=""):
        if not names:
            return

        name = names[0]
        if name.isdigit():
            name = int(name)

        _name_path = f"{_name_path}.{name}" if _name_path else f"{name}"
        if len(names) == 1:
            if name == "__single_to_multi_handler__":
                if value:
                    data.update(value)
            else:
                try:
                    data[name] = value
                except IndexError:
                    if name != len(data):
                        raise InvalidRuleSchema(
                            path=rule_id,
                            reason=f"{_name_path} is invalid. The index should be {len(data)}",
                        )
                    data.append(value)
        else:
            default_sub_data = [] if names[1].isdigit() else {}
            try:
                sub_data = data[name]
            except KeyError:
                sub_data = data[name] = default_sub_data
            except IndexError:
                if name != len(data):
                    raise InvalidRuleSchema(
                        path=rule_id,
                        reason=f"{_name_path} is invalid. The index should be {len(data)}",
                    )
                data.append(default_sub_data)
                sub_data = default_sub_data

            self._handle_props_and_value(sub_data, names[1:], value, _name_path)

    def _transform_outputs(self, out_outputs: Outputs):
        cf_outputs = self.source.get("Outputs", {})
        for name, value in cf_outputs.items():
            value, _ = self._transform_value(value)
            output = Output(
                name=name,
                value=value.get(Output.VALUE),
                description=value.get(Output.DESCRIPTION),
                condition=value.get(Output.CONDITION),
            )
            out_outputs.add(output)

    def _transform_meta_data(self, out_meta_data: MetaData):
        cf_meta_data = self.source.get("Metadata", {})
        meta_data_rule = self.rule_manager.meta_data_rule

        for name, value in cf_meta_data.items():
            typer.secho(f"Transforming metadata {name}")
            rule_props = meta_data_rule.meta_data.get(name)
            if not rule_props or rule_props.get("Ignore") or not rule_props.get("To"):
                typer.secho(
                    f"  Metadata {name!r} is not supported and will be ignored.",
                    fg="yellow",
                )
            else:
                name = rule_props["To"]

            meta_item = MetaItem(type=name, value=value)
            out_meta_data.add(meta_item)

    def _transform_value(self, value):
        resolved = True
        if isinstance(value, list):
            data = []
            for v in value:
                v, resolved_v = self._transform_value(v)
                if not resolved_v:
                    resolved = False
                data.append(v)
            return data, resolved
        elif isinstance(value, dict):
            data = {}
            is_func = False
            if len(value) == 1:
                key = list(value.keys())[0]
                function_rule: FunctionRule = self.rule_manager.function_rule
                # transform func
                if key in function_rule.function:
                    is_func = True
                    data.update(
                        self._transform_function(
                            key, value[key], function_rule.function[key]
                        )
                    )
                elif re.match(r"^Fn::[\s\S]+$", key):
                    is_func = True
                    typer.secho(
                        f"  Function {key!r} is not supported and will be ignored.",
                        fg="yellow",
                    )
                    data.update(value)
            if not is_func:
                for k, v in value.items():
                    val, resolved_val = self._transform_value(v)
                    data[k] = val
                    if not resolved_val:
                        resolved = False
            else:
                resolved = False
            return data, resolved
        elif isinstance(value, str):
            pseudo_parameters_rule: PseudoParametersRule = (
                self.rule_manager.pseudo_parameters_rule
            )
            if value in pseudo_parameters_rule.pseudo_parameters:
                return (
                    self._transform_pseudo_parameter(
                        value, pseudo_parameters_rule.pseudo_parameters[value]
                    ),
                    False,
                )
            elif re.match(r"^AWS::[\s\S]+$", value):
                typer.secho(
                    f"  Pseudo parameter {value!r} is not supported and will be ignored.",
                    fg="yellow",
                )
                resolved = False

        return value, resolved

    def _transform_pseudo_parameter(self, param, rule_props) -> str:
        if rule_props.get("Ignore") or not rule_props.get("To"):
            typer.secho(
                f"  Pseudo parameter {param!r} is not supported and will be ignored.",
                fg="yellow",
            )
            return param
        return rule_props["To"]

    def _transform_function(self, func_name, func_value, rule_props) -> dict:
        if rule_props.get("Ignore") or not rule_props.get("To"):
            typer.secho(
                f"  Function {func_name!r} is not supported and will be ignored.",
                fg="yellow",
            )
            return {func_name: func_value}

        final_func_name = rule_props["To"]
        final_func_value, _ = self._transform_value(func_value)
        if final_func_name == "Fn::Sub":
            if isinstance(final_func_value, str):
                final_func_value = self._transform_sub_pseudo(final_func_value)
            elif (
                isinstance(final_func_value, list)
                and len(final_func_value) >= 1
                and isinstance(final_func_value[0], str)
            ):
                final_func_value[0] = self._transform_sub_pseudo(final_func_value[0])

        handler_name = rule_props.get("Handler")
        if handler_name is not None:
            handler_func = getattr(basic_handler_module, handler_name)
            final_func_value = handler_func(final_func_value, False)

        return {final_func_name: final_func_value}

    def _transform_sub_pseudo(self, value):
        for (
            param,
            rule_props,
        ) in self.rule_manager.pseudo_parameters_rule.pseudo_parameters.items():
            param_ref = f"${{{param}}}"
            if param_ref not in value:
                continue
            if rule_props.get("Ignore") or not rule_props.get("To"):
                typer.secho(
                    f"  Function Fn::Sub pseudo parameter {param!r} is not supported and will be ignored.",
                    fg="yellow",
                )
                continue
            value = value.replace(param_ref, f'${{{rule_props["To"]}}}')
        return value
