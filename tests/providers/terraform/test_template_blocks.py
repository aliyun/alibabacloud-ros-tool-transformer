import json
import textwrap

from rostran.providers.terraform.template_blocks import (
    QuotedString, NumberType, NullType, BooleanType, JsonType, CommentType, Block, Variable, Resource
)


def test_renders():
    a = QuotedString("a")
    b = NumberType(1.1)
    c = NullType()
    d = BooleanType(True)
    e = CommentType("comment")
    for item in [a, b, c, d, e]:
        ret = item.render()
        assert isinstance(ret, str)

    a2 = QuotedString("a2")
    a3 = QuotedString("a3")
    json_type1 = JsonType([a, a2, a3])
    assert json_type1.render() == json.dumps(["a", "a2", "a3"], indent=2)


def test_base_block():
    block = Block("locals")
    assert block.render() == "locals {}"

    block = Block("variable", (QuotedString("name"),))
    assert block.render() == 'variable "name" {}'

    block = Block(
        "resource",
        (QuotedString("alicloud_vpc"), QuotedString("vpc")),
        {"vpc_name": QuotedString("test-name")}
    )
    result = block.render()
    assert result == 'resource "alicloud_vpc" "vpc" {\n  vpc_name = "test-name"\n}'

    expect_block = """resource alicloud_instance instance {
  system_disk_category = "cloud_essd"
  data_disks {
    category = "cloud_essd"
  }
}"""

    nested_block = Block("data_disks", arguments={"category": QuotedString("cloud_essd")})
    block = Block(
        "resource",
        ("alicloud_instance", "instance"),
        {"system_disk_category": QuotedString("cloud_essd"), "data_disks": nested_block},
    )
    assert block.render() == expect_block


def test_blocks():
    var = Variable("test", {"type": "string"})
    assert var.render() == 'variable "test" {\n  type = string\n}'

    value = json.dumps({"a": "b", "c": "d"}, indent=2)
    value = textwrap.indent(value, "  ")
    desc = f"<<EOT\n{value}\n  EOT"
    var = Variable("test", {"type": "string", "description": desc})
    expect_var = """variable "test" {
  type = string
  description = <<EOT
  {
    "a": "b",
    "c": "d"
  }
  EOT
}"""
    assert var.render() == expect_var

    tags = Block("tags", arguments={"key1": QuotedString("value1"), "key2": QuotedString("value2")})
    props = {
        "cidr_block": QuotedString("192.168.0.0/16"),
        "tags": tags,
        "security_groups": JsonType({"key1": QuotedString("value1"), "key2": QuotedString("value2")})
    }

    res = Resource("my_demo_vpc", "alicloud_vpc", props)
    expect_res = """resource "alicloud_vpc" "my_demo_vpc" {
  cidr_block = "192.168.0.0/16"
  security_groups = {
    key1 = "value1"
    key2 = "value2"
  }
  tags {
    key1 = "value1"
    key2 = "value2"
  }
}"""
    assert res.render() == expect_res
