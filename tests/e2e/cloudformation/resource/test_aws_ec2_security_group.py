from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "mySecurityGroup": {
            "Type": "AWS::EC2::SecurityGroup",
            "Properties": {
                "GroupDescription": "Allow access to port 3389 from local addresses",
                "VpcId": "vpc-xxxxxx",
                "SecurityGroupIngress": [
                    {
                        "IpProtocol": "tcp",
                        "FromPort": "3380",
                        "ToPort": "3389",
                        "CidrIp": "20.0.0.0/8",
                    }
                ],
                "SecurityGroupEgress": [{"IpProtocol": "tcp", "CidrIp": "0.0.0.0/0"}],
            },
        },
    },
}
ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "mySecurityGroup": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "Description": "Allow access to port 3389 from local addresses",
                "VpcId": "vpc-xxxxxx",
                "SecurityGroupIngress": [
                    {
                        "IpProtocol": "tcp",
                        "PortRange": "3380/3389",
                        "SourceCidrIp": "20.0.0.0/8",
                    }
                ],
                "SecurityGroupEgress": [
                    {"IpProtocol": "tcp", "DestCidrIp": "0.0.0.0/0"}
                ],
            },
        }
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
