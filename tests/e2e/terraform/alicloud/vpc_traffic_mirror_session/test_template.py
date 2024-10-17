import os

from tests.testing import _test_tf_template

root = os.path.dirname(os.path.abspath(__file__))
tf_plan_path = os.path.join(root, "main.tfplan")

tpl = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Resources": {
        "alicloud_ecs_network_interface.default": {
            "Type": "ALIYUN::ECS::NetworkInterface",
            "Properties": {
                "NetworkInterfaceName": "tf-example",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_ecs_network_interface_attachment.default": {
            "Type": "ALIYUN::ECS::NetworkInterfaceAttachment",
            "Properties": {
                "InstanceId": {
                    "Fn::GetAtt": ["alicloud_instance.default", "InstanceId"]
                },
                "NetworkInterfaceId": {
                    "Fn::GetAtt": [
                        "alicloud_ecs_network_interface.default",
                        "NetworkInterfaceId",
                    ]
                },
            },
        },
        "alicloud_instance.default": {
            "Type": "ALIYUN::ECS::Instance",
            "Properties": {
                "ZoneId": "cn-beijing-i",
                "HostName": "tf-example",
                "ImageId": "ubuntu_22_04_x64_20G_alibase_20240926.vhd",
                "InstanceName": "tf-example",
                "InstanceType": "ecs.g7.large",
                "SystemDiskCategory": "cloud_essd",
                "VSwitchId": {"Fn::GetAtt": ["alicloud_vswitch.default", "VSwitchId"]},
            },
        },
        "alicloud_security_group.default": {
            "Type": "ALIYUN::ECS::SecurityGroup",
            "Properties": {
                "Description": "tf-example",
                "SecurityGroupName": "tf-example",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
            },
        },
        "alicloud_vpc.default": {
            "Type": "ALIYUN::ECS::VPC",
            "Properties": {"CidrBlock": "10.4.0.0/16", "VpcName": "tf-example"},
        },
        "alicloud_vpc_traffic_mirror_filter.default": {
            "Type": "ALIYUN::VPC::TrafficMirrorFilter",
            "Properties": {
                "TrafficMirrorFilterDescription": "tf-example",
                "TrafficMirrorFilterName": "tf-example",
            },
        },
        "alicloud_vpc_traffic_mirror_session.default": {
            "Type": "ALIYUN::VPC::TrafficMirrorSession",
            "Properties": {
                "Priority": 1,
                "TrafficMirrorFilterId": {
                    "Fn::GetAtt": [
                        "alicloud_vpc_traffic_mirror_filter.default",
                        "TrafficMirrorFilterId",
                    ]
                },
                "TrafficMirrorSessionDescription": "tf-example",
                "TrafficMirrorSessionName": "tf-example",
                "TrafficMirrorTargetId": {
                    "Fn::GetAtt": [
                        "alicloud_ecs_network_interface_attachment.default",
                        "NetworkInterfaceId",
                    ]
                },
                "TrafficMirrorTargetType": "NetworkInterface",
                "VirtualNetworkId": 10,
            },
        },
        "alicloud_vswitch.default": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "CidrBlock": "10.4.0.0/24",
                "VpcId": {"Fn::GetAtt": ["alicloud_vpc.default", "VpcId"]},
                "VSwitchName": "tf-example",
                "ZoneId": "cn-beijing-i",
            },
        },
    },
}


def test_template():
    t = _test_tf_template(root, tf_plan_path)
    assert t == tpl
