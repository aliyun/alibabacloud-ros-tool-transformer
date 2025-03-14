variable "connections" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcPrivateConnection": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ConnectionPort": {
                "Type": "Number",
                "Description": {
                  "en": "The service port number of the ApsaraDB for Redis instance. Valid values: 1024 to 65535."
                },
                "Required": true,
                "MinValue": 1024,
                "Label": {
                  "zh-cn": "实例的ApsaraDB服务端口号。"
                },
                "MaxValue": 65535
              },
              "ConnectionString": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the public endpoint. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
                },
                "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
                "Required": true,
                "Label": {
                  "zh-cn": "公共端点的前缀。"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Vpc intranet address."
          },
          "Required": false,
          "Label": {
            "zh-cn": "VPC内网地址。"
          }
        },
        "PublicConnection": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ConnectionPort": {
                "Type": "Number",
                "Description": {
                  "en": "The service port number of the ApsaraDB for Redis instance. Valid values: 1024 to 65535."
                },
                "Required": true,
                "MinValue": 1024,
                "Label": {
                  "zh-cn": "实例的ApsaraDB服务端口号。"
                },
                "MaxValue": 65535
              },
              "ConnectionString": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the public endpoint. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
                },
                "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
                "Required": true,
                "Label": {
                  "zh-cn": "公共端点的前缀。"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Public address."
          },
          "Required": false,
          "Label": {
            "zh-cn": "公共地址。"
          }
        },
        "DirectConnection": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ConnectionPort": {
                "Type": "Number",
                "Description": {
                  "en": "The service port number of the ApsaraDB for Redis instance. Valid values: 1024 to 65535."
                },
                "Required": true,
                "MinValue": 1024,
                "Label": {
                  "zh-cn": "实例的ApsaraDB服务端口号。"
                },
                "MaxValue": 65535
              },
              "ConnectionString": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the public endpoint. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
                },
                "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
                "Required": true,
                "Label": {
                  "zh-cn": "公共端点的前缀。"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Direct connection address. The instance is a cluster instance. \nYou can apply for a direct connection endpoint as required."
          },
          "Required": false,
          "Label": {
            "zh-cn": "直接连接地址。"
          }
        },
        "ClassicInnerConnection": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ConnectionPort": {
                "Type": "Number",
                "Description": {
                  "en": "The service port number of the ApsaraDB for Redis instance. Valid values: 1024 to 65535."
                },
                "Required": true,
                "MinValue": 1024,
                "Label": {
                  "zh-cn": "实例的ApsaraDB服务端口号。"
                },
                "MaxValue": 65535
              },
              "ConnectionString": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the public endpoint. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
                },
                "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
                "Required": true,
                "Label": {
                  "zh-cn": "公共端点的前缀。"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Classic intranet address."
          },
          "Required": false,
          "Label": {
            "zh-cn": "经典内网地址。"
          }
        }
      }
    },
    "Description": {
      "en": "Connection address"
    },
    "Label": {
      "zh-cn": "连接地址。"
    }
  }
  EOT
}

variable "secondary_zone_switch" {
  type        = bool
  description = <<EOT
  {
    "Label": {
      "zh-cn": "是否是双可用区"
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

variable "shard_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of data nodes in the instance. Default value: 1. Valid values:\n1: You can create an instance in the standard architecture that contains only a single data node. \nFor more information about the standard architecture, see Cluster master-replica instances.\n2 to 32: You can create an instance in the cluster architecturethat contains the specified number of data nodes. \nFor more information about the cluster architecture, see Cluster master-replica instances."
    },
    "Label": {
      "en": "ShardCount",
      "zh-cn": "分片数"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether destroy instance when it is in recycle. Default is false"
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否在回收时删除实例"
    }
  }
  EOT
}

variable "sslenabled" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "SSLEnabled"
    },
    "Description": {
      "en": "Modifies the SSL status. Valid values:\nDisable: disables SSL encryption.\nEnable: enables SSL encryption.\nUpdate: updates the SSL certificate."
    },
    "AllowedValues": [
      "Disable",
      "Enable",
      "Update"
    ],
    "Label": {
      "en": "SSLEnabled",
      "zh-cn": "SSL状态"
    }
  }
  EOT
}

variable "tair_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "StorageType": {
          "Type": "String",
          "Description": {
            "en": "The storage type of the instance. Set the value to essd_pl1.This parameter is available only if the InstanceClass parameter is start with tair.essdEnumeration Value:\nessd_pl0\nessd_pl1\nessd_pl\nessd_pl3\n"
          },
          "AllowedValues": [
            "essd_pl0",
            "essd_pl1",
            "essd_pl2",
            "essd_pl3"
          ],
          "Required": false
        },
        "Storage": {
          "Type": "Number",
          "Description": {
            "en": "The storage space of cloud disks. Valid values vary based on the instance specifications. \nFor more information, see ESSD-based instances.\nThis parameter is available and required only if the InstanceClass parameter is start with tair.essd"
          },
          "Required": false
        },
        "ShardCount": {
          "Type": "Number",
          "Description": {
            "en": "The number of data nodes in the instance. Default value: 1. Valid values:\n1: You can create an instance in the standard architecture that contains only a single data node. \nFor more information about the standard architecture, see Cluster master-replica instances.\n2 to 32: You can create an instance in the cluster architecturethat contains the specified number of data nodes. \nFor more information about the cluster architecture, see Cluster master-replica instances.\nThis parameter is available and required only if the InstanceClass parameter is start with tair.rdb or tair.scm"
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Tair config. This parameter is available only if the InstanceClass parameter is start with tair."
    },
    "Label": {
      "en": "TairConfig",
      "zh-cn": "Tair配置"
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
      "en": "Tags to attach to redis. Max support 20 tags to add during create redis. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "backup_policy" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PreferredBackupPeriod": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "LocaleKey": "BackupPolicy_PreferredBackupPeriod"
          },
          "Type": "String",
          "Description": {
            "en": "The backup cycle. Valid values: Monday/Tuesday/Wednesday/Thursday/Friday/Saturday/Sunday"
          },
          "AllowedValues": [
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
            "Sunday"
          ],
          "Required": true,
          "Label": {
            "zh-cn": "备份周期。"
          }
        },
        "PreferredBackupTime": {
          "Type": "String",
          "Description": {
            "en": "The time period in which data is backed up. The time period must be in the HH:mmZ-HH:mmZ format."
          },
          "Required": true,
          "Label": {
            "zh-cn": "备份时间。"
          }
        },
        "EnableBackupLog": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "LocaleKey": "BackupPolicy_EnableBackupLog"
          },
          "Type": "Number",
          "Description": {
            "en": "Enable or disable incremental backup. Options:\n1, means open.\n0, which means off, the default value."
          },
          "AllowedValues": [
            0,
            1
          ],
          "Required": false,
          "Label": {
            "zh-cn": "开启或关闭增量备份。"
          }
        }
      }
    },
    "Description": {
      "en": "Backup policy"
    },
    "Label": {
      "en": "BackupPolicy",
      "zh-cn": "备份策略"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The password of redis instance.length 8 to 30 characters, need to contain both uppercase and lowercase letters and numbers"
    },
    "Label": {
      "en": "Password",
      "zh-cn": "密码"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Engine version. Supported values: 2.8, 4.0, 5.0, 6.0 and 7.0"
    },
    "AllowedValues": [
      "4.0",
      "5.0",
      "6.0",
      "7.0"
    ],
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "数据库版本"
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
      "en": "The zone id of input region."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "eviction_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "EvictionPolicy"
    },
    "Description": {
      "en": "The eviction policy of cache data storage."
    },
    "AllowedValues": [
      "noeviction",
      "allkeys-lru",
      "volatile-lru",
      "allkeys-random",
      "volatile-random",
      "volatile-ttl"
    ],
    "Label": {
      "en": "EvictionPolicy",
      "zh-cn": "数据逐出策略"
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
      "zh-cn": "专有网络下的交换机ID"
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
      "en": "The IDs of security groups. Separate multiple security group IDs with commas (,) and up to 10 can be set."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "product_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "ProductType"
    },
    "Description": {
      "en": "Product type. Valid values:Local: Community Edition(Local) or Enhanced Edition(Local)Tair_rdb: Performance Enhanced(Cloud Disk)Tair_scm: Persistent Memory(Cloud Disk)Tair_essd: Capacity Storage(Cloud Disk)OnECS: Community Edition(Cloud Disk)"
    },
    "AllowedValues": [
      "Local",
      "Tair_rdb",
      "Tair_scm",
      "Tair_essd",
      "OnECS"
    ],
    "Label": {
      "en": "ProductType",
      "zh-cn": "产品类型"
    }
  }
  EOT
}

variable "instance_maintain_time" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MaintainEndTime": {
          "Type": "String",
          "Description": {
            "en": "The end time of the maintenance window. \nSpecify the time in the ISO 8601 standard in the HH:mmZ format. \nThe time must be in UTC. For example, if the maintenance ends at 2:00 a.m. UTC+08:00, \nyou must set this parameter to 18:00Z."
          },
          "AllowedPattern": "^([0-1][0-9]|2[0-3]):([0-5][0-9])Z$",
          "Required": false
        },
        "MaintainStartTime": {
          "Type": "String",
          "Description": {
            "en": "The start time of the maintenance window. \nSpecify the time in the ISO 8601 standard in the HH:mmZ format. \nThe time must be in UTC. For example, if the maintenance starts at 1:00 a.m. UTC+08:00, \nyou must set this parameter to 17:00Z."
          },
          "AllowedPattern": "^([0-1][0-9]|2[0-3]):([0-5][0-9])Z$",
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Instance maintain time. "
    },
    "Label": {
      "en": "InstanceMaintainTime",
      "zh-cn": "实例的可维护时间段"
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
      "en": "The period of order, when choose Prepaid required.optional value 1-9, 12, 24, 36, 60 Unit in month."
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
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "付费周期"
    }
  }
  EOT
}

variable "instance_class" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}",
      "InstanceChargeType": "$${ChargeType}",
      "ProductType": "$${ProductType}"
    },
    "AssociationProperty": "ALIYUN::Redis::Instance::InstanceType",
    "Description": {
      "en": "Redis instance type. Refer the Redis instance type reference, such as 'redis.master.small.default', 'redis.master.4xlarge.default', 'redis.sharding.mid.default' etc"
    },
    "Label": {
      "en": "InstanceClass",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "vpc_password_free" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable password free for access within the VPC. If set to:\n- true: enables password free.\n- false: disables password free."
    },
    "Label": {
      "en": "VpcPasswordFree",
      "zh-cn": "是否启用免密码访问专有网络中的实例"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the instance. Default is false."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否已开启释放保护功能"
    }
  }
  EOT
}

variable "secondary_zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${SecondaryZoneSwitch}",
                true
              ]
            }
          ]
        }
      }
    },
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The secondary zone ID of the instance."
    },
    "Label": {
      "en": "SecondaryZoneId",
      "zh-cn": "备可用区ID"
    }
  }
  EOT
}

variable "auto_renew_duration" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ChargeType}",
            "PrePaid"
          ]
        }
      }
    },
    "Description": {
      "en": "The auto-renewal period. Valid values: 1 to 12. \n When the instance is about to expire, the instance is automatically renewed \nbased on the number of months specified by this parameter. \nNote This parameter is valid only when ChargeType is set to PrePaid."
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
      10,
      11,
      12
    ],
    "Label": {
      "en": "AutoRenewDuration",
      "zh-cn": "自动续费时长"
    },
    "MinValue": 1,
    "MaxValue": 12
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

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
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

variable "charge_type" {
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
            9
          ],
          "Year": [
            1,
            2,
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the ApsaraDB for Redis instance."
    },
    "AllowedValues": [
      "PrePaid",
      "PostPaid"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "实例付费类型"
    }
  }
  EOT
}

variable "node_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of node. Valid value:\n- **STAND_ALONE**\n- **MASTER_SLAVE**\n- **double**\n- **single**"
    },
    "AllowedValues": [
      "MASTER_SLAVE",
      "STAND_ALONE",
      "double",
      "single"
    ],
    "Label": {
      "en": "NodeType",
      "zh-cn": "节点类型"
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
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "month",
      "year",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "时长单位"
    }
  }
  EOT
}

resource "alicloud_kvstore_instance" "kv_instance" {
  resource_group_id = var.resource_group_id
  shard_count       = var.shard_count
  tags              = var.tags
  password          = var.password
  engine_version    = var.engine_version
  availability_zone = var.zone_id
  vswitch_id        = var.vswitch_id
  security_group_id = var.security_group_id
  period            = var.period
  instance_class    = var.instance_class
  vpc_auth_mode     = var.vpc_password_free
  secondary_zone_id = var.secondary_zone_id
  instance_name     = var.instance_name
  payment_type      = var.charge_type
  node_type         = var.node_type
}

output "connections" {
  // Could not transform ROS Attribute Connections to Terraform attribute.
  value       = null
  description = "The maximum number of connections supported by the instance."
}

output "direct_connection_port" {
  // Could not transform ROS Attribute DirectConnectionPort to Terraform attribute.
  value       = null
  description = "The direct connection port of the instance"
}

output "resource_group_id" {
  value       = alicloud_kvstore_instance.kv_instance.resource_group_id
  description = "The ID of the resource group to which the instance belongs."
}

output "port" {
  // Could not transform ROS Attribute Port to Terraform attribute.
  value       = null
  description = "Port of created instance."
}

output "vpc_private_connection_string" {
  // Could not transform ROS Attribute VpcPrivateConnectionString to Terraform attribute.
  value       = null
  description = "The vpc private connection string of the instance"
}

output "has_renew_change_order" {
  // Could not transform ROS Attribute HasRenewChangeOrder to Terraform attribute.
  value       = null
  description = "Indicates whether the Alibaba Cloud account has pending renewal or scaling orders"
}

output "connection_domain" {
  value       = alicloud_kvstore_instance.kv_instance.connection_domain
  description = "Connection domain of created instance."
}

output "capacity" {
  value       = alicloud_kvstore_instance.kv_instance.capacity
  description = "The storage capacity of the instance. Unit: MB."
}

output "qps" {
  // Could not transform ROS Attribute QPS to Terraform attribute.
  value       = null
  description = "The queries per second (QPS) supported by the instance."
}

output "private_ip" {
  value       = alicloud_kvstore_instance.kv_instance.private_ip
  description = "The internal IP address of the instance."
}

output "network_type" {
  // Could not transform ROS Attribute NetworkType to Terraform attribute.
  value       = null
  description = "The network type."
}

output "package_type" {
  // Could not transform ROS Attribute PackageType to Terraform attribute.
  value       = null
  description = "The plan type."
}

output "bandwidth" {
  value       = alicloud_kvstore_instance.kv_instance.bandwidth
  description = "The bandwidth of the instance. Unit: Mbit/s."
}

output "public_connection_string" {
  // Could not transform ROS Attribute PublicConnectionString to Terraform attribute.
  value       = null
  description = "The public connection string of the instance"
}

output "instance_type" {
  value       = alicloud_kvstore_instance.kv_instance.instance_type
  description = "The engine type of the instance."
}

output "architecture_type" {
  // Could not transform ROS Attribute ArchitectureType to Terraform attribute.
  value       = null
  description = "The architecture."
}

output "engine_version" {
  value       = alicloud_kvstore_instance.kv_instance.engine_version
  description = "The engine version of the instance."
}

output "zone_id" {
  value       = alicloud_kvstore_instance.kv_instance.availability_zone
  description = "The ID of the zone."
}

output "instance_id" {
  value       = alicloud_kvstore_instance.kv_instance.id
  description = "Instance id of created redis instance."
}

output "classic_inner_connection_port" {
  // Could not transform ROS Attribute ClassicInnerConnectionPort to Terraform attribute.
  value       = null
  description = "The classic inner connection port of the instance"
}

output "vswitch_id" {
  value       = alicloud_kvstore_instance.kv_instance.vswitch_id
  description = "The ID of the vSwitch."
}

output "classic_inner_connection_string" {
  // Could not transform ROS Attribute ClassicInnerConnectionString to Terraform attribute.
  value       = null
  description = "The classic inner connection string of the instance"
}

output "vpc_private_connection_port" {
  // Could not transform ROS Attribute VpcPrivateConnectionPort to Terraform attribute.
  value       = null
  description = "The vpc private connection port of the instance"
}

output "instance_class" {
  value       = alicloud_kvstore_instance.kv_instance.instance_class
  description = "Redis instance type."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Order Id of created instance."
}

output "instance_name" {
  value       = alicloud_kvstore_instance.kv_instance.instance_name
  description = "Name of created redis instance."
}

output "vpc_id" {
  // Could not transform ROS Attribute VpcId to Terraform attribute.
  value       = null
  description = "The ID of the VPC."
}

output "public_connection_port" {
  // Could not transform ROS Attribute PublicConnectionPort to Terraform attribute.
  value       = null
  description = "The public connection port of the instance"
}

output "charge_type" {
  // Could not transform ROS Attribute ChargeType to Terraform attribute.
  value       = null
  description = "The billing method of the instance."
}

output "node_type" {
  value       = alicloud_kvstore_instance.kv_instance.node_type
  description = "The type of node."
}

output "direct_connection_string" {
  // Could not transform ROS Attribute DirectConnectionString to Terraform attribute.
  value       = null
  description = "The direct connection string of the instance"
}

