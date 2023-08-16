from rostran.core.parameters import Parameters
from rostran.core.metadata import MetaData

tpl_parameters = {
    "EnableProtection": {"Type": "Boolean", "Default": None},
    "ZoneId": {
        "Type": "String",
    },
    "Data": {"Type": "Json", "TextArea": True, "Default": {"k": "v"}},
    "Amount": {
        "Type": "Number",
        "AllowedValues": [1, 2, 3],
        "Label": {"zh-cn": "Label(zh-cn) for Amount", "en": "Label(en) for Amount"},
        "MaxValue": 3,
        "ConstraintDescription": {
            "zh-cn": "Constraint description(zh-cn) for Amount",
            "en": "Constraint description(en) for Amount",
        },
        "MinValue": 1,
        "Description": {
            "zh-cn": "Description(zh-cn) for Amount",
            "en": "Description(en) for Amount",
        },
        "Default": 1,
    },
    "Password": {
        "Type": "String",
        "NoEcho": True,
        "MaxLength": 30,
        "Confirm": True,
        "AllowedPattern": "[0-9A-Za-z\\_\\-&:;'<>,=%`~!@#\\(\\)\\$\\^\\*\\+\\|\\{\\}\\[\\]\\.\\?\\/]+$",
        "MinLength": 8,
        "Default": "Default123",
    },
    "InstanceType": {
        "Type": "String",
        "AssociationPropertyMetadata": {"ZoneId": "${ZoneId}"},
        "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
        "Description": "Description for Data",
        "Label": "Label for B",
        "ConstraintDescription": "Constraint description for Data",
    },
}

tpl_metadata_for_parameters = {
    "ALIYUN::ROS::Interface": {
        "ParameterGroups": [
            {
                "Label": {"default": "Basic"},
                "Parameters": ["ZoneId"],
            },
            {
                "Label": {"default": "ECS"},
                "Parameters": ["InstanceType", "Amount", "Password"],
            },
        ],
    },
}


def test_format_parameters():
    params = Parameters.initialize(tpl_parameters)
    data = params.as_dict(format=True)

    # Parameters key order
    assert list(data) == [
        "EnableProtection",
        "ZoneId",
        "Data",
        "Amount",
        "Password",
        "InstanceType",
    ]

    # Parameters value key order
    v = data["EnableProtection"]
    assert list(v) == ["Type", "Default"]
    assert v["Default"] is None

    v = data["ZoneId"]
    assert list(v) == ["Type"]

    v = data["Data"]
    assert list(v) == ["Type", "Default", "TextArea"]

    v = data["Amount"]
    assert list(v) == [
        "Type",
        "Label",
        "Description",
        "ConstraintDescription",
        "Default",
        "AllowedValues",
        "MinValue",
        "MaxValue",
    ]

    v = data["Password"]
    assert list(v) == [
        "Type",
        "Default",
        "AllowedPattern",
        "MinLength",
        "MaxLength",
        "NoEcho",
        "Confirm",
    ]

    v = data["InstanceType"]
    assert list(v) == [
        "Type",
        "Label",
        "Description",
        "ConstraintDescription",
        "AssociationProperty",
        "AssociationPropertyMetadata",
    ]


def test_format_parameters_with_meta_data():
    metadata = MetaData.initialize(tpl_metadata_for_parameters)
    params = Parameters.initialize(tpl_parameters)
    data = params.as_dict(format=True, metadata=metadata)

    # Parameters key order
    assert list(data) == [
        "ZoneId",
        "InstanceType",
        "Amount",
        "Password",
        "EnableProtection",
        "Data",
    ]
