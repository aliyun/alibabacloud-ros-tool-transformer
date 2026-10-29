from types import SimpleNamespace

import pytest

from rostran.providers.ros import functions as fn
from rostran.providers.terraform import template_blocks as tf


def context(rule=None):
    return SimpleNamespace(
        parameters={"Input": {}},
        resources={"Server": {"Type": "ALIYUN::ECS::Instance"}},
        resources_with_count=set(),
        get_tf_params=lambda name: name,
        get_resource_rule=lambda resource_type: rule,
        resolve_values=lambda value: tf.convert_to_tf_type(value),
        data_for_pseudo_param={},
        image_data_sources={},
    )


def test_resolve_nested_functions_and_plain_values():
    ctx = context()
    result = fn.resolve(ctx, {"values": [{"Ref": "Input"}, {"other": [1, 2]}]})
    assert result["values"][0].value == "var.input"
    assert result["values"][1] == {"other": [1, 2]}


def test_ref_and_get_att_with_missing_and_counted_resources():
    ctx = context()
    assert fn.ref(ctx, "Input").value == "var.input"
    assert fn.ref(ctx, "Other").value == '"Other"'
    assert isinstance(fn.ref(ctx, "Server"), tf.CommentType)
    assert isinstance(fn.get_att(ctx, ["Server", "Address"]), tf.CommentType)
    rule = SimpleNamespace(
        target_resource_type="alicloud_instance",
        attributes={"Address": {"To": "private_ip"}},
    )
    ctx = context(rule)
    assert fn.ref(ctx, "Server").value == "alicloud_instance.server.id"
    assert (
        fn.get_att(ctx, ["Server", "Address"]).value
        == "alicloud_instance.server.private_ip"
    )
    rule.attributes["Address$$0"] = {"To": "new_ip"}
    assert fn.get_att(ctx, ["Server", "Address"]).value.endswith(".new_ip")
    ctx.resources_with_count.add("Server")
    assert "[*].id" in fn.ref(ctx, "Server").value
    assert "[*].new_ip" in fn.get_att(ctx, ["Server", "Address"]).value
    assert isinstance(fn.get_att(ctx, ["Server", "Unknown"]), tf.CommentType)


@pytest.mark.parametrize(
    ("value", "expected_type"),
    [
        ("s", tf.QuotedString),
        (True, tf.BooleanType),
        (3, tf.NumberType),
        (None, tf.NullType),
        ([1], tf.JsonType),
        ({"a": 1}, tf.JsonType),
    ],
)
def test_convert_value_for_func(value, expected_type):
    result = fn.convert_value_for_func(value)
    assert isinstance(result, expected_type)
    assert fn.convert_value_for_func(result) is result


def test_convert_nested_values_and_unknown_object():
    result = fn.convert_value_for_func({"key": [True, 2]}, ignore_map_key=True)
    assert list(result.value) == ["key"]
    assert [item.value for item in result.value["key"].value] == [True, 2]
    marker = object()
    assert fn.convert_value_for_func(marker).value is marker


def test_select_and_jq_support_and_reject_inputs():
    assert fn.select_(None, ["key", {"key": "value"}]).value == "value"
    assert fn.select_(None, ["missing", {}, "fallback"]).value == "fallback"
    assert fn.select_(None, [1, "items"]).value == "items[1]"
    assert fn.select_(None, ["bad", "items"]).value == ["bad", "items"]
    assert fn.select_(None, [1]).value == [1]
    assert fn.jq_(None, ["First", ".[0].id", "items"]).value == "items[0].id"
    args = ["First", ".a | .b", "items"]
    assert fn.jq_(None, args).value == args
    args = ["All", ".a", "items"]
    assert fn.jq_(None, args).value == args


def test_image_id_passthrough_and_cached_lookup():
    ctx = context()
    reference = tf.LiteralType("var.image")
    assert fn.handle_image_id(ctx, reference) is reference
    assert fn.handle_image_id(ctx, "m-123").value == "m-123"
    first = fn.handle_image_id(ctx, "ubuntu")
    second = fn.handle_image_id(ctx, tf.QuotedString("ubuntu"))
    assert first.value == second.value
    assert len(ctx.data_for_pseudo_param) == 1
    data = next(iter(ctx.data_for_pseudo_param.values()))
    assert data.arguments["name_regex"].value == "*ubuntu*"


def test_tag_and_dictionary_handlers():
    ctx = context()
    tags = fn.handle_tags(ctx, [{"Key": "team", "Value": "ops"}, {}, "bad"])
    assert tags.value["team"].value == "ops"
    assert fn.handle_dict_value(ctx, {"k": "v"}, "k").value == "v"
    assert fn.handle_dict_value(ctx, {"k": "v"}, "missing") is None
    assert fn.handle_dict_value(ctx, tf.JsonType({"k": 2}), "k").value == 2
    assert fn.handle_dict_value(ctx, tf.JsonType({}), "missing") is None


def test_list_and_value_handlers():
    reference = tf.LiteralType("var.tags")
    assert fn.handle_tags(None, reference) is reference
    assert fn.select_first(None, reference) is reference
    assert fn.select_first(None, tf.JsonType([tf.NumberType(1)])).value == 1
    assert fn.select_first(None, ["a", "b"]).value == "a"
    assert fn.select_first(None, []) == []
    assert fn.handle_to_list(None, reference).value == [reference]
    wrapped = tf.JsonType([1, 2])
    assert fn.handle_to_list(None, wrapped) is wrapped
    assert fn.handle_to_list(None, "one").value[0].value == "one"
    assert fn.handle_lower(None, tf.QuotedString("ABC")).value == "abc"
    assert fn.handle_lower(None, 3).value == 3


@pytest.mark.parametrize(
    ("charge", "expected"),
    [("Subscription", "PrePaid"), ("PostPaid", "PostPaid"), ("custom", "custom")],
)
def test_instance_charge_types(charge, expected):
    assert fn.handle_instance_charge_type(None, charge).value == expected


def test_payment_type_and_reference_are_preserved():
    reference = tf.LiteralType("var.pay_type")
    assert fn.handle_pay_type(None, reference, "on-demand", "subscription") is reference
    assert (
        fn.handle_pay_type(None, "PrePaid", "on-demand", "subscription").value
        == "subscription"
    )
    assert (
        fn.handle_pay_type(None, "anything", "on-demand", "subscription").value
        == "on-demand"
    )
    assert fn.handle_instance_charge_type(None, reference) is reference


def test_substitution_resolves_parameters_mappings_and_missing_attributes():
    ctx = context()
    result = fn.sub_(ctx, ["Hello ${Input} ${Name}", {"Name": "world"}])
    assert result.value.value == 'Hello ${var.input} "world"'
    assert isinstance(fn.sub_(ctx, "${Server.Address}"), tf.CommentType)


@pytest.mark.parametrize(
    ("function", "arguments", "expected"),
    [
        (fn.join_, [",", ["a", "b"]], 'join(",", ["a", "b"])'),
        (fn.split_, [",", "a,b"], 'split(",", "a,b")'),
        (fn.indent_, ["text", 2, 3], 'indent(6, "text")'),
        (fn.match_pattern, ["hello", "h.*"], 'can(regex("h.*", "hello"))'),
        (fn.cidr, ["10.0.0.0/8", 2, 4], 'cidrsubnets("10.0.0.0/8", 4, 2)'),
    ],
)
def test_intrinsic_function_rendering(function, arguments, expected):
    assert function(None, arguments).value == expected


@pytest.mark.parametrize(
    "function", [fn.join_, fn.split_, fn.index_fn, fn.match_pattern, fn.cidr]
)
def test_intrinsic_functions_preserve_invalid_arity(function):
    assert function(None, ["only-one"]).value == ["only-one"]


def test_pseudo_parameters_create_and_reuse_data_sources():
    ctx = context()
    ctx.uid = "stack-uid"
    assert fn.ref(ctx, "ALIYUN::StackId") == "stack-uid"
    assert fn.index_(ctx, None).value == "count.index"
    assert fn.no_value_(ctx, None).value == "null"
    account = fn.account_id_(ctx, None).value
    tenant = fn.tenant_id_(ctx, None).value
    assert account.replace(".account_id", ".id") == tenant
    assert fn.region_(ctx, None).value.startswith("data.alicloud_regions.")
    assert fn.resource_group_id_(ctx, None).value.startswith(
        "data.alicloud_resource_manager_resource_groups."
    )
    assert len(ctx.data_for_pseudo_param) == 3


@pytest.mark.parametrize(
    ("function", "args", "expected"),
    [
        (fn.equals, [1, 2], "1 == 2"),
        (fn.and_, [True, False], "alltrue([true, false])"),
        (fn.or_, [True, False], "anytrue([true, false])"),
        (fn.if_, ["enabled", "yes", "no"], 'local.enabled ? "yes" : "no"'),
        (fn.not_, True, "!true"),
        (fn.any_fn, [True, False], "anytrue([true, false])"),
        (fn.max_fn, [1, 2], "max([1, 2]...)"),
        (fn.min_fn, [1, 2], "min([1, 2]...)"),
        (fn.length_, [1, 2], "length([1, 2])"),
        (fn.format_time, "%Y-%m-%d", 'formatdate("YYYY-MM-DD", timestamp())'),
    ],
)
def test_expression_conversions(function, args, expected):
    assert function(None, args).value == expected


@pytest.mark.parametrize("value", [True, None, tf.LiteralType("var.x")])
def test_add_rejects_unsupported_operand_types(value):
    assert isinstance(fn.add_(None, [value]), tf.CommentType)


def test_add_converts_strings_numbers_lists_and_passthrough():
    assert fn.add_(None, ["a", "b"]).value == 'join("", ["a", "b"])'
    assert fn.add_(None, [1, 2]).value == "1+ 2"
    assert fn.add_(None, [[1], [2]]).value == "concat([1], [2])"
    assert fn.add_(None, "invalid").value == "invalid"


def test_select_with_terraform_values_and_unsupported_functions():
    literal = tf.LiteralType("var.example")
    assert fn.select_(None, ["key", {"key": literal}]) is literal
    assert fn.select_(None, [0, tf.LiteralType("var.items")]).value == "var.items[0]"
    assert fn.jq_(None, ["First", ".name", literal]).value == "var.example.name"
    assert isinstance(fn.calculate(None, []), tf.CommentType)
    assert isinstance(fn.merge_map_to_list(None, []), tf.CommentType)
    assert isinstance(fn.select_map_list(None, []), tf.CommentType)
    assert isinstance(fn.get_stack_output(None, []), tf.CommentType)


def test_base64_encoding_and_decoding_use_matching_terraform_functions():
    assert fn.base64_encode(None, "hello").value == 'base64encode("hello")'
    assert fn.base64_decode(None, "aGVsbG8=").value == 'base64decode("aGVsbG8=")'
    reference = tf.LiteralType("var.input")
    assert fn.base64_encode(None, reference).value == "base64encode(var.input)"
    assert fn.base64_decode(None, reference).value == "base64decode(var.input)"


def test_lookup_string_and_list_intrinsic_functions():
    ctx = context()
    ctx.mappings_name_in_local = "mappings"
    assert (
        fn.find_in_map(ctx, ["Map", "A", "B"]).value
        == 'local.mappings["Map"]["A"]["B"]'
    )
    ctx.mappings_name_in_local = None
    assert fn.find_in_map(ctx, ["Map", "A", "B"]).value == ["Map", "A", "B"]
    assert fn.str_(None, 42).value == "tostring(42)"
    assert fn.indent_(None, ["text", 2]).value == 'indent(4, "text")'
    assert fn.indent_(None, ["text"]).value == ["text"]
    assert fn.indent_(None, ["text", "invalid"]).value == ["text", "invalid"]
    assert fn.replace_(None, [{"a": "b"}, "cat"]).value == 'replace("cat", "a", "b")'
    assert fn.replace_(None, ["invalid"]).value == ["invalid"]
    assert fn.index_fn(None, ["a", ["a", "b"]]).value == 'index(["a", "b"], "a")'
    assert fn.list_merge(None, [[1], [2]]).value == "concat([1], [2])"
    assert fn.list_merge(None, "invalid").value == "invalid"
    assert fn.get_json_value(None, ["key", "{}"]).value == 'jsondecode("{}")["key"]'
    assert fn.get_json_value(None, ["invalid"]).value == ["invalid"]
    assert fn.avg_(None, ["ignored", [1, 2]]).value == "sum([1, 2]) / length([1, 2])"
    assert fn.avg_(None, []).value == []


def test_membership_and_format_time_intrinsics():
    assert fn.contains(None, [[1, 2], 2]).value == "contains([1, 2], 2)"
    assert (
        fn.each_member_in(None, [[1], [1, 2]]).value
        == "length(setsubtract([1], [1, 2])) == 0"
    )
    assert fn.each_member_in(None, [1]).value == [1]
    assert fn.format_time(None, []).value == []
    assert fn.format_time(None, ["%Y"]).value == 'formatdate("YYYY", timestamp())'
    assert isinstance(fn.marketplace_image(None, "image"), tf.CommentType)
    assert fn._is_image_id_literal(42) is False


def test_property_handlers_preserve_references_and_normalize_values():
    ctx = context()
    reference = tf.LiteralType("var.value")
    assert fn.handle_lower(ctx, reference) is reference
    assert fn.handle_dict_value(ctx, reference, "key") is reference
    inner = tf.NumberType(2)
    assert fn.handle_dict_value(ctx, tf.JsonType({"key": inner}), "key") is inner
    assert fn.handle_dict_value(ctx, tf.JsonType([]), "key") is None
    assert fn.handle_tags(ctx, {"key": "value"}).value == {"key": "value"}
    assert fn.select_first(ctx, tf.JsonType([])).value == []
    assert fn.handle_to_list(ctx, tf.JsonType({"key": "value"})).value[0].value == {
        "key": "value"
    }
    assert [item.value for item in fn.handle_to_list(ctx, [1, 2]).value] == [1, 2]
    assert (
        fn.handle_pay_type(
            ctx, tf.QuotedString("PrePaid"), "payg", "subscription"
        ).value
        == "subscription"
    )
    assert (
        fn.handle_instance_charge_type(ctx, tf.QuotedString("PostPaid")).value
        == "PostPaid"
    )


def test_add_maps_and_nonstring_image_lookup():
    assert fn.add_(None, [{"a": 1}, {"b": 2}]).value.startswith("merge(")
    ctx = context()
    lookup = fn.handle_image_id(ctx, tf.NumberType(42))
    assert lookup.value.startswith("data.alicloud_images.")
    assert fn.get_azs(ctx, None).value.startswith("data.alicloud_zones.")
