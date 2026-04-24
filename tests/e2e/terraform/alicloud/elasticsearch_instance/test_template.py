import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_elasticsearch_instance.default": {
            "Type": "ALIYUN::ElasticSearch::Instance",
            "Properties": {
                "DataNode": {
                    "Amount": 2,
                    "DiskSize": 20,
                    "Spec": "elasticsearch.sn2ne.large",
                    "DiskType": "cloud_ssd"
                },
                "Description": "tf-example",
                "InstanceChargeType": "PostPaid",
                "KibanaNode": {
                    "Spec": "elasticsearch.sn2ne.large"
                },
                "Password": "******",
                "Tags": [
                    {"Key": "Created", "Value": "TF"},
                    {"Key": "For", "Value": "example"},
                ],
                "Version": "7.10_with_X-Pack",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.0.0.0/8", "VpcName": "tf-example"},
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.1.0.0/16",
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
