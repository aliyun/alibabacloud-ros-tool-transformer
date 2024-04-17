import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_slb_server_group_server_attachment.server_attachment": {
            "Type": "ALIYUN::SLB::BackendServerToVServerGroupAddition",
            "Properties": {
                "BackendServers": {"Port": 8080, "ServerId": "fake-id", "Weight": 0},
                "VServerGroupId": "fake-id",
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
