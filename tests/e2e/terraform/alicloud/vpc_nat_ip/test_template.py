import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_nat_gateway.example": {
            "Type": "ALIYUN::ECS::NatGateway",
            "Properties": {
                "Description": "terraform-example",
                "InternetChargeType": "PayByLcu",
                "NatGatewayName": "terraform-example",
                "NatType": "Enhanced",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.example", "VSwitchId"]},
            },
        },
        "alicloud_vpc.example": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.16.0.0/12",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vpc_nat_ip.example": {
            "Type": "ALIYUN::VPC::NatIp",
            "Properties": {
                "NatGatewayId": {
                    "Fn::GetAtt": ["alicloud_nat_gateway.example", "NatGatewayId"]
                },
                "NatIp": "192.168.0.37",
                "NatIpCidr": "nat_ip_cidr_id",
                "NatIpDescription": "example_value",
                "NatIpName": "example_value",
            },
        },
        "alicloud_vswitch.example": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/21",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
