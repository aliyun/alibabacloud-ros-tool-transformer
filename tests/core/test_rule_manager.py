from types import SimpleNamespace

import pytest

from rostran.core import rule_manager as rm
from rostran.core.exceptions import (
    InvalidRuleSchema,
    RuleAlreadyExist,
    RuleTypeNotSupport,
    RuleVersionNotSupport,
)


def test_user_rules_override_builtin_and_missing_rules_are_allowed(
    tmp_path, monkeypatch
):
    user = tmp_path / "user"
    builtin = tmp_path / "builtin"
    (builtin / "ros").mkdir(parents=True)
    monkeypatch.setattr(rm, "USER_RULES_DIR", str(user))
    monkeypatch.setattr(rm, "RULES_DIR", str(builtin))
    manager = rm.RuleManager("ros")
    assert manager._get_rules_dirs() == [str(builtin / "ros")]
    (user / "ros").mkdir(parents=True)
    assert manager._get_rules_dirs() == [str(user / "ros")]
    assert rm.RuleManager("unknown")._get_rules_dirs() == []


@pytest.mark.parametrize(
    ("content", "exception"),
    [
        ("- invalid\n", InvalidRuleSchema),
        ("Version: old\nType: Resource\n", RuleVersionNotSupport),
        ("Version: '2020-06-01'\nType: Unknown\n", RuleTypeNotSupport),
    ],
)
def test_invalid_rule_files_are_rejected(tmp_path, content, exception):
    path = tmp_path / "invalid.yml"
    path.write_text(content)
    with pytest.raises(exception):
        rm.Rule.initialize(str(path))


@pytest.mark.parametrize(
    ("kind", "field", "value"),
    [
        ("Resource", "ResourceType", "{From: source, To: target}"),
        ("PseudoParameters", "PseudoParameters", "{p: {To: target}}"),
        ("Function", "Function", "{f: {To: target}}"),
        ("Metadata", "Metadata", "{m: {To: target}}"),
        ("AssociationProperty", "AssociationProperty", "{a: {To: target}}"),
    ],
)
def test_loading_a_duplicate_rule_fails(tmp_path, kind, field, value):
    content = f"Version: '2020-06-01'\nType: {kind}\n{field}: {value}\n"
    (tmp_path / "first.yml").write_text(content)
    (tmp_path / "second.yml").write_text(content)
    (tmp_path / "ignored.yaml").write_text("invalid")
    with pytest.raises(RuleAlreadyExist):
        rm.RuleManager("example")._load_from_dir(str(tmp_path))


def test_show_formats_rules_and_documentation_links(capsys):
    manager = rm.RuleManager(
        rm.RuleClassifier.TerraformAliCloud,
        resource_rules={
            "alicloud_ecs_instance": SimpleNamespace(
                target_resource_type="ALIYUN::ECS::Instance"
            ),
            "alicloud_unused": SimpleNamespace(target_resource_type=None),
        },
        pseudo_parameters_rule=SimpleNamespace(
            pseudo_parameters={"region": {"To": "Region"}}
        ),
        function_rule=SimpleNamespace(function={"ref": {"To": "Ref"}}),
        association_property_rule=SimpleNamespace(
            association_property={"zone": {"To": "Zone"}}
        ),
        meta_data_rule=SimpleNamespace(meta_data={"meta": {"To": "Metadata"}}),
    )
    manager.show(markdown=True, with_link=True)
    output = capsys.readouterr().out
    assert "## Resources" in output
    assert (
        "registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_instance"
        in output
    )
    assert "alibabacloud.com/help/ros/developer-reference/aliyun-ecs-instance" in output
    assert "alicloud_unused" not in output
    for section in (
        "Pseudo Parameters",
        "Function",
        "Association Property",
        "Metadata",
    ):
        assert f"## {section}" in output


@pytest.mark.parametrize(
    ("classifier", "link"),
    [
        (rm.RuleClassifier.CloudFormation, "aws-resource-ec2-vpc"),
        (rm.RuleClassifier.ROS, None),
    ],
)
def test_show_resource_links_for_other_classifiers(classifier, link, capsys):
    manager = rm.RuleManager(
        classifier,
        resource_rules={
            "AWS::EC2::VPC": SimpleNamespace(target_resource_type="ALIYUN::ECS::VPC")
        },
    )
    manager.show(markdown=True, with_link=True)
    output = capsys.readouterr().out
    if link:
        assert link in output
    else:
        assert "[AWS::EC2::VPC]" not in output
    manager.show()
    assert "AWS::EC2::VPC -> ALIYUN::ECS::VPC" in capsys.readouterr().out


@pytest.mark.parametrize(
    ("kind", "fields"),
    [
        ("Resource", {"ResourceType": []}),
        ("Resource", {"ResourceType": {"From": "x"}, "Properties": []}),
        ("Resource", {"ResourceType": {"From": "x"}, "Attributes": []}),
        ("PseudoParameters", {"PseudoParameters": []}),
        ("Function", {"Function": []}),
        ("Metadata", {"Metadata": []}),
        ("AssociationProperty", {"AssociationProperty": []}),
    ],
)
def test_invalid_rule_sections_raise_schema_error(tmp_path, kind, fields):
    import json

    path = tmp_path / "invalid.yml"
    path.write_text(json.dumps({"Version": "2020-06-01", "Type": kind, **fields}))
    with pytest.raises(InvalidRuleSchema):
        rm.Rule.initialize(str(path))


@pytest.mark.parametrize(
    ("field", "value", "heading"),
    [
        (
            "pseudo_parameters_rule",
            SimpleNamespace(pseudo_parameters={"p": {"To": "target"}}),
            "Pseudo Parameters",
        ),
        (
            "function_rule",
            SimpleNamespace(function={"f": {"To": "target"}}),
            "Function",
        ),
        (
            "association_property_rule",
            SimpleNamespace(association_property={"a": {"To": "target"}}),
            "Association Property",
        ),
        (
            "meta_data_rule",
            SimpleNamespace(meta_data={"m": {"To": "target"}}),
            "Metadata",
        ),
    ],
)
def test_show_single_rule_category_without_resource_heading(
    field, value, heading, capsys
):
    manager = rm.RuleManager("test", **{field: value})
    manager.show(markdown=True, with_link=False)
    output = capsys.readouterr().out
    assert f"## {heading}" in output
    assert "| From |  To  |" in output


def test_load_ignores_dangling_yaml_link(tmp_path):
    (tmp_path / "broken.yml").symlink_to(tmp_path / "missing.yml")
    manager = rm.RuleManager("test")
    manager._load_from_dir(str(tmp_path))
    assert manager.resource_rules == {}
