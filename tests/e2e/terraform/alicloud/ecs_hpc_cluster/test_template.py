import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_hpc_cluster.example": {
            "Type": "ALIYUN::ECS::HpcCluster",
            "Properties": {"Description": "For Terraform Test", "Name": "tf-testAcc"},
        }
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
