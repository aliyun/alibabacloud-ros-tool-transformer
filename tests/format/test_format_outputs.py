from rostran.core.outputs import Outputs

tpl_outputs = {
    "O2": {
        "Value": {"Fn::GetAtt": ["R1", "InstanceId"]},
        "Condition": "C1",
        "Description": "Description for O2",
    },
    "O1": {
        "Value": {"Fn::GetAtt": ["R1", "InstanceId"]},
        "Description": "Description for O1",
    },
}


def test_format_outputs():
    params = Outputs.initialize(tpl_outputs)
    data = params.as_dict(format=True)

    # Outputs key order
    assert list(data) == ["O2", "O1"]

    # Output key order
    v = data["O2"]
    assert list(v) == ["Description", "Condition", "Value"]

    v = data["O1"]
    assert list(v) == ["Description", "Value"]
