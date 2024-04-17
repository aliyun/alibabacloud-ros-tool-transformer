import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_log_etl.example": {
            "Type": "ALIYUN::SLS::Etl",
            "Properties": {
                "Description": "terraform-example",
                "DisplayName": "terraform-example",
                "Name": "terraform-example",
                "Configuration": {
                    "Logstore": "example-store",
                    "Script": "e_set('new','key')",
                    "Sinks": [
                        {
                            "Endpoint": "cn-hangzhou.log.aliyuncs.com",
                            "Logstore": "example-store2",
                            "Name": "target_name",
                            "Project": "terraform-example-01",
                        },
                        {
                            "Endpoint": "cn-hangzhou.log.aliyuncs.com",
                            "Logstore": "example-store3",
                            "Name": "target_name2",
                            "Project": "terraform-example-01",
                        },
                    ],
                },
                "ProjectName": "terraform-example-01",
            },
        },
        "alicloud_log_project.example": {
            "Type": "ALIYUN::SLS::Project",
            "Properties": {
                "Description": "terraform-example",
                "Name": "terraform-example-01",
            },
        },
        "alicloud_log_store.example": {
            "Type": "ALIYUN::SLS::Logstore",
            "Properties": {
                "AppendMeta": True,
                "AutoSplit": True,
                "MaxSplitShard": 60,
                "LogstoreName": "example-store",
                "ProjectName": "terraform-example-01",
                "TTL": 3650,
                "ShardCount": 3,
            },
        },
        "alicloud_log_store.example2": {
            "Type": "ALIYUN::SLS::Logstore",
            "Properties": {
                "AppendMeta": True,
                "AutoSplit": True,
                "MaxSplitShard": 60,
                "LogstoreName": "example-store2",
                "ProjectName": "terraform-example-01",
                "TTL": 3650,
                "ShardCount": 3,
            },
        },
        "alicloud_log_store.example3": {
            "Type": "ALIYUN::SLS::Logstore",
            "Properties": {
                "AppendMeta": True,
                "AutoSplit": True,
                "MaxSplitShard": 60,
                "LogstoreName": "example-store3",
                "ProjectName": "terraform-example-01",
                "TTL": 3650,
                "ShardCount": 3,
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
