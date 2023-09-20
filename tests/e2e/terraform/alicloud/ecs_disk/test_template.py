import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_disk.example": {
            "Type": "ALIYUN::ECS::Disk",
            "Properties": {
                "Description": "terraform-example",
                "DiskName": "terraform-example",
                "Encrypted": True,
                "Size": 30,
                "Tags": [{"Key": "Name", "Value": "terraform-example"}],
                "ZoneId": "cn-beijing-c",
            },
        },
        "alicloud_kms_key.example": {
            "Type": "ALIYUN::KMS::Key",
            "Properties": {
                "Description": "terraform-example",
                "PendingWindowInDays": 7,
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
