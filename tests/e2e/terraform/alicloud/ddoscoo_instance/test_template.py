import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ddoscoo_instance.default": {
            "Type": "ALIYUN::DDoSPro::ProInstance",
            "Properties": {
                "Bandwidth": 30,
                "BaseBandwidth": 30,
                "DomainCount": 50,
                "Period": 1,
                "PortCount": 50,
                "ServiceBandwidth": 100,
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
