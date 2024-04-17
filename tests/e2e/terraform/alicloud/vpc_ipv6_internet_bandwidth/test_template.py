import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.16.0.0/12",
                "EnableIpv6": True,
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vpc_ipv6_gateway.example": {
            "Type": "ALIYUN::VPC::Ipv6Gateway",
            "Properties": {"VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]}},
        },
        "alicloud_vpc_ipv6_internet_bandwidth.example": {
            "Type": "ALIYUN::VPC::Ipv6InternetBandwidth",
            "Properties": {
                "Bandwidth": 20,
                "InternetChargeType": "PayByBandwidth",
                "Ipv6AddressId": "ipv6_address_id",
                "Ipv6GatewayId": {
                    "Fn::GetAtt": ["alicloud_vpc_ipv6_gateway.example", "Ipv6GatewayId"]
                },
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
