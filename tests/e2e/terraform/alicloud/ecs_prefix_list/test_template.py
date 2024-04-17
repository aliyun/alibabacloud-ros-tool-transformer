import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_prefix_list.default": {
            "Type": "ALIYUN::ECS::PrefixList",
            "Properties": {
                "AddressFamily": "IPv4",
                "Description": "description",
                "MaxEntries": 2,
                "PrefixListName": "tftest",
                "Entries": [{"cidr": "192.168.0.0/24", "description": "description"}],
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
