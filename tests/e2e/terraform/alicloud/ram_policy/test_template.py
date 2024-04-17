import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ram_policy.policy": {
            "Type": "ALIYUN::RAM::ManagedPolicy",
            "Properties": {
                "Description": "this is a policy test",
                "PolicyDocument": {
                    "Statement": [
                        {
                            "Action": ["oss:ListObjects", "oss:GetObject"],
                            "Effect": "Allow",
                            "Resource": [
                                "acs:oss:*:*:mybucket",
                                "acs:oss:*:*:mybucket/*",
                            ],
                        }
                    ],
                    "Version": "1",
                },
                "PolicyName": "policyName",
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
