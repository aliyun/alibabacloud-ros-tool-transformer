import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_slb_acl.listener": {
            "Type": "ALIYUN::SLB::AccessControl",
            "Properties": {"AddressIPVersion": "ipv4", "AclName": "forSlbListener"},
        },
        "alicloud_slb_listener.listener": {
            "Type": "ALIYUN::SLB::Listener",
            "Properties": {
                "AclId": {"Fn::GetAtt": ["alicloud_slb_acl.listener", "AclId"]},
                "AclStatus": "on",
                "AclType": "white",
                "BackendServerPort": 80,
                "Bandwidth": 10,
                "Persistence": {
                    "CookieTimeout": 86400,
                    "StickySession": "on",
                    "StickySessionType": "insert",
                    "XForwardedFor_SLBIP": "on",
                    "XForwardedFor_SLBID": "on",
                    "XForwardedFor": "on",
                },
                "ListenerPort": 80,
                "HealthCheck": {
                    "Switch": "on",
                    "Port": 20,
                    "Domain": "ali.com",
                    "HttpCode": "http_2xx,http_3xx",
                    "Interval": 5,
                    "Timeout": 8,
                    "URI": "/cons",
                    "HealthyThreshold": 8,
                    "UnhealthyThreshold": 8,
                },
                "IdleTimeout": 30,
                "LoadBalancerId": {
                    "Fn::GetAtt": [
                        "alicloud_slb_load_balancer.listener",
                        "LoadBalancerId",
                    ]
                },
                "Protocol": "http",
                "RequestTimeout": 80,
            },
        },
        "alicloud_slb_load_balancer.listener": {
            "Type": "ALIYUN::SLB::LoadBalancer",
            "Properties": {
                "AddressType": "internet",
                "InstanceChargeType": "PayByCLCU",
                "InternetChargeType": "PayByTraffic",
                "LoadBalancerName": "tf-exampleSlbListenerHttp",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
