import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_nlb_load_balancer.default": {
            "Type": "ALIYUN::NLB::LoadBalancer",
            "Properties": {
                "AddressIpVersion": "Ipv4",
                "AddressType": "Internet",
                "DeletionProtectionConfig": {"Enabled": True, "Reason": "just protect"},
                "LoadBalancerName": "tf-example",
                "LoadBalancerType": "Network",
                "ModificationProtectionConfig": {
                    "Reason": "just protect",
                    "Status": "ConsoleProtection",
                },
                "ResourceGroupId": "rg-acfm2xwmxvrzq6q",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "ZoneMappings": [
                    {"ZoneId": "cn-beijing-h"},
                    {"ZoneId": "cn-beijing-l"},
                ],
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default1": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.1.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example_1",
                "ZoneId": "cn-beijing-h",
            },
        },
        "alicloud_vswitch.default2": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.2.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example_2",
                "ZoneId": "cn-beijing-l",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
