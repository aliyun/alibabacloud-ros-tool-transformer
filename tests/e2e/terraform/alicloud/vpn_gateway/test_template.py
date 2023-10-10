import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc.foo": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.16.0.0/12",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vpn_gateway.foo": {
            "Type": "ALIYUN::VPC::VpnGateway",
            "Properties": {
                "Bandwidth": 10,
                "Description": "test_create_description",
                "EnableSsl": True,
                "InstanceChargeType": "PrePaid",
                "Name": "terraform-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.foo", "VpcId"]},
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.foo", "VSwitchId"]},
            },
        },
        "alicloud_vswitch.foo": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/21",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.foo", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
