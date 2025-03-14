from typing import TYPE_CHECKING, Any

from rostran.providers.terraform import template_blocks as tf
from tools.utils import camel_to_snake

if TYPE_CHECKING:
    from rostran.providers.ros.template import ROS2TerraformTemplate


def ref(ros2tf: "ROS2TerraformTemplate", args: str):
    if args.startswith("ALIYUN::") and args in ALL_FUNCTIONS:
        return ALL_FUNCTIONS[args](ros2tf, args)

    tf_value = ros2tf.get_tf_params(camel_to_snake(args))
    if args in ros2tf.parameters:
        return tf.LiteralType(f"var.{tf_value}")
    elif args in ros2tf.resources:
        resource = ros2tf.resources[args]
        resource_rule = ros2tf.get_resource_rule(resource.get("Type"))
        tf_res_type = resource_rule.target_resource_type
        if args in ros2tf.resources_with_count:
            tf_item = f"{tf_res_type}.{tf_value}[*].id"
            return tf.LiteralType(f"length({tf_item}) > 0 ? {tf_item} : {tf.NullType()}")
        return tf.LiteralType(f'{tf_res_type}.{tf_value}.id')
    raise ValueError(f"Ref - {args} is not a valid Resource or Parameter.")


def get_att(ros2tf: "ROS2TerraformTemplate", args: list):
    res_name, att_name = args
    tf_res_name = camel_to_snake(res_name)
    resource = ros2tf.resources[res_name]
    resource_rule = ros2tf.get_resource_rule(resource.get("Type"))
    msg = f"Could not transform ROS Attribute {att_name} to Terraform attribute."
    if not resource_rule:
        return tf.CommentType(msg)
    tf_res_type = resource_rule.target_resource_type
    rule_attr = resource_rule.attributes
    if not rule_attr:
        return tf.CommentType(msg)
    tf_attr = rule_attr.get(att_name, {}).get('To')
    if not tf_attr:
        return tf.CommentType(msg)
    if res_name in ros2tf.resources_with_count:
        tf_item = f"{tf_res_type}.{tf_res_name}[*].{tf_attr}"
        return tf.LiteralType(f"length({tf_item}) > 0 ? {tf_item} : {tf.NullType()}")
    return tf.LiteralType(f'{tf_res_type}.{tf_res_name}.{tf_attr}')


def equals(_, args: list):
    tf_args = [item if isinstance(item, tf.TerraformType) else tf.convert_to_tf_type(item) for item in args]
    return tf.LiteralType(f"{tf_args[0]} == {tf_args[1]}")


def and_(_, args: list):
    tf_args = [item if isinstance(item, tf.TerraformType) else tf.convert_to_tf_type(item) for item in args]
    return tf.LiteralType(f"alltrue({tf_args})")


def or_(_, args: list):
    tf_args = [item if isinstance(item, tf.TerraformType) else tf.convert_to_tf_type(item) for item in args]
    return tf.LiteralType(f"anytrue({tf_args})")


def if_(_, args: list):
    tf_args = [item if isinstance(item, tf.TerraformType) else tf.convert_to_tf_type(item) for item in args[1:]]
    return tf.LiteralType(f"local.{args[0]} ? {tf_args[0]} : {tf_args[1]}")


def not_(_, args: str):
    if not isinstance(args, tf.TerraformType):
        args = tf.convert_to_tf_type(args)
    return tf.LiteralType(f"!{args}")


def index_(_, __):
    return tf.LiteralType(f"count.index")


def handle_tags(ros2tf: "ROS2TerraformTemplate", args: Any, tag_key="Key", tag_value="Value"):
    if isinstance(args, list):
        result = {}
        for tag in args:
            if not isinstance(tag, dict):
                continue
            key = tag.get(tag_key)
            if not key:
                continue
            value = tag.get(tag_value)
            result[key] = ros2tf.resolve_values(value)
        return tf.JsonType(result)
    return ros2tf.resolve_values(args)


ALL_FUNCTIONS = {
    "Ref": ref,
    "Fn::GetAtt": get_att,
    "Fn::Equals": equals,
    "Fn::And": and_,
    "Fn::Or": or_,
    "Fn::If": if_,
    "Fn::Not": not_,
    "ALIYUN::Index": index_
}
