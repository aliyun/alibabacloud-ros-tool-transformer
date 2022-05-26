from rostran.core.conditions import Conditions

tpl_conditions = {
    "IsDevEnv": {"Fn::Equals": ["Dev", {"Ref": "EnvType"}]},
    "IsUtEnv": {"Fn::Equals": ["UT", {"Ref": "EnvType"}]},
    "IsProdEnv": {
        "Fn::And": [{"Fn::Equals": ["Prod", {"Ref": "EnvType"}]}, "IsPreEnv"]
    },
    "IsPreEnv": {"Fn::Not": {"Fn::Or": ["IsDevEnv", "IsUtEnv"]}},
}


def test_format_conditions():
    conditions = Conditions.initialize(tpl_conditions)
    data = conditions.as_dict(format=True)

    # Conditions key order
    assert list(data) == ["IsDevEnv", "IsPreEnv", "IsProdEnv", "IsUtEnv"]
