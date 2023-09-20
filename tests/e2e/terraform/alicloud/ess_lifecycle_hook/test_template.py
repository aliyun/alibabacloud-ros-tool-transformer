import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ess_lifecycle_hook.default": {
            "Type": "ALIYUN::ESS::LifecycleHook",
            "Properties": {
                "HeartbeatTimeout": 400,
                "LifecycleTransition": "SCALE_OUT",
                "LifecycleHookName": "terraform-example",
                "NotificationMetadata": "example",
                "ScalingGroupId": {
                    "Fn::GetAtt": [
                        "alicloud_ess_scaling_group.default",
                        "ScalingGroupId",
                    ]
                },
            },
        },
        "alicloud_ess_scaling_group.default": {
            "Type": "ALIYUN::ESS::ScalingGroup",
            "Properties": {
                "DefaultCooldown": 200,
                "MaxSize": 1,
                "MinSize": 1,
                "RemovalPolicys": ["OldestInstance", "NewestInstance"],
                "ScalingGroupName": "terraform-example",
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
                "CidrBlock": "172.16.0.0/16",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
        "alicloud_vswitch.default2": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.1.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "terraform-example-bar",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
