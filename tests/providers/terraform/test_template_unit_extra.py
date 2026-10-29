from types import SimpleNamespace

import pytest

from rostran.core.exceptions import (
    InvalidRuleSchema,
    RunCommandFailed,
    RosTranWarning,
    TemplateFormatNotSupport,
    TerraformMultiProvidersNotSupported,
    TerraformPlanFormatVersionNotSupported,
    TerraformProviderNotFound,
)
from rostran.core.format import FileFormat
from rostran.providers.terraform import template as module
from rostran.providers.terraform.template import (
    TerraformTemplate,
    _plan_expressions_to_body,
    _tf_data_from_plan_configuration,
)


def make_template():
    plan = {
        "planned_values": {
            "root_module": {
                "resources": [
                    {"address": "alicloud_vpc.example", "type": "alicloud_vpc"}
                ]
            }
        }
    }
    rule = SimpleNamespace(
        rule_id="vpc-rule",
        target_resource_type="ALIYUN::ECS::VPC",
        attributes={"id": {"To": "VpcId"}, "nested": {"To": "Attributes.0.Value"}},
        properties={},
    )
    return TerraformTemplate(
        {}, plan, "alicloud", SimpleNamespace(resource_rules={"alicloud_vpc": rule})
    )


def test_plan_configuration_converts_resources_outputs_and_nested_blocks():
    plan = {
        "configuration": {
            "root_module": {
                "resources": [
                    {
                        "mode": "managed",
                        "address": "alicloud_vpc.example",
                        "name": "example",
                        "type": "alicloud_vpc",
                        "expressions": {
                            "vpc_id": {"references": ["alicloud_vpc.other.id"]},
                            "nested": [{"name": {}}],
                        },
                    },
                    {
                        "mode": "data",
                        "address": "data.example",
                        "name": "example",
                        "type": "data",
                    },
                    {"mode": "managed"},
                ],
                "outputs": {
                    "vpc": {"expression": {"references": ["alicloud_vpc.example.id"]}}
                },
            }
        }
    }
    result = _tf_data_from_plan_configuration(plan)
    managed = result["ManagedResources"]["alicloud_vpc.example"]["Config"]
    assert (
        managed["Attributes"]["vpc_id"]["Expr"]["Traversal"][0]["Name"]
        == "alicloud_vpc"
    )
    assert managed["Blocks"][0]["Type"] == "nested"
    assert "data.example" in result["DataResources"]
    assert result["Outputs"]["vpc"]["Expr"]["Traversal"][-1]["Name"] == "id"
    assert _plan_expressions_to_body({"nested": [None]}) == {"Attributes": {}}


def test_source_expressions_support_references_counts_and_splats():
    template = make_template()
    traversal = [{"Name": name} for name in ("alicloud_vpc", "example", "id")]
    result = template._parse_source_expr({"Traversal": traversal})
    assert result[".Args"] == ["alicloud_vpc.example", "id"]
    assert (
        template._parse_source_expr({"Traversal": [{"Name": "var"}, {"Name": "x"}]})
        is None
    )
    source = {"Collection": {"Traversal": traversal[:2]}}
    counted = template._parse_source_expr(
        {"Traversal": [{"Name": "id"}], "Source": source}, count_index=2
    )
    assert counted[".Args"] == ["alicloud_vpc.example[2]", "id"]
    splat = {
        "Source": {"Traversal": traversal[:2]},
        "Each": {"Traversal": [{"Name": "id"}]},
    }
    assert template._parse_source_expr(
        splat,
        planned_resources={
            "alicloud_vpc.example": [{"address": "alicloud_vpc.example[0]"}]
        },
    )[0][".Args"][0].endswith("[0]")
    assert template._parse_source_expr({"ForEach": {}}) is None


def test_attribute_conversion_and_unknown_resources():
    template = make_template()
    assert template._transform_func_get_att("alicloud_vpc.example", "id") == {
        "Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]
    }
    assert template._transform_func_get_att("alicloud_vpc.example", "nested") == {
        "Fn::Jq": [
            "First",
            ".[0].Value",
            {"Fn::GetAtt": ["alicloud_vpc.example", "Attributes"]},
        ]
    }
    assert template._transform_func_get_att("missing", "id") is None
    assert template._transform_func_get_att("alicloud_vpc.example", "missing") is None


def test_property_mapping_nested_values_and_invalid_rule():
    template = make_template()
    values = {
        "name": "demo",
        "settings": [{"value": 3}],
        "ignored": "x",
        "unsupported": "x",
    }
    rules = {
        "name": {"To": "Name"},
        "settings": {
            "To": "Settings",
            "Type": "List",
            "Schema": {"value": {"To": "Value"}},
        },
        "ignored": {"Ignore": True},
    }
    assert template._transform_resource_props("type", values, rules, "rule") == {
        "Name": "demo",
        "Settings": [{"Value": 3}],
    }
    with pytest.raises(InvalidRuleSchema):
        template._transform_resource_props(
            "type", {"name": "x"}, {"name": {"Type": "String"}}, "rule"
        )


def test_property_path_rejects_discontinuous_list_index():
    template = make_template()
    result = {}
    template._handle_props_and_value(result, ["Items", "0", "Name"], "first", "rule")
    assert result == {"Items": [{"Name": "first"}]}
    with pytest.raises(InvalidRuleSchema):
        template._handle_props_and_value(result, ["Items", "3", "Name"], "bad", "rule")


@pytest.mark.parametrize(
    ("providers", "error"),
    [
        ({}, TerraformProviderNotFound),
        ({"aws": {}}, RosTranWarning),
        ({"aws": {}, "alicloud": {}}, TerraformMultiProvidersNotSupported),
    ],
)
def test_initialize_rejects_unsupported_provider_sets(
    tmp_path, monkeypatch, providers, error
):
    monkeypatch.setattr(
        TerraformTemplate,
        "_get_plan_data",
        lambda *args: ({"configuration": {"provider_config": providers}}, {}),
    )
    with pytest.raises(error):
        TerraformTemplate.initialize(str(tmp_path), FileFormat.Terraform)
    with pytest.raises(TemplateFormatNotSupport):
        TerraformTemplate.initialize(str(tmp_path), FileFormat.Json)


def test_initialize_loads_alicloud_rules(tmp_path, monkeypatch):
    monkeypatch.setattr(
        TerraformTemplate,
        "_get_plan_data",
        lambda *args: ({"configuration": {"provider_config": {"alicloud": {}}}}, {}),
    )
    expected = SimpleNamespace(resource_rules={})
    monkeypatch.setattr(module.RuleManager, "initialize", lambda classifier: expected)
    template = TerraformTemplate.initialize(str(tmp_path), FileFormat.Terraform)
    assert template.provider == "alicloud" and template.rule_manager is expected


def test_json_plan_falls_back_to_configuration_when_parser_fails(tmp_path, monkeypatch):
    import json

    plan = {
        "format_version": "1.2",
        "configuration": {
            "root_module": {
                "resources": [
                    {
                        "mode": "managed",
                        "address": "alicloud_vpc.a",
                        "name": "a",
                        "type": "alicloud_vpc",
                    }
                ]
            }
        },
    }
    path = tmp_path / "plan.json"
    path.write_text(json.dumps(plan))

    def fail(path):
        raise ValueError("parser unavailable")

    monkeypatch.setattr(module.TerraformConfig, "load_config_dir", fail)
    actual_plan, config = TerraformTemplate._get_plan_data(str(tmp_path), str(path))
    assert actual_plan == plan
    assert "alicloud_vpc.a" in config["ManagedResources"]
    plan["format_version"] = "unsupported"
    path.write_text(json.dumps(plan))
    with pytest.raises(TerraformPlanFormatVersionNotSupported):
        TerraformTemplate._get_plan_data(str(tmp_path), str(path))


def test_parse_source_config_resolves_nested_blocks_and_output_expressions():
    template = make_template()
    ref = {"Traversal": [{"Name": "alicloud_vpc"}, {"Name": "example"}, {"Name": "id"}]}
    config = {
        "Attributes": {
            "known": {"Expr": {}},
            "ref": {"Expr": ref},
            "count": {"Expr": {}},
        },
        "Blocks": [{"Type": "nested", "Body": {"Attributes": {"name": {"Expr": {}}}}}],
    }
    parsed = template._parse_source_config(
        config, {"values": {"known": "value", "nested": [{"name": "child"}]}}
    )
    assert parsed["known"] == "value"
    assert parsed["ref"][".Args"] == ["alicloud_vpc.example", "id"]
    assert parsed["nested"] == [{"name": "child"}]
    assert "count" not in parsed
    output = template._parse_source_config(
        {"Expr": ref}, {"planned_resources": {}}, entity_type="outputs"
    )
    assert output[".Args"] == ["alicloud_vpc.example", "id"]
    with pytest.raises(ValueError):
        template._parse_source_config({}, {}, entity_type="invalid")


def test_generated_plan_is_cleaned_up_and_failure_is_reported(tmp_path, monkeypatch):
    monkeypatch.chdir(tmp_path)
    plan = {"format_version": "1.2"}
    calls = []

    class Runner:
        def __init__(self, **kwargs):
            pass

        def __enter__(self):
            return self

        def __exit__(self, *args):
            return None

        def run(self, directory, command, *args, **kwargs):
            calls.append(command)
            if command == "plan":
                from pathlib import Path

                Path(kwargs["out"]).write_text("plan")
            return SimpleNamespace(value=plan)

    monkeypatch.setattr(module, "TerraformRunner", Runner)
    monkeypatch.setattr(
        module.TerraformConfig,
        "load_config_dir",
        lambda path: ({"ManagedResources": {}}, None),
    )
    assert TerraformTemplate._get_plan_data(".")[0] == plan
    assert calls == ["init", "plan", "show"]
    assert not list(tmp_path.glob("*.tfplan"))

    def fail(self, directory, command, *args, **kwargs):
        raise module.TerraformCommandError(1, "terraform", stderr="failed")

    monkeypatch.setattr(Runner, "run", fail)
    with pytest.raises(RunCommandFailed, match="failed"):
        TerraformTemplate._get_plan_data(".", str(tmp_path / "plan.bin"))


def test_indexed_references_read_index_from_source(tmp_path):
    import linecache

    template = make_template()
    source = tmp_path / "main.tf"
    source.write_text("[2]")
    traversal = [
        {"Name": "alicloud_vpc"},
        {"Name": "example"},
        {
            "Key": {},
            "SrcRange": {
                "Filename": str(source),
                "Start": {"Line": 1, "Column": 1},
                "End": {"Line": 1, "Column": 3},
            },
        },
        {"Name": "id"},
    ]
    assert template._parse_source_expr({"Traversal": traversal})[".Args"] == [
        "alicloud_vpc.example[2]",
        "id",
    ]
    source.write_text("[x]")
    linecache.clearcache()
    assert template._parse_source_expr({"Traversal": traversal}) is None


def test_map_merging_and_property_handlers():
    template = make_template()
    values = {
        "nested": [{"key": "value"}],
        "first": "a",
        "second": "b",
        "hidden": "ignored",
    }
    rules = {
        "nested": {"Type": "Map", "Schema": {"key": {"To": "Key"}}},
        "first": {"To": "Path"},
        "second": {"To": "Path", "MergeHandler": "append_str", "Warning": "duplicate"},
        "hidden": {"Ignore": True, "NoWarning": True},
    }
    result = template._transform_resource_props("type", values, rules, "rule")
    assert result == {"Key": "value", "Path": "a/b"}


def test_plan_fallback_raises_when_config_contains_no_resources(tmp_path, monkeypatch):
    import json

    path = tmp_path / "plan.json"
    path.write_text(json.dumps({"format_version": "1.0", "configuration": {}}))

    def fail(path):
        raise RuntimeError("cannot parse")

    monkeypatch.setattr(module.TerraformConfig, "load_config_dir", fail)
    with pytest.raises(RuntimeError, match="cannot parse"):
        TerraformTemplate._get_plan_data(str(tmp_path), str(path))


def test_parse_unplanned_blocks_and_unresolved_expressions():
    template = make_template()
    reference = {
        "Traversal": [{"Name": "alicloud_vpc"}, {"Name": "example"}, {"Name": "id"}]
    }
    config = {
        "Attributes": {"ref": {"Expr": reference}},
        "Blocks": [
            {"Type": "nested", "Body": {"Attributes": {"ref": {"Expr": reference}}}}
        ],
    }
    parsed = template._parse_source_config(config, {"values": None})
    assert parsed["ref"][".Args"] == ["alicloud_vpc.example", "id"]
    assert parsed["nested"][0]["ref"][".Args"] == ["alicloud_vpc.example", "id"]
    assert (
        template._parse_source_expr(
            {
                "Source": {"Traversal": [{"Name": "missing"}, {"Name": "item"}]},
                "Each": {"Traversal": [{"Name": "id"}]},
            },
            planned_resources={"other": []},
        )
        is None
    )


def test_attribute_mapping_lists_and_invalid_schema():
    template = make_template()
    rule = template.rule_manager.resource_rules["alicloud_vpc"]
    rule.attributes["multiple"] = {"To": ["VpcId", "Name"]}
    assert template._transform_func_get_att("alicloud_vpc.example", "multiple") == [
        {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
        {"Fn::GetAtt": ["alicloud_vpc.example", "Name"]},
    ]
    rule.attributes["invalid"] = {"To": 1}
    with pytest.raises(InvalidRuleSchema):
        template._transform_func_get_att("alicloud_vpc.example", "invalid")


def test_nested_assignment_and_unresolved_value_handling():
    template = make_template()
    result = {}
    template._handle_props_and_value(result, [], "ignored", "rule")
    template._handle_props_and_value(
        result, ["__single_to_multi_handler__"], {"A": 1}, "rule"
    )
    assert result == {"A": 1}
    with pytest.raises(InvalidRuleSchema):
        template._handle_props_and_value([], ["2"], "value", "rule")
    expression = {
        ".Type": "Func",
        ".Value": "GetAtt",
        ".Args": ["alicloud_vpc.example", "id"],
    }
    value, resolved = template._transform_prop_or_attr(
        {"values": [expression, "literal"]}
    )
    assert not resolved
    assert value["values"][0] == {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]}


def test_plan_reference_and_unrecognized_resource_mode():
    assert module._plan_reference_to_expr("") == {}
    result = module._tf_data_from_plan_configuration(
        {
            "configuration": {
                "root_module": {
                    "resources": [
                        {
                            "address": "other.example",
                            "mode": "unknown",
                            "name": "example",
                            "type": "other",
                        }
                    ]
                }
            }
        }
    )
    assert not result["ManagedResources"]


def test_property_mapping_with_dictionary_map_and_duplicate_names():
    template = make_template()
    result = template._transform_resource_props(
        "type",
        {"nested": {"key": "v"}, "a": "first", "b": "second"},
        {
            "nested": {
                "Type": "Map",
                "Schema": {"key": {"To": "Key"}},
                "Warning": "Warning.",
            },
            "a": {"To": "Path"},
            "b": {"To": "Path"},
        },
        "rule",
    )
    assert result == {"Key": "v", "Path": "second"}
    assert template._transform_prop_or_attr({".Type": "Other"}) == (None, True)
    target = {}
    template._handle_props_and_value(
        target, ["__single_to_multi_handler__"], {}, "rule"
    )
    assert target == {}
