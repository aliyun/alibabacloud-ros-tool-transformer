import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_instance.rule": {
            "Type": "ALIYUN::ECS::Instance",
            "Properties": {
                "ZoneId": "cn-beijing-c",
                "ImageId": "ubuntu_18_04_x64_20G_alibase_20240223.vhd",
                "InstanceChargeType": "PostPaid",
                "InstanceName": "terraform-example",
                "InstanceType": "ecs.sn1.large",
                "InternetChargeType": "PayByTraffic",
                "InternetMaxBandwidthOut": 10,
                "SystemDiskCategory": "cloud_efficiency",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.rule", "VSwitchId"]},
            },
        },
        "alicloud_security_group.rule": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "SecurityGroupName": "terraform-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.rule", "VpcId"]},
            },
        },
        "alicloud_slb_listener.rule": {
            "Type": "ALIYUN::SLB::Listener",
            "Properties": {
                "BackendServerPort": 22,
                "Bandwidth": 5,
                "ListenerPort": 22,
                "HealthCheck": {"Port": 20},
                "Protocol": "http",
            },
        },
        "alicloud_slb_load_balancer.rule": {
            "Type": "ALIYUN::SLB::LoadBalancer",
            "Properties": {
                "InstanceChargeType": "PayByCLCU",
                "LoadBalancerName": "terraform-example",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.rule", "VSwitchId"]},
            },
        },
        "alicloud_slb_rule.rule": {
            "Type": "ALIYUN::SLB::Rule",
            "Properties": {
                "RuleList": [
                    {
                        "Domain": "*.aliyun.com",
                        "RuleName": "terraform-example",
                        "VServerGroupId": {
                            "Fn::GetAtt": [
                                "alicloud_slb_server_group.rule",
                                "VServerGroupId",
                            ]
                        },
                        "Url": "/image",
                    }
                ],
                "ListenerPort": 22,
                "LoadBalancerId": {
                    "Fn::GetAtt": ["alicloud_slb_load_balancer.rule", "LoadBalancerId"]
                },
            },
        },
        "alicloud_slb_server_group.rule": {
            "Type": "ALIYUN::SLB::VServerGroup",
            "Properties": {
                "LoadBalancerId": {
                    "Fn::GetAtt": ["alicloud_slb_load_balancer.rule", "LoadBalancerId"]
                },
                "VServerGroupName": "terraform-example",
            },
        },
        "alicloud_vpc.rule": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {
                "CidrBlock": "172.16.0.0/16",
                "VpcName": "terraform-example",
            },
        },
        "alicloud_vswitch.rule": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "172.16.0.0/16",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.rule", "VpcId"]},
                "VSwitchName": "terraform-example",
                "ZoneId": "cn-beijing-c",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
