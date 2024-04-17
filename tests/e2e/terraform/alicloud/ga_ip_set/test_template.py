import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ga_accelerator.default": {
            "Type": "ALIYUN::GA::Accelerator",
            "Properties": {"Duration": 1, "Spec": "1"},
        },
        "alicloud_ga_bandwidth_package.default": {
            "Type": "ALIYUN::GA::BandwidthPackage",
            "Properties": {
                "Bandwidth": 100,
                "BandwidthType": "Basic",
                "BillingType": "PayBy95",
                "Ratio": 30,
                "Type": "Basic",
            },
        },
        "alicloud_ga_bandwidth_package_attachment.default": {
            "Type": "ALIYUN::GA::BandwidthPackageAcceleratorAddition",
            "Properties": {
                "AcceleratorId": {
                    "Fn::GetAtt": ["alicloud_ga_accelerator.default", "AcceleratorId"]
                },
                "BandwidthPackageId": {
                    "Fn::GetAtt": [
                        "alicloud_ga_bandwidth_package.default",
                        "BandwidthPackageId",
                    ]
                },
            },
        },
        "alicloud_ga_ip_set.example": {
            "Type": "ALIYUN::GA::IpSets",
            "Properties": {
                "AccelerateRegion": [
                    {"AccelerateRegionId": "cn-beijing", "Bandwidth": 5}
                ],
                "AcceleratorId": {
                    "Fn::GetAtt": [
                        "alicloud_ga_bandwidth_package_attachment.default",
                        "AcceleratorId",
                    ]
                },
            },
        },
    },
    "Outputs": {
        "accelerate_region_id": {"Value": "cn-beijing"},
        "ip_set_id": {
            "Value": {
                "Fn::Jq": [
                    "First",
                    ".[0]",
                    {"Fn::GetAtt": ["alicloud_ga_ip_set.example", "IpSetIds"]},
                ]
            }
        },
        "ip_version": {
            "Value": {
                "Fn::Jq": [
                    "First",
                    ".[0]",
                    {"Fn::GetAtt": ["alicloud_ga_ip_set.example", "IpVersions"]},
                ]
            }
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
