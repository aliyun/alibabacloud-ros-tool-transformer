import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_db_database.default": {
            "Type": "ALIYUN::RDS::Database",
            "Properties": {
                "DBInstanceId": {
                    "Fn::GetAtt": ["alicloud_db_instance.default", "DBInstanceId"]
                },
                "DBName": "tf-example",
            },
        },
        "alicloud_db_instance.default": {
            "Type": "ALIYUN::RDS::DBInstance",
            "Properties": {
                "Engine": "MySQL",
                "EngineVersion": "5.6",
                "DBInstanceDescription": "tf-example",
                "DBInstanceStorage": 10,
                "DBInstanceClass": "rds.mysql.s1.small",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "172.16.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example",
                "ZoneId": "cn-beijing-e",
            },
        },
    },
    "Outputs": {
        "id": {
            "Value": {
                "Fn::Join": [
                    ":",
                    [
                        {
                            "Fn::GetAtt": [
                                "alicloud_db_database.default",
                                "DBInstanceId",
                            ]
                        },
                        {"Fn::GetAtt": ["alicloud_db_database.default", "DBName"]},
                    ],
                ]
            }
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
