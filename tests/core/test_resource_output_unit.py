import pytest
from openpyxl import Workbook

from rostran.core.exceptions import (
    InvalidTemplateOutput,
    InvalidTemplateOutputs,
    InvalidTemplateResource,
    InvalidTemplateResources,
)
from rostran.core.outputs import Output, Outputs
from rostran.core.resources import Resource, Resources


@pytest.mark.parametrize(
    ("name", "data"),
    [
        (1, {"Value": "x"}),
        ("name", []),
        ("name", {}),
        ("name", {"Value": 1, "Condition": 3}),
    ],
)
def test_invalid_outputs_are_rejected(name, data):
    with pytest.raises(InvalidTemplateOutput):
        Output.initialize(name, data)


def test_outputs_preserve_description_condition_and_values():
    data = {"Value": "value", "Description": "description", "Condition": "Enabled"}
    assert Output.initialize("Name", data).as_dict(format=True) == {"Name": data}
    assert Outputs.initialize({"Name": data}).as_dict() == {"Name": data}
    with pytest.raises(InvalidTemplateOutputs):
        Outputs.initialize([])


@pytest.mark.parametrize(
    ("name", "value"),
    [
        ("name", []),
        (1, {"Type": "ALIYUN::ECS::VPC"}),
        ("", {"Type": "ALIYUN::ECS::VPC"}),
        ("name", {}),
        ("name", {"Type": ""}),
        ("name", {"Type": "ALIYUN::ECS::VPC", "DependsOn": 1}),
        ("name", {"Type": "ALIYUN::ECS::VPC", "Condition": 1}),
        ("name", {"Type": "ALIYUN::ECS::VPC", "DeletionPolicy": "invalid"}),
        ("name", {"Type": "ALIYUN::ECS::VPC", "Metadata": []}),
    ],
)
def test_invalid_resources_are_rejected(name, value):
    with pytest.raises(InvalidTemplateResource):
        Resource.initialize(name, value)


def test_resource_excel_type_and_dependency_ordering():
    sheet = Workbook().active
    sheet["A1"] = "ECS::VPC"
    sheet["B1"] = "Vpc"
    resource = Resource.initialize_from_excel(sheet["A1"], sheet["B1"])
    assert resource.type == "ALIYUN::ECS::VPC"
    sheet["A1"] = "invalid"
    with pytest.raises(InvalidTemplateResource):
        Resource.initialize_from_excel(sheet["A1"], sheet["B1"])
    with pytest.raises(InvalidTemplateResources):
        Resources.initialize([])
    resources = Resources.initialize(
        {
            "Server": {
                "Type": "ALIYUN::ECS::Instance",
                "DependsOn": ["Vpc"],
                "Properties": {"VpcId": {"Ref": "Vpc"}},
            },
            "Vpc": {
                "Type": "ALIYUN::ECS::VPC",
                "DeletionPolicy": "Retain",
                "Metadata": {"key": "value"},
            },
        }
    )
    assert list(resources.as_dict(format=True)) == ["Vpc", "Server"]
    assert resources["Server"].get_depends_on_set() == {"Vpc"}
