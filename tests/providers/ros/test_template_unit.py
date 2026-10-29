from types import SimpleNamespace

import pytest
from Tea.exceptions import TeaException

from rostran.core.exceptions import (
    InvalidTargetPath,
    InvalidTemplate,
    InvalidTemplateWorkspace,
    TemplateFormatNotSupport,
)
from rostran.core.format import FileFormat
from rostran.providers.ros import template as module
from rostran.providers.terraform import template_blocks as tf


def make_template(source):
    return module.ROS2TerraformTemplate(source, SimpleNamespace(resource_rules={}))


def test_workspace_extraction_and_invalid_input(tmp_path):
    wrapped = module.WrapTerraformTemplate(
        source={"Workspace": {"nested/main.tf": "content"}}
    )
    wrapped.transform(str(tmp_path))
    assert (tmp_path / "nested" / "main.tf").read_text() == "content"
    with pytest.raises(InvalidTargetPath):
        wrapped.transform(None)
    with pytest.raises(InvalidTemplateWorkspace):
        module.WrapTerraformTemplate(source={"Workspace": []}).transform(str(tmp_path))


def test_wrapped_template_loads_json_and_yaml_with_short_tags(tmp_path):
    yaml_file = tmp_path / "template.yml"
    yaml_file.write_text(
        "Workspace:\n  main.tf: resource\nMetadata:\n  Value: !Ref Name\n"
    )
    wrapped = module.WrapTerraformTemplate.initialize(str(yaml_file), FileFormat.Yaml)
    assert wrapped.source["Workspace"]["main.tf"] == "resource"
    assert wrapped.source["Metadata"]["Value"] == {"Ref": "Name"}
    json_file = tmp_path / "template.json"
    json_file.write_text('{"Workspace": {"main.tf": "resource"}}')
    assert (
        module.WrapTerraformTemplate.initialize(str(json_file), FileFormat.Json).source[
            "Workspace"
        ]["main.tf"]
        == "resource"
    )
    with pytest.raises(TemplateFormatNotSupport):
        module.WrapTerraformTemplate.initialize(str(json_file), FileFormat.Terraform)


def test_parameters_conditions_and_mappings_are_rendered():
    source = {
        "Parameters": {
            "Name": {
                "Type": "String",
                "Default": "demo",
                "NoEcho": True,
                "Required": True,
            },
            "Count": {"Type": "Number", "Default": 2},
            "Names": {"Type": "CommaDelimitedList", "Default": "a,b"},
            "Unknown": {"Type": "unsupported", "Description": "${value}"},
        },
        "Conditions": {"Active": True},
        "Mappings": {"Regions": {"cn": {"Name": "Hangzhou"}}},
        "Resources": {"Server": {"Condition": "Active"}},
    }
    template = make_template(source)
    variables = {item.name: item for item in template._transform_parameters()}
    assert variables["name"].arguments["default"].value == "demo"
    assert variables["name"].arguments["sensitive"].value is True
    assert variables["name"].arguments["nullable"].value is False
    assert variables["names"].arguments["default"].render() == '["a", "b"]'
    assert variables["unknown"].arguments["type"] == "any"
    assert "$${value}" in variables["unknown"].arguments["description"]
    assert template.resources_with_count == ["Server"]
    assert len(template._transform_conditions()) == 1
    assert len(template._transform_mappings()) == 1
    assert template.mappings_name_in_local.startswith("mappings_")
    assert template.get_tf_params("name") == "name"
    assert template.get_tf_params("count") == template.get_tf_params("count")
    assert template.get_tf_params("count").startswith("count_")


def test_resolve_values_and_pseudo_parameters():
    template = make_template({"Parameters": {"Name": {}}})
    assert template.resolve_values({"Ref": "Name"}).value == "var.name"
    values = template.resolve_values({"key": ["value", 1]})
    assert values.value["key"].value[0].value == "value"
    marker = tf.Data("regions", "alicloud_regions")
    template.data_for_pseudo_param["region"] = marker
    template.tf_region_parameter = tf.Variable("region", {})
    variables, resources = template._transform_for_pseudo_param([], [])
    assert resources == [marker]
    assert variables[0].name == "region"


def test_transform_writes_files_and_formats_them(tmp_path, monkeypatch):
    template = make_template({})
    monkeypatch.setattr(
        template, "_transform_conditions", lambda: [tf.Locals({"x": tf.NumberType(1)})]
    )
    monkeypatch.setattr(template, "_transform_mappings", lambda: [])
    monkeypatch.setattr(
        template, "_transform_parameters", lambda: [tf.Variable("name", {})]
    )
    monkeypatch.setattr(template, "_transform_resources", lambda: [])
    monkeypatch.setattr(template, "_transform_resource_in_properties", lambda: [])
    monkeypatch.setattr(template, "_transform_outputs", lambda: [])
    monkeypatch.setattr(template.reporter, "generate_report", lambda: None)
    calls = []

    class Runner:
        def __init__(self, **kwargs):
            pass

        def __enter__(self):
            return self

        def __exit__(self, *args):
            return None

        def run(self, *args, **kwargs):
            calls.append((args, kwargs))

    monkeypatch.setattr(module, "TerraformRunner", Runner)
    out = tmp_path / "out"
    template.transform(str(out), single_file=True)
    assert "locals" in (out / "main.tf").read_text()
    assert 'variable "name"' in (out / "main.tf").read_text()
    assert calls[0][0][1] == "fmt"
    template.transform(str(tmp_path / "multi"))
    assert (tmp_path / "multi" / "local.tf").exists()
    assert (tmp_path / "multi" / "variable.tf").exists()
    invalid = tmp_path / "file"
    invalid.touch()
    with pytest.raises(InvalidTargetPath):
        template.transform(str(invalid))


def test_validation_reports_downstream_errors(monkeypatch):
    monkeypatch.setattr(module, "CredClient", lambda: object())
    monkeypatch.setattr(module.open_api_models, "Config", lambda **kwargs: object())
    error = TeaException({"code": "Invalid", "message": "bad template"})

    def fail(*args, **kwargs):
        raise error

    monkeypatch.setattr(
        module,
        "Client",
        lambda config: SimpleNamespace(validate_template_with_options=fail),
    )
    with pytest.raises(InvalidTemplate, match="bad template"):
        module.ROS2TerraformTemplate.validate_ros_template({})


def test_property_conversion_handles_mapping_blocks_and_unsupported_values():
    template = make_template({})
    schema = {
        "Name": {"To": "name"},
        "Ignored": {"Ignore": True},
        "Both": {"To": ["first", "second"]},
        "Nested": {"To": "settings", "Schema": {"Key": {"To": "key"}}},
        "Lower": {"To": "lower", "Handler": "handle_lower"},
    }
    result = template._get_tf_argument(
        "ALIYUN::Test",
        {
            "Name": "example",
            "Ignored": "x",
            "Unknown": 3,
            "Both": 2,
            "Nested": {"Key": "value"},
            "Lower": "ABC",
        },
        schema,
    )
    assert result["name"].value == "example"
    assert result["first"].value == result["second"].value == 2
    assert result["Nested$Block"].arguments["key"].value == "value"
    assert result["lower"].value == "abc"
    assert "Ignored" not in result and "Unknown" not in result


def test_resource_conversion_applies_condition_dependencies_and_builtins():
    source = {
        "Resources": {
            "Vpc": {"Type": "VPC", "Properties": {"Name": "demo"}},
            "Server": {
                "Type": "ECS",
                "Properties": {"Name": "server"},
                "Condition": "Enabled",
                "DependsOn": "Vpc",
            },
            "Unknown": {"Type": "UNSUPPORTED"},
        }
    }
    template = make_template(source)
    template.rule_manager.resource_rules = {
        name: SimpleNamespace(
            target_resource_type=f"alicloud_{name.lower()}",
            properties={"Name": {"To": "name"}},
            built_in_properties={"region": {"Value": "cn-test"}},
        )
        for name in ("VPC", "ECS")
    }
    resources = template._transform_resources()
    assert len(resources) == 2
    server = next(item for item in resources if item.name == "server")
    assert server.arguments["name"].value == "server"
    assert server.arguments["region"].value == "cn-test"
    assert server.arguments["count"].value == "local.enabled ? 1 : 0"
    assert server.arguments["depends_on"].value[0].value == "alicloud_vpc.vpc"


def test_output_conversion_renders_condition_and_description():
    template = make_template(
        {
            "Outputs": {
                "Name": {
                    "Value": "demo",
                    "Description": "Example",
                    "Condition": "Enabled",
                },
                "Count": {"Value": 2, "Description": {"en": "count"}},
            }
        }
    )
    outputs = {item.name: item for item in template._transform_outputs()}
    assert outputs["name"].arguments["value"].value == 'local.enabled ? "demo" : null'
    assert outputs["name"].arguments["description"].value == "Example"
    assert "<<EOT" in outputs["count"].arguments["description"]


def test_property_handlers_required_values_and_repeated_blocks():
    template = make_template({})
    schema = {
        "Tags": {"To": "tags", "Handler": "handle_tags"},
        "Missing": {
            "To": "auto_name",
            "Required": True,
            "Handler": "handle_required_string",
        },
        "Items": {"To": "item", "Schema": {"Name": {"To": "name"}}},
        "Variant$$0": {"To": "new_field"},
    }
    values = {
        "Tags": [{"Key": "team", "Value": "ops"}],
        "Items": [{"Name": "one"}, {"Name": "two"}],
        "Variant": "value",
    }
    result = template._get_tf_argument(
        "ALIYUN::Test", values, schema, res_name="Example"
    )
    assert result["tags"].value["team"].value == "ops"
    assert result["auto_name"].value.startswith("auto-")
    assert result["Items$0"].arguments["name"].value == "one"
    assert result["Items$1"].arguments["name"].value == "two"
    assert result["new_field"].value == "value"


def test_property_conversion_can_create_resources_from_nested_properties():
    template = make_template({})
    nested_rule = {
        "ResourceType": {"From": "ALIYUN::Parent.Child", "To": "alicloud_child"},
        "Properties": {"Name": {"To": "name"}},
    }
    result = template._get_tf_argument(
        "ALIYUN::Parent",
        {"Children": [{"Name": "first"}, "ignored"]},
        {"Children": {"ToResources": nested_rule}},
        res_name="Parent",
    )
    assert result == {}
    assert len(template.resources_from_properties) == 1
    resources = template._transform_resource_in_properties()
    assert len(resources) == 1
    assert resources[0].arguments["name"].value == "first"


def test_resource_conversion_supports_multiple_target_resources_and_unknown_dependencies():
    template = make_template(
        {
            "Resources": {
                "Dependency": {"Type": "Unknown"},
                "Parent": {
                    "Type": "Parent",
                    "Properties": {"Name": "example"},
                    "Count": 2,
                    "DependsOn": ["Dependency"],
                },
            }
        }
    )
    template.rule_manager.resource_rules = {
        "Parent": SimpleNamespace(
            target_resource_type="alicloud_first,alicloud_second",
            properties={"Name": {"To": "alicloud_first.name"}},
            built_in_properties={"alicloud_second.region": {"Value": "cn-test"}},
        )
    }
    resources = template._transform_resources()
    assert len(resources) == 2
    first = next(item for item in resources if item.res_type == "alicloud_first")
    second = next(item for item in resources if item.res_type == "alicloud_second")
    assert first.arguments["name"].value == "example"
    assert second.arguments["region"].value == "cn-test"
    assert first.arguments["count"].value == 2
    assert isinstance(first.arguments["depends_on"].value[0], tf.CommentType)


def test_failed_output_expression_is_reported_and_not_emitted():
    template = make_template(
        {
            "Resources": {"Vpc": {"Type": "Unknown"}},
            "Outputs": {"Bad": {"Value": {"Fn::GetAtt": ["Vpc", "Id"]}}},
        }
    )
    assert template._transform_outputs() == []


def test_validation_reports_missing_credentials(monkeypatch):
    def fail():
        raise module.CredentialException("credentials unavailable")

    monkeypatch.setattr(module, "CredClient", fail)
    with pytest.raises(InvalidTemplate, match="credentials unavailable"):
        module.ROS2TerraformTemplate.validate_ros_template({})


def test_handlers_can_skip_and_apply_one_value_to_multiple_arguments():
    template = make_template({})
    result = {}
    assert template._handled_value(
        result, {"Handler": "handle_dict_value(missing)"}, "name", {"key": "value"}
    )
    assert result == {}
    assert template._handled_value(
        result, {"Handler": "handle_lower"}, ["one", "two"], "HELLO"
    )
    assert result["one"].value == result["two"].value == "hello"
    assert (
        template._handled_value(result, {"Handler": "unknown"}, "name", "value") is None
    )
    assert (
        template._get_tf_argument("type", {"key": "value"}, None).value["key"].value
        == "value"
    )


def test_resolve_stops_when_nested_function_cannot_be_transformed():
    template = make_template({"Resources": {"Vpc": {"Type": "Unknown"}}})
    failure = {"Fn::GetAtt": ["Vpc", "Id"]}
    assert isinstance(
        template.resolve_values([failure], ignore_comment=True), tf.CommentType
    )
    assert isinstance(
        template.resolve_values({"key": failure}, ignore_comment=True), tf.CommentType
    )
    assert template._transform_mappings() == []


def test_terraform_fmt_failure_keeps_original_output(tmp_path, monkeypatch, capsys):
    template = make_template({})
    monkeypatch.setattr(template, "_transform_conditions", lambda: [])
    monkeypatch.setattr(template, "_transform_mappings", lambda: [])
    monkeypatch.setattr(
        template, "_transform_parameters", lambda: [tf.Variable("name", {})]
    )
    monkeypatch.setattr(template, "_transform_resources", lambda: [])
    monkeypatch.setattr(template, "_transform_resource_in_properties", lambda: [])
    monkeypatch.setattr(template, "_transform_outputs", lambda: [])
    monkeypatch.setattr(template.reporter, "generate_report", lambda: None)

    class Runner:
        def __init__(self, **kwargs):
            pass

        def __enter__(self):
            return self

        def __exit__(self, *args):
            return None

        def run(self, *args, **kwargs):
            raise module.TerraformCommandError(1, "fmt", stderr="bad")

    monkeypatch.setattr(module, "TerraformRunner", Runner)
    template.transform(str(tmp_path / "out"))
    assert 'variable "name"' in (tmp_path / "out" / "variable.tf").read_text()
    assert "Terraform fmt failed" in capsys.readouterr().out


def test_parameter_boolean_and_nonstring_list_defaults():
    template = make_template(
        {
            "Parameters": {
                "Enabled": {
                    "Type": "Boolean",
                    "Default": True,
                    "Description": "boolean flag",
                },
                "Names": {"Type": "CommaDelimitedList", "Default": ["a", "b"]},
            }
        }
    )
    variables = {item.name: item for item in template._transform_parameters()}
    assert variables["enabled"].arguments["type"] == "bool"
    assert variables["enabled"].arguments["default"].value is True
    assert variables["names"].arguments["default"].render() == '["a", "b"]'


def test_nested_comment_is_propagated_through_intrinsic_function():
    template = make_template({"Resources": {"Vpc": {"Type": "Unknown"}}})
    value = {"Fn::Join": [",", {"Fn::GetAtt": ["Vpc", "Id"]}]}
    assert isinstance(
        template.resolve_values(value, ignore_comment=True), tf.CommentType
    )


def test_invalid_nested_block_becomes_comment_and_existing_required_value_is_preserved():
    template = make_template({})
    schema = {
        "Nested": {"To": "nested", "Schema": {"Name": {"To": "name"}}},
        "Required": {"To": "required", "Required": True},
    }
    result = template._get_tf_argument(
        "type", {"Nested": "invalid", "Required": "present"}, schema
    )
    assert isinstance(result["Nested$Comment"], tf.CommentType)
    assert result["required"].value == "present"


def test_builtin_attribute_reference_is_resolved_for_generated_resource():
    template = make_template({"Resources": {"Server": {"Type": "Server"}}})
    template.rule_manager.resource_rules = {
        "Server": SimpleNamespace(
            target_resource_type="alicloud_server",
            properties={},
            built_in_properties={
                "vpc_id": {"ValueType": "ResolveAttribute", "Value": "alicloud_vpc.id"}
            },
        )
    }
    resource = template._transform_resources()[0]
    assert resource.arguments["vpc_id"].value == "alicloud_vpc.server_alicloud_vpc.id"
