from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "myVPC": {
            "Type": "AWS::EC2::VPC",
            "Properties": {
                "CidrBlock": "10.0.0.0/16",
                "EnableDnsSupport": "true",
                "EnableDnsHostnames": "true",
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
        "mySubnet": {
            "Type": "AWS::EC2::Subnet",
            "Properties": {
                "VpcId": {"Ref": "myVPC"},
                "CidrBlock": "10.0.0.0/24",
                "AvailabilityZone": "us-east-1a",
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
    },
}
ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "myVPC": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "10.0.0.0/16",
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
        "mySubnet": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "VpcId": {"Ref": "myVPC"},
                "CidrBlock": "10.0.0.0/24",
                "ZoneId": "us-east-1a",
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
