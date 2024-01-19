from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "Vpc": {"Type": "AWS::EC2::VPC", "Properties": {"CidrBlock": "10.0.0.0/16"}},
        "VpnGateway": {
            "Type": "AWS::EC2::VPNGateway",
            "Properties": {
                "Type": "ipsec.1",
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
        "VpnGatewayAttachment": {
            "Type": "AWS::EC2::VPCGatewayAttachment",
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "VpnGatewayId": {"Ref": "VpnGateway"},
            },
        },
    },
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "Vpc": {"Type": "ALIYUN::ECS::VPC", "Properties": {"CidrBlock": "10.0.0.0/16"}},
        "VpnGateway": {
            "Type": "ALIYUN::VPC::VpnGateway",
            "Properties": {
                "VpcId": {"Ref": "Vpc"},
                "Tags": [{"Key": "stack", "Value": "production"}],
            },
        },
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
