import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc_prefix_list.default": {
            "Type": "ALIYUN::VPC::PrefixList",
            "Properties": {
                "IpVersion": "IPV4",
                "MaxEntries": 50,
                "PrefixListDescription": "test",
                "PrefixListName": "tf-testacc-example",
                "ResourceGroupId": "resource_group_id",
                "Entries": [{"cidr": "192.168.0.0/16", "description": "test"}],
            },
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
