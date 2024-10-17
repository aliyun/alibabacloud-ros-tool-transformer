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
                "PayType": "PayAsYouGo",
                "SegNodeNum": 4,
                "SegStorageType": "cloud_essd",
                "StorageSize": 50,
                "VPCId": "vpc-xxx",
                "VSwitchId": "vsw-xxx",
                "ZoneId": "cn-beijing-g",
            },
        }
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
