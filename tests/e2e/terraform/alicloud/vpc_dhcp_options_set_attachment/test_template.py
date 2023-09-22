import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc.example": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vpc_dhcp_options_set.example": {
            "Type": "ALIYUN::VPC::DhcpOptionsSet",
            "Properties": {
                "DhcpOptionsSetDescription": "tf-example",
                "DhcpOptionsSetName": "tf-example",
                "DomainName": "example.com",
                "DomainNameServers": "100.100.2.136",
            },
        },
        "alicloud_vpc_dhcp_options_set_attachment.example": {
            "Type": "ALIYUN::VPC::DhcpOptionsSetAttachment",
            "Properties": {
                "DhcpOptionsSetId": {
                    "Fn::GetAtt": [
                        "alicloud_vpc_dhcp_options_set.example",
                        "DhcpOptionsSetId",
                    ]
                },
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
