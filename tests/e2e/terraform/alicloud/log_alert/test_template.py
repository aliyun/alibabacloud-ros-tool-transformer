import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_log_alert.example-2": {
            "Type": "ALIYUN::SLS::Alert",
            "Properties": {
                "Detail": {
                    "DisplayName": "example-alert",
                    "Name": "example-alert",
                    "Configuration": {
                        "AutoAnnotation": True,
                        "Dashboard": "example-dashboard",
                        "MuteUntil": 1632486684,
                        "NoDataFire": False,
                        "NoDataSeverity": 8,
                        "SendResolved": True,
                        "Version": "2.0",
                        "Schedule": {
                            "DayOfWeek": 0,
                            "Delay": 0,
                            "Hour": 0,
                            "Interval": "5m",
                            "RunImmediately": False,
                            "Type": "FixedRate",
                        },
                        "QueryList": [
                            {
                                "chart_title": "chart_title",
                                "end": "20s",
                                "power_sql_mode": "auto",
                                "project": "terraform-example",
                                "query": "* AND aliyun | select count(1) as cnt",
                                "region": "cn-heyuan",
                                "start": "-60s",
                                "store": "example-store",
                                "store_type": "log",
                            },
                            {
                                "chart_title": "chart_title",
                                "end": "20s",
                                "power_sql_mode": "enable",
                                "project": "terraform-example",
                                "query": "error | select count(1) as error_cnt",
                                "region": "cn-heyuan",
                                "start": "-60s",
                                "store": "example-store",
                                "store_type": "log",
                            },
                        ],
                        "Labels": [{"Key": "env", "Value": "test"}],
                        "Annotations": [
                            {"Key": "title", "Value": "alert title"},
                            {"Key": "desc", "Value": "alert desc"},
                            {"Key": "test_key", "Value": "test value"},
                        ],
                        "GroupConfiguration": {"Fields": ["cnt"], "Type": "custom"},
                        "PolicyConfiguration": {
                            "ActionPolicyId": "sls_test_action",
                            "AlertPolicyId": "sls.bultin",
                            "RepeatInterval": "4h",
                        },
                        "SeverityConfigurations": [
                            {
                                "EvalCondition": {
                                    "Condition": "cnt > 3",
                                    "CountCondition": "__count__ > 3",
                                },
                                "Severity": 8,
                            },
                            {
                                "EvalCondition": {
                                    "Condition": "",
                                    "CountCondition": "__count__ > 0",
                                },
                                "Severity": 6,
                            },
                            {
                                "EvalCondition": {
                                    "Condition": "",
                                    "CountCondition": "",
                                },
                                "Severity": 2,
                            },
                        ],
                        "JoinConfigurations": [{"Condition": "", "Type": "cross_join"}],
                    },
                    "Type": "default",
                },
                "Project": "terraform-example",
            },
        },
        "alicloud_log_project.example": {
            "Type": "ALIYUN::SLS::Project",
            "Properties": {
                "Description": "terraform-example",
                "Name": "terraform-example",
            },
        },
        "alicloud_log_store.example": {
            "Type": "ALIYUN::SLS::Logstore",
            "Properties": {
                "AppendMeta": True,
                "AutoSplit": True,
                "MaxSplitShard": 60,
                "LogstoreName": "example-store",
                "ProjectName": "terraform-example",
                "TTL": 3650,
                "ShardCount": 3,
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
