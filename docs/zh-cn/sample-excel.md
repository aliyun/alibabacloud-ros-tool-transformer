# Excel模板转ROS模板
## 命令
使用以下命令在 tests 目录下生成 ROS 模板 `template.json`。<br>
Excel 中的每个 sheet 都是一个模板。如果您在 Excel 中定义了多个模板，则最多可同时转换5个模板，并为生成的 ROS 模板添加有序后缀。
```bash
rostran transform templates/excel/EcsInstance.xlsx.md --target-path tests/template.json
```
## Excel 模板
[view](https://github.com/aliyun/alibabacloud-ros-tool-transformer/blob/master/templates/excel/EcsInstance.xlsx)

## ROS 模板
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



