import os
import re

import boto3
from alibabacloud_tea_openapi import models as open_api_models
from alibabacloud_credentials.client import Client as CredClient
from alibabacloud_ros20190910.client import Client
from alibabacloud_ros20190910 import models as ros_models

from tools.settings import (
    TF_ALI_ROS_GENERATE_MAPPINGS,
    TF_ALI_ROS_PROD_MAPPINGS,
    CF_ROS_PROD_MAPPINGS,
)


def snake_to_camel(snake_str: str):
    words = snake_str.split("_")
    camel_str = "".join(word.title() for word in words)
    return camel_str


def camel_to_snake(name):
    snake_str = ""
    for i in range(len(name)):
        if name[i] == "_":
            snake_str += name[i]
        elif name[i].isupper():
            if i - 1 >= 0 and name[i - 1].isupper():
                snake_str += name[i].lower()
            elif i + 1 < len(name) and name[i + 1].isupper():
                snake_str += name[i].lower()
            else:
                if snake_str and snake_str[-1] != "_":
                    snake_str += "_"
                snake_str += name[i].lower()
        else:
            snake_str += name[i]
    return snake_str


def print_tf_ali_ros_mapping(ros_types=None):
    alicloud_local = os.getenv("TERRAFORM_PROVIDER_ALICLOUD")
    if not alicloud_local:
        return {}

    tf_types = set()
    path = os.path.join(alicloud_local, "alicloud")
    pattern = re.compile(r"resource_(alicloud_[\w\W]+).go$")
    for filename in os.listdir(path):
        result = pattern.match(filename)
        if result:
            tf_type = result.group(1)
            if not tf_type.endswith("_test"):
                tf_types.add(tf_type)

    if not ros_types:
        ros_types = list_ros_types()
    ros_types = set(ros_types)

    mapping = TF_ALI_ROS_GENERATE_MAPPINGS.copy()
    for tf_type in tf_types:
        if tf_type in mapping:
            continue

        partial_tf_type = tf_type.replace("alicloud_", "")
        index = partial_tf_type.find("_")
        if not index:
            continue

        tf_prod = partial_tf_type[:index]
        ros_prod = TF_ALI_ROS_PROD_MAPPINGS.get(tf_prod) or tf_prod.upper()
        ros_type = "ALIYUN::{}::{}".format(
            ros_prod, snake_to_camel(partial_tf_type[index + 1 :])
        )
        if ros_type not in ros_types:
            mapping[tf_type] = None
        else:
            mapping[tf_type] = ros_type

    _print_mapping_orderly(mapping)


def print_cf_ros_mapping(cf_types=None, ros_types=None):
    from tools.settings import CF_ROS_GENERATE_MAPPINGS

    if not cf_types:
        cf_types = list_cf_types()
    cf_types = set(cf_types)

    if not ros_types:
        ros_types = list_ros_types()
    ros_types = set(ros_types)

    mapping = CF_ROS_GENERATE_MAPPINGS.copy()
    for cf_type in cf_types:
        if cf_type in mapping:
            continue

        if not cf_type.startswith("AWS::"):
            continue

        cf_type_splits = cf_type.split("::")
        cf_prod = cf_type_splits[1]
        ros_prod = CF_ROS_PROD_MAPPINGS.get(cf_prod) or cf_prod
        ros_type = "ALIYUN::{}::{}".format(ros_prod, cf_type_splits[2])
        if ros_type not in ros_types:
            mapping[cf_type] = None
        else:
            mapping[cf_type] = ros_type

    _print_mapping_orderly(mapping)


def _print_mapping_orderly(mapping: dict):
    keys = list(mapping.keys())
    keys.sort()
    print("{")
    for key in keys:
        value = mapping[key]
        if value:
            if isinstance(value, (list, tuple)):
                print(f'    "{key}": (')
                for rt in value:
                    print(f'        "{rt}",')
                print("    ),")
            else:
                print(f'    "{key}": "{value}",')
        else:
            print(f'    # "{key}": "",')
    print("}")


def list_ros_types():
    ros_config = open_api_models.Config(
        credential=CredClient(),
        endpoint="ros.aliyuncs.com",
    )
    ros_client = Client(ros_config)
    req = ros_models.ListResourceTypesRequest(entity_type="Resource")
    resp = ros_client.list_resource_types(req)
    return resp.body.resource_types


def list_cf_types():
    cf_client = boto3.client("cloudformation")
    cf_types = []
    next_token = True
    kwargs = {}
    while next_token:
        if next_token is not True:
            kwargs = {"NextToken": next_token}
        r = cf_client.list_types(
            Visibility="PUBLIC", Type="RESOURCE", MaxResults=100, **kwargs
        )
        type_summaries = r["TypeSummaries"]
        next_token = r.get("NextToken")
        cf_types.extend(ts["TypeName"] for ts in type_summaries)
    return cf_types
