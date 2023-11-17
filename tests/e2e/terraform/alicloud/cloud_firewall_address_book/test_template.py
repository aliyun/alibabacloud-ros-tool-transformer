import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_cloud_firewall_address_book.example": {
            "Type": "ALIYUN::CLOUDFW::AddressBook",
            "Properties": {
                "AddressList": "10.168.1.12,10.168.1.11",
                "AutoAddTagEcs": True,
                "Description": "example_value",
                "GroupName": "example_value",
                "GroupType": "tag",
                "TagRelation": "and",
                "TagList": [{"TagKey": "created", "TagValue": "tfTestAcc0"}],
            },
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
