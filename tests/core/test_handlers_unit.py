import pytest

from rostran.core.properties import Properties
from rostran.core.resources import Resource, Resources
from rostran.handlers import basic, merge, resource as handler


def test_tag_conversion_and_scalar_handlers():
    assert basic.tags_dict_to_list({"team": "ops"}, True) == [
        {"Key": "team", "Value": "ops"}
    ]
    assert basic.tags_dict_to_list({"Ref": "Tags"}, False)["Fn::Jq"][0] == "First"
    assert basic.tags_list_to_dict([{"Key": "team", "Value": "ops"}], True) == [
        {"team": "ops"}
    ]
    assert "Fn::Jq" in basic.tags_list_to_dict({"Ref": "Tags"}, False)
    assert basic.tags_dict_to_list({}) is None
    assert basic.tags_list_to_dict([]) is None
    assert basic.json_load('{"x": 1}', True) == {"x": 1}
    assert basic.json_load("{}", False) is None
    assert basic.to_boolean(1, True) is True
    assert basic.to_boolean(None, True) is None
    assert basic.to_int("12", True) == 12
    assert basic.to_int("bad", True) == "bad"
    assert basic.to_int("12", False) is None


def test_list_handlers_support_literals_and_expressions():
    assert basic.select_first(["a", "b"], True) == "a"
    assert basic.select_first({"Ref": "List"}, False) == {
        "Fn::Select": ["0", {"Ref": "List"}]
    }
    assert basic.select_first([], True) is None
    assert basic.colon_join(["a", "b"], True) == "a:b"
    assert basic.slash_join({"Ref": "Items"}, False) == {
        "Fn::Join": ["/", {"Ref": "Items"}]
    }
    assert basic.comma_join([], True) is None
    assert basic.replace_slash_to_colon("a/b", True) == "a:b"
    assert "Fn::Replace" in basic.replace_slash_to_colon({"Ref": "Value"}, False)
    assert basic.replace_slash_to_colon("", True) is None
    assert basic.kv_list_to_map([{"key": "a", "value": 1}], "key", "value") == {"a": 1}
    assert basic.kv_list_to_map([], "key", "value") is None
    assert basic.ros_parameters(
        [{"parameter_key": "a", "parameter_value": "b"}], True
    ) == {"a": "b"}
    assert basic.ros_parameters([{}], False) is None


def test_product_handlers_filter_unsupported_values():
    assert basic.slb_x_forwarded_for([{"retrive_slb_ip": True}], True) == {
        "XForwardedFor_SLBIP": "on",
        "XForwardedFor": "on",
    }
    assert basic.slb_x_forwarded_for("invalid", True) is None
    assert basic.slb_x_forwarded_for({}, True) is None
    assert basic.ots_search_index_sorters(
        [
            {"sorter_type": "FieldSort", "field_name": "id", "order": "asc"},
            {"sorter_type": "Unsupported"},
            {},
        ],
        True,
    ) == [{"FieldSort": {"FieldName": "id", "SortOrder": "asc"}}]
    assert basic.ec2_network_interface_ipv6_addresses(
        [{"Ipv6Address": "::1"}], True
    ) == ["::1"]
    assert basic.ec2_network_interface_private_addresses(
        [{"PrivateIpAddress": "10.0.0.1"}], True
    ) == ["10.0.0.1"]
    assert basic.ec2_network_interface_private_addresses([], True) is None


@pytest.mark.parametrize(
    ("value", "expected"),
    [
        ({"Ref": "Vpc"}, "Vpc"),
        ({"Fn::GetAtt": ["Vpc", "VpcId"]}, "Vpc"),
        ({"Fn::GetAtt": "bad"}, None),
        ({"Fn::GetAtt": ["Vpc"]}, None),
        ({"Fn::GetAtt": [1, "Id"]}, None),
        ("literal", None),
    ],
)
def test_resource_reference_validation(value, expected):
    assert handler.get_ref_id("VpcId", value, "not a reference") == expected


def test_gateway_attachment_and_nat_gateway_split():
    gateway = Resource(resource_id="Gateway", resource_type="ALIYUN::VPC::NatGateway")
    resources = Resources()
    resources.add(gateway)
    attachment = Resource(
        resource_id="Attachment",
        resource_type="AWS::EC2::VPCGatewayAttachment",
        properties=Properties.initialize(
            {"VpcId": {"Ref": "Vpc"}, "InternetGatewayId": {"Ref": "Gateway"}}
        ),
    )
    handler.merge_vpc_gateway_attachment_to_gateway(attachment, resources)
    assert gateway.properties["VpcId"].value == {"Ref": "Vpc"}
    nat = Resource(
        resource_id="Nat",
        resource_type="ALIYUN::VPC::NatGateway",
        properties=Properties.initialize({"AllocationId": "eip"}),
    )
    handler.split_nat_gateway(nat, resources)
    assert resources["NatEIPAssociation"].properties["AllocationId"].value == "eip"


def test_merge_handlers_keep_expression_and_literal_order():
    assert merge.insert_str("a", "b", True) == "a/b"
    assert merge.append_str("a", "b", True) == "b/a"
    assert merge.insert_str("a", "b", False) == {"Fn::Join": ["/", ["a", "b"]]}
    assert merge.append_str("a", None, False) == "a"


def test_vpn_attachment_and_unmatched_gateway_types(capsys):
    vpn = Resource(resource_id="Vpn", resource_type="ALIYUN::VPC::VpnGateway")
    resources = Resources()
    resources.add(vpn)
    attachment = Resource(
        resource_id="Attachment",
        resource_type="AWS::EC2::VPCGatewayAttachment",
        properties=Properties.initialize(
            {"VpcId": {"Ref": "Vpc"}, "VpnGatewayId": {"Fn::GetAtt": ["Vpn", "Id"]}}
        ),
    )
    handler.merge_vpc_gateway_attachment_to_gateway(attachment, resources)
    assert vpn.properties["VpcId"].value == {"Ref": "Vpc"}
    vpn.type = "other"
    handler.merge_vpc_gateway_attachment_to_gateway(attachment, resources)
    assert "other than EC2::VpnGateway" in capsys.readouterr().out
    empty = Resource(resource_id="Empty", resource_type="type")
    handler.merge_vpc_gateway_attachment_to_gateway(empty, resources)
    handler.split_nat_gateway(empty, resources)
    assert "missing VpcId" in capsys.readouterr().out


def test_gateway_attachment_rejects_wrong_internet_gateway_type(capsys):
    wrong = Resource(resource_id="Gateway", resource_type="other")
    resources = Resources()
    resources.add(wrong)
    attachment = Resource(
        resource_id="Attachment",
        resource_type="type",
        properties=Properties.initialize(
            {
                "VpcId": {"Ref": "Vpc"},
                "InternetGatewayId": {"Ref": "Gateway"},
            }
        ),
    )
    handler.merge_vpc_gateway_attachment_to_gateway(attachment, resources)
    assert "other than EC2::InternetGateway" in capsys.readouterr().out
