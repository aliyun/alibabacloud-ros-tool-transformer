import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc_dhcp_options_set.example": {
            "Type": "ALIYUN::VPC::DhcpOptionsSet",
            "Properties": {
                "DhcpOptionsSetDescription": "terraform-example",
                "DhcpOptionsSetName": "terraform-example",
                "DomainName": "terraform-example.com",
                "DomainNameServers": "100.100.2.136",
            },
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
