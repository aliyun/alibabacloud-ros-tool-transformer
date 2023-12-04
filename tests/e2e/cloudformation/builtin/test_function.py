from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Outputs": {"ToJsonString": {"Value": {"Fn::ToJsonString": {"k": "v"}}}},
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Outputs": {"ToJsonString": {"Value": {"Fn::Jq": [". | tostring", {"k": "v"}]}}},
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
