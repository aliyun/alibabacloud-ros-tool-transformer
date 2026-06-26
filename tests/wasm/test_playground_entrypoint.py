import json
import subprocess
import sys


def _run(payload: dict) -> dict:
    from rostran import wasm

    return json.loads(wasm.handle(json.dumps(payload)))


def test_transform_cloudformation_json_to_ros_yaml():
    payload = {
        "operation": "transform",
        "sourceFormat": "cloudformation",
        "inputFormat": "json",
        "targetFormat": "yaml",
        "content": json.dumps(
            {
                "AWSTemplateFormatVersion": "2010-09-09",
                "Resources": {
                    "Vpc": {
                        "Type": "AWS::EC2::VPC",
                        "Properties": {"CidrBlock": "192.168.0.0/16"},
                    }
                },
            }
        ),
    }

    result = _run(payload)

    assert result["ok"] is True
    assert result["targets"] == [
        {
            "filename": "template.yml",
            "content": (
                "ROSTemplateFormatVersion: '2015-09-01'\n"
                "Resources:\n"
                "  Vpc:\n"
                "    Type: ALIYUN::ECS::VPC\n"
                "    Properties:\n"
                "      CidrBlock: 192.168.0.0/16\n"
            ),
        }
    ]
    assert "Transforming CloudFormation template to ROS template" in result["log"]


def test_format_ros_yaml_to_json():
    payload = {
        "operation": "format",
        "sourceFormat": "ros",
        "inputFormat": "yaml",
        "targetFormat": "json",
        "content": (
            "ROSTemplateFormatVersion: '2015-09-01'\n"
            "Resources:\n"
            "  Sg:\n"
            "    Type: ALIYUN::ECS::SecurityGroup\n"
            "    Properties:\n"
            "      SecurityGroupName: demo\n"
        ),
    }

    result = _run(payload)

    assert result["ok"] is True
    assert result["targets"][0]["filename"] == "template.json"
    assert json.loads(result["targets"][0]["content"]) == {
        "ROSTemplateFormatVersion": "2015-09-01",
        "Resources": {
            "Sg": {
                "Type": "ALIYUN::ECS::SecurityGroup",
                "Properties": {"SecurityGroupName": "demo"},
            }
        },
    }


def test_terraform_reports_server_start_guidance():
    payload = {
        "operation": "transform",
        "sourceFormat": "terraform",
        "inputFormat": "hcl",
        "targetFormat": "yaml",
        "content": 'resource "alicloud_vpc" "demo" {}\n',
    }

    result = _run(payload)

    assert result["ok"] is False
    assert result["error"]["type"] == "UnsupportedSourceFormat"
    assert "rostran server start" in result["error"]["message"]


def test_provider_exports_are_lazy_for_browser_subset():
    code = """
import sys
import rostran.providers
assert 'rostran.providers.terraform.template' not in sys.modules
assert 'rostran.providers.ros.template' not in sys.modules
_ = rostran.providers.CloudFormationTemplate
assert 'rostran.providers.cloudformation.template' in sys.modules
assert 'rostran.providers.terraform.template' not in sys.modules
assert 'rostran.providers.ros.template' not in sys.modules
"""

    result = subprocess.run(
        [sys.executable, "-c", code],
        check=False,
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0, result.stderr
