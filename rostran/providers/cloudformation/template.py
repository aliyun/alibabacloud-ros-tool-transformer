import re
import os
import json
import logging
import importlib

import yaml

from rostran.core.exceptions import RosTranWarning, TemplateFormatNotSupport
from rostran.core.format import FileFormat
from rostran.core.template import Template, RosTemplate
from rostran.core.settings import RULES_DIR
from rostran.core.rules import (
    RuleClassifier,
    RuleManager,
    ResourceRule,
    PseudoParametersRule,
    MetaDataRule,
    AssociationPropertyRule,
    FunctionRule,
)
from rostran.core.outputs import Output, Outputs
from rostran.core.resources import Resource, Resources
from rostran.core.properties import Property
from rostran.core.parameters import Parameter, Parameters
from rostran.core.metadata import MetaItem, MetaData
from rostran.core.conditions import Condition, Conditions
from rostran.core.mappings import Mapping, Mappings

logger = logging.getLogger(__name__)
RULES_DIR = os.path.join(RULES_DIR, "cloudformation")
BUILTIN_RULES = os.path.join(RULES_DIR, "builtin")
RESOURCE_RULES = os.path.join(RULES_DIR, "resource")


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
                source = yaml.safe_load(f)
        else:
            raise TemplateFormatNotSupport(path=path, format=format)

        rule_manager = RuleManager.initialize(RuleClassifier.CloudFormation)

        return cls(source=source, rule_manager=rule_manager)

    def transform_meta_data(self, out_meta_data: MetaData):
        meta_data = self.source.get("Metadata", {})

        meta_data_rule: MetaDataRule = self.rule_manager.meta_data_rule
        for aws, ros in meta_data_rule.meta_data.items():
            if ros.get("Ignore"):
                logger.warning(f"Ignore MetaData: {aws}.")
            elif ros.get("To") and meta_data.get(aws):
                meta_item = MetaItem(type=ros["To"], value=meta_data[aws])
                out_meta_data.add(meta_item)

    def transform_parameters(self, out_parameters: Parameters):
        association_properties_rule: AssociationPropertyRule = (
            self.rule_manager.association_property_rule
        )
        association_properties = association_properties_rule.association_property
        parameters = self.source.get("Parameters", {})
        labels = (
            self.source.get("Metadata", {})
            .get("AWS::CloudFormation::Interface", {})
            .get("ParameterLabels", {})
        )

        for name, value in parameters.items():
            aws_parameter_type = value["Type"]
            association_property = None
            if aws_parameter_type in Parameter.TYPES:
                ros_parameter_type = aws_parameter_type
            elif association_properties.get(aws_parameter_type) is None:
                logger.warning(
                    f"Missing {aws_parameter_type} in association type rules, please fill in."
                )
                continue
            elif association_properties[aws_parameter_type].get("Ignore"):
                ros_parameter_type = "String"
                logger.warning(
                    f"Ignore {aws_parameter_type}.\nType of parameter <{name}> will be converted to String."
                )
            else:
                ros_parameter_type = "String"
                association_property = association_properties[aws_parameter_type]["To"]
            parameter = Parameter(
                name=name,
                type=ros_parameter_type,
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
                label=labels.get(name, {}).get("default"),
            )
            parameter.validate()
            out_parameters.add(parameter)

    def transform_resource(self, out_resources: Resources):
        resources = self.source.get("Resources", {})

        for logical_id, aws_resource in resources.items():
            resource_type = aws_resource["Type"]

            resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
                resource_type
            )
            self.rules[logical_id] = resource_rule

            ros_resource = Resource(
                resource_id=logical_id, resource_type=resource_rule.target_resource_type
            )

            aws_properties = aws_resource.get("Properties", {})
            ros_properties = self.convert_property(
                aws_properties, resource_rule.properties, {}
            )
            for k, v in ros_properties.items():
                p = Property(k, v)
                ros_resource.properties.add(p)

            ros_resource.condition = aws_resource.get("Condition")
            ros_resource.depends_on = aws_resource.get("DependsOn")
            ros_resource.deletion_policy = aws_resource.get("DeletionPolicy")
            out_resources.add(ros_resource)

    def convert_property(
        self, aws_properties: dict, rule_properties: dict, ros_properties: dict
    ):

        for property_key, property_value in aws_properties.items():

            if rule_properties.get(property_key) is None:
                logger.warning(f"Missing {property_key} in rule file.")
            elif rule_properties[property_key].get("Ignore"):
                logger.warning(
                    f"Property <{property_key}> can not be transformed to ROS, will be ignored."
                )
            elif rule_properties[property_key].get("To"):
                ros_property = rule_properties[property_key]["To"]
                if rule_properties[property_key].get("Handler"):
                    handler_module = importlib.import_module("rostran.handler")
                    handler_func = getattr(
                        handler_module, rule_properties[property_key]["Handler"]
                    )
                    property_value = handler_func(property_value)
                    logger.warning(rule_properties[property_key].get("Warning"))

                if rule_properties[property_key].get("Schema") is None:
                    property_value = self.check_nonsupport_pseudo_parameters(
                        property_value
                    )
                    property_value = self.transform_function_pseudo_parameters(
                        property_value, json.dumps(property_value)
                    )

                    ros_properties[ros_property] = property_value
                elif rule_properties[property_key].get("Type") == "Map":
                    sep_ros_properties = self.convert_property(
                        property_value, rule_properties[property_key]["Schema"], {}
                    )
                    ros_properties[ros_property] = sep_ros_properties
                elif rule_properties[property_key].get("Type") == "List":
                    ros_properties[ros_property] = []
                    for i in property_value:
                        sep_ros_properties = self.convert_property(
                            i, rule_properties[property_key]["Schema"], {}
                        )
                        ros_properties[ros_property].append(sep_ros_properties)

        return ros_properties

    def transform_function_pseudo_parameters(
        self, aws_property_value: dict, ros_property_value: str
    ):
        if not aws_property_value:
            return aws_property_value
        if isinstance(aws_property_value, (str, int, float)):
            return aws_property_value
        elif isinstance(aws_property_value, dict):
            if len(aws_property_value) > 1:
                return aws_property_value
            else:
                aws_fn_name, fn_value = list(aws_property_value.items())[0]
                function_rule: FunctionRule = self.rule_manager.function_rule
                to_function = function_rule.function.get(aws_fn_name, {})
                if not to_function:
                    logger.warning(
                        f"Missing function <{aws_fn_name}>, please fill in the function rule file."
                    )

                elif to_function.get("Ignore"):
                    logger.warning(
                        f"Ignore function <{aws_fn_name}>, please enter value in template."
                    )
                    return ""
                elif to_function.get("Handler"):
                    handler_module = importlib.import_module("rostran.handler")
                    handler_func = getattr(handler_module, to_function["Handler"])
                    fn_value = handler_func(fn_value)
                    ros_fn_name = to_function["To"]
                    ros_property_value.replace(aws_fn_name, ros_fn_name, 1)
                    self.transform_function_pseudo_parameters(
                        fn_value, ros_property_value
                    )
                else:
                    ros_fn_name = to_function["To"]
                    ros_property_value.replace(aws_fn_name, ros_fn_name, 1)
                    self.transform_function_pseudo_parameters(
                        fn_value, ros_property_value
                    )
        else:
            for i in aws_property_value:
                self.transform_function_pseudo_parameters(i, ros_property_value)

        return json.loads(ros_property_value)

    def transform_outputs(self, out_outputs: Outputs):
        aws_outputs = self.source.get("Outputs", {})
        for output_key, output in aws_outputs.items():
            value: dict = output["Value"]

            value: str = json.dumps(value)
            attrs_list = re.findall(r"\"Fn::GetAtt\": \[\"(\w+)\", \"(\w+)\"\]", value)
            for logical_id, aws_attribute in attrs_list:
                attr_rule = self.rules[logical_id].attributes
                if attr_rule.get(aws_attribute) is None:
                    logger.warning(f"Missing {aws_attribute} in rules.")
                    value: str = ""
                    break
                if attr_rule[aws_attribute].get("Ignore"):
                    value: str = ""
                    logger.warning(f"Ignore outputs {output_key}.")
                else:
                    ros_attribute = attr_rule[aws_attribute]["To"]
                    value: str = value.replace(
                        f'"Fn::GetAtt": ["{logical_id}", "{aws_attribute}"]',
                        f'"Fn::GetAtt": ["{logical_id}", "{ros_attribute}"]',
                    )
            if value:
                value: dict = json.loads(value)
                value = self.check_nonsupport_pseudo_parameters(value)
                value = self.transform_function_pseudo_parameters(
                    value, json.dumps(value)
                )
                output = Output(name=output_key, value=value)
                out_outputs.add(output)

    def transform_pseudo_parameters(self):

        template = json.dumps(self.source)
        pseudo_parameters_rule: PseudoParametersRule = (
            self.rule_manager.pseudo_parameters_rule
        )
        trans = {
            aws_pseudo: ros_pseudo["To"]
            for aws_pseudo, ros_pseudo in pseudo_parameters_rule.pseudo_parameters.items()
            if ros_pseudo.get("To")
        }

        for aws_builtin, ros_builtin in trans.items():
            template = template.replace(aws_builtin, ros_builtin)

        self.source = json.loads(template)

    def check_nonsupport_pseudo_parameters(self, value):
        pseudo_parameters_rule: PseudoParametersRule = (
            self.rule_manager.pseudo_parameters_rule
        )

        ignored = [
            aws
            for aws, ros in pseudo_parameters_rule.pseudo_parameters.items()
            if ros.get("Ignore")
        ]

        str_value = json.dumps(value)
        for pseudo_parameter in ignored:
            if pseudo_parameter in str_value:
                return ""
        return value

    def transform_description(self, template: RosTemplate):
        template.description = self.source.get("Description")

    def transform_conditions(self, out_conditions: Conditions):
        conditions = self.source.get("Conditions", {})
        for name, value in conditions.items():
            condition = Condition(name=name, value=value)
            out_conditions.add(condition)

    def transform_mappings(self, out_mappings: Mappings):
        mappings = self.source.get("Mappings", {})
        for name, value in mappings.items():
            mapping = Mapping(name=name, value=value)
            out_mappings.add(mapping)

    def transform(self):
        logger.info(f"Transform AWS CloudFormation template to ROS template.")

        if self.source.get("Transform"):
            raise RosTranWarning(message="Can not convert Transform template.")

        template = RosTemplate()

        self.transform_pseudo_parameters()
        self.transform_description(template)
        self.transform_parameters(template.parameters)
        self.transform_resource(template.resources)
        self.transform_outputs(template.outputs)

        self.transform_meta_data(template.metadata)
        self.transform_conditions(template.conditions)
        self.transform_mappings(template.mappings)

        return template
