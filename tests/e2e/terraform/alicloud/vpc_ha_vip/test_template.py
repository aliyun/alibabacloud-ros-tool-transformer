import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc.defaultVpc": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "192.168.0.0/16",
                "Description": "tf-test-acc-vpc",
                "VpcName": "tf-testacc-example",
            },
        },
        "alicloud_vpc_ha_vip.default": {
            "Type": "ALIYUN::VPC::HaVip",
            "Properties": {
                "Description": "test",
                "Name": "tf-testacc-example",
                "IpAddress": "192.168.1.101",
                "VSwitchId": {
                    "Fn::GetAtt": ["alicloud_vswitch.defaultVswitch", "VSwitchId"]
                },
            },
        },
        "alicloud_vswitch.defaultVswitch": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "192.168.0.0/21",
                "Description": "tf-testacc-vswitch",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.defaultVpc", "VpcId"]},
                "VSwitchName": "tf-testacc-example1",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
