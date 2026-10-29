from types import SimpleNamespace

import pytest

from rostran.core.conditions import Conditions
from rostran.core.exceptions import (
    CloudFormationTransformNotSupported,
    InvalidRuleSchema,
    InvalidYamlTemplateTag,
)
from rostran.core.format import FileFormat
from rostran.core.mappings import Mappings
from rostran.core.parameters import Parameters
from rostran.providers.cloudformation import template as module


def manager():
    return SimpleNamespace(
        function_rule=SimpleNamespace(
            function={"Fn::Sub": {"To": "Fn::Sub"}, "Fn::Ignored": {"Ignore": True}}
        ),
        pseudo_parameters_rule=SimpleNamespace(
            pseudo_parameters={"AWS::Region": {"To": "ALIYUN::Region"}}
        ),
        association_property_rule=SimpleNamespace(
            association_property={"AWS::Type": {"To": "ALIYUN::Type"}}
        ),
        meta_data_rule=SimpleNamespace(meta_data={}),
        resource_rules={},
    )


def test_yaml_short_tags_and_unsupported_transform(tmp_path, monkeypatch):
    monkeypatch.setattr(module.RuleManager, "initialize", lambda classifier: manager())
    path = tmp_path / "template.yml"
    path.write_text("Value: !GetAtt Vpc.VpcId\n")
    template = module.CloudFormationTemplate.initialize(str(path), FileFormat.Yaml)
    assert template.source["Value"] == {"Fn::GetAtt": ["Vpc", "VpcId"]}
    path.write_text("Value: !Ref Vpc\n")
    assert module.CloudFormationTemplate.initialize(str(path), FileFormat.Yaml).source[
        "Value"
    ] == {"Ref": "Vpc"}
    path.write_text("Value: !Unknown value\n")
    with pytest.raises(InvalidYamlTemplateTag):
        module.CloudFormationTemplate.initialize(str(path), FileFormat.Yaml)
    with pytest.raises(CloudFormationTransformNotSupported):
        module.CloudFormationTemplate({"Transform": "macro"}, manager()).transform()


def test_parameters_conditions_and_mappings():
    template = module.CloudFormationTemplate(
        {
            "Parameters": {
                "Type": {"Type": "AWS::Type"},
                "Unknown": {"Type": "Custom::Unknown"},
                "List": {"Type": "List<Number>"},
            },
            "Conditions": {"Enabled": True},
            "Mappings": {"Region": {"cn": {"Name": "China"}}},
        },
        manager(),
    )
    parameters, conditions, mappings = Parameters(), Conditions(), Mappings()
    template._transform_parameters(parameters)
    template._transform_conditions(conditions)
    template._transform_mappings(mappings)
    assert parameters["Type"].association_property == "ALIYUN::Type"
    assert parameters["Unknown"].type == "String"
    assert parameters["List"].type == "CommaDelimitedList"
    assert conditions["Enabled"].value is True
    assert "Region" in mappings


def test_transform_value_handles_functions_and_pseudo_parameters():
    template = module.CloudFormationTemplate({}, manager())
    assert template._transform_value("AWS::Region") == ("ALIYUN::Region", False)
    assert template._transform_value("AWS::Unknown") == ("AWS::Unknown", False)
    result, resolved = template._transform_value({"Fn::Sub": "${AWS::Region}-test"})
    assert result == {"Fn::Sub": "${ALIYUN::Region}-test"} and not resolved
    assert template._transform_value({"Fn::Ignored": "value"}) == (
        {"Fn::Ignored": "value"},
        False,
    )
    assert template._transform_value([{"Fn::Unknown": "x"}, 1])[1] is False


def test_nested_property_mapping_and_invalid_indices():
    template = module.CloudFormationTemplate({}, manager())
    values = {"Name": "value", "Items": [{"Item": "x"}], "Ignored": "x"}
    rules = {
        "Name": {"To": "Name", "Warning": "warning"},
        "Items": {"To": "Items", "Type": "List", "Schema": {"Item": {"To": "Item"}}},
        "Ignored": {"Ignore": True},
    }
    assert template._transform_resource_props("type", values, rules, "rule") == {
        "Name": "value",
        "Items": [{"Item": "x"}],
    }
    with pytest.raises(InvalidRuleSchema):
        template._transform_resource_props(
            "type", {"Name": "x"}, {"Name": {"Type": "String"}}, "rule"
        )
    result = {}
    template._handle_props_and_value(result, ["Items", "0", "Name"], "x", "rule")
    assert result == {"Items": [{"Name": "x"}]}
    with pytest.raises(InvalidRuleSchema):
        template._handle_props_and_value(result, ["Items", "3", "Name"], "x", "rule")


def test_map_rules_merge_values_and_apply_handlers():
    template = module.CloudFormationTemplate({}, manager())
    values = {
        "Map": [{"Key": "value"}],
        "A": "a",
        "B": "b",
        "Count": "2",
        "Empty": None,
    }
    rules = {
        "Map": {"Type": "Map", "Schema": {"Key": {"To": "Key"}}},
        "A": {"To": "Path"},
        "B": {"To": "Path", "MergeHandler": "append_str"},
        "Count": {"To": "Count", "Handler": "to_int"},
        "Empty": {"To": "Empty", "Handler": "to_int"},
    }
    assert template._transform_resource_props("type", values, rules, "rule") == {
        "Key": "value",
        "Path": "a/b",
        "Count": 2,
    }


def test_function_sub_list_and_nested_assignment_edge_cases():
    template = module.CloudFormationTemplate({}, manager())
    result = template._transform_function(
        "Fn::Sub", ["${AWS::Region}", {}], {"To": "Fn::Sub"}
    )
    assert result == {"Fn::Sub": ["${ALIYUN::Region}", {}]}
    data = {}
    template._handle_props_and_value(data, [], None, "rule")
    template._handle_props_and_value(
        data, ["__single_to_multi_handler__"], {"Name": "value"}, "rule"
    )
    assert data == {"Name": "value"}
    template._handle_props_and_value(data, ["__single_to_multi_handler__"], {}, "rule")
    with pytest.raises(InvalidRuleSchema):
        template._handle_props_and_value([], ["2"], "value", "rule")


def test_additional_property_and_function_cases(tmp_path):
    assert module.short_handler_for_getatt(["Vpc", "Id"]) == ["Vpc", "Id"]
    with pytest.raises(module.TemplateFormatNotSupport):
        module.CloudFormationTemplate.initialize(str(tmp_path / "x"), None)
    template = module.CloudFormationTemplate({}, manager())
    values = {"Map": {"Key": "v"}, "A": "first", "B": "second"}
    rules = {
        "Map": {"Type": "Map", "Schema": {"Key": {"To": "Key"}}, "Warning": "Warning."},
        "A": {"To": "Path"},
        "B": {"To": "Path"},
    }
    assert template._transform_resource_props("type", values, rules, "rule") == {
        "Key": "v",
        "Path": "second",
    }
    data = []
    template._handle_props_and_value(data, ["0"], "first", "rule")
    assert data == ["first"]
    assert template._transform_function("Fn::Sub", [], {"To": "Fn::Sub"}) == {
        "Fn::Sub": []
    }


def test_unmapped_metadata_is_preserved():
    from rostran.core.metadata import MetaData

    template = module.CloudFormationTemplate(
        {"Metadata": {"Unknown": "value"}}, manager()
    )
    metadata = MetaData()
    template._transform_meta_data(metadata)
    assert metadata.as_dict()["Unknown"] == "value"


def test_short_constructor_converts_scalar_tags_independently():
    loader = SimpleNamespace(construct_scalar=lambda node: node.value)
    assert module.short_constructor(
        loader, SimpleNamespace(tag="!GetAtt", value="Vpc.Id")
    ) == {"Fn::GetAtt": ["Vpc", "Id"]}
    assert module.short_constructor(
        loader, SimpleNamespace(tag="!Ref", value="Vpc")
    ) == {"Ref": "Vpc"}
    with pytest.raises(InvalidYamlTemplateTag):
        module.short_constructor(loader, SimpleNamespace(tag="!Unknown", value="x"))
