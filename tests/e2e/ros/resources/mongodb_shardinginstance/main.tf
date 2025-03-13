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
      "zh-cn": "实例所属的资源组ID"
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
      "zh-cn": "设置实例是否自动续费"
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

variable "securityiparray" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security ips to add or remove."
    },
    "Label": {
      "en": "SecurityIPArray",
      "zh-cn": "实例的IP白名单"
    }
  }
  EOT
}

variable "mongos" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Class": {
          "Type": "String",
          "Description": {
            "en": "The specification of mongo."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Mongos",
      "zh-cn": "Mongos节点"
    },
    "MinLength": 2,
    "MaxLength": 32
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
      "zh-cn": "实例使用的存储引擎"
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

variable "restore_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time to restore the cloned instance to. The format is yyyy-MM-ddTHH:mm:ssZ.This parameter can only be specified when this operation is called to clone instances.You must also specify theSrcDBInstanceIdparameter and theBackupIdparameter.You can clone instances to any restore time in the past seven days."
    },
    "Label": {
      "en": "RestoreTime",
      "zh-cn": "克隆实例时所恢复的时间点"
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

variable "protocol_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Protocol type. Valid value: mongodb or dynamodb."
    },
    "AllowedValues": [
      "mongodb",
      "dynamodb"
    ],
    "Label": {
      "en": "ProtocolType",
      "zh-cn": "访问协议的类型"
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

variable "config_server" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Storage": {
          "Type": "Number",
          "Description": {
            "en": "The storage space of config server. Valid value: 20. Unit: GB."
          },
          "Required": true
        },
        "Class": {
          "Type": "String",
          "Description": {
            "en": "The specification of config server."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "ConfigServer",
      "zh-cn": "ConfigServer规格配置"
    },
    "MinLength": 1,
    "MaxLength": 3
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

variable "replica_set" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Storage": {
          "Type": "Number",
          "Description": {
            "en": "The storage space of shard.\nValid values: 10 to 2000. Unit: GB.\nYou can only specify this value in 10 GB increments."
          },
          "Required": true
        },
        "ReadonlyReplicas": {
          "Type": "Number",
          "Description": {
            "en": "The number of read-only nodes in shard node."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 5
        },
        "Class": {
          "Type": "String",
          "Description": {
            "en": "The specification of shard."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "ReplicaSet",
      "zh-cn": "Shard节点"
    },
    "MinLength": 2,
    "MaxLength": 32
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
      "zh-cn": "实例名称"
    }
  }
  EOT
}

resource "alicloud_mongodb_sharding_instance" "mongo_db_sharding_instance" {
  engine_version       = var.engine_version
  storage_type         = var.storage_type
  resource_group_id    = var.resource_group_id
  zone_id              = var.zone_id
  auto_renew           = var.auto_renew
  vswitch_id           = var.vswitch_id
  period               = var.period
  security_ip_list     = var.securityiparray
  mongo_list           = var.mongos
  storage_engine       = var.storage_engine
  account_password     = var.account_password
  vpc_id               = var.vpc_id
  protocol_type        = var.protocol_type
  instance_charge_type = var.charge_type
  shard_list           = var.replica_set
  tags                 = var.tags
  name                 = var.dbinstance_description
}

output "dbinstance_status" {
  // Could not transform ROS Attribute DBInstanceStatus to Terraform attribute.
  value       = null
  description = "Status of mongodb instance."
}

output "dbinstance_id" {
  value       = alicloud_mongodb_sharding_instance.mongo_db_sharding_instance.id
  description = "The instance id of created mongodb instance."
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

