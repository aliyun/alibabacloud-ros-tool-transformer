import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_adb_db_cluster.default": {
            "Type": "ALIYUN::ADB::DBCluster",
            "Properties": {
                "DBClusterCategory": "Cluster",
                "DBClusterVersion": "3.0",
                "DBNodeGroupCount": 4,
                "DBNodeStorage": 400,
                "DBClusterDescription": "terraform-example",
                "Mode": "reserver",
                "PayType": "PayAsYouGo",
                "ResourceGroupId": "rg-acfm2xwmxvrzq6q",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "terraform-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-f",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
