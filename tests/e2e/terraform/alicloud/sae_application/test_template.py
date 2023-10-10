import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_sae_application.default": {
            "Type": "ALIYUN::SAE::Application",
            "Properties": {
                "AppDescription": "tf-example",
                "AppName": "tf-example",
                "Cpu": 500,
                "ImageUrl": "registry-vpc.cn-beijing.aliyuncs.com/sae-demo-image/consumer:1.0",
                "Memory": 2048,
                "NamespaceId": {
                    "Fn::GetAtt": ["alicloud_sae_namespace.default", "NamespaceId"]
                },
                "PackageType": "Image",
                "Replicas": 5,
                "SecurityGroupId": {
                    "Fn::GetAtt": ["alicloud_security_group.default", "SecurityGroupId"]
                },
                "Timezone": "Asia/Beijing",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_sae_namespace.default": {
            "Type": "ALIYUN::SAE::Namespace",
            "Properties": {
                "NamespaceDescription": "tf-example",
                "NamespaceId": "cn-beijing:example",
                "NamespaceName": "tf-example",
            },
        },
        "alicloud_security_group.default": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {"VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]}},
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
