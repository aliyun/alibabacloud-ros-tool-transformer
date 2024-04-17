import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_gpdb_instance.default": {
            "Type": "ALIYUN::GPDB::DBInstance",
            "Properties": {
                "DBInstanceCategory": "HighAvailability",
                "DBInstanceClass": "gpdb.group.segsdx1",
                "DBInstanceMode": "StorageElastic",
                "DBInstanceDescription": "tf-example",
                "EngineVersion": "6.0",
                "InstanceSpec": "2C16G",
                "MasterNodeNum": 1,
                "PayType": "PayAsYouGo",
                "PrivateIpAddress": "1.1.1.1",
                "SegNodeNum": 4,
                "SegStorageType": "cloud_essd",
                "StorageSize": 50,
                "VPCId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
                "ZoneId": "cn-beijing-g",
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example",
                "ZoneId": "cn-beijing-g",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
