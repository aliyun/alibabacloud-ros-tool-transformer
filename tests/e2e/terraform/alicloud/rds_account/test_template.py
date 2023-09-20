import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_db_instance.default": {
            "Type": "ALIYUN::RDS::DBInstance",
            "Properties": {
                "Engine": "MySQL",
                "EngineVersion": "5.6",
                "DBInstanceDescription": "tf_example",
                "DBInstanceStorage": 10,
                "DBInstanceClass": "rds.mysql.c1.large",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_rds_account.default": {
            "Type": "ALIYUN::RDS::Account",
            "Properties": {
                "AccountName": "tf_example",
                "AccountPassword": "Example1234",
                "DBInstanceId": {
                    "Fn::GetAtt": ["alicloud_db_instance.default", "DBInstanceId"]
                },
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "172.16.0.0/16", "VpcName": "tf_example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf_example",
                "ZoneId": "cn-beijing-a",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
