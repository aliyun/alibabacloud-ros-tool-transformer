import os
from rostran.providers import ExcelTemplate

CUR_PATH = os.path.abspath(__file__)
CUR_DIR = os.path.dirname(CUR_PATH)
EXCEL_TEMPLATE_NAME = os.path.join(CUR_DIR, 'ExcelTemplate.xlsx')


tpl1 = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Parameters": {
        "ZoneId": {
            "Type": "String",
            "Default": "cn-beijing-h"
        },
        "SystemDiskSize": {
            "Type": "Number",
            "Default": 100
        }
    },
    "Resources": {
        "MyInstance": {
            "Type": "ALIYUN::ECS::InstanceGroup",
            "Properties": {
                "RegionId": "cn-beijing",
                "ZoneId": "cn-beijing-h",
                "ChargeType": "PostPaid",
                "InstanceType": "ecs.g5.large",
                "Amount": 200,
                "SystemDiskCategory": "cloud_efficiency",
                "SystemDiskSize": 100,
                "DiskMappings": [{
                    "Category": "cloud_ssd",
                    "Size": 200
                }],
                "ImageId": "EasyShopLinux20190723",
                "Password": "password",
                "VpcId": {"Ref": "MyVpc"},
                "VSwitchId": {"Ref": "MyVSwitch"},
                "InternetMaxBandwidthOut": 0,
                "SecurityGroupId": "sg-2zej2g9ep36k3yhhubaa"
            }
        },
        "MyVpc": {
            "Type": "ALIYUN::ECS::Vpc",
            "Properties": {
                "VpcName": "MyVpcName"
            }
        },
        "MyVSwitch": {
            "Type": "ALIYUN::ECS::VSwitch",
            "Properties": {
                "VpcId": {"Ref": "MyVpc"},
                "ZoneId": "cn-beijing-h",
                "VSwitchName": "MyVSwitchName"
            }
        }
    }
}

tpl2 = {
    "ROSTemplateFormatVersion": "2015-09-01",
    "Parameters": {
        "ZoneId": {
            "Type": "String"
        },
        "SystemDiskSize": {
            "Type": "Number"
        }
    },
    "Resources": {
        "MyInstance": {
            "Type": "ALIYUN::ECS::InstanceGroup",
            "Properties": {
                "RegionId": "cn-beijing",
                "ZoneId": {"Ref": "ZoneId"},
                "ChargeType": "PostPaid",
                "InstanceType": "ecs.r5.6xlarge",
                "Amount": 50,
                "SystemDiskCategory": "cloud_ssd",
                "SystemDiskSize": 100,
                "DiskMappings": [{
                    "Category": "cloud_ssd",
                    "Size": 200
                }],
                "ImageId": "EasyShopLinux20190723",
                "Password": "password",
                "VpcId": "vpc-bp1397wjfjjzlck86emaa",
                "VSwitchId": "vsw-bp1apypxlcxdao9w7cpaa",
                "InternetMaxBandwidthOut": 0,
                "SecurityGroupId": "sg-2zej2g9ep36k3yhhubaa"
            }
        }
    }
}


def test_template():
    template = ExcelTemplate.initialize(EXCEL_TEMPLATE_NAME)
    ros_templates = template.transform()
    assert len(ros_templates) == 2

    for i, t in enumerate(ros_templates):
        d = t.as_dict()
        assert d == globals().get(f'tpl{i+1}')
