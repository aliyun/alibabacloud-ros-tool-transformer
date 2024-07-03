import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_disk.example": {
            "Type": "ALIYUN::ECS::Disk",
            "Properties": {
                "DiskName": "terraform-example",
                "Size": 20,
                "ZoneId": "cn-beijing-c",
            },
        },
        "alicloud_ecs_disk_attachment.example": {
            "Type": "ALIYUN::ECS::DiskAttachment",
            "Properties": {
                "DiskId": {"Fn::GetAtt": ["alicloud_ecs_disk.example", "DiskId"]},
                "InstanceId": {
                    "Fn::GetAtt": ["alicloud_instance.example", "InstanceId"]
                },
            },
        },
        "alicloud_ecs_snapshot.example": {
            "Type": "ALIYUN::ECS::Snapshot",
            "Properties": {
                "Description": "terraform-example",
                "DiskId": {"Fn::GetAtt": ["alicloud_ecs_disk.example", "DiskId"]},
                "RetentionDays": 20,
                "SnapshotName": "terraform-example",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
            },
        },
        "alicloud_instance.example": {
            "Type": "ALIYUN::ECS::Instance",
            "Properties": {
                "ZoneId": "cn-beijing-c",
                "ImageId": "ubuntu_24_04_x64_20G_alibase_20240508.vhd",
                "InstanceName": "terraform-example",
                "InstanceType": "ecs.sn1.large",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.example", "VSwitchId"]},
            },
        },
        "alicloud_security_group.example": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "Description": "New security group",
                "SecurityGroupName": "terraform-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
            },
        },
        "alicloud_vpc.example": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.17.3.0/24",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vswitch.example": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.17.3.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
