import json
import os
import shutil
from uuid import uuid4
import importlib
from typing import Any
import typer
from libterraform import TerraformCommand, TerraformConfig
from libterraform.exceptions import TerraformCommandError

from rostran.core.exceptions import (
    RosTranWarning,
    TemplateFormatNotSupport,
    CommandNotFound,
    RunCommandFailed,
    TerraformPlanFormatVersionNotSupported,
    TerraformMultiProvidersNotSupported,
    TerraformProviderNotFound,
    RosTranException,
)
from rostran.core.format import FileFormat
from rostran.core.rules import RuleManager, RuleClassifier, ResourceRule
from rostran.core.template import RosTemplate
from rostran.core.template import Template
from rostran.core.properties import Property
from rostran.core.resources import Resources, Resource
from rostran.core.outputs import Outputs, Output


class TerraformTemplate(Template):
    PROVIDERS = (ALICLOUD, AWS,) = (
        "alicloud",
        "aws",
    )

    SUPPORTED_PLAN_FORMAT_VERSIONS = ("1.0",)

    PLAN_PROPERTIES = (
        P_FORMAT_VERSION,
        P_CONFIGURATION,
        P_PLANNED_VALUES,
        P_RESOURCES,
        P_PROVIDER_CONFIG,
        P_ROOT_MODULE,
        P_MODE,
        P_ADDRESS,
        P_VALUES,
        P_VALUE,
        P_OUTPUTS,
        P_TYPE,
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

    PLAN_MODES = (P_MANAGED,) = ("managed",)

    SOURCE_PROPERTIES = (
        MANAGED_RESOURCES,
        DATA_RESOURCES,
        OUTPUTS,
        PROPERTIES,
        NAME,
        MODE,
        TYPE,
        CONFIG,
        BODY,
        ATTRIBUTES,
        BLOCKS,
        SRC_RANGE,
        END_RANGE,
        COUNT,
        EXPR,
        TRAVERSAL,
        ARGS,
        PARTS,
        FOR_EACH,
        PROVIDER_CONFIG_REF,
        PROVIDER,
        NAMESPACE,
        HOSTNAME,
        DEPENDS_ON,
        MANAGED,
        CONNECTION,
        PROVISIONERS,
        CREATE_BEFORE_DESTROY,
        PREVENT_DESTROY,
        CREATE_BEFORE_DESTROY_SET,
        PREVENT_DESTROY_SET,
        IGNORE_CHANGED,
        IGNORE_ALL_CHANGED,
        DECL_RANGE,
        TYPE_RANGE,
        FILENAME,
        START,
        END,
    ) = (
        "ManagedResources",
        "DataResources",
        "Outputs",
        "Properties",
        "Name",
        "Mode",
        "Type",
        "Config",
        "Body",
        "Attributes",
        "Blocks",
        "SrcRange",
        "EndRange",
        "Count",
        "Expr",
        "Traversal",
        "Args",
        "Parts",
        "ForEach",
        "ProviderConfigRef",
        "Provider",
        "Namespace",
        "Hostname",
        "DependsOn",
        "Managed",
        "Connection",
        "Provisioners",
        "CreateBeforeDestroy",
        "PreventDestroy",
        "CreateBeforeDestroySet",
        "PreventDestroySet",
        "IgnoreChanged",
        "IgnoreAllChanged",
        "DeclRanage",
        "TypeRanage",
        "FileName",
        "Start",
        "End",
    )

    RESOURCE_PROP_PROPERTIES = (PROP_TYPE, PROP_VALUE, PROP_ARGS,) = (
        ".Type",
        ".Value",
        ".Args",
    )

    RESOURCE_PROP_TYPES = (
        PROP_TYPE_VALUE,
        PROP_TYPE_FUNC,
    ) = ("Value", "Func")

    RESOURCE_PROP_FUNCS = (FUNC_GET_ATT,) = ("GetAtt",)

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

        providers = tf_plan[cls.P_CONFIGURATION][cls.P_PROVIDER_CONFIG]
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
        typer.secho("Parsing terraform config...")
        tf_plan = None
        cwd = os.getcwd()
        if not os.path.isabs(tf_dir):
            tf_dir = os.path.join(cwd, tf_dir)
        tf = TerraformCommand(tf_dir)
        if tf_plan_path is None:
            plan_filename = f"{str(uuid4())[:8]}.tfplan"
            tf_plan_path = os.path.join(cwd, plan_filename)
            try:
                tf.init(check=True)
                tf.plan(out=tf_plan_path, check=True)
                r = tf.show(tf_plan_path, check=True)
                tf_plan = r.value
            except TerraformCommandError as e:
                raise RunCommandFailed(cmd=e.cmd, reason=e.stderr or e.stdout)
            finally:
                if os.path.exists(tf_plan_path):
                    os.remove(tf_plan_path)
        else:
            try:
                r = tf.show(tf_plan_path, check=True)
                tf_plan = r.value
            except TerraformCommandError as e:
                raise RunCommandFailed(cmd=e.cmd, reason=e.stderr or e.stdout)

        if tf_plan is None:
            raise RosTranException()

        version = tf_plan[cls.P_FORMAT_VERSION]
        if version not in cls.SUPPORTED_PLAN_FORMAT_VERSIONS:
            raise TerraformPlanFormatVersionNotSupported(version=version)

        tf_data, _ = TerraformConfig.load_config_dir(tf_dir)
        typer.secho("Parse terraform config done.")
        return tf_plan, tf_data

    def transform(self) -> RosTemplate:
        typer.secho(
            f"Transforming terraform (provider: {self.provider}) template to ROS template..."
        )

        template = RosTemplate()
        tf_resources = self._parse_resources()
        self._transform_resources(tf_resources, template.resources)

        tf_outputs = self._parse_outputs()
        self._transform_outputs(tf_outputs, template.outputs)

        typer.secho(
            f"Transform terraform (provider: {self.provider}) template to ROS template successful.",
            fg="green",
        )
        return template

    def _parse_resources(self):
        planned_resources = {}
        planned_resource_list: list = self.plan[self.P_PLANNED_VALUES][
            self.P_ROOT_MODULE
        ].get(self.P_RESOURCES, [])
        for planned_resource in planned_resource_list:
            if planned_resource[self.P_MODE] != self.P_MANAGED:
                continue
            address = planned_resource[self.P_ADDRESS]
            planned_resources[address] = planned_resource[self.P_VALUES]

        resources = {}
        managed_resources: dict = self.source[self.MANAGED_RESOURCES]
        for address, resource in managed_resources.items():
            planned_resource = planned_resources[address]
            resource = self._parse_resource(resource, planned_resource)
            resources[address] = resource

        return resources

    def _parse_resource(self, managed_resource: dict, planned_resource: dict):
        depends_on = []
        resource = {
            self.DEPENDS_ON: depends_on,
            self.TYPE: managed_resource[self.TYPE],
            self.NAME: managed_resource[self.NAME],
        }

        m_depends_on = managed_resource.get(self.DEPENDS_ON)
        if m_depends_on:
            for items in m_depends_on:
                depends_on.append(".".join(item[self.NAME] for item in items))
        config = managed_resource[self.CONFIG]
        properties = self._parse_source_config(config, planned_resource)
        resource[self.PROPERTIES] = properties

        return resource

    def _parse_source_config(self, config: dict, planned_resource: dict = None):
        props = {}
        attributes = config.get(self.ATTRIBUTES, {})
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
                expr = prop[self.EXPR]
                value = self._parse_source_expr(expr)
                if value is not None:
                    props[propname] = value
            else:
                props[propname] = planned_value

        blocks = config.get(self.BLOCKS, [])
        for block in blocks:
            propname = block[self.TYPE]
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

            res = self._parse_source_config(block[self.BODY], new_planned_resource)
            props[propname].append(res)

        if self.EXPR in config:
            return self._parse_source_expr(config[self.EXPR])

        return props

    def _parse_source_expr(self, expr: dict):
        data = None
        # func
        if self.ARGS in expr:
            func_name = expr[self.NAME]
            func_args = []
            for arg in expr[self.ARGS]:
                func_args.append(self._parse_source_expr(arg))
            data = {
                self.PROP_TYPE: self.PROP_TYPE_FUNC,
                self.PROP_VALUE: func_name,
                self.PROP_ARGS: func_args,
            }
        # dot attr
        elif self.TRAVERSAL in expr:
            traversal = expr[self.TRAVERSAL]
            first = traversal[0][self.NAME]
            # ROS not supports, so return None
            if first in ("var", "data"):
                return None
            if len(traversal) != 3:
                return None
            data = {
                self.PROP_TYPE: self.PROP_TYPE_FUNC,
                self.PROP_VALUE: self.FUNC_GET_ATT,
                self.PROP_ARGS: [
                    f"{first}.{traversal[1][self.NAME]}",
                    traversal[2][self.NAME],
                ],
            }
        # list literal (*)
        # ROS not supports, so return None
        elif self.FOR_EACH in expr:
            return None

        return data

    def _transform_resources(self, tf_resources: dict, out_resources: Resources):
        for resource_id, tf_resource in tf_resources.items():
            tf_resource_type = tf_resource[self.TYPE]
            tf_resource_props = tf_resource[self.PROPERTIES]

            # Get rule by resource type
            resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
                tf_resource_type
            )
            if resource_rule is None:
                typer.secho(
                    f"Resource type {tf_resource_type!r} is not supported and will be ignored.",
                    fg="yellow",
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
                typer.secho(
                    f"Resource property {name!r} of {resource_type!r} is not supported and will be ignored.",
                    fg="yellow",
                )
                continue

            # Warn if specify Warning
            warn_msg = prop_rule.get("Warning")
            if warn_msg:
                if not warn_msg.endswith("."):
                    warn_msg += "."
                typer.secho(warn_msg, fg="yellow")

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

            if final_value is not None:
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
        for resource in self.plan[self.P_PLANNED_VALUES][self.P_ROOT_MODULE].get(
            self.P_RESOURCES, []
        ):
            if resource_id == resource[self.P_ADDRESS]:
                tf_resource_type = resource[self.P_TYPE]

        resource_rule: ResourceRule = self.rule_manager.resource_rules.get(
            tf_resource_type
        )
        if tf_resource_type is None or resource_rule is None:
            typer.secho(
                f"Resource type {tf_resource_type!r} is not supported and will be ignored.",
                fg="yellow",
            )
            return None

        if attrname not in resource_rule.attributes:
            typer.secho(
                f"Resource attribute {attrname!r} of {tf_resource_type!r} is not supported and will be ignored.",
                fg="yellow",
            )

        final_attrname = resource_rule.attributes[attrname]["To"]
        return {"Fn::GetAtt": [resource_id, final_attrname]}

    def _parse_outputs(self):
        planned_outputs = {}
        raw_planned_outputs: dict = self.plan[self.P_PLANNED_VALUES].get(
            self.P_OUTPUTS, {}
        )
        for name, info in raw_planned_outputs.items():
            value = info.get(self.P_VALUE)
            planned_outputs[name] = value

        outputs = {}
        source_outputs: dict = self.source[self.OUTPUTS]
        for name, source_output in source_outputs.items():
            planned_output = planned_outputs[name]
            output = self._parse_output(source_output, planned_output)
            outputs[name] = output

        return outputs

    def _parse_output(self, source_output: dict, planned_output: dict = None):
        if planned_output is not None:
            return planned_output

        output = self._parse_source_config(source_output, planned_output)
        return output

    def _transform_outputs(self, tf_outputs: dict, out_outputs: Outputs):
        for name, value in tf_outputs.items():
            value, _ = self._transform_prop_or_attr(value)
            if not _:
                resource_name = value["Fn::GetAtt"][0]
                ros_attrs = value["Fn::GetAtt"][1]
                if isinstance(ros_attrs, list):
                    attr_list = [
                        {"Fn::GetAtt": [resource_name, ros_attr]}
                        for ros_attr in ros_attrs
                    ]
                    value = {"Fn::Join": [":", attr_list]}
            output = Output(
                name=name,
                value=value,
            )

            out_outputs.add(output)
