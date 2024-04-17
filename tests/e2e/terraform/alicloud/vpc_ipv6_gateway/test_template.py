import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_resource_manager_resource_group.changeRg": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {
                "DisplayName": "tf-testacc-ipv6gateway311",
                "Name": "tf-testacc-example2",
            },
        },
        "alicloud_resource_manager_resource_group.defaultRg": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {
                "DisplayName": "tf-testacc-ipv6gateway503",
                "Name": "tf-testacc-example1",
            },
        },
        "alicloud_vpc.defaultVpc": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"Description": "tf-testacc", "EnableIpv6": True},
        },
        "alicloud_vpc_ipv6_gateway.default": {
            "Type": "ALIYUN::VPC::Ipv6Gateway",
            "Properties": {
                "Description": "test",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.defaultVpc", "VpcId"]},
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
