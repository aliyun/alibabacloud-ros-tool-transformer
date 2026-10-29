import pytest
from openpyxl import Workbook

from rostran.core.exceptions import (
    InvalidTemplateParameter,
    InvalidTemplateParameters,
    InvalidTemplateRule,
    InvalidTemplateRules,
)
from rostran.core.parameters import Parameter, Parameters
from rostran.core.rules import Rule, Rules


@pytest.mark.parametrize(
    ("name", "value"),
    [
        ("Name", "not a dict"),
        (4, {"Type": "String"}),
        ("Name", {"Type": "Unknown"}),
        ("Name", {"Type": "String", "AssociationProperty": 1}),
        ("Name", {"Type": "String", "AssociationPropertyMetadata": []}),
    ],
)
def test_invalid_parameters_are_rejected(name, value):
    with pytest.raises(InvalidTemplateParameter):
        Parameter.initialize(name, value)


def test_excel_parameter_types_and_explicit_null():
    sheet = Workbook().active
    sheet["A1"] = "Count(Number)"
    sheet["B1"] = 2
    param = Parameter.initialize_from_excel(sheet["A1"], sheet["B1"])
    assert param.name == "Count" and param.type == "Number" and param.default == 2
    sheet["A1"] = "Name"
    assert Parameter.initialize_from_excel(sheet["A1"], sheet["B1"]).type == "String"
    sheet["A1"] = "Name(Unknown)"
    with pytest.raises(InvalidTemplateParameter):
        Parameter.initialize_from_excel(sheet["A1"], sheet["B1"])
    assert (
        Parameter.initialize("Name", {"Type": "String", "Default": None}).as_dict(
            format=True
        )["Name"]["Default"]
        is None
    )
    with pytest.raises(InvalidTemplateParameters):
        Parameters.initialize([])


def test_parameter_format_preserves_supported_options():
    value = {
        "Type": "String",
        "Label": "Name",
        "Description": "desc",
        "ConstraintDescription": "constraint",
        "AssociationProperty": "ALIYUN::ECS::Image",
        "AssociationPropertyMetadata": {"key": "value"},
        "Default": "test",
        "AllowedValues": ["test"],
        "AllowedPattern": ".*",
        "MinLength": 1,
        "MaxLength": 10,
        "MinValue": 0,
        "MaxValue": 3,
        "NoEcho": True,
        "Confirm": True,
        "TextArea": True,
    }
    parameter = Parameter.initialize("Name", value)
    assert parameter.as_dict(format=True) == {"Name": value}
    assert parameter.as_dict() == {"Name": value}


@pytest.mark.parametrize(
    ("name", "value"),
    [
        (1, {"Assertions": []}),
        ("rule", []),
        ("rule", {1: []}),
        ("rule", {"Unknown": []}),
        ("rule", {"Assertions": "invalid"}),
        ("rule", {}),
    ],
)
def test_invalid_rules_are_rejected(name, value):
    with pytest.raises(InvalidTemplateRule):
        Rule.initialize(name, value)


def test_rules_collection_formats_valid_values():
    with pytest.raises(InvalidTemplateRules):
        Rules.initialize([])
    rules = Rules.initialize(
        {
            "Z": {"Assertions": []},
            "A": {"Assertions": [], "RuleCondition": {"Fn::Equals": [1, 1]}},
        }
    )
    data = rules.as_dict(format=True)
    assert list(data) == ["A", "Z"]
    assert list(data["A"]) == ["RuleCondition", "Assertions"]
