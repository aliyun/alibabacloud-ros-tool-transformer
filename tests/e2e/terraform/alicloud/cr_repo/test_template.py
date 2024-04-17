import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_cr_namespace.example": {
            "Type": "ALIYUN::CR::Namespace",
            "Properties": {
                "AutoCreate": False,
                "DefaultVisibility": "PUBLIC",
                "Namespace": "tf-example",
            },
        },
        "alicloud_cr_repo.example": {
            "Type": "ALIYUN::CR::Repository",
            "Properties": {
                "Detail": "this is a public repo",
                "RepoName": "tf-example",
                "RepoNamespace": "tf-example",
                "RepoType": "PUBLIC",
                "Summary": "this is summary of my new repo",
            },
        },
    },
    "Outputs": {
        "id": {
            "Value": {
                "Fn::Join": [
                    "/",
                    [
                        {"Fn::GetAtt": ["alicloud_cr_repo.example", "RepoNamespace"]},
                        {"Fn::GetAtt": ["alicloud_cr_repo.example", "RepoName"]},
                    ],
                ]
            }
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
