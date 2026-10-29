import pytest
from openpyxl import Workbook

from rostran.core.exceptions import (
    ConflictDataTypeInExpression,
    DiscontinuousIndexInExpression,
    InvalidExpression,
    InvalidTemplateProperties,
    InvalidTemplateProperty,
)
from rostran.core.properties import Properties, Property


def test_excel_reference_parsing_and_name_validation():
    sheet = Workbook().active
    sheet["A1"] = "  ImageId  "
    sheet["B1"] = " !Ref Image "
    prop = Property.initialize_from_excel(sheet["A1"], sheet["B1"])
    assert prop.as_dict() == {"ImageId": {"Ref": "Image"}}
    sheet["B1"] = "plain"
    assert Property.initialize_from_excel(sheet["A1"], sheet["B1"]).value == "plain"
    with pytest.raises(InvalidTemplateProperty):
        Property.initialize(3, "value")
    with pytest.raises(InvalidTemplateProperties):
        Properties.initialize([])


def test_resolves_nested_object_and_contiguous_list_expressions():
    props = Properties.initialize(
        {
            "Name": "server",
            "Config.Size": 2,
            "Disks[0].Name": "first",
            "Disks[1].Name": "second",
            "Config.Tags[0]": "production",
        }
    ).resolve()
    assert props.as_dict() == {
        "Name": "server",
        "Config": {"Size": 2, "Tags": ["production"]},
        "Disks": [{"Name": "first"}, {"Name": "second"}],
    }


@pytest.mark.parametrize(
    ("data", "error"),
    [
        ({"A": "scalar", "A.B": "value"}, ConflictDataTypeInExpression),
        ({"Items[1].Name": "value"}, DiscontinuousIndexInExpression),
        ({"Config.invalid name": "value"}, InvalidExpression),
    ],
)
def test_resolve_rejects_invalid_expressions(data, error):
    with pytest.raises(error):
        Properties.initialize(data).resolve()


def test_dependency_collection_and_formatted_order():
    props = Properties.initialize(
        {
            "ImageId": {"Ref": "Image"},
            "VpcId": {"Fn::GetAtt": ["Vpc", "VpcId"]},
            "Nested": [
                {"Ref": "Instance"},
                {"other": {"Ref": "Ignored"}, "ref": {"Ref": "Nested"}},
            ],
            "Unused": None,
            "ZoneId": "zone",
        }
    )
    assert props.get_depends_on_set() == {
        "Image",
        "Vpc",
        "Instance",
        "Ignored",
        "Nested",
    }
    result = props.as_dict(format=True)
    assert list(result)[:3] == ["ZoneId", "VpcId", "ImageId"]
    assert "Unused" not in result


def test_resolves_deep_nested_lists_and_multidimensional_indices():
    props = Properties.initialize(
        {
            "Config.List[0].Name": "one",
            "Config.List[1].Name": "two",
            "Matrix[0][0].Name": "cell",
        }
    ).resolve()
    assert props.as_dict() == {
        "Config": {"List": [{"Name": "one"}, {"Name": "two"}]},
        "Matrix": [[{"Name": "cell"}]],
    }


@pytest.mark.parametrize(
    "data",
    [
        {"Config": "scalar", "Config.Child.Name": "value"},
        {"Config": "scalar", "Config.List[0]": "value"},
        {"Config": "scalar", "Config.List[0].Name": "value"},
        {"Items": {}, "Items[0].Name": "value"},
    ],
)
def test_conflicting_intermediate_expression_types(data):
    with pytest.raises(ConflictDataTypeInExpression):
        Properties.initialize(data).resolve()
