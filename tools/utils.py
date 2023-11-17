import os
import re


def snake_to_camel(snake_str: str):
    words = snake_str.split("_")
    camel_str = "".join(word.title() for word in words)
    return camel_str


def print_tf_ali_ros_mapping(valid_ros_types=None):
    from settings import TF_ALI_ROS_GENERATE_MAPPING

    alicloud_local = os.getenv("TERRAFORM_PROVIDER_ALICLOUD")
    if not alicloud_local:
        return {}

    tf_types = []
    path = os.path.join(alicloud_local, "alicloud")
    pattern = re.compile(r"resource_(alicloud_[\w\W]+).go$")
    for filename in os.listdir(path):
        result = pattern.match(filename)
        if result:
            tf_type = result.group(1)
            if not tf_type.endswith("_test"):
                tf_types.append(tf_type)

    prod_mapping = {
        "alidns": "DNS",
        "alikafka": "KAFKA",
        "db": "RDS",
        "log": "SLS",
        "market": "MarketPlace",
        "api_gateway": "ApiGateway",
    }
    mapping = TF_ALI_ROS_GENERATE_MAPPING.copy()
    tf_types.sort()
    for tf_type in tf_types:
        if tf_type in mapping:
            continue

        partial_tf_type = tf_type.replace("alicloud_", "")
        index = partial_tf_type.find("_")
        if not index:
            continue

        tf_prod = partial_tf_type[:index]
        ros_prod = prod_mapping.get(tf_prod) or tf_prod.upper()
        ros_type = "ALIYUN::{}::{}".format(
            ros_prod, snake_to_camel(partial_tf_type[index + 1 :])
        )
        if valid_ros_types and ros_type not in valid_ros_types:
            mapping[tf_type] = None
        else:
            mapping[tf_type] = ros_type

    tf_types = list(mapping.keys())
    tf_types.sort()
    print("{")
    for tf_type in tf_types:
        ros_type = mapping[tf_type]
        if ros_type:
            if isinstance(ros_type, (list, tuple)):
                print(f'    "{tf_type}": (')
                for rt in ros_type:
                    print(f'        "{rt}",')
                print("    ),")
            else:
                print(f'    "{tf_type}": "{ros_type}",')
        else:
            print(f'    # "{tf_type}": "",')
    print("}")
    return mapping
