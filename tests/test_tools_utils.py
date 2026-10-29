from types import SimpleNamespace

import pytest

from tools import utils


@pytest.mark.parametrize(
    ("source", "expected"),
    [
        ("VpcId", "vpc_id"),
        ("HTTPServer", "httpserver"),
        ("foo_bar", "foo_bar"),
        ("a.b", "a.b"),
    ],
)
def test_camel_to_snake(source, expected):
    assert utils.camel_to_snake(source) == expected


def test_name_conversions():
    assert utils.snake_to_camel("ecs_instance") == "EcsInstance"
    assert utils.camel_to_tf("server.instance_id") == "server_instance_id"


def test_cloudformation_types_are_paginated(monkeypatch):
    calls = []

    def list_types(**kwargs):
        calls.append(kwargs)
        if "NextToken" not in kwargs:
            return {
                "TypeSummaries": [{"TypeName": "AWS::EC2::VPC"}],
                "NextToken": "next",
            }
        return {"TypeSummaries": [{"TypeName": "AWS::S3::Bucket"}]}

    monkeypatch.setattr(
        utils.boto3, "client", lambda name: SimpleNamespace(list_types=list_types)
    )
    assert utils.list_cf_types() == ["AWS::EC2::VPC", "AWS::S3::Bucket"]
    assert "NextToken" not in calls[0]
    assert calls[1]["NextToken"] == "next"


def test_print_cloudformation_mapping_includes_known_missing_and_ignores_other_providers(
    monkeypatch, capsys
):
    monkeypatch.setattr("tools.settings.CF_ROS_GENERATE_MAPPINGS", {})
    monkeypatch.setattr(utils, "CF_ROS_PROD_MAPPINGS", {})
    utils.print_cf_ros_mapping(
        ["AWS::EC2::Vpc", "AWS::EC2::Missing", "Other::EC2::Vpc"], ["ALIYUN::EC2::Vpc"]
    )
    output = capsys.readouterr().out
    assert '"AWS::EC2::Vpc": "ALIYUN::EC2::Vpc"' in output
    assert '# "AWS::EC2::Missing": ""' in output
    assert "Other::" not in output


def test_terraform_mapping_scans_provider_files(tmp_path, monkeypatch, capsys):
    folder = tmp_path / "alicloud"
    folder.mkdir()
    for name in (
        "resource_alicloud_ecs_instance.go",
        "resource_alicloud_ecs_instance_test.go",
    ):
        (folder / name).touch()
    monkeypatch.setenv("TERRAFORM_PROVIDER_ALICLOUD", str(tmp_path))
    monkeypatch.setattr(utils, "TF_ALI_ROS_GENERATE_MAPPINGS", {})
    monkeypatch.setattr(utils, "TF_ALI_ROS_PROD_MAPPINGS", {"ecs": "ECS"})
    utils.print_tf_ali_ros_mapping(["ALIYUN::ECS::Instance"])
    output = capsys.readouterr().out
    assert '"alicloud_ecs_instance": "ALIYUN::ECS::Instance"' in output
    assert "instance_test" not in output


def test_mapping_uses_remote_types_when_inputs_are_missing(
    tmp_path, monkeypatch, capsys
):
    monkeypatch.delenv("TERRAFORM_PROVIDER_ALICLOUD", raising=False)
    assert utils.print_tf_ali_ros_mapping() == {}
    folder = tmp_path / "alicloud"
    folder.mkdir()
    (folder / "resource_alicloud_ecs_instance.go").touch()
    (folder / "resource_alicloud_ecs_missing.go").touch()
    monkeypatch.setenv("TERRAFORM_PROVIDER_ALICLOUD", str(tmp_path))
    monkeypatch.setattr(utils, "list_ros_types", lambda: ["ALIYUN::ECS::Instance"])
    monkeypatch.setattr(utils, "TF_ALI_ROS_GENERATE_MAPPINGS", {})
    monkeypatch.setattr(utils, "TF_ALI_ROS_PROD_MAPPINGS", {"ecs": "ECS"})
    utils.print_tf_ali_ros_mapping()
    output = capsys.readouterr().out
    assert '"alicloud_ecs_instance": "ALIYUN::ECS::Instance"' in output
    assert '# "alicloud_ecs_missing": ""' in output


def test_mapping_printer_handles_multiple_targets(capsys):
    utils._print_mapping_orderly({"many": ["one", "two"], "none": None})
    output = capsys.readouterr().out
    assert '"one",' in output and '"two",' in output
    assert '# "none": ""' in output


def test_list_ros_types_uses_client(monkeypatch):
    monkeypatch.setattr(utils, "CredClient", lambda: "credentials")
    monkeypatch.setattr(utils.open_api_models, "Config", lambda **kwargs: kwargs)
    client = SimpleNamespace(
        list_resource_types=lambda request: SimpleNamespace(
            body=SimpleNamespace(resource_types=["ALIYUN::Test"])
        )
    )
    monkeypatch.setattr(utils, "Client", lambda config: client)
    assert utils.list_ros_types() == ["ALIYUN::Test"]


def test_mapping_skips_existing_and_unrecognized_files(tmp_path, monkeypatch, capsys):
    folder = tmp_path / "alicloud"
    folder.mkdir()
    for name in (
        "README.md",
        "resource_alicloud_ecs_instance.go",
        "resource_alicloud__bad.go",
    ):
        (folder / name).touch()
    monkeypatch.setenv("TERRAFORM_PROVIDER_ALICLOUD", str(tmp_path))
    monkeypatch.setattr(
        utils, "TF_ALI_ROS_GENERATE_MAPPINGS", {"alicloud_ecs_instance": "known"}
    )
    utils.print_tf_ali_ros_mapping(["ALIYUN::ECS::Instance"])
    assert "known" in capsys.readouterr().out


def test_cloudformation_mapping_uses_discovered_types_and_keeps_known_mapping(
    monkeypatch, capsys
):
    monkeypatch.setattr(
        "tools.settings.CF_ROS_GENERATE_MAPPINGS", {"AWS::EC2::Vpc": "known"}
    )
    monkeypatch.setattr(utils, "list_cf_types", lambda: ["AWS::EC2::Vpc"])
    monkeypatch.setattr(utils, "list_ros_types", lambda: ["ALIYUN::ECS::Vpc"])
    utils.print_cf_ros_mapping()
    assert "known" in capsys.readouterr().out
