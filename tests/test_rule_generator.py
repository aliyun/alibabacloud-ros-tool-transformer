from types import SimpleNamespace

import pytest
import yaml

from tools import exceptions, generator


def resource(name, properties=None, attributes=None):
    return SimpleNamespace(
        resource_type=name,
        properties=lambda: properties or {},
        attributes=lambda: attributes or {},
    )


def test_generator_requires_supported_resource_types_and_asty(monkeypatch):
    with pytest.raises(exceptions.RosToolWarning, match="starts with alicloud_"):
        generator.TerraformRuleGenerator.initialize("invalid", "ALIYUN::ECS::Instance")
    monkeypatch.setattr(generator.shutil, "which", lambda name: None)
    with pytest.raises(exceptions.RosToolWarning, match="asty"):
        generator.TerraformRuleGenerator.initialize(
            "alicloud_instance", "ALIYUN::ECS::Instance"
        )
    with pytest.raises(exceptions.RosToolWarning, match="starts with AWS"):
        generator.CloudFormationRuleGenerator.initialize(
            "invalid", "ALIYUN::ECS::Instance"
        )


def test_generates_properties_attributes_and_nested_rules(monkeypatch):
    src = resource(
        "alicloud_test",
        {
            "name": {"Type": "string"},
            "missing": {"Type": "string"},
            "mismatch": {"Type": "boolean"},
            "custom": {"Type": "map", "Handler": "handle_custom"},
            "objects": {
                "Type": "list",
                "Schema": {
                    "*": {"Type": "map", "Schema": {"child": {"Type": "string"}}}
                },
            },
        },
        {"name": {}, "missing": {}},
    )
    dest = resource(
        "ALIYUN::ECS::Test",
        {
            "Name": {"Type": "string"},
            "Mismatch": {"Type": "map"},
            "Custom": {"Type": "map"},
            "Objects": {
                "Type": "list",
                "Schema": {
                    "*": {"Type": "map", "Schema": {"Child": {"Type": "string"}}}
                },
            },
        },
        {"Name": {}},
    )
    monkeypatch.setattr(generator, "TF_ALI_ROS_PROP_MAPPINGS", {})
    rule = generator.TerraformRuleGenerator(src, dest)._generate_rule()
    assert rule["Properties"]["name"] == {"To": "Name"}
    assert rule["Properties"]["missing"] == {"Ignore": True}
    assert rule["Properties"]["mismatch"] == {"Ignore": True}
    assert rule["Properties"]["custom"]["Handler"] == "handle_custom"
    assert rule["Properties"]["objects"]["Schema"]["child"] == {"To": "Child"}
    assert rule["Attributes"]["name"] == {"To": "Name"}
    assert rule["Attributes"]["missing"] == {"Ignore": True}
    assert generator.BaseRuleGenerator._is_type_compatible("integer", "string")
    assert not generator.BaseRuleGenerator._is_type_compatible("boolean", "string")


def test_reverse_mapping_skips_ignored_and_deprecated_and_handles_duplicates(
    monkeypatch,
):
    monkeypatch.setattr(
        generator, "TF_ALI_DEPRECATED_PROPERTIES", {"alicloud_test": ["deprecated"]}
    )
    instance = generator.ROS2TerraformRuleGenerator(
        resource("ALIYUN::ECS::Test"), resource("alicloud_test")
    )
    result = instance._get_rule_section(
        {
            "name": {"To": "Name"},
            "alias": {"To": "Name"},
            "tags": {"To": "Tags", "Handler": "tags_dict_to_list"},
            "deprecated": {"To": "Name"},
            "ignored": {"Ignore": True},
            "not_string": {"To": ["Name"]},
        },
        {"Name": {}, "Tags": {}, "Unused": {}},
    )
    assert result["Name"] == {"To": "name"}
    assert result["Name$$0"] == {"To": "alias"}
    assert result["Tags"] == {"To": "tags", "Handler": "handle_tags"}
    assert result["Unused"] == {"Ignore": True}


def test_merge_preserves_manual_rules_and_replaces_ignored_rules():
    existing = {
        "manual": {"To": "custom"},
        "ignored": {"Ignore": True},
        "old": {"To": "old"},
    }
    generated = {
        "manual": {"To": "generated"},
        "ignored": {"To": "found"},
        "new": {"To": "new"},
    }
    assert generator.ROS2TerraformRuleGenerator._merge_rule_section(
        existing, generated
    ) == {
        "manual": {"To": "custom"},
        "ignored": {"To": "found"},
        "old": {"To": "old"},
        "new": {"To": "new"},
    }


def test_generate_reverse_rule_preserves_manual_entries_and_reports_mismatch(
    tmp_path, monkeypatch
):
    tf_rules = tmp_path / "tf"
    ros_rules = tmp_path / "ros"
    tf_rules.mkdir()
    ros_rules.mkdir()
    monkeypatch.setattr(generator, "TF_ALI_RULES_DIR", str(tf_rules))
    monkeypatch.setattr(generator, "ROS_RESOURCE_RULES_DIR", str(ros_rules))
    src = resource("ALIYUN::ECS::Test", {"Name": {"Type": "string"}}, {})
    dst = resource("alicloud_test")
    instance = generator.ROS2TerraformRuleGenerator(src, dst)
    path = instance._get_rule_path()
    assert not instance.generate()
    (tf_rules / "test.yml").write_text(
        yaml.safe_dump({"Properties": {"name": {"To": "Name"}}})
    )
    assert instance.generate()
    with open(path) as stream:
        result = yaml.safe_load(stream)
    assert result["Properties"]["Name"] == {"To": "name"}
    result["Properties"]["Name"] = {"To": "manual"}
    result["ResourceType"]["BuiltInProperties"] = {"region": "x"}
    with open(path, "w") as stream:
        yaml.safe_dump(result, stream)
    assert instance.generate()
    with open(path) as stream:
        result = yaml.safe_load(stream)
    assert result["Properties"]["Name"] == {"To": "manual"}
    assert result["ResourceType"]["BuiltInProperties"] == {"region": "x"}
    records = {}
    mismatch = generator.ROS2TerraformRuleGenerator(src, resource("alicloud_other"))
    assert not mismatch.generate(mismatch_records=records)
    assert (
        records[src.resource_type]["TerraformResourceTypeInRuleFile"] == "alicloud_test"
    )


def test_multiple_mapping_file_round_trip(tmp_path, monkeypatch):
    path = tmp_path / "mappings.json"
    monkeypatch.setattr(generator, "MULTIPLE_MAPPINGS_PATH", str(path))
    assert generator.ROS2TerraformRuleGenerator.load_multiple_mappings() == {}
    expected = {"ALIYUN::ECS::Test": {"CorrectTerraformResourceType": "alicloud_test"}}
    generator.ROS2TerraformRuleGenerator.save_multiple_mappings(expected)
    assert generator.ROS2TerraformRuleGenerator.load_multiple_mappings() == expected


def test_forward_generation_preserves_manual_mapping_and_attribute_id(
    tmp_path, monkeypatch
):
    monkeypatch.setattr(generator, "TF_ALI_RULES_DIR", str(tmp_path))
    monkeypatch.setattr(generator, "TF_ALI_ROS_PROP_MAPPINGS", {})
    source = resource("alicloud_test", {"legacy": {"Type": "string"}}, {})
    target = resource("ALIYUN::Test", {}, {})
    instance = generator.TerraformRuleGenerator(source, target)
    path = tmp_path / "test.yml"
    path.write_text(
        yaml.safe_dump(
            {
                "Properties": {"legacy": {"To": "ManualName"}},
                "Attributes": {"id": {"To": "InstanceId"}},
            }
        )
    )
    instance.generate()
    result = yaml.safe_load(path.read_text())
    assert result["Properties"]["legacy"] == {"To": "ManualName"}
    assert result["Attributes"]["id"]["To"] == "InstanceId"


def test_reverse_nested_mapping_and_missing_target_schemas(monkeypatch):
    monkeypatch.setattr(generator, "TF_ALI_DEPRECATED_PROPERTIES", {})
    instance = generator.ROS2TerraformRuleGenerator(
        resource("ALIYUN::Test"), resource("alicloud_test")
    )
    rules = {
        "map": {"To": "Map", "Type": "Map", "Schema": {"name": {"To": "Name"}}},
        "list": {"To": "List", "Type": "List", "Schema": {"value": {"To": "Value"}}},
        "missing": {"To": "Missing", "Type": "Map", "Schema": {"x": {"To": "X"}}},
        "unknown": {"To": "Unknown", "Type": "Other", "Schema": {"x": {"To": "X"}}},
    }
    schemas = {
        "Map": {"Schema": {"Name": {}}},
        "List": {"Schema": {"*": {"Schema": {"Value": {}}}}},
        "Missing": {},
        "Unknown": {},
    }
    result = instance._get_rule_section(rules, schemas)
    assert result["Map"]["Schema"] == {"Name": {"To": "name"}}
    assert result["List"]["Schema"] == {"Value": {"To": "value"}}
    assert "Schema" not in result["Missing"]
    assert "Schema" not in result["Unknown"]


def test_cloudformation_mapping_falls_back_to_explicit_property_mapping(monkeypatch):
    monkeypatch.setattr(
        generator,
        "CF_ROS_PROP_MAPPINGS",
        {"AWS::Test": {"old": "New"}, "*": {"common": "Shared"}},
    )
    instance = generator.CloudFormationRuleGenerator(
        resource("AWS::Test"), resource("ALIYUN::Test")
    )
    assert instance._get_ros_key({"Name": {}}, "Name", "Name") == "Name"
    assert instance._get_ros_key({}, "old", "old") == "New"
    assert instance._get_ros_key({}, "common", "common") == "Shared"
    assert instance._get_ros_key({}, "missing", "missing") is None


def test_generator_initializers_use_clients_and_asty(monkeypatch):
    monkeypatch.setattr(generator.shutil, "which", lambda name: "/bin/asty")
    monkeypatch.setattr(generator, "CredClient", lambda: object())
    monkeypatch.setattr(generator.open_api_models, "Config", lambda **kwargs: kwargs)
    monkeypatch.setattr(generator, "Client", lambda config: "ros-client")
    monkeypatch.setattr(generator.boto3, "client", lambda name: "cf-client")
    terraform = generator.TerraformRuleGenerator.initialize(
        "alicloud_test", "ALIYUN::Test", "custom"
    )
    assert terraform.from_resource.resource_filename == "custom"
    assert terraform.to_resource.client == "ros-client"
    cf = generator.CloudFormationRuleGenerator.initialize("AWS::Test", "ALIYUN::Test")
    assert cf.from_resource.client == "cf-client"
    reverse = generator.ROS2TerraformRuleGenerator.initialize(
        "ALIYUN::Test", "alicloud_test"
    )
    assert reverse.from_resource.client == "ros-client"
    assert reverse.to_resource.resource_type == "alicloud_test"


def test_property_rule_generator_handles_oneof_and_nested_type_mismatches(monkeypatch):
    monkeypatch.setattr(generator, "CF_ROS_PROP_MAPPINGS", {})
    instance = generator.CloudFormationRuleGenerator(
        resource("AWS::Test"), resource("ALIYUN::Test")
    )
    source = {
        "Choice": {"oneof": [{"Type": "string"}]},
        "Map": {"Type": "map", "Schema": {"Type": "boolean"}},
        "List": {"Type": "list", "Schema": {"*": {"Type": "string"}}},
    }
    target = {
        "Choice": {"Type": "string"},
        "Map": {"Type": "map", "Schema": {"Type": "integer"}},
        "List": {"Type": "list"},
    }
    result = instance._generate_properties_rule(source, target)
    assert result["Choice"] == {"Ignore": True}
    assert result["Map"] == {"Ignore": True}
    assert result["List"] == {"To": "List", "Type": "List"}


def test_reverse_mapping_selection_can_reject_nonpreferred_type(tmp_path, monkeypatch):
    monkeypatch.setattr(generator, "ROS_RESOURCE_RULES_DIR", str(tmp_path))
    instance = generator.ROS2TerraformRuleGenerator(
        resource("ALIYUN::Test"), resource("alicloud_old")
    )
    mappings = {"ALIYUN::Test": {"CorrectTerraformResourceType": "alicloud_new"}}
    assert not instance.generate(multiple_mappings=mappings)
    assert list(tmp_path.iterdir()) == []


def test_cloudformation_generation_writes_empty_rules_when_no_properties(
    tmp_path, monkeypatch
):
    monkeypatch.setattr(generator, "CF_RESOURCE_RULES_DIR", str(tmp_path))
    instance = generator.CloudFormationRuleGenerator(
        resource("AWS::EC2::Test"), resource("ALIYUN::Test")
    )
    instance.generate()
    result = yaml.safe_load((tmp_path / "aws_ec2_test.yml").read_text())
    assert result["ResourceType"] == {"From": "AWS::EC2::Test", "To": "ALIYUN::Test"}
    assert "Properties" not in result and "Attributes" not in result


def test_reverse_generation_records_preferred_mapping(tmp_path, monkeypatch):
    tf_rules = tmp_path / "tf"
    ros_rules = tmp_path / "ros"
    tf_rules.mkdir()
    ros_rules.mkdir()
    monkeypatch.setattr(generator, "TF_ALI_RULES_DIR", str(tf_rules))
    monkeypatch.setattr(generator, "ROS_RESOURCE_RULES_DIR", str(ros_rules))
    (tf_rules / "test.yml").write_text("Properties: {}\nAttributes: {}\n")
    instance = generator.ROS2TerraformRuleGenerator(
        resource("ALIYUN::Test"), resource("alicloud_test")
    )
    mappings = {"ALIYUN::Test": {"CorrectTerraformResourceType": "alicloud_test"}}
    assert instance.generate(multiple_mappings=mappings)
    assert (
        mappings["ALIYUN::Test"]["TerraformResourceTypeInRuleFile"] == "alicloud_test"
    )


def test_reverse_mapping_ignores_absent_targets_and_incomplete_nested_schema(
    monkeypatch,
):
    monkeypatch.setattr(generator, "TF_ALI_DEPRECATED_PROPERTIES", {})
    instance = generator.ROS2TerraformRuleGenerator(
        resource("ALIYUN::Test"), resource("alicloud_test")
    )
    rules = {
        "absent": {"To": ""},
        "list": {"To": "List", "Type": "List", "Schema": {"x": {"To": "X"}}},
    }
    result = instance._get_rule_section(rules, {"List": {}})
    assert result == {"List": {"To": "list", "Type": "List"}}
