import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc_bgp_group.example": {
            "Type": "ALIYUN::VPC::BgpGroup",
            "Properties": {
                "AuthKey": "YourPassword+12345678",
                "Name": "tf-example",
                "Description": "tf-example",
                "IsFakeAsn": True,
                "PeerAsn": 1111,
                "RouterId": "router_id",
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
