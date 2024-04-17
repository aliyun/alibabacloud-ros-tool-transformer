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
                "Description": "terraform-example",
                "NetworkInterfaceName": "terraform-example",
                "PrimaryIpAddress": "172.17.3.100",
                "ResourceGroupId": "rg-acfm2xwmxvrzq6q",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_ecs_network_interface_permission.example": {
            "Type": "ALIYUN::ECS::NetworkInterfacePermission",
            "Properties": {
                "AccountId": "1754580903499898",
                "NetworkInterfaceId": {
                    "Fn::GetAtt": [
                        "alicloud_ecs_network_interface.default",
                        "NetworkInterfaceId",
                    ]
                },
                "Permission": "InstanceAttach",
            },
        },
        "alicloud_security_group.default": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "SecurityGroupName": "terraform-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.17.3.0/24",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.17.3.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
