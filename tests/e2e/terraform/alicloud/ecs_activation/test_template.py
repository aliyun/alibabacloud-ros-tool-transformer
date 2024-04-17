import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_activation.example": {
            "Type": "ALIYUN::ECS::Activation",
            "Properties": {
                "Description": "terraform-example",
                "InstanceCount": 10,
                "InstanceName": "terraform-example",
                "IpAddressRange": "0.0.0.0/0",
                "TimeToLiveInHours": 4,
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
