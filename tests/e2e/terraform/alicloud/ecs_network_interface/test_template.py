import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_network_interface.default": {
            "Type": "ALIYUN::ECS::NetworkInterface",
            "Properties": {
                "Description": "Basic test",
                "NetworkInterfaceName": "tf-testAcc",
                "PrimaryIpAddress": "192.168.0.2",
                "ResourceGroupId": "rg-acfm2xwmxvrzq6q",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "Test"},
                ],
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_security_group.default": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "SecurityGroupName": "tf-testAcc",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "192.168.0.0/24", "VpcName": "tf-testAcc"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "192.168.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-testAcc",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
