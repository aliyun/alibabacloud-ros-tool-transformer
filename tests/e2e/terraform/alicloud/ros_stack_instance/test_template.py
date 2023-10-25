import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ros_stack_group.example": {
            "Type": "ALIYUN::ROS::StackGroup",
            "Properties": {
                "Description": "test for stack groups",
                "StackGroupName": "terraform-example",
                "TemplateBody": {
                    "ROSTemplateFormatVersion": "2015-09-01",
                    "Parameters": {
                        "VpcName": {"Type": "String"},
                        "InstanceType": {"Type": "String"},
                    },
                },
                "Parameters": {
                    "InstanceType": "ecs.g6.large",
                    "VpcName": "terraform-example",
                },
            },
        },
        "alicloud_ros_stack_instance.example": {
            "Type": "ALIYUN::ROS::StackInstances",
            "Properties": {
                "OperationPreferences": {
                    "FailureToleranceCount": 1,
                    "MaxConcurrentCount": 2,
                },
                "StackGroupName": "terraform-example",
                "AccountIds": ["123456789"],
                "RegionIds": ["cn-beijing"],
                "ParameterOverrides": {"VpcName": "terraform-example"},
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
