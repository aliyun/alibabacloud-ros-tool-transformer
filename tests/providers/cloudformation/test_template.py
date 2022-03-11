import os

from rostran.core.format import FileFormat
from rostran.core.settings import ROOT
from rostran.providers.cloudformation.template import CloudFormationTemplate

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Description": "This template create vpc security group.",
    "Metadata": {
        "ALIYUN::ROS::Interface": {
            "ParameterGroups": {
                "Parameters": ["CidrBlock"],
                "Label": {"default": "VPC"},
            },
            "ParameterLabels": {"CidrBlock": {"default": "Vpc Cidr Block"}},
        }
    },
    "Parameters": {
        "CidrBlock": {
            "Type": "String",
            "Default": "10.0.0.0/16",
            "Label": "Vpc Cidr Block",
        }
    },
    "Resources": {
        "MyVpc": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": {"Ref": "CidrBlock"},
                "Tags": [{"Key": "foo", "Value": "bar"}],
            },
            "DeletionPolicy": "Retain",
        },
        "MySg": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "Description": "Create vpc security group",
                "VpcId": {"Ref": "MyVpc"},
            },
            "DependsOn": "MyVpc",
        },
    },
    "Outputs": {
        "VpcId": {"Value": {"Ref": "MyVpc"}},
        "SgId": {"Value": {"Fn::GetAtt": ["MySg", "SecurityGroupId"]}},
    },
}


def test_template():
    aws_template = os.path.join(ROOT, "templates", "cloudformation", "vpc_sg.json")

    template = CloudFormationTemplate.initialize(aws_template, FileFormat.Json)
    assert tpl == template.transform().as_dict()
