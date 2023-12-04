from tests.e2e.cloudformation.testing import _test_template

cf_tpl = {
    "AWSTemplateFormatVersion": "2010-09-09",
    "Parameters": {
        "Number": {"Type": "Number"},
        "CommaDelimitedList": {"Type": "CommaDelimitedList"},
        "NumberList": {"Type": "List<Number>"},
        "ZoneId": {"Type": "String"},
        "ZoneId2": {"Type": "AWS::EC2::AvailabilityZone::Name"},
        "ZoneId3": {"Type": "List<AWS::EC2::AvailabilityZone::Name>"},
        "Route53HostedZoneId": {"Type": "AWS::Route53::HostedZone::Id"},
    },
}

ros_tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Parameters": {
        "Number": {"Type": "Number"},
        "CommaDelimitedList": {"Type": "CommaDelimitedList"},
        "NumberList": {"Type": "CommaDelimitedList"},
        "ZoneId": {"Type": "String"},
        "ZoneId2": {
            "Type": "String",
            "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
        },
        "ZoneId3": {
            "Type": "CommaDelimitedList",
            "AssociationProperty": "ALIYUN::ECS::Instance::ZoneId",
        },
        "Route53HostedZoneId": {"Type": "String"},
    },
}


def test_template():
    _test_template(cf_tpl, ros_tpl)
