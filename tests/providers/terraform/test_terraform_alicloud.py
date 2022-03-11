import os

from rostran.providers import TerraformTemplate
from tests.conf import TERRAFORM_PROVIDER_DIR, TERRAFORM_ALICLOUD_DIR

ALICLOUD_PLAN_PATH = os.path.join(TERRAFORM_PROVIDER_DIR, "alicloud/alicloud.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_instance.myinstance": {
            "Type": "ALIYUN::ECS::Instance",
            "Properties": {
                "ImageId": "centos_7_9_x64_20G_alibase_20220208.vhd",
                "InstanceName": "myinstance",
                "InstanceType": "ecs.n1.medium",
                "SystemDiskCategory": "cloud_efficiency",
                "VSwitchId": {
                    "Fn::GetAtt": ["alicloud_vswitch.myvswitch", "VSwitchId"]
                },
                "DiskMappings": [
                    {"Category": "cloud_efficiency", "DiskName": "mydisk1", "Size": 20},
                    {
                        "Category": "cloud_essd",
                        "Description": "disk 2",
                        "DiskName": "mydisk2",
                        "Size": 25,
                    },
                ],
            },
            "DependsOn": ["alicloud_security_group.mysg"],
        },
        "alicloud_log_machine_group.sls_machine_group": {
            "Type": "ALIYUN::SLS::MachineGroup",
            "Properties": {
                "MachineIdentifyType": "ip",
                "GroupName": "tf-machine-group",
                "ProjectName": "tf-log",
            },
            "DependsOn": ["alicloud_log_project.sls"],
        },
        "alicloud_log_project.sls": {
            "Type": "ALIYUN::SLS::Project",
            "Properties": {"Description": "created by terraform", "Name": "tf-log"},
        },
        "alicloud_security_group.mysg": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "SecurityGroupName": "mysg",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.myvpc", "VpcId"]},
            },
        },
        "alicloud_vpc.myvpc": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "172.16.0.0/12"},
        },
        "alicloud_vswitch.myvswitch": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/21",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.myvpc", "VpcId"]},
            },
        },
    },
    "Outputs": {
        "const_map": {"Value": {"foo": "bar"}},
        "instance_id": {
            "Value": {"Fn::GetAtt": ["alicloud_instance.myinstance", "InstanceId"]}
        },
        "log_machine_group_id": {
            "Value": {
                "Fn::Join": [
                    ":",
                    [
                        {
                            "Fn::GetAtt": [
                                "alicloud_log_machine_group.sls_machine_group",
                                "ProjectName",
                            ]
                        },
                        {
                            "Fn::GetAtt": [
                                "alicloud_log_machine_group.sls_machine_group",
                                "GroupName",
                            ]
                        },
                    ],
                ]
            }
        },
    },
}


def test_template():
    template = TerraformTemplate.initialize(
        TERRAFORM_ALICLOUD_DIR, tf_plan_path=ALICLOUD_PLAN_PATH
    )
    ros_template = template.transform()
    d = ros_template.as_dict()
    assert d == tpl
