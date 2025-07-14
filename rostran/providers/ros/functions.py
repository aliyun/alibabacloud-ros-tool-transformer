import re
import uuid
from typing import TYPE_CHECKING, Any, Union

from rostran.providers.terraform import template_blocks as tf
from tools.utils import camel_to_snake

if TYPE_CHECKING:
    from rostran.providers.ros.template import ROS2TerraformTemplate


def resolve(ros2tf: "ROS2TerraformTemplate", data: Any):
    if isinstance(data, dict):
        if len(data) == 1:
            key, value = next(iter(data.items()))
            if key in ALL_FUNCTIONS:
                return ALL_FUNCTIONS[key](ros2tf, resolve(ros2tf, value))
            return {key: resolve(ros2tf, value)}
        return {k: resolve(ros2tf, v) for k, v in data.items()}
    elif isinstance(data, list):
        return [resolve(ros2tf, v) for v in data]
    else:
        return data

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
    return tf.LiteralType(f'"{args}"')


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


def sub_(ros2tf: "ROS2TerraformTemplate", args: Union[str, list]):
    if isinstance(args, list):
        sub_string, sub_mapping = args[0], args[1]
    else:
        sub_string, sub_mapping = args, {}

    pattern = re.compile(r'\$\{([^!][^}]*)}')
    keys = pattern.findall(sub_string)
    mapping = {}
    for k in keys:
        if k in sub_mapping:
            mapping[k] = resolve(ros2tf, sub_mapping[k])
        elif "." in k:
            mapping[k] = get_att(ros2tf, k.rsplit(".", 1))
        else:
            mapping[k] = ref(ros2tf, k)

    def replacer(match):
        key = match.group(1)
        value = mapping.get(key, match.group(0))
        if isinstance(value, tf.LiteralType):
            value = value.ref_render()
        elif not isinstance(value, str):
            value = str(value)
        return value

    result = pattern.sub(replacer, sub_string)
    return tf.LiteralType(f'"{result}"')


def select_(_, args: list):
    if len(args) == 2:
        lookup, data = args
        default_value = tf.NullType()
    elif len(args) >= 3:
        args = args[:3]
        lookup, data, default_value = args
    else:
        return tf.LiteralType(args)

    if isinstance(data, dict):
        result = data.get(lookup, default_value)
        if isinstance(result, tf.TerraformType):
            return result
        else:
            return tf.LiteralType(result)

    try:
        index = int(lookup)
    except ValueError:
        return tf.LiteralType(args)
    if isinstance(data, tf.TerraformType):
        value = data.value
    else:
        value = data
    return tf.LiteralType(f"{value}[{index}]")


def jq_(_, args: list):
    method, script, data = args
    if method != 'First':
        return tf.LiteralType(args)

    unsupported_characters = ("|", " ", "&", "{", "(")
    for c in unsupported_characters:
        if c in script:
            return tf.LiteralType(args)

    script = script.replace('.[', '[')
    if isinstance(data, tf.TerraformType):
        value = data.value
    else:
        value = data
    return tf.LiteralType(f"{value}{script}")


def index_(_, __):
    return tf.LiteralType(f"count.index")

def stack_id_(ros2tf: "ROS2TerraformTemplate", __):
    return ros2tf.uid

def no_value_(_, __):
    return tf.NullType()

def _data_for_pseudo_param(ros2tf: "ROS2TerraformTemplate", tf_res_type, name_prefix, arguments=None):
    tf_res_type = tf_res_type
    pseudo_res = ros2tf.data_for_pseudo_param
    if tf_res_type not in pseudo_res:
        tf_name = f"{name_prefix}_for_pseudo_parameter_{uuid.uuid4().hex[:8]}"
        pseudo_res[tf_res_type] = tf.Data(tf_name, tf_res_type, arguments)
    else:
        tf_name = pseudo_res[tf_res_type].name
    return tf_name

def account_id_(ros2tf: "ROS2TerraformTemplate", __):
    tf_name = _data_for_pseudo_param(ros2tf, "alicloud_caller_identity", "caller_identity")
    return tf.LiteralType(f"data.alicloud_caller_identity.{tf_name}.account_id")

def tenant_id_(ros2tf: "ROS2TerraformTemplate", __):
    tf_name = _data_for_pseudo_param(ros2tf, "alicloud_caller_identity", "caller_identity")
    return tf.LiteralType(f"data.alicloud_caller_identity.{tf_name}.id")

def resource_group_id_(ros2tf: "ROS2TerraformTemplate", __):
    tf_res_type = "alicloud_resource_manager_resource_groups"
    tf_name = _data_for_pseudo_param(ros2tf, tf_res_type, "resource_group_id", {"name_regex": "default"})
    return tf.LiteralType(f"data.{tf_res_type}.{tf_name}.ids[0]")

def region_(ros2tf: "ROS2TerraformTemplate", __):
    if ros2tf.tf_region_parameter is None:
        tf_var_name = f"region_{uuid.uuid4().hex[:8]}"
        args = {
            "default": "cn-hangzhou",
            "description": tf.LiteralType("Used to replace ALIYUN::Region")
        }
        ros2tf.tf_region_parameter = tf.Variable(tf_var_name, args)
    else:
        tf_var_name = ros2tf.tf_region_parameter.name
    return tf.LiteralType(f"var.{tf_var_name}")


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

def handle_one_line_list(_, args: Any):
    if not isinstance(args, list):
        args = [args]
    return tf.ListOneLineType(args)

def handle_base64_encode(_, args: Any):
    if isinstance(args, tf.TerraformType):
        args = args.value
    return tf.LiteralType(f"base64encode({repr(args)[1:-1]})")

def handle_required_string(_, __):
    return tf.QuotedString(f"auto-{uuid.uuid4().hex[:8]}")



ALL_FUNCTIONS = {
    "Ref": ref,
    "Fn::GetAtt": get_att,
    "Fn::Equals": equals,
    "Fn::And": and_,
    "Fn::Or": or_,
    "Fn::If": if_,
    "Fn::Not": not_,
    "ALIYUN::Index": index_,
    "ALIYUN::StackId": stack_id_,
    "ALIYUN::StackName": stack_id_,
    "ALIYUN::NoValue": no_value_,
    "ALIYUN::AccountId": account_id_,
    "ALIYUN::TenantId": tenant_id_,
    "ALIYUN::Region": region_,
    "ALIYUN::ResourceGroupId": resource_group_id_,
    "Fn::Sub": sub_,
    "Fn::Select": select_,
    "Fn::Jq": jq_
}
