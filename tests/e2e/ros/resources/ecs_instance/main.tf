variable "dedicated_host_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "which dedicated host will be deployed"
    },
    "Label": {
      "zh-cn": "宿主机ID"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Private IP for the instance created. Only works for VPC instance and cannot duplicated with existing instance.",
      "zh-cn": "在专有网络环境下，指定的内网IP。"
    },
    "Label": {
      "zh-cn": "内网IP地址"
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
      "en": "Description of the instance, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "disk_mappings" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SnapshotId": {
          "AssociationPropertyMetadata": {
            "Category": "$${.Category}",
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Snapshot::SnapshotId",
          "Type": "String",
          "Description": {
            "en": "ID of the snapshot to create the volume."
          },
          "Required": false
        },
        "Category": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Disk::DataDiskCategory",
          "Type": "String",
          "Description": {
            "en": "The volume type.Now support: cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd. Default is cloud_efficiency."
          },
          "AllowedValues": [
            "cloud_essd",
            "cloud_efficiency",
            "cloud_ssd",
            "cloud",
            "cloud_auto",
            "cloud_essd_entry"
          ],
          "Required": false,
          "Label": {
            "zh-cn": "类型"
          },
          "Default": "cloud_essd"
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the disk, [2, 256] characters. Do not fill or empty, the default is empty."
          },
          "Required": false
        },
        "Device": {
          "Type": "String",
          "Description": {
            "en": "The device where the volume is exposed on the instance. could be /dev/xvd[a-z]. If not specification, will use default value."
          },
          "Required": false
        },
        "PerformanceLevel": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Category}",
                  "cloud_essd"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The performance level of the enhanced SSD used as the Nth data disk.Default value: PL1. Valid values:PL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.PL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.PL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.PL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS."
          },
          "AllowedValues": [
            "PL0",
            "PL1",
            "PL2",
            "PL3"
          ],
          "Required": false,
          "Label": {
            "zh-cn": "性能"
          },
          "Default": "PL0"
        },
        "Size": {
          "Type": "String",
          "Description": {
            "en": "The size of the volume, unit in GB.Value range: cloud: [5,2000], cloud_efficiency: [20,32768], cloud_ssd: [20,32768], cloud_essd: [20,32768], ephemeral_ssd: [5,800].The value should be equal to or greater than the specific snapshot."
          },
          "Required": true,
          "Label": {
            "zh-cn": "容量"
          },
          "Default": 100
        },
        "DiskName": {
          "Type": "String",
          "Description": {
            "en": "Display name of the disk, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'."
          },
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Category",
          "Size",
          "PerformanceLevel",
          "SnapshotId",
          "Device",
          "DiskName",
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Disk mappings to attach to instance. Max support 16 disks.\nIf the image contains a data disk, you can specify other parameters of the data disk via the same value of parameter \"Device\". If parameter \"Category\" is not specified, it will be cloud_efficiency instead of \"Category\" of data disk in the image."
    },
    "Label": {
      "en": "DiskMappings",
      "zh-cn": "需要挂载的数据盘"
    },
    "MaxLength": 16
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  default     = 40
  description = <<EOT
  {
    "Description": {
      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size. "
    },
    "MinValue": 2,
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "user_data" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Language": [
        "shell",
        "bat",
        "powershell"
      ]
    },
    "AssociationProperty": "Code",
    "Description": {
      "en": "User data to pass to instance. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "创建ECS实例时传递的用户数据"
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
      "zh-cn": "系统盘描述信息"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  default     = "PostPaid"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PostPaid": {},
        "PrePaid": {
          "Month": [
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
          "Week": [
            1,
            2,
            3,
            4
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Instance Charge type, allowed value: Prepaid and Postpaid. If specified Prepaid, please ensure you have sufficient balance in your account. Or instance creation will be failure. Default value is Postpaid."
    },
    "AllowedValues": [
      "PrePaid",
      "PostPaid"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "ECS实例付费类型"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = string
  default     = "False"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether renew the fee automatically? When the parameter InstanceChargeType is PrePaid, it will take effect. Range of value:True: automatic renewal.False: no automatic renewal. Default value is False."
    },
    "AllowedValues": [
      "True",
      "False"
    ],
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
    }
  }
  EOT
}

variable "spot_duration" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotWithPriceLimit"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotAsPriceGo"
                  ]
                }
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
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

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::Role",
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
  default     = "PL1"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SystemDiskCategory}",
            "cloud_essd"
          ]
        }
      }
    },
    "Description": {
      "en": "The performance level of the enhanced SSD used as the system disk.Default value: PL1. Valid values:PL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.PL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.PL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.PL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS.",
      "zh-cn": "创建ESSD云盘作为系统盘使用时，设置云盘的性能等级。"
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "zh-cn": "ESSD系统盘性能等级"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "DefaultFilter": {
        "ImageOwnerAlias": "system",
        "ImageName": "aliyun_3_**",
        "OSType": "linux"
      },
      "InstanceType": "$${InstanceType}",
      "SupportedImageOwnerAlias": [
        "system",
        "self",
        "others"
      ]
    },
    "AssociationProperty": "ALIYUN::ECS::Image::ImageId",
    "Description": {
      "en": "Image ID to create ecs instance.",
      "zh-cn": "镜像ID。包括公共镜像、自定义镜像和云市场镜像。"
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "spot_price_limit" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${SpotStrategy}",
                "SpotWithPriceLimit"
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
    "AssociationProperty": "Number",
    "Description": {
      "en": "The hourly price threshold of a instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Three decimals is allowed at most. "
    },
    "Label": {
      "en": "SpotPriceLimit",
      "zh-cn": "实例的每小时最高价格"
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

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}",
      "DefaultValueStrategy": "recent",
      "InstanceChargeType": "$${InstanceChargeType}",
      "SpotStrategy": "$${SpotStrategy}"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "Description": {
      "en": "Ecs instance supported instance type, make sure it should be correct."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "ECS实例规格"
    }
  }
  EOT
}

variable "allocate_publicip" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "The public ip for ecs instance, if properties is true, will allocate public ip. If property InternetMaxBandwidthOut set to 0, it will not assign public ip."
    },
    "Label": {
      "en": "AllocatePublicIP",
      "zh-cn": "是否分配公网IP"
    }
  }
  EOT
}

variable "tags" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
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
          "Required": true
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "用户自定义标签"
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
      "en": "Host name of created ecs instance. at least 2 characters, and '.' '-' Is not the first and last characters as hostname, not continuous use. Windows platform can be up to 15 characters, allowing letters (without limiting case), numbers and '-', and does not support the number of points, not all is digital ('.').Other (Linux, etc.) platform up to 64 characters, allowing support number multiple points for the period between the points, each permit letters (without limiting case), numbers and '-' components."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "云服务器的主机名"
    },
    "MinLength": 2,
    "MaxLength": 64
  }
  EOT
}

variable "spot_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NodeGroups_SpotStrategy"
    },
    "Description": {
      "en": "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Value range: \"NoSpot: A regular Pay-As-You-Go instance\", \"SpotWithPriceLimit: A price threshold for a spot instance, \"\"SpotAsPriceGo: A price that is based on the highest Pay-As-You-Go instance. \"Default value: NoSpot."
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "按量付费实例的竞价策略"
    }
  }
  EOT
}

variable "password_inherit" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to use the password preset in the image. To use the PasswordInherit parameter, the Password parameter must be empty and you must make sure that the selected image has a password configured."
    },
    "Label": {
      "en": "PasswordInherit",
      "zh-cn": "是否使用镜像预设的密码"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::Password",
    "Description": {
      "en": "Password of created ecs instance. Must contain at least 3 types of special character, lower character, upper character, number."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "ECS实例登录密码"
    }
  }
  EOT
}

variable "auto_renew_period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "The time period of auto renew. When the parameter InstanceChargeType is PrePaid, it will take effect.It could be 1, 2, 3, 6, 12, 24, 36, 48, 60. Default value is 1."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "每次自动续费的时长"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::KeyPair::KeyPairName",
    "Description": {
      "en": "SSH key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "ECS实例绑定的密钥对名称"
    }
  }
  EOT
}

variable "io_optimized" {
  type        = string
  default     = "optimized"
  description = <<EOT
  {
    "Description": {
      "en": "The 'optimized' instance can provide better IO performance. Support 'none' and 'optimized' only, default is 'optimized'."
    },
    "AllowedValues": [
      "none",
      "optimized"
    ],
    "Label": {
      "en": "IoOptimized",
      "zh-cn": "是否创建I/O优化实例"
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
      "en": "The ID of the zone to which the instance belongs. For more information, \ncall the DescribeZones operation to query the most recent zone list. \nDefault value is empty, which means random selection."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "hpc_cluster_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::EHPC::Cluster::ClusterId",
    "Description": {
      "en": "The HPC cluster ID to which the instance belongs."
    },
    "Label": {
      "en": "HpcClusterId",
      "zh-cn": "实例所属的HPC集群ID"
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
      "ZoneId": "$${ZoneId}",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "vpc"
          ]
        }
      }
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

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period. Unit is month, it could be from 1 to 9 or 12, 24, 36, 48, 60. Default value is 1."
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
      "zh-cn": "付费周期"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether an instance can be released manually through the console or API, deletion protection only support postPaid instance",
      "zh-cn": "实例释放保护属性，指定是否支持通过控制台或DeleteInstance接口释放实例。"
    },
    "AllowedValues": [
      true,
      false
    ],
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "实例释放保护属性"
    }
  }
  EOT
}

variable "security_group_ids" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
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
      "en": "The ID list of security group to which to assign the instance. The max length is based on the maximum number of security groups to which an instance can belong. For more information, see the \"Security group limits\" section in Limits."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "安全组ID列表"
    },
    "MinLength": 1,
    "MaxLength": 16
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  default     = "paybytraffic"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AllocatePublicIP}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "Instance internet access charge type.Support 'PayByBandwidth' and 'PayByTraffic' only. Default is PayByTraffic"
    },
    "AllowedValues": [
      "paybytraffic",
      "paybybandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "访问公网计费方式"
    }
  }
  EOT
}

variable "system_disk_category" {
  type        = string
  default     = "cloud_essd"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoSelectFirst": true,
      "AutoChangeType": false,
      "ZoneId": "$${ZoneId}",
      "InstanceType": "$${InstanceType}"
    },
    "AssociationProperty": "ALIYUN::ECS::Disk::SystemDiskCategory",
    "Description": {
      "en": "Category of system disk. Default is cloud_efficiency. support cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd|cloud_auto|cloud_essd_entry"
    },
    "AllowedValues": [
      "cloud_essd",
      "cloud_efficiency",
      "cloud_ssd",
      "cloud",
      "cloud_auto",
      "cloud_essd_entry"
    ],
    "Label": {
      "en": "SystemDiskCategory",
      "zh-cn": "系统盘类型"
    }
  }
  EOT
}

variable "spot_interruption_behavior" {
  type        = string
  default     = "Terminate"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ECSSpotInstanceInterruptionBehavior",
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotWithPriceLimit"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotAsPriceGo"
                  ]
                }
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The interruption mode of the preemptible instance. Default value: Terminate. Set the value to Terminate, which specifies to release the instance."
    },
    "Label": {
      "en": "SpotInterruptionBehavior",
      "zh-cn": "抢占实例中断模式"
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
    "AssociationProperty": "ALIYUN::ECS::DeploymentSet::DeploymentSetId",
    "Description": {
      "en": "Deployment set ID."
    },
    "Label": {
      "en": "DeploymentSetId",
      "zh-cn": "部署集ID"
    }
  }
  EOT
}

variable "internet_max_bandwidth_out" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AllocatePublicIP}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "Set internet output bandwidth of instance. Unit is Mbps(Mega bit per second). Range is [0,200]. Default is 1.While the property is not 0, public ip will be assigned for instance."
    },
    "MinValue": 0,
    "Label": {
      "en": "InternetMaxBandwidthOut",
      "zh-cn": "公网出带宽最大值"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "vpc"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC id to create ecs instance."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "security_enhancement_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ECSSecurityEnhancementStrategy"
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

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of prepaid time period, it could be Week/Month/Year. Default value is Month."
    },
    "AllowedValues": [
      "Week",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

resource "alicloud_instance" "instance" {
  // The value var.disk_mappings of arguments data_disks is not block and will be ignore.
  dedicated_host_id             = var.dedicated_host_id
  private_ip                    = var.private_ip_address
  description                   = var.description
  resource_group_id             = var.resource_group_id
  system_disk_size              = var.system_disk_size
  user_data                     = var.user_data
  system_disk_description       = var.system_disk_description
  instance_charge_type          = var.instance_charge_type
  spot_duration                 = var.spot_duration
  role_name                     = var.ram_role_name
  system_disk_performance_level = var.system_disk_performance_level
  image_id                      = var.image_id
  spot_price_limit              = var.spot_price_limit
  instance_type                 = var.instance_type
  tags                          = var.tags
  host_name                     = var.host_name
  spot_strategy                 = var.spot_strategy
  password                      = var.password
  auto_renew_period             = var.auto_renew_period
  key_name                      = var.key_pair_name
  availability_zone             = var.zone_id
  hpc_cluster_id                = var.hpc_cluster_id
  vswitch_id                    = var.vswitch_id
  period                        = var.period
  deletion_protection           = var.deletion_protection
  security_groups               = var.security_group_ids
  internet_charge_type          = var.internet_charge_type
  system_disk_category          = var.system_disk_category
  instance_name                 = var.instance_name
  deployment_set_id             = var.deployment_set_id
  internet_max_bandwidth_out    = var.internet_max_bandwidth_out
  vpc_id                        = var.vpc_id
  security_enhancement_strategy = var.security_enhancement_strategy
  period_unit                   = var.period_unit
}

output "primary_network_interface_id" {
  // Could not transform ROS Attribute PrimaryNetworkInterfaceId to Terraform attribute.
  value       = null
  description = "Primary network interface ID of created instance."
}

output "inner_ip" {
  // Could not transform ROS Attribute InnerIp to Terraform attribute.
  value       = null
  description = "Inner IP address of the specified instance. Only for classical instance."
}

output "zone_id" {
  value       = alicloud_instance.instance.availability_zone
  description = "Zone ID of created instance."
}

output "private_ip" {
  value       = alicloud_instance.instance.private_ip
  description = "Private IP address of created ecs instance. Only for VPC instance."
}

output "instance_id" {
  value       = alicloud_instance.instance.id
  description = "The instance ID of created ecs instance"
}

output "public_ip" {
  value       = alicloud_instance.instance.public_ip
  description = "Public IP address of created ecs instance."
}

output "security_group_ids" {
  // Could not transform ROS Attribute SecurityGroupIds to Terraform attribute.
  value       = null
  description = "Security group ID list of created instance."
}

output "host_name" {
  value       = alicloud_instance.instance.host_name
  description = "Host name of created instance."
}

