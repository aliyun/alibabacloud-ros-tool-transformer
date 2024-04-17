import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecp_instance.default": {
            "Type": "ALIYUN::CloudPhone::InstanceGroup",
            "Properties": {
                "Description": "tf-example",
                "ImageId": "android_9_0_0_release_2851157_20211201.vhd",
                "InstanceName": "tf-example",
                "InstanceType": "ecp.ce.xlarge",
                "ChargeType": "PayAsYouGo",
                "SecurityGroupId": {
                    "Fn::GetAtt": ["alicloud_security_group.default", "SecurityGroupId"]
                },
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_security_group.default": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "SecurityGroupName": "tf-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.0.0.0/8", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.1.0.0/16",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example",
                "ZoneId": "cn-beijing-k",
            },
        },
    },
    "Outputs": {
        "instance_id": {
            "Value": {
                "Fn::Jq": [
                    "First",
                    ".[0]",
                    {"Fn::GetAtt": ["alicloud_ecp_instance.default", "InstanceIds"]},
                ]
            }
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
