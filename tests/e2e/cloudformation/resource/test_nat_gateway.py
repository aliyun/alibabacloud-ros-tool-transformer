from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "Vpc": {"Type": "AWS::EC2::VPC", "Properties": {"CidrBlock": "10.0.0.0/16"}},
        "Subnet": {
            "Type": "AWS::EC2::Subnet",
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "CidrBlock": "10.0.0.0/24",
                "AvailabilityZone": "us-east-1a",
            },
        },
        "NATGateway": {
            "Type": "AWS::EC2::NatGateway",
            "Properties": {
                "AllocationId": {"Fn::GetAtt": ["NATGatewayEIP", "AllocationId"]},
                "SubnetId": {"Ref": "Subnet"},
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
        "NATGatewayEIP": {"Type": "AWS::EC2::EIP", "Properties": {"Domain": "vpc"}},
    },
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "Vpc": {"Type": "ALIYUN::ECS::VPC", "Properties": {"CidrBlock": "10.0.0.0/16"}},
        "Subnet": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "CidrBlock": "10.0.0.0/24",
                "ZoneId": "us-east-1a",
            },
        },
        "NATGateway": {
            "Type": "ALIYUN::VPC::NatGateway",
            "Properties": {
                "AllocationId": {"Fn::GetAtt": ["NATGatewayEIP", "AllocationId"]},
                "VSwitchId": {"Ref": "Subnet"},
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
        "NATGatewayEIP": {"Type": "ALIYUN::VPC::EIP", "Properties": {}},
        "NATGatewayEIPAssociation": {
            "Type": "ALIYUN::VPC::EIPAssociation",
            "Properties": {
                "AllocationId": {"Fn::GetAtt": ["NATGatewayEIP", "AllocationId"]},
                "InstanceId": "NATGateway",
            },
        },
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
