import json
import logging
import os
import shutil
from subprocess import CalledProcessError
from uuid import uuid4
import importlib
from typing import Any

import parsetf
from python_terraform import Terraform, TerraformCommandError

from rostran.core.exceptions import (
    RosTranWarning,
    TemplateFormatNotSupport,
    CommandNotFound,
    RunCommandFailed,
    TerraformPlanFormatVersionNotSupported,
    TerraformMultiProvidersNotSupported,
    TerraformProviderNotFound,
)
from rostran.core.format import FileFormat
from rostran.core.rules import RuleManager, RuleClassifier, ResourceRule
from rostran.core.template import RosTemplate
from rostran.core.template import Template
from rostran.core.properties import Property
from rostran.core.resources import Resources, Resource
from rostran.core.outputs import Outputs, Output

logger = logging.getLogger(__name__)


class TerraformTemplate(Template):
    PLAN_PROPERTIES = (
        FORMAT_VERSION,
        CONFIGURATION,
        PLANNED_VALUES,
        RESOURCES,
        PROVIDER_CONFIG,
        ROOT_MODULE,
        MODE,
        ADDRESS,
        VALUES,
        VALUE,
        OUTPUTS,
        TYPE,
    ) = (
        "format_version",
        "configuration",
        "planned_values",
        "resources",
        "provider_config",
        "root_module",
        "mode",
        "address",
        "values",
        "value",
        "outputs",
        "type",
    )

    SOURCE_PROPERTIES = (
        SOURCE_RESOURCES,
        SOURCE_OUTPUTS,
        SOURCE_MODE,
        SOURCE_TYPE,
        SOURCE_NAME,
        SOURCE_RAW_CONFIG,
        SOURCE_BODY,
        SOURCE_ATTRIBUTES,
        SOURCE_BLOCKS,
        SOURCE_EXPR,
        DEPENDS_ON,
        SOURCE_ARGS,
        SOURCE_TRAVERSAL,
        SOURCE_EACH,
        PROPERTIES,
    ) = (
        "Resources",
        "Outputs",
        "Mode",
        "Type",
        "Name",
        "RawConfig",
        "Body",
        "Attributes",
        "Blocks",
        "Expr",
        "DependsOn",
        "Args",
        "Traversal",
        "Each",
        "Properties",
    )

    RESOURCE_PROP_PROPERTIES = (PROP_TYPE, PROP_VALUE, PROP_ARGS,) = (
        ".Type",
        ".Value",
        ".Args",
    )

    RESOURCE_PROP_TYPES = (PROP_TYPE_VALUE, PROP_TYPE_FUNC,) = ("Value", "Func")

    RESOURCE_PROP_FUNCS = (FUNC_GET_ATT,) = ("GetAtt",)

    SUPPORTED_PLAN_FORMAT_VERSIONS = ("0.1",)

    PROVIDERS = (ALICLOUD, AWS,) = (
        "alicloud",
        "aws",
    )

    MODES = (MANAGED, DATA, SOURCE_MANAGED, SOURCE_DATA) = ("managed", "data", 0, 1)

    def __init__(self, source, plan, provider, rule_manager: RuleManager):
        super().__init__(source)
        self.plan = plan
        self.provider = provider
        self.rule_manager = rule_manager

    @classmethod
    def initialize(
        cls,
        path: str,
        format: FileFormat = FileFormat.Terraform,
        tf_plan_path: str = None,
    ):
        if format != FileFormat.Terraform:
            raise TemplateFormatNotSupport(path=path, format=format)

        tf_dir = path if os.path.isdir(path) else os.path.dirname(path)
        tf_plan, tf_data = cls._get_plan_data(tf_dir, tf_plan_path)

        providers = tf_plan[cls.CONFIGURATION][cls.PROVIDER_CONFIG]
        if len(providers) > 1:
            raise TerraformMultiProvidersNotSupported()
        elif len(providers) < 1:
            raise TerraformProviderNotFound()

        provider = list(providers.keys())[0]
        if cls.ALICLOUD == provider:
            rule_manager = RuleManager.initialize(RuleClassifier.TerraformAliCloud)
        else:
            message = (
                f"Terraform transformation for provider {provider} is not supported"
            )
            raise RosTranWarning(message=message)

        return cls(
            source=tf_data, plan=tf_plan, provider=provider, rule_manager=rule_manager
        )

    @classmethod
    def _get_plan_data(cls, tf_dir, tf_plan_path=None) -> (dict, dict):

        # Check "terraform" command
        tf_cmd_path = shutil.which("terraform")
        if tf_cmd_path is None:
            raise CommandNotFound(cmd="terraform")

        # Using "terraform plan/show" to parse configuration
        logger.info("Parsing terraform files...")
        tf = Terraform()
        if tf_plan_path is None:
            tf_plan_path = os.path.join(os.getcwd(), str(uuid4()))
            try:
                cmd_args = ["plan", "-input=false", "-out", tf_plan_path, tf_dir]
                tf.cmd(*cmd_args, raise_on_error=True)
                cmd_args = ["show", "-json", tf_plan_path]
                _, output, _ = tf.cmd(*cmd_args, raise_on_error=True)
            except TerraformCommandError as e:
                raise RunCommandFailed(cmd=e.cmd, reason=e.err or e.out)
            finally:
                if os.path.exists(tf_plan_path):
                    os.remove(tf_plan_path)
        else:
            try:
                cmd_args = ["show", "-json", tf_plan_path]
                _, output, _ = tf.cmd(*cmd_args, raise_on_error=True)
            except TerraformCommandError as e:
                raise RunCommandFailed(cmd=e.cmd, reason=e.err or e.out)

        tf_plan = json.loads(output)
        version = tf_plan[cls.FORMAT_VERSION]
        if version not in cls.SUPPORTED_PLAN_FORMAT_VERSIONS:
            raise TerraformPlanFormatVersionNotSupported(version=version)

        # Using "parsetf" to parse configuration
        try:
            output = parsetf.parse(tf_dir)

        except CalledProcessError as e:
            raise RunCommandFailed(cmd=e.cmd, reason=e.output)

        logger.info("Parse terraform files done")

        tf_data = json.loads(output)
        return tf_plan, tf_data

    def transform(self) -> RosTemplate:
        logger.info(f"Transform terraform {self.provider} template to ROS template")

        template = RosTemplate()
        tf_resources = self._parse_resources()
        self._transform_resources(tf_resources, template.resources)

        tf_outputs = self._parse_outputs()
        self._transform_outputs(tf_outputs, template.outputs)

        return template

    def _parse_resources(self):
        planned_resources = {}
        planned_resource_list: list = self.plan[self.PLANNED_VALUES][
            self.ROOT_MODULE
        ].get(self.RESOURCES, [])
        for planned_resource in planned_resource_list:
            if planned_resource[self.MODE] != self.MANAGED:
                continue
            address = planned_resource[self.ADDRESS]
            planned_resources[address] = planned_resource[self.VALUES]

        resources = {}
        source_resource_list: list = self.source[self.SOURCE_RESOURCES]
        for source_resource in source_resource_list:
            if source_resource[self.SOURCE_MODE] != self.SOURCE_MANAGED:
                continue

            name = source_resource[self.SOURCE_NAME]
            type_ = source_resource[self.SOURCE_TYPE]
            address = f"{type_}.{name}"
            planned_resource = planned_resources[address]
            resource = self._parse_resource(source_resource, planned_resource)
            resources[address] = resource

        return resources

    def _parse_resource(self, source_resource: dict, planned_resource: dict):
        resource = {
            self.DEPENDS_ON: source_resource.get(self.DEPENDS_ON),
            self.SOURCE_TYPE: source_resource[self.SOURCE_TYPE],
        }

        body = source_resource[self.SOURCE_RAW_CONFIG][self.SOURCE_BODY]
        properties = self._parse_source_body(body, planned_resource)
        resource[self.PROPERTIES] = properties

        return resource

    def _parse_source_body(self, body: dict, planned_resource: dict = None):
        props = {}
        attributes = body.get(self.SOURCE_ATTRIBUTES, {})
        for propname, prop in attributes.items():
            if propname == "depends_on":
                continue

            if planned_resource is None:
                planned_value = None
            else:
                planned_value = planned_resource.get(propname)

            # If cannot get value from planned resource,
            # it means value cannot resolved statically
            if planned_value is None:
                expr = prop[self.SOURCE_EXPR]
                props[propname] = self._parse_source_expr(expr)
            else:
                props[propname] = planned_value

        blocks = body.get(self.SOURCE_BLOCKS, [])
        for block in blocks:
            propname = block[self.SOURCE_TYPE]
            if propname not in props:
                props[propname] = []
                index = 0
            else:
                index = len(props[propname])

            if planned_resource is None or not isinstance(
                planned_resource[propname], list
            ):
                new_planned_resource = None
            else:
                new_planned_resource = planned_resource[propname][index]

            res = self._parse_source_body(block[self.SOURCE_BODY], new_planned_resource)
            props[propname].append(res)

        if self.SOURCE_EXPR in body:
            return self._parse_source_expr(body[self.SOURCE_EXPR])

        return props

    def _parse_source_expr(self, expr: dict):
        data = None
        # func
        if self.SOURCE_ARGS in expr:
            func_name = expr[self.SOURCE_NAME]
            func_args = []
            for arg in expr[self.SOURCE_ARGS]:
                func_args.append(self._parse_source_expr(arg))
            data = {
                self.PROP_TYPE: self.PROP_TYPE_FUNC,
                self.PROP_VALUE: func_name,
                self.PROP_ARGS: func_args,
            }
        # dot attr
        elif self.SOURCE_TRAVERSAL in expr:
            traversal = expr[self.SOURCE_TRAVERSAL]
            first = traversal[0][self.SOURCE_NAME]
            # ROS not supports, so return None
            if first in ("var", "data"):
                return None
            if len(traversal) != 3:
                return None
            data = {
                self.PROP_TYPE: self.PROP_TYPE_FUNC,
                self.PROP_VALUE: self.FUNC_GET_ATT,
                self.PROP_ARGS: [
                    f"{first}.{traversal[1][self.SOURCE_NAME]}",
                    traversal[2][self.SOURCE_NAME],
                ],
            }
        # list literal (*)
        # ROS not supports, so return NOne
        elif self.SOURCE_EACH in expr:
            return None

        return data

    def _transform_resources(self, tf_resources: dict, out_resources: Resources):
        for resource_id, tf_resource in tf_resources.items():
            tf_resource_type = tf_resource[self.SOURCE_TYPE]
            tf_resource_props = tf_resource[self.PROPERTIES]

            # Get rule by resource type
            resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
                tf_resource_type
            )
            if resource_rule is None:
                logger.warning(
                    f"Resource type {tf_resource_type} is not supported and will be ignored."
                )
                continue

            props = self._transform_resource_props(
                tf_resource_type, tf_resource_props, resource_rule.properties
            )
            if props is None:
                continue

            depends_on = tf_resource[self.DEPENDS_ON]
            resource_type = resource_rule.target_resource_type
            resource = Resource(
                resource_id=resource_id,
                resource_type=resource_type,
                depends_on=depends_on,
            )
            for k, v in props.items():
                p = Property(k, v)
                resource.properties.add(p)

            out_resources.add(resource)

    def _transform_resource_props(
        self, resource_type, resource_props, resource_rule_props
    ):
        final_props = {}
        for name, value in resource_props.items():
            # Ignore not support prop
            prop_rule = resource_rule_props.get(name)
            if prop_rule is None or prop_rule.get("Ignore"):
                logger.warning(
                    f'Resource property "{name}" of {resource_type} is not supported and will be ignored.'
                )
                continue

            # Warn if specify Warning
            warn_msg = prop_rule.get("Warning")
            if warn_msg:
                logger.warning(warn_msg)

            transformed_value, resolved = self._transform_prop_or_attr(value)
            final_name = prop_rule["To"]
            prop_type = prop_rule.get("Type")
            prop_schema = prop_rule.get("Schema")
            if prop_type == "List" and prop_schema:
                final_value = []
                for each in transformed_value:
                    val = self._transform_resource_props(
                        resource_type, each, prop_schema
                    )
                    final_value.append(val)
            else:
                final_value = transformed_value

            handler_name = prop_rule.get("Handler")
            if handler_name is not None:
                handler_module = importlib.import_module("rostran.handler")
                handler_func = getattr(handler_module, handler_name)
                final_value = handler_func(final_value, resolved)

            final_props[final_name] = final_value

        return final_props

    def _transform_prop_or_attr(self, value) -> (Any, bool):
        if not isinstance(value, dict):
            return value, True

        if self.PROP_TYPE not in value:
            data = {}
            resolved = True
            for k, v in value.items():
                val, resolved_ = self._transform_prop_or_attr(v)
                if resolved_ is False:
                    resolved = False
                data[k] = val
            return data, resolved

        prop_type = value.get(self.PROP_TYPE)
        if prop_type == self.PROP_TYPE_FUNC:
            prop_args = value.get(self.PROP_ARGS)
            prop_value = value.get(self.PROP_VALUE)
            if prop_value == self.FUNC_GET_ATT:
                return self._transform_func_get_att(prop_args[0], prop_args[1]), False

        return None, True

    def _transform_func_get_att(self, resource_id, attrname):
        tf_resource_type = None
        for resource in self.plan[self.PLANNED_VALUES][self.ROOT_MODULE].get(
            self.RESOURCES, []
        ):
            if resource_id == resource[self.ADDRESS]:
                tf_resource_type = resource[self.TYPE]

        resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
            tf_resource_type
        )
        if tf_resource_type is None or resource_rule is None:
            logger.warning(
                f"Resource type {tf_resource_type} is not supported and will be ignored."
            )
            return None

        if attrname not in resource_rule.attributes:
            logger.warning(
                f'Resource attribute "{attrname}" of {tf_resource_type} is not supported and will be ignored.'
            )

        final_attrname = resource_rule.attributes[attrname]["To"]
        return {"Fn::GetAtt": [resource_id, final_attrname]}

    def _parse_outputs(self):
        planned_outputs = {}
        raw_planned_outputs: dict = self.plan[self.PLANNED_VALUES].get(self.OUTPUTS, {})
        for name, info in raw_planned_outputs.items():
            value = info.get(self.VALUE)
            planned_outputs[name] = value

        outputs = {}
        source_output_list: list = self.source[self.SOURCE_OUTPUTS]
        for source_output in source_output_list:
            name = source_output[self.SOURCE_NAME]
            planned_output = planned_outputs[name]
            output = self._parse_output(source_output, planned_output)
            outputs[name] = output

        return outputs

    def _parse_output(self, source_output: dict, planned_output: dict = None):
        if planned_output is not None:
            return planned_output

        body = source_output[self.SOURCE_RAW_CONFIG][self.SOURCE_BODY]
        output = self._parse_source_body(body, planned_output)

        return output

    def _transform_outputs(self, tf_outputs: dict, out_outputs: Outputs):
        for name, value in tf_outputs.items():
            value, _ = self._transform_prop_or_attr(value)
            if not _:
                resource_name = value['Fn::GetAtt'][0]
                ros_attrs = value['Fn::GetAtt'][1]
                if isinstance(ros_attrs, list):
                    attr_list = [
                        {'Fn::GetAtt': [resource_name, ros_attr]}
                        for ros_attr in ros_attrs
                    ]
                    value = {'Fn::Join': [':', attr_list]}
            output = Output(name=name, value=value,)

            out_outputs.add(output)
