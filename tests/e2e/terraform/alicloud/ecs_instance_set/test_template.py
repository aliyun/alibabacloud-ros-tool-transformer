import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_instance_set.instance_set": {
            "Type": "ALIYUN::ECS::InstanceGroup",
            "Properties": {
                "MaxAmount": 10,
                "ImageId": "ubuntu_20_04_x64_20G_alibase_20230718.vhd",
                "InstanceChargeType": "PostPaid",
                "InstanceName": "terraform-example",
                "InstanceType": "ecs.sn1.large",
                "SystemDiskCategory": "cloud_essd",
                "SystemDiskPerformanceLevel": "PL1",
                "SystemDiskSize": 200,
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
                "ZoneId": "cn-beijing-c",
                # todo: not support converting `alicloud_security_group.default.*.id`
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
    t = _test_template(root, tf_plan_path)
    assert t == tpl
