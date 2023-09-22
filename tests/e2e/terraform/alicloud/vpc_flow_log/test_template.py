import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_log_project.example": {
            "Type": "ALIYUN::SLS::Project",
            "Properties": {"Description": "tf-example", "Name": "tf-example"},
        },
        "alicloud_log_store.example": {
            "Type": "ALIYUN::SLS::Logstore",
            "Properties": {
                "AppendMeta": True,
                "AutoSplit": True,
                "MaxSplitShard": 60,
                "LogstoreName": "tf-example",
                "ProjectName": "tf-example",
                "ShardCount": 3,
            },
        },
        "alicloud_vpc.example": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vpc_flow_log.example": {
            "Type": "ALIYUN::VPC::FlowLog",
            "Properties": {
                "Description": "tf-example",
                "FlowLogName": "tf-example",
                "LogStoreName": "tf-example",
                "ProjectName": "tf-example",
                "ResourceId": {"Fn::GetAtt": ["alicloud_vpc.example", "VpcId"]},
                "ResourceType": "VPC",
                "TrafficType": "All",
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
