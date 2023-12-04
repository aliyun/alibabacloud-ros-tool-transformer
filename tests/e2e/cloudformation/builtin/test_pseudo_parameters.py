from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Outputs": {
        "PseudoList": {
            "Value": [
                {"Ref": "AWS::AccountId"},
                {"Ref": "AWS::NoValue"},
                {"Ref": "AWS::Region"},
                {"Ref": "AWS::StackId"},
                {"Ref": "AWS::StackName"},
                {"Ref": "AWS::NotificationARNs"},
                {"Ref": "AWS::Partition"},
                {"Ref": "AWS::Partition"},
                {"Ref": "AWS::URLSuffix"},
            ]
        },
        "PseudoSub1": {
            "Value": {
                "Fn::Sub": "${AWS::AccountId},${AWS::NoValue},${AWS::Region},${AWS::StackId},${AWS::StackName},${AWS::NotificationARNs},${AWS::Partition},${AWS::URLSuffix}"
            }
        },
        "PseudoSub2": {
            "Value": {
                "Fn::Sub": [
                    "${AWS::AccountId},${AWS::NoValue},${AWS::Region},${AWS::StackId},${AWS::StackName},${AWS::NotificationARNs},${AWS::Partition},${AWS::URLSuffix}",
                    {},
                ]
            }
        },
        "PseudoSub3": {
            "Value": {
                "Fn::Sub": [
                    "${TenantId},${NoValue}",
                    {
                        "TenantId": {"Ref": "AWS::AccountId"},
                        "NoValue": {"Ref": "AWS::NoValue"},
                    },
                ]
            }
        },
    },
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Outputs": {
        "PseudoList": {
            "Value": [
                {"Ref": "ALIYUN::TenantId"},
                {"Ref": "ALIYUN::NoValue"},
                {"Ref": "ALIYUN::Region"},
                {"Ref": "ALIYUN::StackId"},
                {"Ref": "ALIYUN::StackName"},
                # The following cannot be transformed:
                {"Ref": "AWS::NotificationARNs"},
                {"Ref": "AWS::Partition"},
                {"Ref": "AWS::Partition"},
                {"Ref": "AWS::URLSuffix"},
            ]
        },
        "PseudoSub1": {
            "Value": {
                "Fn::Sub": "${ALIYUN::TenantId},${ALIYUN::NoValue},${ALIYUN::Region},${ALIYUN::StackId},${ALIYUN::StackName},${AWS::NotificationARNs},${AWS::Partition},${AWS::URLSuffix}"
            }
        },
        "PseudoSub2": {
            "Value": {
                "Fn::Sub": [
                    "${ALIYUN::TenantId},${ALIYUN::NoValue},${ALIYUN::Region},${ALIYUN::StackId},${ALIYUN::StackName},${AWS::NotificationARNs},${AWS::Partition},${AWS::URLSuffix}",
                    {},
                ]
            }
        },
        "PseudoSub3": {
            "Value": {
                "Fn::Sub": [
                    "${TenantId},${NoValue}",
                    {
                        "TenantId": {"Ref": "ALIYUN::TenantId"},
                        "NoValue": {"Ref": "ALIYUN::NoValue"},
                    },
                ]
            }
        },
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
