import json

import pytest

from rostran.core.exceptions import InvalidRosTemplateFormatVersion
from rostran.core.format import TargetTemplateFormat
from rostran.core.template import RosTemplate


@pytest.mark.parametrize("data", [{}, {"ROSTemplateFormatVersion": "wrong"}])
def test_ros_template_requires_supported_version(data):
    with pytest.raises(InvalidRosTemplateFormatVersion):
        RosTemplate.initialize(data)


def test_ros_template_initializes_all_sections_and_saves_additional_data(tmp_path):
    source = {
        "ROSTemplateFormatVersion": "2015-09-01",
        "Description": "demo",
        "Transform": "Aliyun::Terraform-v1.0",
        "Conditions": {"Enabled": {"Fn::Equals": [1, 1]}},
        "Mappings": {"Region": {"cn": {"Name": "China"}}},
        "Parameters": {"Name": {"Type": "String"}},
        "Resources": {"Vpc": {"Type": "ALIYUN::ECS::VPC", "Properties": {}}},
        "Outputs": {"VpcId": {"Value": {"Ref": "Vpc"}}},
        "Rules": {"Check": {"Assertions": []}},
        "Metadata": {"custom": {"note": "value"}},
        "Workspace": {"main.tf": "resource"},
    }
    template = RosTemplate.initialize(source)
    assert template.as_dict(format=True) == source
    with pytest.raises(AssertionError):
        template.additional_data = []
    template.additional_data = {"Custom": "value"}
    target = tmp_path / "template.json"
    template.save(target, TargetTemplateFormat.Json)
    assert json.loads(target.read_text())["Custom"] == "value"
