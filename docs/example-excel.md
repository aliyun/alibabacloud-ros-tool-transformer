# Transform Excel Template to ROS Template
## Command
Use the following command to transform Execl template into ROS template
and generate `template-{number}.json` in the current directory.

Each sheet in Excel is a template. If you define multiple sheets in Excel, 
you can convert up to 5 sheets at the same time.

```bash
rostran transform templates/excel/EcsInstance.xlsx.md --target-path tests/template.json
```

## Original Excel Template
[Click to View](https://github.com/aliyun/alibabacloud-ros-tool-transformer/blob/master/templates/excel/EcsInstance.xlsx)

<img src="https://github.com/aliyun/alibabacloud-ros-tool-transformer/raw/master/docs/_media/example-execl.png" style="zoom:50%" />

## Transformed ROS Template
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



