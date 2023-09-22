import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_auto_snapshot_policy.example": {
            "Type": "ALIYUN::ECS::AutoSnapshotPolicy",
            "Properties": {
                "AutoSnapshotPolicyName": "tf-testAcc",
                "RepeatWeekdays": ["1", "2", "3"],
                "RetentionDays": -1,
                "TimePoints": ["1", "22", "23"],
            },
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
