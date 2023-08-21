from rostran.core.rules import Rules

tpl_rules = {
    "PublicNet": {
        "Assertions": [
            {
                "Assert": {
                    "Fn::Equals": [{"Ref": "InternetMaxBandwidthOut"}, 0]
                }
            },
            {
                "Assert": {
                    "Fn::Equals": [{"Ref": "InternetMaxBandwidthIn"}, 0]
                }
            }
        ],
        "RuleCondition": {
            "Fn::Equals": [{"Ref": "Environment"}, "prod"]
        }
    },
    "ChargeType": {
        "Assertions": [
            {
                "Assert": {
                    "Fn::Equals": [{"Ref": "InstanceChargeType"}, "PayAsYouGo"]
                },
                "AssertDescription": "ECS instance should be postpaid when the environment is pre.",
            }
        ]
    }
}


def test_format_rules():
    rules = Rules.initialize(tpl_rules)
    data = rules.as_dict(format=True)

    # Rules key order
    assert list(data) == ["ChargeType", "PublicNet"]
    assert list(data['PublicNet']) == ["RuleCondition", "Assertions"]
