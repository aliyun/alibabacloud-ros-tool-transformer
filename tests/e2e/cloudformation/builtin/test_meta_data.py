from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Parameters": {"VPCID": {"Type": "String"}},
    "Metadata": {
        "AWS::CloudFormation::Interface": {
            "ParameterGroups": [
                {
                    "Label": {"default": "Network Configuration"},
                    "Parameters": ["VPCID", "SubnetId", "SecurityGroupID"],
                },
                {
                    "Label": {"default": "Amazon EC2 Configuration"},
                    "Parameters": ["InstanceType", "KeyName"],
                },
            ],
            "ParameterLabels": {
                "VPCID": {"default": "Which VPC should this be deployed to?"}
            },
        }
    },
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Parameters": {
        "VPCID": {"Type": "String", "Label": "Which VPC should this be deployed to?"}
    },
    "Metadata": {
        "ALIYUN::ROS::Interface": {
            "ParameterGroups": [
                {
                    "Label": {"default": "Network Configuration"},
                    "Parameters": ["VPCID", "SubnetId", "SecurityGroupID"],
                },
                {
                    "Label": {"default": "Amazon EC2 Configuration"},
                    "Parameters": ["InstanceType", "KeyName"],
                },
            ]
        }
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
