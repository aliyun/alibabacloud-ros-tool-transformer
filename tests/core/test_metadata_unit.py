import pytest

from rostran.core.exceptions import InvalidTemplateMetaData, InvalidTemplateMetaDataItem
from rostran.core.metadata import MetaData, MetaItem


@pytest.mark.parametrize(
    ("kind", "value"),
    [
        (123, {}),
        (MetaItem.ROS_INTERFACE, []),
        (MetaItem.ROS_DESIGNER, "invalid"),
        (MetaItem.PREDEFINED_PARAMETERS, {}),
        (MetaItem.PREDEFINED_PARAMETERS, ["invalid"]),
        (MetaItem.PREDEFINED_PARAMETERS, [{}]),
        (MetaItem.PREDEFINED_PARAMETERS, [{"Name": 1}]),
        (MetaItem.PREDEFINED_PARAMETERS, [{"Name": "example"}]),
        (MetaItem.PREDEFINED_PARAMETERS, [{"Name": "example", "Parameters": []}]),
        (MetaItem.ROS_INTERFACE, {"ParameterGroups": {}}),
        (MetaItem.ROS_INTERFACE, {"ParameterGroups": ["invalid"]}),
        (MetaItem.ROS_INTERFACE, {"ParameterGroups": [{}]}),
        (MetaItem.ROS_INTERFACE, {"ParameterGroups": [{"Parameters": "invalid"}]}),
        (MetaItem.ROS_INTERFACE, {"ParameterGroups": [{"Parameters": [123]}]}),
        (
            MetaItem.ROS_INTERFACE,
            {"ParameterGroups": [{"Parameters": [], "Label": "invalid"}]},
        ),
        (
            MetaItem.ROS_INTERFACE,
            {"ParameterGroups": [{"Parameters": [], "Label": {}}]},
        ),
        (MetaItem.ROS_INTERFACE, {"TemplateTags": "invalid"}),
        (MetaItem.ROS_INTERFACE, {"TemplateTags": [1]}),
    ],
)
def test_invalid_metadata_is_rejected(kind, value):
    with pytest.raises(InvalidTemplateMetaDataItem):
        MetaItem.initialize(kind, value)


def test_metadata_accepts_parameter_expressions_and_omits_none():
    with pytest.raises(InvalidTemplateMetaData):
        MetaData.initialize([])
    data = MetaData.initialize(
        {
            "ALIYUN::ROS::Interface": {
                "ParameterGroups": [{"Parameters": [{"Ref": "Name"}]}]
            },
            "unused": None,
        }
    )
    assert "unused" not in data.as_dict(format=True)
    assert data.as_dict()["ALIYUN::ROS::Interface"]["ParameterGroups"][0][
        "Parameters"
    ] == [{"Ref": "Name"}]
