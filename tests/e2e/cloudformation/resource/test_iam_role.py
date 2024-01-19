from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "RootRole": {
            "Type": "AWS::IAM::Role",
            "Properties": {
                "AssumeRolePolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Principal": {"Service": ["ec2.amazonaws.com"]},
                            "Action": ["sts:AssumeRole"],
                        }
                    ],
                },
                "Path": "/",
                "Policies": [
                    {
                        "PolicyName": "root",
                        "PolicyDocument": {
                            "Version": "2012-10-17",
                            "Statement": [
                                {"Effect": "Allow", "Action": "*", "Resource": "*"}
                            ],
                        },
                    }
                ],
            },
        },
        "RootInstanceProfile": {
            "Type": "AWS::IAM::InstanceProfile",
            "Properties": {"Path": "/", "Roles": [{"Ref": "RootRole"}]},
        },
    },
}
ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "RootRole": {
            "Type": "ALIYUN::RAM::Role",
            "Properties": {
                "AssumeRolePolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Principal": {
                                "Service": ["ec2.amazonaws.com"]
                            },  # todo: convert to aliyun service
                            "Action": ["sts:AssumeRole"],
                        }
                    ],
                },
                "Policies": [
                    {
                        "PolicyName": "root",
                        "PolicyDocument": {
                            "Version": "2012-10-17",
                            "Statement": [
                                {"Effect": "Allow", "Action": "*", "Resource": "*"}
                            ],
                        },
                    }
                ],
            },
        }
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
