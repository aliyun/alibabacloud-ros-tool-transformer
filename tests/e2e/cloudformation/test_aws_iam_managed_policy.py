from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "CreateTestDBPolicy": {
            "Type": "AWS::IAM::ManagedPolicy",
            "Properties": {
                "Description": "Policy for creating a test database",
                "Path": "/",
                "PolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Action": "rds:CreateDBInstance",
                            "Resource": {
                                "Fn::Join": [
                                    "",
                                    [
                                        "arn:aws:rds:",
                                        {"Ref": "AWS::Region"},
                                        ":",
                                        {"Ref": "AWS::AccountId"},
                                        ":db:test*",
                                    ],
                                ]
                            },
                            "Condition": {
                                "StringEquals": {"rds:DatabaseEngine": "mysql"}
                            },
                        },
                        {
                            "Effect": "Allow",
                            "Action": "rds:CreateDBInstance",
                            "Resource": {
                                "Fn::Join": [
                                    "",
                                    [
                                        "arn:aws:rds:",
                                        {"Ref": "AWS::Region"},
                                        ":",
                                        {"Ref": "AWS::AccountId"},
                                        ":db:test*",
                                    ],
                                ]
                            },
                            "Condition": {
                                "StringEquals": {"rds:DatabaseClass": "db.t2.micro"}
                            },
                        },
                    ],
                },
                "Groups": ["TestDBGroup"],
            },
        }
    },
}
ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "CreateTestDBPolicy": {
            "Type": "ALIYUN::RAM::ManagedPolicy",
            "Properties": {
                "Description": "Policy for creating a test database",
                "PolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Action": "rds:CreateDBInstance",
                            "Resource": {
                                "Fn::Join": [
                                    "",
                                    [
                                        "arn:aws:rds:",  # todo: replace arn:aws:xxx
                                        {"Ref": "ALIYUN::Region"},
                                        ":",
                                        {"Ref": "ALIYUN::TenantId"},
                                        ":db:test*",
                                    ],
                                ]
                            },
                            "Condition": {
                                "StringEquals": {"rds:DatabaseEngine": "mysql"}
                            },
                        },
                        {
                            "Effect": "Allow",
                            "Action": "rds:CreateDBInstance",
                            "Resource": {
                                "Fn::Join": [
                                    "",
                                    [
                                        "arn:aws:rds:",
                                        {"Ref": "ALIYUN::Region"},
                                        ":",
                                        {"Ref": "ALIYUN::TenantId"},
                                        ":db:test*",
                                    ],
                                ]
                            },
                            "Condition": {
                                "StringEquals": {"rds:DatabaseClass": "db.t2.micro"}
                            },
                        },
                    ],
                },
                "Groups": ["TestDBGroup"],
            },
        }
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
