import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_slb_load_balancer.load_balancer": {
            "Type": "ALIYUN::SLB::LoadBalancer",
            "Properties": {
                "AddressType": "intranet",
                "InstanceChargeType": "PayBySpec",
                "LoadBalancerName": "forSlbLoadBalancer",
                "LoadBalancerSpec": "slb.s2.small",
                "Tags": [{"Key": "info", "Value": "create for internet"}],
                "VSwitchId": {
                    "Fn::GetAtt": ["alicloud_vswitch.load_balancer", "VSwitchId"]
                },
            },
        },
        "alicloud_vpc.load_balancer": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"VpcName": "forSlbLoadBalancer"},
        },
        "alicloud_vswitch.load_balancer": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/21",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.load_balancer", "VpcId"]},
                "VSwitchName": "forSlbLoadBalancer",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
