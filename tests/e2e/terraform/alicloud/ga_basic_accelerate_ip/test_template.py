import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ga_basic_accelerate_ip.default": {
            "Type": "ALIYUN::GA::BasicAccelerateIp",
            "Properties": {
                "AcceleratorId": {
                    "Fn::GetAtt": [
                        "alicloud_ga_basic_accelerator.default",
                        "AcceleratorId",
                    ]
                },
                "IpSetId": {
                    "Fn::GetAtt": ["alicloud_ga_basic_ip_set.default", "IpSetId"]
                },
            },
        },
        "alicloud_ga_basic_accelerator.default": {
            "Type": "ALIYUN::GA::BasicAccelerator",
            "Properties": {
                "AutoPay": True,
                "AutoUseCoupon": "true",
                "BandwidthBillingType": "CDT",
                "Duration": 1,
            },
        },
        "alicloud_ga_basic_ip_set.default": {
            "Type": "ALIYUN::GA::BasicIpSet",
            "Properties": {
                "AccelerateRegionId": "cn-hangzhou",
                "AcceleratorId": {
                    "Fn::GetAtt": [
                        "alicloud_ga_basic_accelerator.default",
                        "AcceleratorId",
                    ]
                },
                "Bandwidth": 5,
                "IspType": "BGP",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
