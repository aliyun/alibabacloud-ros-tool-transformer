import os

from rostran.providers import TerraformTemplate
from tests.conf import TERRAFORM_PROVIDER_DIR

TF_DIR = os.path.join(TERRAFORM_PROVIDER_DIR, "count")
PLAN_PATH = os.path.join(TERRAFORM_PROVIDER_DIR, "count/main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc.multi_vpcs[0]": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "172.16.0.0/12", "VpcName": "multivpc-0"},
        },
        "alicloud_vpc.multi_vpcs[1]": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "192.168.0.0/16", "VpcName": "multivpc-1"},
        },
        "alicloud_vpc.single_vpc": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "192.168.0.0/16", "VpcName": "singlevpc"},
        },
        "alicloud_vswitch.multi_vsws[0]": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.multi_vpcs[0]", "VpcId"]},
                "ZoneId": "cn-beijing-c",
            },
        },
        "alicloud_vswitch.multi_vsws[1]": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "192.168.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.multi_vpcs[1]", "VpcId"]},
                "ZoneId": "cn-beijing-d",
            },
        },
    },
    "Outputs": {
        "multi_vsws_ids": {
            "Value": [
                {"Fn::GetAtt": ["alicloud_vswitch.multi_vsws[0]", "VSwitchId"]},
                {"Fn::GetAtt": ["alicloud_vswitch.multi_vsws[1]", "VSwitchId"]},
            ]
        },
        "mutil_vsws_first_id": {
            "Value": {"Fn::GetAtt": ["alicloud_vswitch.multi_vsws[0]", "VSwitchId"]}
        },
        "single_vpc_id": {
            "Value": {"Fn::GetAtt": ["alicloud_vpc.single_vpc", "VpcId"]}
        },
    },
}


def test_template():
    template = TerraformTemplate.initialize(TF_DIR, tf_plan_path=PLAN_PATH)
    ros_template = template.transform()
    d = ros_template.as_dict()
    assert d == tpl
