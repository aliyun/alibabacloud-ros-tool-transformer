from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Resources": {
        "RecordServiceS3Bucket": {
            "Type": "AWS::S3::Bucket",
            "DeletionPolicy": "Retain",
            "Properties": {
                "ReplicationConfiguration": {
                    "Role": {"Fn::GetAtt": ["WorkItemBucketBackupRole", "Arn"]},
                    "Rules": [
                        {
                            "Destination": {
                                "Bucket": {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {
                                                "Fn::Join": [
                                                    "-",
                                                    [
                                                        {"Ref": "AWS::Region"},
                                                        {"Ref": "AWS::StackName"},
                                                        "replicationbucket",
                                                    ],
                                                ]
                                            },
                                        ],
                                    ]
                                },
                                "StorageClass": "STANDARD",
                            },
                            "Id": "Backup",
                            "Prefix": "",
                            "Status": "Enabled",
                        }
                    ],
                },
                "VersioningConfiguration": {"Status": "Enabled"},
            },
        },
        "WorkItemBucketBackupRole": {
            "Type": "AWS::IAM::Role",
            "Properties": {
                "AssumeRolePolicyDocument": {
                    "Statement": [
                        {
                            "Action": ["sts:AssumeRole"],
                            "Effect": "Allow",
                            "Principal": {"Service": ["s3.amazonaws.com"]},
                        }
                    ]
                }
            },
        },
        "BucketBackupPolicy": {
            "Type": "AWS::IAM::Policy",
            "Properties": {
                "PolicyDocument": {
                    "Statement": [
                        {
                            "Action": [
                                "s3:GetReplicationConfiguration",
                                "s3:ListBucket",
                            ],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {"Ref": "RecordServiceS3Bucket"},
                                        ],
                                    ]
                                }
                            ],
                        },
                        {
                            "Action": ["s3:GetObjectVersion", "s3:GetObjectVersionAcl"],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {"Ref": "RecordServiceS3Bucket"},
                                            "/*",
                                        ],
                                    ]
                                }
                            ],
                        },
                        {
                            "Action": ["s3:ReplicateObject", "s3:ReplicateDelete"],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {
                                                "Fn::Join": [
                                                    "-",
                                                    [
                                                        {"Ref": "AWS::Region"},
                                                        {"Ref": "AWS::StackName"},
                                                        "replicationbucket",
                                                    ],
                                                ]
                                            },
                                            "/*",
                                        ],
                                    ]
                                }
                            ],
                        },
                    ]
                },
                "PolicyName": "BucketBackupPolicy",
                "Roles": [{"Ref": "WorkItemBucketBackupRole"}],
            },
        },
    },
}
ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "RecordServiceS3Bucket": {
            "Type": "ALIYUN::OSS::Bucket",
            "Properties": {},  # todo: need more detail properties transform
            "DeletionPolicy": "Retain",
        },
        "WorkItemBucketBackupRole": {
            "Type": "ALIYUN::RAM::Role",
            "Properties": {
                "AssumeRolePolicyDocument": {
                    "Statement": [
                        {
                            "Action": ["sts:AssumeRole"],
                            "Effect": "Allow",
                            "Principal": {"Service": ["s3.amazonaws.com"]},
                        }
                    ]
                }
            },
        },
        "BucketBackupPolicy": {
            "Type": "ALIYUN::RAM::ManagedPolicy",
            "Properties": {
                "PolicyDocument": {
                    "Statement": [
                        {
                            "Action": [
                                "s3:GetReplicationConfiguration",
                                "s3:ListBucket",
                            ],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",  # todo: replace arn:aws
                                            {"Ref": "RecordServiceS3Bucket"},
                                        ],
                                    ]
                                }
                            ],
                        },
                        {
                            "Action": ["s3:GetObjectVersion", "s3:GetObjectVersionAcl"],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {"Ref": "RecordServiceS3Bucket"},
                                            "/*",
                                        ],
                                    ]
                                }
                            ],
                        },
                        {
                            "Action": ["s3:ReplicateObject", "s3:ReplicateDelete"],
                            "Effect": "Allow",
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            "arn:aws:s3:::",
                                            {
                                                "Fn::Join": [
                                                    "-",
                                                    [
                                                        {"Ref": "ALIYUN::Region"},
                                                        {"Ref": "ALIYUN::StackName"},
                                                        "replicationbucket",
                                                    ],
                                                ]
                                            },
                                            "/*",
                                        ],
                                    ]
                                }
                            ],
                        },
                    ]
                },
                "PolicyName": "BucketBackupPolicy",
                "Roles": [{"Ref": "WorkItemBucketBackupRole"}],
            },
        },
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
