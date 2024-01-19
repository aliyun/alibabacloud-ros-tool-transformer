import os
import linecache
from uuid import uuid4
import importlib
from typing import Any
import typer
from libterraform import TerraformCommand, TerraformConfig
from libterraform.exceptions import TerraformCommandError

from rostran.core.exceptions import (
    RosTranWarning,
    TemplateFormatNotSupport,
    RunCommandFailed,
    TerraformPlanFormatVersionNotSupported,
    TerraformMultiProvidersNotSupported,
    TerraformProviderNotFound,
    RosTranException,
    InvalidRuleSchema,
)
from rostran.core.format import FileFormat
from rostran.core.rule_manager import RuleManager, RuleClassifier, ResourceRule
from rostran.core.template import Template, RosTemplate
from rostran.core.properties import Property
from rostran.core.resources import Resources, Resource
from rostran.core.outputs import Outputs, Output
import rostran.handlers.basic as basic_handler_module
import rostran.handlers.merge as merge_handler_module


class TerraformTemplate(Template):
    PROVIDERS = (
        ALICLOUD,
        AWS,
    ) = (
        "alicloud",
        "aws",
    )

    SUPPORTED_PLAN_FORMAT_VERSIONS = ("1.0", "1.1", "1.2")

    PLAN_PROPERTIES = (
        P_PLANNED_RESOURCES,
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
        "planned_resources",
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
        SOURCE,
        COLLECTION,
        KEY,
        ARGS,
        PARTS,
        EACH,
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
        "Source",
        "Collection",
        "Key",
        "Args",
        "Parts",
        "Each",
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
        "Filename",
        "Start",
        "End",
    )

    RESOURCE_PROP_PROPERTIES = (
        PROP_TYPE,
        PROP_VALUE,
        PROP_ARGS,
    ) = (
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
        tf_resources, planned_resources = self._parse_resources()
        self._transform_resources(tf_resources, template.resources)

        tf_outputs = self._parse_outputs(planned_resources)
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

            org_address = "{type}.{name}".format(**planned_resource)
            # Handle resource using `count`
            if "index" in planned_resource:
                count_resource_list = planned_resources.setdefault(org_address, [])
                count_resource_list.append(planned_resource)
            # Handle normal resource
            else:
                planned_resources[org_address] = [planned_resource]

        resources = {}
        managed_resources: dict = self.source[self.MANAGED_RESOURCES]
        for org_address, managed_resource in managed_resources.items():
            for planned_resource in planned_resources[org_address]:
                resource = self._parse_resource(managed_resource, planned_resource)
                address = planned_resource[self.P_ADDRESS]
                resources[address] = resource

        return resources, planned_resources

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

    def _parse_source_config(
        self, config: dict, planned_entity: dict, entity_type: str = P_RESOURCES
    ):
        # For resource
        if entity_type == self.P_RESOURCES:
            props = {}
            planned_props = planned_entity[self.P_VALUES]
            attributes = config.get(self.ATTRIBUTES)
            if attributes:
                for name, prop in attributes.items():
                    if name in ("depends_on", "count"):
                        continue

                    if planned_props is None:
                        planned_value = None
                    else:
                        planned_value = planned_props.get(name)

                    # If cannot get value from planned resource,
                    # it means value cannot resolved statically
                    if planned_value is None:
                        expr = prop[self.EXPR]
                        value = self._parse_source_expr(
                            expr, planned_entity.get("index")
                        )
                        if value is not None:
                            props[name] = value
                    else:
                        props[name] = planned_value

            blocks = config.get(self.BLOCKS, [])
            for block in blocks:
                name = block[self.TYPE]
                if name not in props:
                    props[name] = []
                    index = 0
                else:
                    index = len(props[name])

                if planned_props is None or not isinstance(planned_props[name], list):
                    new_planned_props = None
                else:
                    new_planned_props = planned_props[name][index]

                new_planned_entity = {self.P_VALUES: new_planned_props}
                res = self._parse_source_config(
                    block[self.BODY], new_planned_entity, entity_type=entity_type
                )
                props[name].append(res)
            return props
        # For output
        elif entity_type == self.P_OUTPUTS:
            assert self.EXPR in config
            assert self.P_PLANNED_RESOURCES in planned_entity
            return self._parse_source_expr(
                config[self.EXPR],
                planned_entity.get("index"),
                planned_entity.get(self.P_PLANNED_RESOURCES),
            )
        else:
            raise ValueError(f"entity_type: {entity_type!r} not supported")

    def _parse_source_expr(
        self, expr: dict, count_index: int = None, planned_resources: dict = None
    ):
        data = None
        # Func
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
        # Attr refer
        elif self.TRAVERSAL in expr:
            traversal = expr[self.TRAVERSAL]
            source = expr.get(self.SOURCE)
            # Attr refer a resource with count
            if source and count_index is not None:
                collection_traversal = source[self.COLLECTION][self.TRAVERSAL]
                data = {
                    self.PROP_TYPE: self.PROP_TYPE_FUNC,
                    self.PROP_VALUE: self.FUNC_GET_ATT,
                    self.PROP_ARGS: [
                        f"{collection_traversal[0][self.NAME]}.{collection_traversal[1][self.NAME]}[{count_index}]",
                        traversal[0][self.NAME],
                    ],
                }
                return data

            first = traversal[0][self.NAME]
            # ROS not supports, so return None
            if first in ("var", "data"):
                return None

            traversal_length = len(traversal)
            if traversal_length == 3:
                data = {
                    self.PROP_TYPE: self.PROP_TYPE_FUNC,
                    self.PROP_VALUE: self.FUNC_GET_ATT,
                    self.PROP_ARGS: [
                        f"{first}.{traversal[1][self.NAME]}",
                        traversal[2][self.NAME],
                    ],
                }
            elif traversal_length == 4 and self.KEY in traversal[2]:
                # As there is no value for the Key (which is in traversal[2]), it needs to be read from a file.
                src_range = traversal[2][self.SRC_RANGE]
                start = src_range[self.START]
                end = src_range[self.END]
                content = ""
                for lineno in range(start["Line"], end["Line"] + 1):
                    content += linecache.getline(
                        src_range[self.FILENAME], lineno
                    ).rstrip("\n")

                key = content[start["Column"] : end["Column"] - 1]
                try:
                    count_index = int(key)
                except ValueError:
                    return None

                data = {
                    self.PROP_TYPE: self.PROP_TYPE_FUNC,
                    self.PROP_VALUE: self.FUNC_GET_ATT,
                    self.PROP_ARGS: [
                        f"{first}.{traversal[1][self.NAME]}[{count_index}]",
                        traversal[3][self.NAME],
                    ],
                }
        # Attr refer using *
        elif self.SOURCE in expr and self.EACH in expr and planned_resources:
            attr_name = expr[self.EACH][self.TRAVERSAL][0][self.NAME]
            source_traversal = expr[self.SOURCE][self.TRAVERSAL]
            raw_address = (
                f"{source_traversal[0][self.NAME]}.{source_traversal[1][self.NAME]}"
            )
            resource_list = planned_resources.get(raw_address)
            if resource_list:
                data = []
                for resource in resource_list:
                    data.append(
                        {
                            self.PROP_TYPE: self.PROP_TYPE_FUNC,
                            self.PROP_VALUE: self.FUNC_GET_ATT,
                            self.PROP_ARGS: [
                                resource[self.P_ADDRESS],
                                attr_name,
                            ],
                        }
                    )
                return data
            return None

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
                tf_resource_type,
                tf_resource_props,
                resource_rule.properties,
                resource_rule.rule_id,
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
        self, resource_type, resource_props, resource_rule_props, rule_id
    ):
        final_props = {}
        for name, value in resource_props.items():
            # Ignore not support prop
            prop_rule = resource_rule_props.get(name)
            if not prop_rule or prop_rule.get("Ignore"):
                if not prop_rule or not prop_rule.get("NoWarning"):
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

    def _transform_prop_or_attr(self, value) -> (Any, bool):
        if isinstance(value, list):
            data = []
            resolved = True
            for v in value:
                val, resolved_ = self._transform_prop_or_attr(v)
                if resolved_ is False:
                    resolved = False
                data.append(val)
            return data, resolved
        elif isinstance(value, dict):
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
                    return (
                        self._transform_func_get_att(prop_args[0], prop_args[1]),
                        False,
                    )
            return None, True

        return value, True

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

        if (
            attrname not in resource_rule.attributes
            or "To" not in resource_rule.attributes[attrname]
        ):
            typer.secho(
                f"Resource attribute {attrname!r} of {tf_resource_type!r} is not supported and will be ignored.",
                fg="yellow",
            )
            return None

        def parse(n):
            names = n.split(".")
            final_attrname = names[0]
            result = {"Fn::GetAtt": [resource_id, final_attrname]}

            if len(names) > 1:
                # using JQ to get value
                jq_expr = "."
                for name in names[1:]:
                    try:
                        index = int(name)
                        jq_expr += f"[{index}]"
                    except ValueError:
                        jq_expr += f".{name}"
                result = {"Fn::Jq": ["First", jq_expr, result]}
            return result

        attr_rule = resource_rule.attributes[attrname]
        to_name = attr_rule["To"]
        if isinstance(to_name, str):
            final_value = parse(to_name)
        elif isinstance(to_name, (list, tuple)):
            final_value = [parse(each) for each in to_name]
        else:
            raise InvalidRuleSchema(
                path=resource_rule.rule_id,
                reason=f"The type of To={to_name} is invalid. Expect str or list",
            )

        handler_name = attr_rule.get("Handler")
        if handler_name is not None:
            handler_func = getattr(basic_handler_module, handler_name)
            final_value = handler_func(final_value, False)

        return final_value

    def _parse_outputs(self, planned_resources: dict = None):
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
            output = self._parse_output(
                source_output, planned_output, planned_resources
            )
            outputs[name] = output

        return outputs

    def _parse_output(
        self,
        source_output: dict,
        planned_output: dict = None,
        planned_resources: dict = None,
    ):
        if planned_output is not None:
            return planned_output

        output = self._parse_source_config(
            source_output,
            {
                self.P_VALUES: planned_output,
                self.P_PLANNED_RESOURCES: planned_resources,
            },
            entity_type=self.P_OUTPUTS,
        )
        return output

    def _transform_outputs(self, tf_outputs: dict, out_outputs: Outputs):
        for name, value in tf_outputs.items():
            value, _ = self._transform_prop_or_attr(value)
            output = Output(
                name=name,
                value=value,
            )
            out_outputs.add(output)
