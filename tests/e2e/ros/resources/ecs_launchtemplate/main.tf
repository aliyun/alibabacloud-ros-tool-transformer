variable "image_owner_alias" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The source of the image. Valid values:\nsystem: public images provided by Alibaba Cloud.\nself: your custom images.\nothers: shared images from other Alibaba Cloud accounts.\nmarketplace: Alibaba Cloud Marketplace images. If Alibaba Cloud Marketplace images are found, you can use these images without prior subscription. You must pay attention to the billing details of Alibaba Cloud Marketplace images."
    },
    "Label": {
      "en": "ImageOwnerAlias",
      "zh-cn": "镜像来源"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The private IP address of the instance.\nTo assign a private IP address to an instance of the VPC type, make sure that the IP address is an idle IP address within the CIDR block of the vSwitch specified by the VSwitchId parameter."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "实例私网IP地址"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the instance, [2, 256] characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "实例描述"
    }
  }
  EOT
}

variable "disk_mappings" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SnapshotId": {
          "Type": "String",
          "Description": {
            "en": "ID of the snapshot to create the volume."
          },
          "Required": false
        },
        "Category": {
          "Type": "String",
          "Description": {
            "en": "The volume type.Now support: cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd. "
          },
          "Required": false
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the disk, [2, 256] characters."
          },
          "Required": false
        },
        "Encrypted": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether data disk is encrypted."
          },
          "Required": false
        },
        "PerformanceLevel": {
          "Type": "String",
          "Description": {
            "en": "The performance level of the ESSD used as data disk. The value of Valid values:\nPL0: A single ESSD can deliver up to 10,000 random read/write IOPS.\nPL1: A single ESSD can deliver up to 50,000 random read/write IOPS.\nPL2: A single ESSD can deliver up to 100,000 random read/write IOPS.\nPL3: A single ESSD can deliver up to 1,000,000 random read/write IOPS."
          },
          "Required": false
        },
        "Size": {
          "Type": "String",
          "Description": {
            "en": "The size of the volume, unit in GB.Value range: cloud: [5,2000], cloud_efficiency: [20,32768], cloud_ssd: [20,32768], cloud_essd: [20,32768] ephemeral_ssd: [5,800].The value should be equal to or greater than the specific snapshot."
          },
          "Required": false
        },
        "DeleteWithInstance": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether data disk should be released with instance."
          },
          "Required": false
        },
        "DiskName": {
          "Type": "String",
          "Description": {
            "en": "Display name of the disk, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Disk mappings to attach to instance. Max support 16 disks."
    },
    "Label": {
      "en": "DiskMappings",
      "zh-cn": "数据盘列表"
    },
    "MaxLength": 16
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which to assign the instance, Elastic Block Storage (EBS) device, and elastic network interface (ENI)."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "实例、块存储和弹性网卡所在的资源组ID"
    }
  }
  EOT
}

variable "user_data" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "User data to pass to instance. [1, 16KB] characters."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "实例自定义数据"
    }
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size. "
    },
    "MinValue": 20,
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "system_disk_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of created system disk."
    },
    "Label": {
      "en": "SystemDiskDescription",
      "zh-cn": "系统盘描述"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "The billing method of the instance. Valid values:\nPrePaid: subscription. If you set this parameter to PrePaid, make sure that your account supports payment by credit. Otherwise, an InvalidPayMethod error is returned.\nPostPaid: pay-as-you-go."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例的计费方式"
    }
  }
  EOT
}

variable "spot_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The protection period of the preemptible instance. Unit: hours. Valid values: 0, 1, 2, 3, 4, 5, and 6.\nProtection periods of 2, 3, 4, 5, and 6 hours are in invitational preview. If you want to set this parameter to one of these values, submit a ticket.\nIf this parameter is set to 0, no protection period is configured for the preemptible instance.\nDefault value: 1."
    },
    "Label": {
      "en": "SpotDuration",
      "zh-cn": "抢占式实例的保留时长"
    }
  }
  EOT
}

variable "template_tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Template tags to attach to launch template."
    },
    "Label": {
      "en": "TemplateTags",
      "zh-cn": "启动模板的标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance RAM role name. The name is provided and maintained by Resource Access Management (RAM) and can be queried using ListRoles. For more information, see RAM API CreateRole and ListRoles."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "system_disk_performance_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The performance level of the ESSD that is used as the system disk. Valid values:\nPL0: A single ESSD can deliver up to 10,000 random read/write IOPS.\nPL1: A single ESSD can deliver up to 50,000 random read/write IOPS.\nPL2: A single ESSD can deliver up to 100,000 random read/write IOPS.\nPL3: A single ESSD can deliver up to 1,000,000 random read/write IOPS.",
      "zh-cn": "创建ESSD云盘作为系统盘使用时，云盘的性能等级。"
    },
    "Label": {
      "en": "SystemDiskPerformanceLevel",
      "zh-cn": "创建ESSD云盘作为系统盘使用时"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance network type. Support 'vpc' and 'classic'"
    },
    "AllowedValues": [
      "vpc",
      "classic"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "实例网络类型"
    }
  }
  EOT
}

variable "ipv6_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of IPv6 addresses to be randomly generated for the primary ENI. Valid values: 1 to 10."
    },
    "MinValue": 1,
    "Label": {
      "en": "Ipv6AddressCount",
      "zh-cn": "为主网卡指定随机生成的IPv6地址数量"
    },
    "MaxValue": 10
  }
  EOT
}

variable "network_interfaces" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of your ENI. It is a string of [2, 256] English or Chinese characters."
          },
          "Required": false
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "The ID of the security group that the ENI joins. The security group and the ENI must be in a same VPC."
          },
          "Required": false
        },
        "VSwitchId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}",
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
          "Type": "String",
          "Description": {
            "en": "VSwitch ID of the specified VPC."
          },
          "Required": false
        },
        "NetworkInterfaceName": {
          "Type": "String",
          "Description": {
            "en": "Name of your ENI. It is a string of [2, 128]  Chinese or English characters. It must begin with a letter and can contain numbers, underscores (_), colons (:), or hyphens (-)."
          },
          "Required": false
        },
        "PrimaryIpAddress": {
          "Type": "String",
          "Description": {
            "en": "The primary private IP address of the ENI."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Elastic network interfaces to be attached to instance."
    },
    "Label": {
      "en": "NetworkInterfaces",
      "zh-cn": "弹性网卡列表"
    },
    "MaxLength": 8
  }
  EOT
}

variable "image_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Image ID to create ecs instance."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "system_disk_disk_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of created system disk."
    },
    "Label": {
      "en": "SystemDiskDiskName",
      "zh-cn": "系统盘名称"
    }
  }
  EOT
}

variable "spot_price_limit" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The hourly price threshold of a instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Three decimals is allowed at most. "
    },
    "Label": {
      "en": "SpotPriceLimit",
      "zh-cn": "设置实例的每小时最高价格"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Ecs instance supported instance type, make sure it should be correct."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例类型"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance, security group, disk and network interface."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例、安全组、磁盘和网卡的标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Host name of created ecs instance. at least 2 characters, and '.' '-' Is not the first and last characters as hostname, not continuous use. Windows platform can be up to 15 characters, allowing letters (without limiting case), numbers and '-', and does not support the number of points, not all is digital ('.').Other (Linux, etc.) platform up to 30 characters, allowing support number multiple points for the period between the points, each permit letters (without limiting case), numbers and '-' components."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "实例主机名"
    }
  }
  EOT
}

variable "spot_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Value range: \"NoSpot: A regular Pay-As-You-Go instance\", \"SpotWithPriceLimit: A price threshold for a spot instance, \"\"SpotAsPriceGo: A price that is based on the highest Pay-As-You-Go instance. \""
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "后付费实例的抢占策略"
    }
  }
  EOT
}

variable "password_inherit" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to use the password preset in the image.\nNote When you use this parameter, leave Password empty and make sure that the selected image has a password preset."
    },
    "Label": {
      "en": "PasswordInherit",
      "zh-cn": "是否使用镜像预设的密码"
    }
  }
  EOT
}

variable "template_resource_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the resource group to which to assign the launch template."
    },
    "Label": {
      "en": "TemplateResourceGroupId",
      "zh-cn": "启动模板所在的资源组ID"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SSH key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对名称"
    }
  }
  EOT
}

variable "launch_template_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of launch template."
    },
    "Label": {
      "en": "LaunchTemplateName",
      "zh-cn": "实例启动模板名称"
    }
  }
  EOT
}

variable "io_optimized" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The 'optimized' instance can provide better IO performance. Support 'none' and 'optimized' only."
    },
    "AllowedValues": [
      "none",
      "optimized"
    ],
    "Label": {
      "en": "IoOptimized",
      "zh-cn": "是否为I/O优化实例"
    }
  }
  EOT
}

variable "version_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description for version 1 of launch template."
    },
    "Label": {
      "en": "VersionDescription",
      "zh-cn": "实例启动模板版本描述"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Current zone to create the instance."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "实例所属的可用区ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The vSwitch Id to create ecs instance."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security group to create ecs instance. For classic instance need the security group not belong to VPC, for VPC instance, please make sure the security group belong to specified VPC."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period of the instance. Unit: months.\nThis parameter is valid and required only when InstanceChargeType is set to PrePaid.\nValid values: 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36, 48, and 60."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The ID of security group list to which to assign the instance."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "实例加入的一个或多个安全组"
    },
    "MaxLength": 20
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "Instance internet access charge type.Support 'PayByBandwidth' and 'PayByTraffic' only."
    },
    "AllowedValues": [
      "PayByTraffic",
      "PayByBandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "网络付费类型"
    }
  }
  EOT
}

variable "system_disk_category" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Category of system disk. support cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd"
    },
    "Label": {
      "en": "SystemDiskCategory",
      "zh-cn": "系统盘类型"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "deployment_set_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the deployment set."
    },
    "Label": {
      "en": "DeploymentSetId",
      "zh-cn": "部署集ID"
    }
  }
  EOT
}

variable "system_disk_delete_with_instance" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to release the system disk when the instance is released. Valid values:\ntrue: releases the system disk when the instance is released.\nfalse: does not release the system disk when the instance is released.\nDefault value: true."
    },
    "Label": {
      "en": "SystemDiskDeleteWithInstance",
      "zh-cn": "系统盘是否随实例释放"
    }
  }
  EOT
}

variable "internet_max_bandwidth_out" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Max internet out bandwidth in Mbps(Mega bit per second). Range is [0,200].While the property is not 0, public ip will be assigned for instance."
    },
    "MinValue": 0,
    "Label": {
      "en": "InternetMaxBandwidthOut",
      "zh-cn": "公网出网带宽最大值"
    },
    "MaxValue": 200
  }
  EOT
}

variable "security_enhancement_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Activate or deactivate security enhancement,Value range: \"Active\" and \"Deactive\""
    },
    "AllowedValues": [
      "Active",
      "Deactive"
    ],
    "Label": {
      "en": "SecurityEnhancementStrategy",
      "zh-cn": "是否开启安全加固"
    }
  }
  EOT
}

variable "auto_release_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Auto release time for created instance, Follow ISO8601 standard using UTC time. format is 'yyyy-MM-ddTHH:mm:ssZ'. Not bigger than 3 years from this day onwards"
    },
    "Label": {
      "en": "AutoReleaseTime",
      "zh-cn": "实例自动释放时间"
    }
  }
  EOT
}

resource "alicloud_ecs_launch_template" "launch_template" {
  image_owner_alias             = var.image_owner_alias
  private_ip_address            = var.private_ip_address
  description                   = var.description
  data_disks                    = var.disk_mappings
  resource_group_id             = var.resource_group_id
  user_data                     = var.user_data
  system_disk_size              = var.system_disk_size
  system_disk_description       = var.system_disk_description
  instance_charge_type          = var.instance_charge_type
  spot_duration                 = var.spot_duration
  template_tags                 = var.template_tags
  ram_role_name                 = var.ram_role_name
  network_type                  = var.network_type
  network_interfaces            = var.network_interfaces
  image_id                      = var.image_id
  spot_price_limit              = var.spot_price_limit
  instance_type                 = var.instance_type
  tags                          = var.tags
  host_name                     = var.host_name
  spot_strategy                 = var.spot_strategy
  password_inherit              = var.password_inherit
  template_resource_group_id    = var.template_resource_group_id
  key_pair_name                 = var.key_pair_name
  launch_template_name          = var.launch_template_name
  io_optimized                  = var.io_optimized
  version_description           = var.version_description
  zone_id                       = var.zone_id
  vswitch_id                    = var.vswitch_id
  security_group_id             = var.security_group_id
  period                        = var.period
  security_group_ids            = var.security_group_ids
  internet_charge_type          = var.internet_charge_type
  system_disk_category          = var.system_disk_category
  instance_name                 = var.instance_name
  deployment_set_id             = var.deployment_set_id
  internet_max_bandwidth_out    = var.internet_max_bandwidth_out
  security_enhancement_strategy = var.security_enhancement_strategy
  auto_release_time             = var.auto_release_time
}

output "launch_template_name" {
  value       = alicloud_ecs_launch_template.launch_template.launch_template_name
  description = "The name of launch template."
}

output "latest_version_number" {
  // Could not transform ROS Attribute LatestVersionNumber to Terraform attribute.
  value       = null
  description = "The latest version number of launch template."
}

output "launch_template_id" {
  value       = alicloud_ecs_launch_template.launch_template.id
  description = "The id of launch template."
}

output "default_version_number" {
  // Could not transform ROS Attribute DefaultVersionNumber to Terraform attribute.
  value       = null
  description = "The default version number of launch template."
}

