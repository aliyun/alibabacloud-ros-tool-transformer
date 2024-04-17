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
        },
        "alicloud_vpc_bgp_peer.example": {
            "Type": "ALIYUN::VPC::BgpPeer",
            "Properties": {
                "BgpGroupId": {
                    "Fn::GetAtt": ["alicloud_vpc_bgp_group.example", "BgpGroupId"]
                },
                "EnableBfd": True,
                "PeerIpAddress": "1.1.1.1",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
