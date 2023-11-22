import os
import shutil
from typing import Union

import yaml
import boto3
from alibabacloud_tea_openapi import models as open_api_models
from alibabacloud_ros20190910.client import Client
from alibabacloud_credentials.client import Client as CredClient

from tools import exceptions
from tools.settings import (
    TF_ALI_ROS_PROP_MAPPINGS,
    TF_ALI_RULES_DIR,
    CF_ROS_PROP_MAPPINGS,
    CF_RESOURCE_RULES_DIR,
)
from tools.resource import RosResource, TerraformResource, CloudFormationResource
from tools.utils import snake_to_camel, camel_to_snake


class BaseRuleGenerator:
    TYPE_MAPPING = {
        "list": "List",
        "map": "Map",
    }
    COMPATIBLE_TYPE_MAPPING = {
        "integer": {"number", "string"},
        "number": {"string"},
        "string": {
            "integer",
            "number",
        },  # ROS supports automatic conversion of string to integer.
    }

    def __init__(
        self,
        from_resource: Union[TerraformResource, CloudFormationResource],
        ros_resource: RosResource,
    ):
        self.from_resource = from_resource
        self.ros_resource = ros_resource

    def generate(self):
        path = self._get_rule_path()
        rule = None
        if os.path.exists(path):
            with open(path, "r") as f:
                rule = yaml.safe_load(f)

        generated_rule = self._generate_rule()

        # reserve some rule sections
        if rule:
            for section in ("Properties", "Attributes"):
                pas = rule.get(section, {})  # props or attrs
                generated_pas = generated_rule.setdefault(section, {})
                for pa_name, pa in pas.items():
                    try:
                        if not pa.get("Ignore") and generated_pas.get(pa_name, {}).get(
                            "Ignore"
                        ):
                            generated_pas[pa_name] = pa
                    except AttributeError as e:
                        print("-------")
                        print(generated_pas)
                        print(pa_name, generated_pas.get(pa_name, {}))
                        print(e)
                        raise e

            attr_id = rule.get("Attributes", {}).get("id", {}).get("To")
            if attr_id:
                generated_rule.setdefault("Attributes", {}).setdefault("id", {})[
                    "To"
                ] = attr_id

        with open(path, "w") as f:
            content = yaml.safe_dump(generated_rule, sort_keys=False)
            content = content.replace("'# todo'", "# todo")
            f.write(content)

    def _get_rule_path(self):
        raise NotImplementedError()

    def _generate_rule(self):
        rule = {
            "Version": "2020-06-01",
            "Type": "Resource",
            "ResourceType": {
                "From": self.from_resource.resource_type,
                "To": self.ros_resource.resource_type,
            },
        }
        props_rule = self._generate_properties_rule(
            self.from_resource.properties(), self.ros_resource.properties()
        )
        if props_rule:
            rule["Properties"] = props_rule

        attrs_rule = self._generate_attributes_rule(
            self.from_resource.attributes(),
            self.ros_resource.attributes(),
        )
        if attrs_rule:
            rule["Attributes"] = attrs_rule

        return rule

    def _generate_properties_rule(
        self, from_schema: dict, ros_schema: dict, from_prop_path="", ros_prop_path=""
    ):
        props_rule = {}
        for from_key in sorted(from_schema):
            from_prop_path_ = (
                f"{from_prop_path}.{from_key}" if from_prop_path else from_key
            )
            ros_key = self._get_ros_key(ros_schema, from_key, from_prop_path_)
            ros_prop_path_ = f"{ros_prop_path}.{ros_key}" if ros_prop_path else ros_key

            if ros_key not in ros_schema:
                prop_rule = {"Ignore": True}
            else:
                from_prop_schema = from_schema[from_key]
                if "Handler" in from_prop_schema:
                    prop_rule = {"To": ros_key, "Handler": from_prop_schema["Handler"]}
                else:
                    from_schema_type = from_prop_schema.get("Type")
                    ros_schema_type = ros_schema[ros_key]["Type"]
                    if not from_schema_type and "oneof" in from_prop_schema:
                        print(
                            f"[Warning] The Schema of property {from_prop_path_!r} has multiple types, "
                            f"and should set rule manually. "
                        )
                        prop_rule = {"Ignore": True}
                    elif not self._is_type_compatible(
                        from_schema_type, ros_schema_type
                    ):
                        print(
                            f"[Warning] Schema type not equal. "
                            f"{from_schema_type}({from_prop_path_}) != {ros_schema_type}({ros_prop_path_})"
                        )
                        prop_rule = {"Ignore": True}
                    else:
                        prop_rule = {"To": ros_key}
                        rule_type = self.TYPE_MAPPING.get(from_schema_type)
                        if rule_type and "Schema" in from_prop_schema:
                            prop_rule["Type"] = rule_type
                            if rule_type == "List":
                                from_sub_schema = from_prop_schema["Schema"]["*"]
                                from_sub_prop_path = f"{from_prop_path_}.*"
                                try:
                                    ros_sub_schema = ros_schema[ros_key]["Schema"]["*"]
                                except KeyError:
                                    ros_sub_schema = {
                                        "Required": True,
                                        "Type": "string",
                                    }
                                ros_sub_prop_path = f"{ros_prop_path_}.*"
                            else:
                                from_sub_schema = from_prop_schema["Schema"]
                                from_sub_prop_path = from_prop_path_
                                try:
                                    ros_sub_schema = ros_schema[ros_key]["Schema"]
                                except KeyError:
                                    ros_sub_schema = {
                                        "Required": True,
                                        "Type": "string",
                                    }
                                ros_sub_prop_path = ros_prop_path_

                            from_sub_schema_type = from_sub_schema.get("Type")
                            ros_sub_schema_type = ros_sub_schema.get("Type")
                            if not from_sub_schema_type or not ros_sub_schema_type:
                                continue

                            if not self._is_type_compatible(
                                from_sub_schema_type, ros_sub_schema_type
                            ):
                                print(
                                    f"[Warning] Schema type not equal. "
                                    f"{from_sub_prop_path}({from_sub_schema_type}) != {ros_sub_prop_path}({ros_sub_schema_type})"
                                )
                                prop_rule = {"Ignore": True}
                            else:
                                from_sub_schema_s = from_sub_schema.get("Schema")
                                ros_sub_schema_s = ros_sub_schema.get("Schema")
                                if from_sub_schema_s and ros_sub_schema_s:
                                    sub_properties_rule = (
                                        self._generate_properties_rule(
                                            from_sub_schema_s,
                                            ros_sub_schema_s,
                                            from_sub_prop_path,
                                            ros_sub_prop_path,
                                        )
                                    )
                                    prop_rule["Schema"] = sub_properties_rule
            props_rule[from_key] = prop_rule
        return props_rule

    def _get_ros_key(self, ros_schema: dict, from_key: str, from_prop_path: str) -> str:
        raise NotImplementedError()

    def _generate_attributes_rule(self, from_schema: dict, ros_schema: dict):
        attrs_rule = self._get_init_attrs_rule()
        for from_key in sorted(from_schema):
            ros_key = self._get_ros_key(ros_schema, from_key, from_key)

            if ros_key not in ros_schema:
                attr_rule = {"Ignore": True}
            else:
                attr_rule = {"To": ros_key}
            attrs_rule[from_key] = attr_rule
        return attrs_rule

    def _get_init_attrs_rule(self):
        return {}

    @classmethod
    def _is_type_compatible(cls, type1, type2):
        if type1 == type2:
            return True

        comp_types = cls.COMPATIBLE_TYPE_MAPPING.get(type1)
        if comp_types and type2 in comp_types:
            return True
        return False


class TerraformRuleGenerator(BaseRuleGenerator):
    @classmethod
    def initialize(
        cls,
        from_resource_type: str,
        ros_resource_type: str,
        from_resource_filename: str = None,
    ):
        if not from_resource_type.startswith("alicloud_"):
            raise exceptions.RosToolWarning(
                message="Terraform resource type only support alicloud resource which starts with alicloud_"
            )

        path = shutil.which("asty")
        if not path:
            raise exceptions.RosToolWarning(
                message="Command `asty` not found. Please run `go install github.com/asty-org/asty`"
            )

        from_resource = TerraformResource(from_resource_type, from_resource_filename)

        ros_config = open_api_models.Config(
            credential=CredClient(),
            endpoint="ros.aliyuncs.com",
        )
        ros_client = Client(ros_config)
        ros_resource = RosResource(ros_client, ros_resource_type)

        return cls(from_resource, ros_resource)

    def _get_rule_path(self):
        name = self.from_resource.resource_type.replace("alicloud_", "")
        filename = f"{name}.yml"
        path = os.path.join(TF_ALI_RULES_DIR, filename)
        return path

    def _get_ros_key(self, ros_schema: dict, from_key: str, from_prop_path: str):
        ros_key = snake_to_camel(from_key)
        if ros_key not in ros_schema:
            ros_key = TF_ALI_ROS_PROP_MAPPINGS.get(
                self.from_resource.resource_type, {}
            ).get(from_prop_path)
            if not ros_key:
                ros_key = TF_ALI_ROS_PROP_MAPPINGS.get("*", {}).get(from_prop_path)

        return ros_key

    def _get_init_attrs_rule(self):
        return ({"id": {"To": "# todo"}},)


class CloudFormationRuleGenerator(BaseRuleGenerator):
    @classmethod
    def initialize(
        cls,
        from_resource_type: str,
        ros_resource_type: str,
    ):
        if not from_resource_type.startswith("AWS::"):
            raise exceptions.RosToolWarning(
                message="CloudFormation resource type only support CloudFormation resource which starts with AWS::"
            )

        cf_client = boto3.client("cloudformation")
        from_resource = CloudFormationResource(cf_client, from_resource_type)

        ros_config = open_api_models.Config(
            credential=CredClient(),
            endpoint="ros.aliyuncs.com",
        )
        ros_client = Client(ros_config)
        ros_resource = RosResource(ros_client, ros_resource_type)

        return cls(from_resource, ros_resource)

    def _get_rule_path(self):
        name = camel_to_snake(self.from_resource.resource_type.replace("::", "_"))
        filename = f"{name}.yml"
        path = os.path.join(CF_RESOURCE_RULES_DIR, filename)
        return path

    def _get_ros_key(self, ros_schema: dict, from_key: str, from_prop_path: str):
        ros_key = from_key
        if ros_key not in ros_schema:
            ros_key = CF_ROS_PROP_MAPPINGS.get(
                self.from_resource.resource_type, {}
            ).get(from_prop_path)
            if not ros_key:
                ros_key = CF_ROS_PROP_MAPPINGS.get("*", {}).get(from_prop_path)

        return ros_key
