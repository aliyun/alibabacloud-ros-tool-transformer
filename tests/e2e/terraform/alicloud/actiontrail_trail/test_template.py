import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_actiontrail_trail.default": {
            "Type": "ALIYUN::ACTIONTRAIL::Trail",
            "Properties": {"EventRW": "All", "OssBucketName": "bucket_name"},
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
