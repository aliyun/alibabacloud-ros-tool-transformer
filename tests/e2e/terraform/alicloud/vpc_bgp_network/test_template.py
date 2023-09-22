import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_vpc_bgp_network.example": {
            "Type": "ALIYUN::VPC::BgpNetwork",
            "Properties": {"DstCidrBlock": "192.168.0.0/24", "RouterId": "rouer_id"},
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
