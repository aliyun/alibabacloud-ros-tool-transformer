import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_network_acl.default": {
            "Type": "ALIYUN::VPC::NetworkAcl",
            "Properties": {
                "VpcId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VpcId"]}
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "192.168.0.0/16"},
        },
        "alicloud_vpc_network_acl_attachment.default": {
            "Type": "ALIYUN::VPC::NetworkAclAssociation",
            "Properties": {
                "NetworkAclId": {
                    "Fn::GetAtt": ["alicloud_network_acl.default", "NetworkAclId"]
                },
                "Resources": [
                    {
                        "ResourceId": {
                            "Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]
                        },
                        "ResourceType": "VSwitch",
                    }
                ],
            },
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "192.168.2.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    # assert t == tpl
    print(t)
