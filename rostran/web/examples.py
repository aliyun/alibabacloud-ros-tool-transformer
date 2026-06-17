"""Built-in example templates for the web playground.

Kept inline (as code) so they ship with the package automatically and require no
extra data files. Each example declares the source format it should be
transformed from.
"""

from typing import Dict, List, Optional

_CFN_VPC = """\
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "A minimal VPC with a security group.",
  "Resources": {
    "Vpc": {
      "Type": "AWS::EC2::VPC",
      "Properties": {
        "CidrBlock": "192.168.0.0/16"
      }
    },
    "SecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "Allow SSH",
        "VpcId": { "Ref": "Vpc" }
      }
    }
  },
  "Outputs": {
    "VpcId": {
      "Value": { "Ref": "Vpc" }
    }
  }
}
"""

_ROS_SIMPLE = """\
ROSTemplateFormatVersion: '2015-09-01'
Description: A simple ROS template with one ECS security group.
Parameters:
  VpcId:
    Type: String
    Description: The VPC to create the security group in.
Resources:
  SecurityGroup:
    Type: ALIYUN::ECS::SecurityGroup
    Properties:
      VpcId:
        Ref: VpcId
      SecurityGroupName: web-sg
Outputs:
  SecurityGroupId:
    Value:
      Ref: SecurityGroup
"""

_TF_ALICLOUD = """\
provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "tf-example"
  cidr_block = "192.168.0.0/16"
}

resource "alicloud_security_group" "sg" {
  name   = "tf-example-sg"
  vpc_id = alicloud_vpc.vpc.id
}
"""


_EXAMPLES: List[Dict] = [
    {
        "id": "cloudformation-vpc",
        "title": "CloudFormation: VPC + Security Group",
        "source_format": "cloudformation",
        "filename": "vpc.json",
        "language": "json",
        "content": _CFN_VPC,
    },
    {
        "id": "ros-simple",
        "title": "ROS: Security Group (format / to Terraform)",
        "source_format": "ros",
        "filename": "template.yml",
        "language": "yaml",
        "content": _ROS_SIMPLE,
    },
    {
        "id": "terraform-alicloud",
        "title": "Terraform: AliCloud VPC + Security Group",
        "source_format": "terraform",
        "filename": "main.tf",
        "language": "hcl",
        "content": _TF_ALICLOUD,
    },
]


def list_examples() -> List[Dict]:
    """Return example metadata without the (potentially large) content body."""
    return [{k: v for k, v in ex.items() if k != "content"} for ex in _EXAMPLES]


def get_example(example_id: str) -> Optional[Dict]:
    for ex in _EXAMPLES:
        if ex["id"] == example_id:
            return ex
    return None
