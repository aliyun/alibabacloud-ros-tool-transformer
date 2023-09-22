import os

from tests.e2e.terraform.alicloud.testing import _test_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_resource_manager_resource_group.default3iXhoa": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {"DisplayName": "testname03", "Name": "terraform-example"},
        },
        "alicloud_resource_manager_resource_group.defaultdNz2qk": {
            "Type": "ALIYUN::ResourceManager::ResourceGroup",
            "Properties": {"DisplayName": "testname04", "Name": "terraform-example1"},
        },
        "alicloud_vpc_traffic_mirror_filter.default": {
            "Type": "ALIYUN::VPC::TrafficMirrorFilter",
            "Properties": {
                "TrafficMirrorFilterDescription": "test",
                "TrafficMirrorFilterName": "terraform-example",
                "EgressRules": [
                    {
                        "Action": "accept",
                        "DestinationCidrBlock": "32.0.0.0/4",
                        "DestinationPortRange": "80/80",
                        "Priority": 1,
                        "Protocol": "TCP",
                        "SourceCidrBlock": "16.0.0.0/4",
                        "SourcePortRange": "80/80",
                    }
                ],
                "IngressRules": [
                    {
                        "Action": "accept",
                        "DestinationCidrBlock": "10.64.0.0/10",
                        "DestinationPortRange": "80/80",
                        "Priority": 1,
                        "Protocol": "TCP",
                        "SourceCidrBlock": "10.0.0.0/8",
                        "SourcePortRange": "80/80",
                    }
                ],
            },
        },
    },
}


def test_template():
    t = _test_template(root, tf_plan_path)
    assert t == tpl
