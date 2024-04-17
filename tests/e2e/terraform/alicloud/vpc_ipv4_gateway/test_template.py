import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_resource_manager_resource_group.default": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {
                "DisplayName": "tf-testAcc-rg665",
                "Name": "tf-testacc-example",
            },
        },
        "alicloud_resource_manager_resource_group.modify": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {
                "DisplayName": "tf-testAcc-rg298",
                "Name": "tf-testacc-example1",
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.0.0.0/8", "VpcName": "tf-testacc-example2"},
        },
        "alicloud_vpc_ipv4_gateway.default": {
            "Type": "ALIYUN::VPC::Ipv4Gateway",
            "Properties": {
                "Ipv4GatewayDescription": "tf-testAcc-Ipv4Gateway",
                "Ipv4GatewayName": "tf-testacc-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
