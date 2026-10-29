import pytest

from rostran.providers.ros.yaml_util import yaml


@pytest.mark.parametrize(
    ("source", "expected"),
    [
        ("!GetAtt Vpc.Id", {"Fn::GetAtt": ["Vpc", "Id"]}),
        ("!GetAtt Stack.Outputs.Name", {"Fn::GetAtt": ["Stack", "Outputs.Name"]}),
        ("!GetAtt Module.Nested.Id", {"Fn::GetAtt": ["Module.Nested", "Id"]}),
        ("!GetAtt [Vpc, Id]", {"Fn::GetAtt": ["Vpc", "Id"]}),
        ("!Ref Vpc", {"Ref": "Vpc"}),
        ("!Join [',', [a, b]]", {"Fn::Join": [",", ["a", "b"]]}),
    ],
)
def test_ros_short_yaml_tags(source, expected):
    assert yaml.load(source) == expected


def test_invalid_getatt_short_tag():
    with pytest.raises(ValueError, match="Resolve !GetAtt error"):
        yaml.load("!GetAtt SingleName")
