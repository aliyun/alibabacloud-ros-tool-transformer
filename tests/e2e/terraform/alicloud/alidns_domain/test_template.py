import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_alidns_domain.default": {
            "Type": "ALIYUN::DNS::Domain",
            "Properties": {
                "DomainName": "starmove.com",
                "GroupId": {
                    "Fn::GetAtt": ["alicloud_alidns_domain_group.default", "GroupId"]
                },
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
            },
        },
        "alicloud_alidns_domain_group.default": {
            "Type": "ALIYUN::DNS::DomainGroup",
            "Properties": {"GroupName": "tf-example"},
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
