import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_eip_address.default": {
            "Type": "ALIYUN::VPC::EIP",
            "Properties": {
                "Name": "terraform-example",
                "Bandwidth": "1",
                "Description": "test",
                "Isp": "BGP",
                "Netmode": "public",
                "SecurityProtectionTypes": ["AntiDDoS_Enhanced"],
                "InstanceChargeType": "PayAsYouGo",
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
