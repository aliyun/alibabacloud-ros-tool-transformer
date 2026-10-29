import pytest

from rostran.core.conditions import Condition, Conditions
from rostran.core.exceptions import (
    InvalidTemplateCondition,
    InvalidTemplateConditions,
    InvalidTemplateMapping,
    InvalidTemplateMappings,
)
from rostran.core.mappings import Mapping, Mappings


@pytest.mark.parametrize(
    ("name", "value"),
    [
        (1, {"Fn::Equals": [1, 1]}),
        ("name", []),
        ("name", {1: []}),
        ("name", {"Fn::Unknown": []}),
        ("name", {"Fn::Equals": "invalid"}),
    ],
)
def test_invalid_conditions(name, value):
    with pytest.raises(InvalidTemplateCondition):
        Condition.initialize(name, value)


@pytest.mark.parametrize(
    ("name", "value"),
    [(1, {}), ("name", []), ("name", {1: {}}), ("name", {"key": 1})],
)
def test_invalid_mappings(name, value):
    with pytest.raises(InvalidTemplateMapping):
        Mapping.initialize(name, value)


def test_collections_validate_and_sort():
    with pytest.raises(InvalidTemplateConditions):
        Conditions.initialize([])
    with pytest.raises(InvalidTemplateMappings):
        Mappings.initialize([])
    conditions = Conditions.initialize(
        {"Z": {"Fn::Equals": [1, 1]}, "A": {"Fn::Not": [False]}}
    )
    assert list(conditions.as_dict(format=True)) == ["A", "Z"]
    mappings = Mappings.initialize({"Z": {"b": {"z": 1, "a": 2}}, "A": {}})
    result = mappings.as_dict(format=True)
    assert list(result) == ["A", "Z"]
    assert list(result["Z"]["b"]) == ["a", "z"]
