import os
import shutil

import yaml
from alibabacloud_tea_openapi import models as open_api_models
from alibabacloud_ros20190910.client import Client
from alibabacloud_credentials.client import Client as CredClient

from tools import exceptions
from tools.settings import TF_ALI_ROS_PROP_MAPPINGS, TF_ALI_RULES_DIR
from tools.resource import RosResource, TerraformResource
from tools.utils import snake_to_camel


class RuleGenerator:
    TYPE_MAPPING = {
        "list": "List",
        "map": "Map",
    }
    COMPATIBLE_TYPE_MAPPING = {
        "integer": {"number", "string"},
        "number": {"string"},
    }

    def __init__(self, tf_resource: TerraformResource, ros_resource: RosResource):
        self.tf_resource = tf_resource
        self.ros_resource = ros_resource

    @classmethod
    def initialize(
        cls,
        tf_resource_type: str,
        ros_resource_type: str,
        tf_resource_filename: str = None,
    ):
        if not tf_resource_type.startswith("alicloud_"):
            raise exceptions.RosToolWarning(
                message="Terraform resource type only support alicloud resource"
            )

        path = shutil.which("asty")
        if not path:
            raise exceptions.RosToolWarning(
                message="Command `asty` not found. Please run `go install github.com/asty-org/asty`"
            )

        config = open_api_models.Config(
            credential=CredClient(),
            endpoint="ros.aliyuncs.com",
        )
        client = Client(config)

        tf_resource = TerraformResource(tf_resource_type, tf_resource_filename)
        ros_resource = RosResource(client, ros_resource_type)

        return cls(tf_resource, ros_resource)

    def generate(self):
        name = self.tf_resource.resource_type.replace("alicloud_", "")
        filename = f"{name}.yml"
        path = os.path.join(TF_ALI_RULES_DIR, filename)
        rule = None
        if os.path.exists(path):
            with open(path, "r") as f:
                rule = yaml.safe_load(f)

        generated_rule = self._generate_rule()

        # reserve some rule sections
        if rule:
            props = rule.get("Properties", {})
            generated_props = generated_rule.setdefault("Properties", {})
            for prop_name, prop in props.items():
                try:
                    if not prop.get("Ignore") and generated_props.get(
                        prop_name, {}
                    ).get("Ignore"):
                        generated_props[prop_name] = prop
                except AttributeError as e:
                    print("-------")
                    print(generated_props)
                    print(prop_name, generated_props.get(prop_name, {}))
                    print(e)
                    raise e

            attr_id = rule.get("Attributes", {}).get("id", {}).get("To")
            if attr_id:
                generated_rule.setdefault("Attributes", {}).setdefault("id", {})[
                    "To"
                ] = attr_id

        with open(os.path.join(TF_ALI_RULES_DIR, filename), "w") as f:
            content = yaml.safe_dump(generated_rule, sort_keys=False)
            content = content.replace("'# todo'", "# todo")
            f.write(content)

    def _generate_rule(self):
        rule = {
            "Version": "2020-06-01",
            "Type": "Resource",
            "ResourceType": {
                "From": self.tf_resource.resource_type,
                "To": self.ros_resource.resource_type,
            },
        }
        props_rule = self._generate_properties_rule(
            self.tf_resource.properties(), self.ros_resource.properties()
        )
        if props_rule:
            rule["Properties"] = props_rule

        attrs_rule = self._generate_attributes_rule(
            self.tf_resource.attributes(), self.ros_resource.attributes()
        )
        if attrs_rule:
            rule["Attributes"] = attrs_rule

        return rule

    def _generate_properties_rule(
        self, tf_schema: dict, ros_schema: dict, tf_prop_path="", ros_prop_path=""
    ):
        props_rule = {}
        for tf_key in sorted(tf_schema):
            tf_prop_path_ = f"{tf_prop_path}.{tf_key}" if tf_prop_path else tf_key
            ros_key = snake_to_camel(tf_key)
            if ros_key not in ros_schema:
                ros_key = TF_ALI_ROS_PROP_MAPPINGS.get(
                    self.tf_resource.resource_type, {}
                ).get(tf_prop_path_)
                if not ros_key:
                    ros_key = TF_ALI_ROS_PROP_MAPPINGS.get("*", {}).get(tf_prop_path_)
            ros_prop_path_ = f"{ros_prop_path}.{ros_key}" if ros_prop_path else ros_key

            if ros_key not in ros_schema:
                prop_rule = {"Ignore": True}
            else:
                tf_prop_schema = tf_schema[tf_key]
                if "Handler" in tf_prop_schema:
                    prop_rule = {"To": ros_key, "Handler": tf_prop_schema["Handler"]}
                else:
                    tf_schema_type = tf_prop_schema["Type"]
                    ros_schema_type = ros_schema[ros_key]["Type"]
                    if not self._is_type_compatible(tf_schema_type, ros_schema_type):
                        print(
                            f"[Warning] Schema type not equal. "
                            f"{tf_schema_type}({tf_prop_path_}) != {ros_schema_type}({ros_prop_path_})"
                        )
                        prop_rule = {"Ignore": True}
                    else:
                        prop_rule = {"To": ros_key}
                        rule_type = self.TYPE_MAPPING.get(tf_schema_type)
                        if rule_type and "Schema" in tf_prop_schema:
                            prop_rule["Type"] = rule_type
                            tf_sub_schema = tf_prop_schema["Schema"]["*"]
                            tf_sub_schema_type = tf_sub_schema["Type"]
                            tf_sub_prop_path = f"{tf_prop_path_}.*"
                            try:
                                ros_sub_schema = ros_schema[ros_key]["Schema"]["*"]
                            except KeyError:
                                ros_sub_schema = {"Required": True, "Type": "string"}
                            ros_sub_schema_type = ros_sub_schema["Type"]
                            ros_sub_prop_path = f"{ros_prop_path_}.*"

                            if not self._is_type_compatible(
                                tf_sub_schema_type, ros_sub_schema_type
                            ):
                                print(
                                    f"[Warning] Schema type not equal. "
                                    f"{tf_sub_prop_path}({tf_sub_prop_path}) != {ros_sub_prop_path}({ros_sub_prop_path})"
                                )
                                prop_rule = {"Ignore": True}
                            else:
                                tf_sub_schema_s = tf_sub_schema.get("Schema")
                                ros_sub_schema_s = ros_sub_schema.get("Schema")
                                if tf_sub_schema_s and ros_sub_schema_s:
                                    sub_properties_rule = (
                                        self._generate_properties_rule(
                                            tf_sub_schema_s,
                                            ros_sub_schema_s,
                                            tf_sub_prop_path,
                                            ros_sub_prop_path,
                                        )
                                    )
                                    prop_rule["Schema"] = sub_properties_rule
            props_rule[tf_key] = prop_rule
        return props_rule

    def _generate_attributes_rule(self, tf_schema: dict, ros_schema: dict):
        attrs_rule = {"id": {"To": "# todo"}}
        for tf_key in sorted(tf_schema):
            ros_key = snake_to_camel(tf_key)
            if ros_key not in ros_schema:
                ros_key = TF_ALI_ROS_PROP_MAPPINGS.get(
                    self.tf_resource.resource_type, {}
                ).get(tf_key)
                if not ros_key:
                    ros_key = TF_ALI_ROS_PROP_MAPPINGS.get("*", {}).get(tf_key)

            if ros_key not in ros_schema:
                attr_rule = {"Ignore": True}
            else:
                attr_rule = {"To": ros_key}
            attrs_rule[tf_key] = attr_rule
        return attrs_rule

    @classmethod
    def _is_type_compatible(cls, type1, type2):
        if type1 == type2:
            return True

        comp_types = cls.COMPATIBLE_TYPE_MAPPING.get(type1)
        if comp_types and type2 in comp_types:
            return True
        return False
