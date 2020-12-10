# Transform Excel Template to ROS Template
## Command
Use the following command to generate the ROS template `template.json` in the tests directory. <br>
Each sheet in Excel is a template. If you define multiple templates in Excel, you can convert up to 5 templates at the same time and add an ordered suffix to the generated ROS template.
```bash
rostran transform templates/excel/EcsInstance.xlsx.md --target-path tests/template.json
```
## Excel Template
[view](https://github.com/aliyun/alibabacloud-ros-tool-transformer/blob/master/templates/excel/EcsInstance.xlsx)

## ROS Template
- template-0.json
```json
{
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
        "DiskMappings": [
          {
            "Category": "cloud_ssd",
            "Size": 200
          }
        ],
        "ImageId": "EasyShopLinux20190723",
        "Password": "password",
        "VpcId": {
          "Ref": "MyVpc"
        },
        "VSwitchId": {
          "Ref": "MyVSwitch"
        },
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
        "VpcId": {
          "Ref": "MyVpc"
        },
        "ZoneId": "cn-beijing-h",
        "VSwitchName": "MyVSwitchName"
      }
    }
  }
}
```
- template-1.json
```json
{
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
        "ZoneId": {
          "Ref": "ZoneId"
        },
        "ChargeType": "PostPaid",
        "InstanceType": "ecs.r5.6xlarge",
        "Amount": 50,
        "SystemDiskCategory": "cloud_ssd",
        "SystemDiskSize": 100,
        "DiskMappings": [
          {
            "Category": "cloud_ssd",
            "Size": 200
          }
        ],
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
```



