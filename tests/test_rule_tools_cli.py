from types import SimpleNamespace
from unittest.mock import Mock

import pytest
import typer
import yaml

from tools import exceptions
from tools.cli import __main__ as cli
from tools.formatter import RuleFormatter


def test_rule_formatter_orders_nested_rules_and_skips_other_files(tmp_path):
    path = tmp_path / "rule.yml"
    path.write_text(
        yaml.safe_dump(
            {
                "Type": "Resource",
                "Version": "2020-06-01",
                "Properties": {
                    "b": {"Schema": {"z": {"Type": "String", "To": "Z"}}, "To": "B"},
                    "a": {"To": "A"},
                },
                "Attributes": {"z": {"To": "Z"}, "id": {"To": "Id"}},
            }
        )
    )
    (tmp_path / "ignored.txt").write_text("untouched")
    RuleFormatter(str(tmp_path)).format()
    rule = yaml.safe_load(path.read_text())
    assert list(rule)[:2] == ["Version", "Type"]
    assert list(rule["Properties"]) == ["a", "b"]
    assert list(rule["Attributes"])[0] == "id"
    assert (tmp_path / "ignored.txt").read_text() == "untouched"
    with pytest.raises(ValueError, match="rule_dir"):
        RuleFormatter().format()


@pytest.mark.parametrize(
    ("ros", "tf", "cf", "message"),
    [
        ("", "alicloud_test", "", "--ros"),
        ("ALIYUN::Test", "", "", "--tf/--cf"),
        ("ALIYUN::Test", "tf", "cf", "not both"),
        ("ALIYUN::Test", "unknown", "", "not supported"),
    ],
)
def test_generate_rejects_invalid_arguments(ros, tf, cf, message):
    with pytest.raises(exceptions.RosToolException, match=message):
        cli.generate(ros=ros, tf=tf, cf=cf, ros2tf=False)


def test_generate_calls_terraform_and_cloudformation_generators(monkeypatch):
    instance = SimpleNamespace(generate=Mock())
    terraform = Mock(return_value=instance)
    cloudformation = Mock(return_value=instance)
    monkeypatch.setattr(
        cli, "TF_ALI_ROS_GENERATE_MAPPINGS", {"alicloud_test": "ALIYUN::Test"}
    )
    monkeypatch.setattr(cli.TerraformRuleGenerator, "initialize", terraform)
    monkeypatch.setattr(cli.CloudFormationRuleGenerator, "initialize", cloudformation)
    cli.generate(ros="ALIYUN::Test", tf="alicloud_test", cf="", ros2tf=False)
    terraform.assert_called_once_with("alicloud_test", "ALIYUN::Test", None)
    cli.generate(ros="ALIYUN::Test", tf="", cf="AWS::Test", ros2tf=False)
    cloudformation.assert_called_once_with("AWS::Test", "ALIYUN::Test")
    assert instance.generate.call_count == 2


def test_reverse_generation_persists_mapping_mismatches(monkeypatch):
    saved = Mock()
    monkeypatch.setattr(
        cli, "TF_ALI_ROS_GENERATE_MAPPINGS", {"alicloud_test": "ALIYUN::Test"}
    )
    monkeypatch.setattr(
        cli.ROS2TerraformRuleGenerator, "load_multiple_mappings", lambda: {"old": {}}
    )
    monkeypatch.setattr(cli.ROS2TerraformRuleGenerator, "save_multiple_mappings", saved)

    def generate(mismatch_records, multiple_mappings):
        mismatch_records["ALIYUN::Test"] = {"types": ["x", "y"]}
        return False

    monkeypatch.setattr(
        cli.ROS2TerraformRuleGenerator,
        "initialize",
        lambda *args: SimpleNamespace(generate=generate),
    )
    with pytest.raises(typer.Exit):
        cli.generate(ros="ALIYUN::Test", tf="alicloud_test", cf="", ros2tf=True)
    assert "ALIYUN::Test" in saved.call_args.args[0]


def test_generate_all_filters_and_uses_explicit_filenames(monkeypatch):
    instance = SimpleNamespace(generate=Mock())
    initialize = Mock(return_value=instance)
    monkeypatch.setattr(
        cli,
        "TF_ALI_ROS_GENERATE_MAPPINGS",
        {
            "alicloud_test": ("custom_file", "ALIYUN::Test"),
            "alicloud_other": "ALIYUN::Other",
        },
    )
    monkeypatch.setattr(cli, "CF_ROS_GENERATE_MAPPINGS", {})
    monkeypatch.setattr(cli.TerraformRuleGenerator, "initialize", initialize)
    cli.generate(ros="all", tf="all", cf="", ros2tf=False)
    initialize.assert_any_call("alicloud_test", "ALIYUN::Test", "custom_file")
    initialize.assert_any_call("alicloud_other", "ALIYUN::Other", None)


def test_format_invokes_both_rule_directories(monkeypatch):
    calls = []
    monkeypatch.setattr(cli, "TF_ALI_RULES_DIR", "terraform")
    monkeypatch.setattr(cli, "CF_RESOURCE_RULES_DIR", "cloudformation")
    monkeypatch.setattr(
        cli,
        "RuleFormatter",
        lambda path: SimpleNamespace(format=lambda: calls.append(path)),
    )
    cli.format()
    assert calls == ["terraform", "cloudformation"]


@pytest.mark.parametrize(
    "error",
    [
        exceptions.RosToolWarning(message="warning"),
        exceptions.RosToolException(message="error"),
        ValueError("unexpected"),
    ],
)
def test_main_reports_failures(monkeypatch, capsys, error):
    def command(**kwargs):
        raise error

    monkeypatch.setattr(typer.main, "get_command", lambda app: command)
    cli.main()
    output = capsys.readouterr().out
    assert str(error) in output


def test_default_generation_and_filter_use_configured_mappings(monkeypatch):
    monkeypatch.setenv("TERRAFORM_PROVIDER_ALICLOUD", "/example/provider")
    monkeypatch.setattr(
        cli, "TF_ALI_ROS_GENERATE_MAPPINGS", {"alicloud_test": "ALIYUN::Test"}
    )
    monkeypatch.setattr(cli, "CF_ROS_GENERATE_MAPPINGS", {"AWS::Test": "ALIYUN::Test"})
    terraform = Mock(return_value=SimpleNamespace(generate=Mock()))
    cloudformation = Mock(return_value=SimpleNamespace(generate=Mock()))
    monkeypatch.setattr(cli.TerraformRuleGenerator, "initialize", terraform)
    monkeypatch.setattr(cli.CloudFormationRuleGenerator, "initialize", cloudformation)
    cli.generate(ros="", tf="", cf="", ros2tf=False)
    terraform.assert_called_once_with("alicloud_test", "ALIYUN::Test", None)
    cloudformation.assert_called_once_with("AWS::Test", "ALIYUN::Test")
    terraform.reset_mock()
    cli.generate(ros="ALIYUN::Test", tf="all", cf="", ros2tf=False)
    terraform.assert_called_once()


def test_reverse_default_generation_saves_existing_mappings(monkeypatch):
    monkeypatch.setattr(
        cli, "TF_ALI_ROS_GENERATE_MAPPINGS", {"alicloud_test": "ALIYUN::Test"}
    )
    monkeypatch.setattr(
        cli.ROS2TerraformRuleGenerator,
        "load_multiple_mappings",
        lambda: {"existing": {}},
    )
    save = Mock()
    monkeypatch.setattr(cli.ROS2TerraformRuleGenerator, "save_multiple_mappings", save)
    monkeypatch.setattr(
        cli.ROS2TerraformRuleGenerator,
        "initialize",
        lambda *args: SimpleNamespace(generate=lambda **kwargs: True),
    )
    cli.generate(ros="", tf="", cf="unused", ros2tf=True)
    save.assert_called_once_with({"existing": {}})
