import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_command.default": {
            "Type": "ALIYUN::ECS::Command",
            "Properties": {
                "CommandContent": "bHMK",
                "Description": "terraform-example",
                "Name": "terraform-example",
                "Type": "RunShellScript",
                "WorkingDir": "/root",
            },
        },
        "alicloud_ecs_invocation.default": {
            "Type": "ALIYUN::ECS::Invocation",
            "Properties": {
                "CommandId": {
                    "Fn::GetAtt": ["alicloud_ecs_command.default", "CommandId"]
                },
                "InstanceIds": ["i-xxx"],
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
