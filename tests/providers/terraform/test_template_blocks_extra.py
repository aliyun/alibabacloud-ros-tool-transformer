import pytest

from rostran.providers.terraform import template_blocks as tf


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        ("x", tf.QuotedString),
        (True, tf.BooleanType),
        (2, tf.NumberType),
        (None, tf.NullType),
        ([1], tf.JsonType),
        ({"a": 1}, tf.JsonType),
    ],
)
def test_automatic_type_conversion(value, expected):
    result = tf.convert_to_tf_type(value)
    assert isinstance(result, expected)
    assert tf.convert_to_tf_type(result) is result


@pytest.mark.parametrize(
    ("name", "expected"),
    [
        ("string", tf.QuotedString),
        ("number", tf.NumberType),
        ("boolean", tf.BooleanType),
        ("null", tf.NullType),
        ("json", tf.JsonType),
        ("dict", tf.JsonType),
        ("list", tf.JsonType),
        ("list_one_line", tf.ListOneLineType),
        ("comment", tf.CommentType),
        ("unknown", tf.LiteralType),
    ],
)
def test_explicit_type_conversion(name, expected):
    assert isinstance(tf.convert_to_tf_type([], name), expected)


def test_normalize_nested_values_and_preserve_plain_values():
    value = tf.JsonType(
        {"a": [tf.NumberType(1), tf.JsonType({"b": tf.BooleanType(True)})]}
    )
    assert tf.normalize_value(value) == {"a": [1, {"b": True}]}


def test_quoted_string_escapes_quotes_and_newlines():
    assert tf.QuotedString('a "quote"\nline').render() == '"a \\"quote\\"\\nline"'
    assert tf.QuotedString(5).render() == '"5"'


def test_nested_json_and_empty_json_rendering():
    assert tf.JsonType({}).render() == "{}"
    assert tf.JsonType([tf.NumberType(1), tf.NumberType(2)]).render() == "[1, 2]"
    assert tf.JsonType([tf.JsonType({"a": tf.NumberType(1)}), "other"]).render() == (
        "[\n  {\n    a = 1\n  },\n  other\n]"
    )
    assert tf.JsonType({"a": tf.NumberType(1), "b": "literal"}).render() == (
        "{\n  a = 1\n  b = literal\n}"
    )


def test_comments_and_one_line_list_rendering():
    assert tf.CommentType("first\nsecond ").render(2) == "  // first\n  // second"
    assert tf.ListOneLineType([tf.QuotedString("a"), 2]).render() == '["a", 2]'


def test_resource_orders_count_comments_values_json_and_blocks():
    resource = tf.Resource(
        "vpc",
        "alicloud_vpc",
        {
            "nested": tf.Block("nested", arguments={"v": tf.NumberType(1)}),
            "tags": tf.JsonType({"env": tf.QuotedString("dev")}),
            "name": tf.QuotedString("example"),
            "note": tf.CommentType("comment"),
            "count": tf.NumberType(2),
        },
    )
    rendered = resource.render()
    assert rendered.index("count = 2") < rendered.index("// comment")
    assert rendered.index("// comment") < rendered.index('name = "example"')
    assert rendered.index('name = "example"') < rendered.index("tags = {")
    assert rendered.index("tags = {") < rendered.index("nested {")
    assert "alicloud_vpc" in str(resource)


def test_json_rendering_with_plain_values_and_nested_collections():
    assert not tf.JsonType({})._is_simple_list()
    assert not tf.JsonType([{}])._is_simple_list()
    assert not tf.JsonType([[]])._is_simple_list()
    assert tf.JsonType(["plain", tf.NumberType(1)]).render() == "[plain, 1]"
    assert tf.JsonType("literal").render() == "literal"
    marker = object()
    assert tf.convert_to_tf_type(marker).value is marker
