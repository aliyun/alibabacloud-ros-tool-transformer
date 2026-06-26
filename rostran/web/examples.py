"""Built-in example templates for the web playground.

Kept inline (as code) so they ship with the package automatically and require no
extra data files. Each example declares the source format it should be
transformed from.
"""

from typing import Dict, List, Optional

_CFN_VPC = """\
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Description": "A VPC with a subnet and a security group that allows SSH.",
  "Parameters": {
    "VpcCidr": {
      "Type": "String",
      "Default": "192.168.0.0/16",
      "Description": "CIDR block for the VPC."
    },
    "SubnetCidr": {
      "Type": "String",
      "Default": "192.168.1.0/24"
    }
  },
  "Resources": {
    "Vpc": {
      "Type": "AWS::EC2::VPC",
      "Properties": {
        "CidrBlock": { "Ref": "VpcCidr" }
      }
    },
    "Subnet": {
      "Type": "AWS::EC2::Subnet",
      "Properties": {
        "VpcId": { "Ref": "Vpc" },
        "CidrBlock": { "Ref": "SubnetCidr" }
      }
    },
    "SecurityGroup": {
      "Type": "AWS::EC2::SecurityGroup",
      "Properties": {
        "GroupDescription": "Allow SSH",
        "VpcId": { "Ref": "Vpc" },
        "SecurityGroupIngress": [
          {
            "IpProtocol": "tcp",
            "FromPort": 22,
            "ToPort": 22,
            "CidrIp": "0.0.0.0/0"
          }
        ]
      }
    }
  },
  "Outputs": {
    "VpcId": {
      "Value": { "Ref": "Vpc" }
    },
    "SubnetId": {
      "Value": { "Ref": "Subnet" }
    }
  }
}
"""

# Deliberately scrambled (sections and keys out of canonical order, Properties
# before Type) so the Format action produces a visibly reordered, normalized
# template instead of an identical-looking one.
_ROS_SIMPLE = """\
Outputs:
  SecurityGroupId:
    Value:
      Ref: SecurityGroup
  VpcId:
    Value:
      Ref: Vpc
Resources:
  SecurityGroup:
    Properties:
      SecurityGroupName: web-sg
      VpcId:
        Ref: Vpc
    Type: ALIYUN::ECS::SecurityGroup
  VSwitch:
    Properties:
      ZoneId:
        Ref: ZoneId
      VpcId:
        Ref: Vpc
      CidrBlock: 192.168.1.0/24
    Type: ALIYUN::ECS::VSwitch
  Vpc:
    Type: ALIYUN::ECS::VPC
    Properties:
      CidrBlock: 192.168.0.0/16
      VpcName: playground-vpc
Parameters:
  ZoneId:
    Description: The zone to deploy the VSwitch in.
    Type: String
  VpcCidr:
    Default: 192.168.0.0/16
    Type: String
    Description: CIDR block for the VPC.
Description: A VPC with a VSwitch and a security group.
ROSTemplateFormatVersion: '2015-09-01'
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
        "title": "CloudFormation: VPC + Subnet + Security Group",
        "source_format": "cloudformation",
        "filename": "vpc.json",
        "language": "json",
        "content": _CFN_VPC,
    },
    {
        "id": "ros-simple",
        "title": "ROS: VPC + VSwitch + Security Group (format / to Terraform)",
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
