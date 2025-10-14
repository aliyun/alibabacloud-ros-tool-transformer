import re
import uuid
from typing import TYPE_CHECKING, Any, Union

from rostran.providers.terraform import template_blocks as tf
from tools.utils import camel_to_tf

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


def convert_value_for_func(value, ignore_map_key=False):
    if isinstance(value, tf.TerraformType):
        return value
    elif isinstance(value, str):
        return tf.QuotedString(value)
    elif isinstance(value, bool):
        return tf.BooleanType(value)
    elif isinstance(value, (int, float)):
        return tf.NumberType(value)
    elif value is None:
        return tf.NullType()
    elif isinstance(value, list):
        values = [convert_value_for_func(v) for v in value]
        return tf.JsonType(values)
    elif isinstance(value, dict):
        if ignore_map_key:
            values = {k: convert_value_for_func(v, ignore_map_key=True) for k, v in value.items()}
        else:
            values = {convert_value_for_func(k): convert_value_for_func(v) for k, v in value.items()}
        return tf.JsonType(values)
    return tf.LiteralType(value)


def ref(ros2tf: "ROS2TerraformTemplate", args: str):
    if args.startswith("ALIYUN::") and args in ALL_FUNCTIONS:
        return ALL_FUNCTIONS[args](ros2tf, args)

    tf_value = ros2tf.get_tf_params(camel_to_tf(args))
    if args in ros2tf.parameters:
        return tf.LiteralType(f"var.{tf_value}")
    elif args in ros2tf.resources:
        resource = ros2tf.resources[args]
        resource_rule = ros2tf.get_resource_rule(resource.get("Type"))
        if resource_rule is None:
            return tf.CommentType(f"Could not find resource rule for {resource.get('Type')}. Args: {args}")
        tf_res_type = resource_rule.target_resource_type
        if args in ros2tf.resources_with_count:
            tf_item = f"{tf_res_type}.{tf_value}[*].id"
            return tf.LiteralType(f"length({tf_item}) > 0 ? {tf_item} : {tf.NullType()}")
        return tf.LiteralType(f'{tf_res_type}.{tf_value}.id')
    return tf.LiteralType(f'"{args}"')


def get_att(ros2tf: "ROS2TerraformTemplate", args: list):
    res_name, att_name = args
    tf_res_name = camel_to_tf(res_name)
    resource = ros2tf.resources[res_name]
    resource_rule = ros2tf.get_resource_rule(resource.get("Type"))
    msg = f"Could not transform ROS attribute {res_name}.{att_name} to Terraform attribute. Args: {args}"

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


def equals(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    tf_args = convert_value_for_func(tf_args).value
    return tf.LiteralType(f"{tf_args[0]} == {tf_args[1]}")


def and_(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    tf_args = convert_value_for_func(tf_args)
    return tf.LiteralType(f"alltrue({tf_args})")


def or_(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    tf_args = convert_value_for_func(tf_args)
    return tf.LiteralType(f"anytrue({tf_args})")


def if_(ros2tf: "ROS2TerraformTemplate", args: list):
    args = convert_value_for_func(args).value
    return tf.LiteralType(f"local.{args[0].value} ? {args[1]} : {args[2]}")


def not_(ros2tf: "ROS2TerraformTemplate", args: str):
    args = convert_value_for_func(args)
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
            map_v = convert_value_for_func(sub_mapping[k])
        elif "." in k:
            map_v = get_att(ros2tf, k.rsplit(".", 1))
        else:
            map_v = ref(ros2tf, k)
        if isinstance(map_v, tf.CommentType):
            return map_v
        mapping[k] = map_v

    def replacer(match):
        key = match.group(1)
        value = mapping.get(key, match.group(0))
        if isinstance(value, tf.LiteralType):
            value = value.ref_render()
        elif not isinstance(value, str):
            value = str(value)
        return value

    result = pattern.sub(replacer, sub_string)
    return tf.LiteralType(convert_value_for_func(result))


def select_(ros2tf: "ROS2TerraformTemplate", args: list):
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


def jq_(ros2tf: "ROS2TerraformTemplate", args: list):
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


def index_(ros2tf: "ROS2TerraformTemplate", args):
    return tf.LiteralType(f"count.index")


def stack_id_(ros2tf: "ROS2TerraformTemplate", args):
    return ros2tf.uid


def no_value_(ros2tf: "ROS2TerraformTemplate", args):
    return tf.NullType()


def _data_for_pseudo_param(ros2tf: "ROS2TerraformTemplate", tf_res_type, name_prefix, arguments=None):
    pseudo_res = ros2tf.data_for_pseudo_param
    if tf_res_type not in pseudo_res:
        tf_name = f"{name_prefix}_for_pseudo_parameter_{uuid.uuid4().hex[:8]}"
        pseudo_res[tf_res_type] = tf.Data(tf_name, tf_res_type, arguments)
    else:
        tf_name = pseudo_res[tf_res_type].name
    return tf_name

def account_id_(ros2tf: "ROS2TerraformTemplate", args):
    tf_name = _data_for_pseudo_param(ros2tf, "alicloud_caller_identity", "caller_identity")
    return tf.LiteralType(f"data.alicloud_caller_identity.{tf_name}.account_id")


def tenant_id_(ros2tf: "ROS2TerraformTemplate", args):
    tf_name = _data_for_pseudo_param(ros2tf, "alicloud_caller_identity", "caller_identity")
    return tf.LiteralType(f"data.alicloud_caller_identity.{tf_name}.id")


def resource_group_id_(ros2tf: "ROS2TerraformTemplate", args):
    tf_res_type = "alicloud_resource_manager_resource_groups"
    tf_name = _data_for_pseudo_param(ros2tf, tf_res_type, "resource_group_id",
                                     {"name_regex": tf.QuotedString("default")})
    return tf.LiteralType(f"data.{tf_res_type}.{tf_name}.ids[0]")


def region_(ros2tf: "ROS2TerraformTemplate", args):
    tf_res_type = "alicloud_regions"
    tf_name = _data_for_pseudo_param(ros2tf, tf_res_type, "current_region",
                                     {"current": tf.BooleanType(True)})
    return tf.LiteralType(f"data.{tf_res_type}.{tf_name}.ids[0]")


def handle_tags(ros2tf: "ROS2TerraformTemplate", args: Any, tag_key="Key", tag_value="Value"):
    if isinstance(args, tf.LiteralType):
        return args
    if isinstance(args, tf.TerraformType):
        args = tf.normalize_value(args)
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
    return tf.JsonType(args)


def handle_one_line_list(ros2tf: "ROS2TerraformTemplate", args: Any):
    if not isinstance(args, list):
        args = [args]
    return tf.ListOneLineType(args)


POST_PAID = ['PayAsYouGo', 'PostPaid', 'PayOnDemand', 'Postpaid', 'PostPay', 'Postpay', 'POSTPAY', 'POST']
PRE_PAID = ['Subscription', 'PrePaid', 'Prepaid', 'PrePay', 'Prepay', 'PREPAY', 'PRE']


def handle_pay_type(ros2tf: "ROS2TerraformTemplate", args: str, pay_as_you_go, subscription):
    if isinstance(args, tf.LiteralType):
        return args
    if isinstance(args, tf.TerraformType):
        args = args.value
    if args in PRE_PAID:
        return tf.QuotedString(subscription)
    else:
        return tf.QuotedString(pay_as_you_go)


def handle_required_string(ros2tf: "ROS2TerraformTemplate", args):
    return tf.QuotedString(f"auto-{uuid.uuid4().hex[:8]}")


def base64_encode(ros2tf: "ROS2TerraformTemplate", args: str):
    if not isinstance(args, tf.TerraformType):
        args = tf.QuotedString(args)
    return tf.LiteralType(f"base64decode({args})")


def base64_decode(ros2tf: "ROS2TerraformTemplate", args: str):
    if not isinstance(args, tf.TerraformType):
        args = tf.QuotedString(args)
    return tf.LiteralType(f"base64decode({args})")


def str_(ros2tf: "ROS2TerraformTemplate", args: str):
    args = convert_value_for_func(args)
    return tf.LiteralType(f"tostring({args.render()})")


def indent_(ros2tf: "ROS2TerraformTemplate", args: Any):
    if len(args) == 3:
        string, level, size = args
    elif len(args) == 2:
        string, level = args
        size = 2
    else:
        return tf.LiteralType(args)

    if not isinstance(level, int) or not isinstance(size, int):
        return tf.LiteralType(args)
    string = convert_value_for_func(string)
    return tf.LiteralType(f"indent({level * size}, {string.render()})")


def find_in_map(ros2tf: "ROS2TerraformTemplate", args: list):
    if len(args) != 3 or not ros2tf.mappings_name_in_local:
        return tf.LiteralType(args)

    args = convert_value_for_func(args).value
    map_name, top_key, second_key = args
    return tf.LiteralType(f"local.{ros2tf.mappings_name_in_local}[{map_name}][{top_key}][{second_key}]")


def join_(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    delimiter, values = tf_args
    delimiter = convert_value_for_func(delimiter)
    values = convert_value_for_func(values)
    return tf.LiteralType(f"join({delimiter.render()}, {values.render()})")


def get_azs(ros2tf: "ROS2TerraformTemplate", _):
    tf_res_type = "alicloud_zones"
    tf_name = _data_for_pseudo_param(ros2tf, tf_res_type, "zones_ds")
    return tf.LiteralType(f"data.{tf_res_type}.{tf_name}.ids")


def replace_(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    replace_mapping, source_string = tf_args
    source_string = convert_value_for_func(source_string)
    result = source_string.render()
    for old_v, new_v in replace_mapping.items():
        old_v = convert_value_for_func(old_v)
        new_v = convert_value_for_func(new_v)
        result = f"replace({result}, {old_v.render()}, {new_v.render()})"
    return tf.LiteralType(result)


def split_(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    delimiter, source_str = tf_args

    delimiter = convert_value_for_func(delimiter)
    source_str = convert_value_for_func(source_str)
    return tf.LiteralType(f"split({delimiter.render()}, {source_str.render()})")


def index_fn(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    element, list_data = tf_args
    element = convert_value_for_func(element)
    list_data = convert_value_for_func(list_data)
    return tf.LiteralType(f"index({list_data}, {element})")


def length_(ros2tf: "ROS2TerraformTemplate", args: Any):
    args = convert_value_for_func(args)
    return tf.LiteralType(f"length({args})")


def list_merge(ros2tf: "ROS2TerraformTemplate", args: list):
    if not isinstance(args, list):
        return tf.LiteralType(args)

    args = convert_value_for_func(args).value
    arg_str = ', '.join([str(i) for i in args])
    return tf.LiteralType(f"concat({arg_str})")


def get_json_value(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    key, json_string = tf_args
    key = convert_value_for_func(key)
    json_string = convert_value_for_func(json_string)
    return tf.LiteralType(f"jsondecode({json_string})[{key}]")


def merge_map_to_list(ros2tf: "ROS2TerraformTemplate", args: list):
    return tf.CommentType(f"Terraform does not support Fn::MergeMapToList function. Args: {args}")


def avg_(ros2tf: "ROS2TerraformTemplate", args: list):
    if len(args) != 2:
        return tf.LiteralType(args)
    _, numbers =  args
    numbers = convert_value_for_func(numbers)
    return tf.LiteralType(f"sum({numbers}) / length({numbers})")


def select_map_list(ros2tf: "ROS2TerraformTemplate", args: Any):
    return tf.CommentType(f"Terraform does not support Fn::SelectMapList function. Args: {args}")


def add_(ros2tf: "ROS2TerraformTemplate", args: list):
    if not isinstance(args, list):
        return tf.LiteralType(args)

    args = convert_value_for_func(args).value
    type_ = None
    for arg in args:
        if isinstance(arg, tf.LiteralType):
            continue
        elif isinstance(arg, tf.QuotedString):
            type_ = "string"
            break
        elif isinstance(arg, tf.NumberType):
            type_ = "number"
            break
        elif isinstance(arg, tf.BooleanType):
            type_ = "boolean"
            break
        elif isinstance(arg, tf.NullType):
            type_ = "null"
            break
        elif isinstance(arg, tf.JsonType):
            arg = arg.value
            if isinstance(arg, list):
                type_ = "list"
                break
            elif isinstance(arg, dict):
                type_ = "map"
                break
        else:
            type_ = "unknown"

    if type_ == "list":
        arg_str = ', '.join([i.render() for i in args])
        return tf.LiteralType(f"concat({arg_str})")
    elif type_ == "map":
        arg_str = ', '.join([str(i) for i in args])
        return tf.LiteralType(f"merge({arg_str})")
    elif type_ == "string":
        arg_str = f"[{', '.join(i.render() for i in args)}]"
        return tf.LiteralType(f'join("", {arg_str})')
    elif type_ == "number":
        args_str = '+ '.join([str(i) for i in args])
        return tf.LiteralType(args_str)
    else:
        return tf.CommentType(f"Terraform does not support Fn::Add function. Args: {args}")


def calculate(ros2tf: "ROS2TerraformTemplate", args: Any):
    return tf.CommentType(f"Terraform does not support Fn::Calculate function. Args: {args}")


def max_fn(ros2tf: "ROS2TerraformTemplate", args: list):
    args = convert_value_for_func(args)
    return tf.LiteralType(f"max({args}...)")


def min_fn(ros2tf: "ROS2TerraformTemplate", args: list):
    args = convert_value_for_func(args)
    return tf.LiteralType(f"min({args}...)")


def get_stack_output(ros2tf: "ROS2TerraformTemplate", args: Any):
    return tf.CommentType(f"Terraform does not support Fn::GetStackOutput function. Args: {args}")


def format_time(ros2tf: "ROS2TerraformTemplate", args: Union[list, str]):
    if not args:
        return tf.LiteralType(args)
    if isinstance(args, str):
        args = [args]
    format_string = args[0]
    replace_map = {
        '%y': 'YY',
        '%Y': 'YYYY',
        '%m': 'MM',
        '%d': 'DD',
        '%H': 'hh',
        '%I': 'HH',
        '%M': 'mm',
        '%S': 'ss',
        '%a': 'EEE',
        '%A': 'EEEE',
        '%b': 'MMM',
        '%B': 'MMMM',
        '%c': 'DD MMM YYYY hh:mm ZZZ',
        '%p': 'AA',
        '%Z': 'ZZZ',
        '%z': 'ZZZZ'
    }
    if isinstance(format_string, str):
        for k, v in replace_map.items():
            format_string = format_string.replace(k, v)
    format_string = convert_value_for_func(format_string)
    return tf.LiteralType(f"formatdate({format_string}, timestamp())")


def marketplace_image(ros2tf: "ROS2TerraformTemplate", args: Any):
    return tf.CommentType(f"Terraform does not support Fn::GetStackOutput function. Args: {args}")


def any_fn(ros2tf: "ROS2TerraformTemplate", args: list):
    args = convert_value_for_func(args)
    return tf.LiteralType(f"anytrue({args})")


def contains(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    tf_args = convert_value_for_func(tf_args).value
    list_data, value = tf_args
    return tf.LiteralType(f"contains({list_data}, {value})")


def each_member_in(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    tf_args = convert_value_for_func(tf_args).value
    list1, list2 = tf_args
    return tf.LiteralType(f"length(setsubtract({list1}, {list2})) == 0")


def match_pattern(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 2:
        return tf.LiteralType(tf_args)

    tf_args = convert_value_for_func(tf_args).value
    input_string, pattern = tf_args
    return tf.LiteralType(f"can(regex({pattern}, {input_string}))")


def cidr(ros2tf: "ROS2TerraformTemplate", tf_args: list):
    if len(tf_args) != 3:
        return tf.LiteralType(tf_args)

    tf_args = convert_value_for_func(tf_args).value
    ip_block, count, cidr_bits = tf_args
    return tf.LiteralType(f"cidrsubnets({ip_block}, {cidr_bits}, {count})")

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
    "Fn::Jq": jq_,
    "Fn::Base64Encode": base64_encode,
    "Fn::Base64Decode": base64_decode,
    "Fn::Str": str_,
    "Fn::Indent": indent_,
    "Fn::FindInMap": find_in_map,
    "Fn::Join": join_,
    "Fn::GetAZs": get_azs,
    "Fn::Replace": replace_,
    "Fn::Split": split_,
    "Fn::Index": index_fn,
    "Fn::Length": length_,
    "Fn::ListMerge": list_merge,
    "Fn::GetJsonValue": get_json_value,
    "Fn::MergeMapToList": merge_map_to_list,
    "Fn::Avg": avg_,
    "Fn::SelectMapList": select_map_list,
    "Fn::Add": add_,
    "Fn::Calculate": calculate,
    "Fn::Max": max_fn,
    "Fn::Min": min_fn,
    "Fn::GetStackOutput": get_stack_output,
    "Fn::FormatTime": format_time,
    "Fn::MarketplaceImage": marketplace_image,
    "Fn::Any": any_fn,
    "Fn::Contains": contains,
    "Fn::EachMemberIn": each_member_in,
    "Fn::MatchPattern": match_pattern,
    "Fn::Cidr": cidr
}