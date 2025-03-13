variable "business_info" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The business information. It is an additional parameter."
    },
    "Label": {
      "en": "BusinessInfo",
      "zh-cn": "业务信息"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "hidden_zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AvailabilityZoneType}",
            "MultiAZ"
          ]
        }
      }
    },
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Configure the zone where the hidden node resides to implement multi-availability zone deployment.\nWhen the value of the EngineVersion is 4.4 and later, this parameter is available and required.\nThe value of this parameter cannot be the same as that of ZoneId and SecondaryZoneId."
    },
    "Label": {
      "en": "HiddenZoneId",
      "zh-cn": "配置隐藏节点（Hidden节点）所在的可用区"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether automatic renewal is enabled for the instance. Valid values:true: Automatic renewal is enabled.false: Automatic renewal is not enabled. You must renew the instance manually.Default value: false."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否为实例启用自动续费"
    }
  }
  EOT
}

variable "securityiparray" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security ips to add or remove."
    },
    "Label": {
      "en": "SecurityIPArray",
      "zh-cn": "所有可以访问创建或克隆实例的IP地址"
    }
  }
  EOT
}

variable "backup_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specific backup set Id."
    },
    "Label": {
      "en": "BackupId",
      "zh-cn": "备份集ID"
    }
  }
  EOT
}

variable "storage_engine" {
  type        = string
  default     = "WiredTiger"
  description = <<EOT
  {
    "Description": {
      "en": "Database storage engine.Support WiredTiger, RocksDB, TerarkDB"
    },
    "AllowedValues": [
      "WiredTiger",
      "RocksDB",
      "TerarkDB"
    ],
    "Label": {
      "en": "StorageEngine",
      "zh-cn": "存储引擎"
    }
  }
  EOT
}

variable "availability_zone_type" {
  type        = string
  default     = "SingleAZ"
  description = <<EOT
  {
    "Description": {
      "zh-cn": "三个节点跨可用区部署，支持机房级别同城容灾切换。"
    },
    "AllowedValues": [
      "SingleAZ",
      "MultiAZ"
    ],
    "Label": {
      "zh-cn": "可用区类型"
    }
  }
  EOT
}

variable "restore_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time to restore the cloned instance to. The format is yyyy-MM-ddTHH:mm:ssZ.This parameter can only be specified when this operation is called to clone instances.You must also specify theSrcDBInstanceIdparameter and theBackupIdparameter.You can clone instances to any restore time in the past seven days."
    },
    "Label": {
      "en": "RestoreTime",
      "zh-cn": "克隆实例时恢复数据的时间点"
    }
  }
  EOT
}

variable "private_connections" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ReplicaConnections": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ConnectionPort": {
                "Type": "Number",
                "Description": {
                  "en": "The service port number of the ApsaraDB for MongoDB instance. Valid values: 1000 to 65535."
                },
                "Required": false,
                "MinValue": 1000,
                "MaxValue": 65535
              },
              "ConnectionString": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the connection string. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
                },
                "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "Replica private connections"
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 6
        }
      }
    },
    "Description": {
      "en": "Connection configs of private connection."
    },
    "Label": {
      "en": "PrivateConnections",
      "zh-cn": "私有连接的连接配置"
    }
  }
  EOT
}

variable "dbinstance_storage" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Database instance storage size. MongoDB is [5,3000], increased every 10 GB, Unit in GB"
    },
    "Label": {
      "en": "DBInstanceStorage",
      "zh-cn": "数据库实例的存储空间"
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "dbinstance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of created database instance."
    },
    "Label": {
      "en": "DBInstanceDescription",
      "zh-cn": "实例描述"
    }
  }
  EOT
}

variable "coupon_no" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The coupon code. Default value:youhuiquan_promotion_option_id_for_blank."
    },
    "Label": {
      "en": "CouponNo",
      "zh-cn": "优惠码"
    }
  }
  EOT
}

variable "tdestatus" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable Transparent Data Encryption (TDE). Valid values:\ntrue: enable TDE\nfalse: disable TDE (default)\nNote: You cannot disable TDE after it is enabled. "
    },
    "Label": {
      "en": "TDEStatus",
      "zh-cn": "是否启用透明数据加密（TDE）"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  default     = "7.0"
  description = <<EOT
  {
    "Description": {
      "en": "Database instance version."
    },
    "AllowedValues": [
      "7.0",
      "6.0",
      "5.0",
      "4.4",
      "4.2",
      "4.0"
    ],
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "数据库版本号"
    }
  }
  EOT
}

variable "storage_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The storage type of the instance.\nInstances of MongoDB 4.4 and later only support cloud disks. cloud_essd1 is selected if you leave this parameter empty.\nInstances of MongoDB 4.2 and earlier support only local disks. local_ssd is selected if you leave this parameter empty."
    },
    "AllowedValues": [
      "local_ssd",
      "cloud_essd1",
      "cloud_essd2",
      "cloud_essd3"
    ],
    "Label": {
      "en": "StorageType",
      "zh-cn": "存储类型"
    }
  }
  EOT
}

variable "readonly_replicas" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Number of read-only nodes, in the range of 1-5."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5
    ],
    "Label": {
      "en": "ReadonlyReplicas",
      "zh-cn": "只读节点的数量"
    }
  }
  EOT
}

variable "replication_factor" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of nodes in the replica set. Allowed values: [3, 5, 7], default to 3."
    },
    "AllowedValues": [
      3,
      5,
      7
    ],
    "Label": {
      "en": "ReplicationFactor",
      "zh-cn": "副本集节点数"
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
      "en": "On which zone to create the instance. If VpcId and VSwitchId is specified, ZoneId is required and VSwitch should be in same zone."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "dbinstance_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "MongoDB instance supported instance type, make sure it should be correct."
    },
    "Label": {
      "en": "DBInstanceClass",
      "zh-cn": "实例规格"
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
      "en": "The ID of the ECS security group.\nEach ApsaraDB for MongoDB instance can be added in up to 10 security group. \nYou can call the ECS DescribeSecurityGroup to describe the ID of the security group in the target region."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
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
      "en": "The vSwitch Id to create mongodb instance."
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
      "en": "The subscription period of the instance.Default Unit: Month.Valid values: [1~9], 12, 24, 36. Default to 1."
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
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "实例的购买时长"
    }
  }
  EOT
}

variable "vpc_password_free" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable password free for access within the VPC. If set to:\n- true: enables password free.\n- false: disables password free.",
      "zh-cn": "在VPC网络中访问创建或克隆的实例时，是否启用免密码。"
    },
    "Label": {
      "zh-cn": "VPC网络中访问是否免密"
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
          "Fn::Equals": [
            "$${AvailabilityZoneType}",
            "MultiAZ"
          ]
        }
      }
    },
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Configure the zone where the secondary node resides to implement multi-availability zone deployment.\nWhen the value of the EngineVersion is 4.4 and later, this parameter is available and required.The value of this parameter cannot be the same as that of ZoneId and HiddenZoneId."
    },
    "Label": {
      "en": "SecondaryZoneId",
      "zh-cn": "配置从节点（Secondary节点）所在的可用区"
    }
  }
  EOT
}

variable "account_password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Root account password, can contain the letters, numbers or underscores the composition, length of 6~32 bit."
    },
    "Label": {
      "en": "AccountPassword",
      "zh-cn": "Root账号的密码"
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
      "en": "The VPC id to create mongodb instance."
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
  default     = "PayAsYouGo"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Subscription": {
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
            36
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the instance.values:PostPaid: Pay-As-You-Go.PrePaid: Subscription.Default value: PostPaid"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "database_names" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the database."
    },
    "Label": {
      "en": "DatabaseNames",
      "zh-cn": "数据库名称"
    }
  }
  EOT
}

variable "srcdbinstance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Create an instance of the backup set based on an instance."
    },
    "Label": {
      "en": "SrcDBInstanceId",
      "zh-cn": "源实例ID"
    }
  }
  EOT
}

resource "alicloud_mongodb_instance" "mongodbinstance" {
  resource_group_id    = var.resource_group_id
  hidden_zone_id       = var.hidden_zone_id
  auto_renew           = var.auto_renew
  security_ip_list     = var.securityiparray
  storage_engine       = var.storage_engine
  tags                 = var.tags
  name                 = var.dbinstance_description
  engine_version       = var.engine_version
  storage_type         = var.storage_type
  readonly_replicas    = var.readonly_replicas
  replication_factor   = var.replication_factor
  zone_id              = var.zone_id
  db_instance_storage  = var.dbinstance_class
  security_group_id    = var.security_group_id
  vswitch_id           = var.vswitch_id
  period               = var.period
  secondary_zone_id    = var.secondary_zone_id
  account_password     = var.account_password
  vpc_id               = var.vpc_id
  instance_charge_type = var.charge_type
}

output "dbinstance_status" {
  // Could not transform ROS Attribute DBInstanceStatus to Terraform attribute.
  value       = null
  description = "Status of mongodb instance."
}

output "dbinstance_id" {
  value       = alicloud_mongodb_instance.mongodbinstance.id
  description = "The instance id of created mongodb instance."
}

output "connectionuri" {
  // Could not transform ROS Attribute ConnectionURI to Terraform attribute.
  value       = null
  description = "Connection uri."
}

output "replica_set_name" {
  value       = alicloud_mongodb_instance.mongodbinstance.replica_set_name
  description = "Name of replica set"
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Order Id of created instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

