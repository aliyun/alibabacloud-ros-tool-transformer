variable "master_node_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of master nodes. Minimum is 1, max is 2."
    },
    "MinValue": 1,
    "Label": {
      "en": "MasterNodeNum",
      "zh-cn": "主节点数量"
    },
    "MaxValue": 2
  }
  EOT
}

variable "encryption_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the encryption. Default value: NULL. Valid values:\nNULL: Encryption is disabled.\nCloudDisk: Encryption is enabled on disks and the encryption key is specified by using the EncryptionKey parameter.\nNote: Disk encryption cannot be disabled after it is enabled."
    },
    "AllowedValues": [
      "NULL",
      "CloudDisk"
    ],
    "Label": {
      "en": "EncryptionType",
      "zh-cn": "加密类型"
    }
  }
  EOT
}

variable "instance_spec" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The specification of segment nodes. For example: 2C16G, 4C32G, 16C128G."
    },
    "Label": {
      "en": "InstanceSpec",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "6.0",
      "6.0x"
    ],
    "Description": {
      "en": "The version of the database engine. For example: 6.0、7.0"
    },
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "引擎版本"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Private IP address."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "私有IP地址"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone ID of the instance, such as cn-hangzhou-d. You can call the DescribeRegions\noperation to query the most recent zone list."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "vpcid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC ID of the instance. If you set the InstanceNetworkType parameter to VPC, you\nmust also specify the VPCId parameter. The specified region of the VPC must be the\nsame as the RegionId value."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VPCId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The vSwitch ID of the instance."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "seg_node_num" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The number of segment nodes.\nFor the high availability version, the value ranges from 4 to 512.\nThe basic version ranges from 2 to 512."
    },
    "MinValue": 2,
    "Label": {
      "en": "SegNodeNum",
      "zh-cn": "节点数量"
    },
    "MaxValue": 512
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period. While choose by pay by month, it could be from 1 to 11. While choose pay by year, it could be from 1 to 3."
    },
    "MinValue": 1,
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长单位"
    },
    "MaxValue": 11
  }
  EOT
}

variable "seg_storage_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The disk type of segment nodes. For example: cloud_essd, cloud_efficiency."
    },
    "Label": {
      "en": "SegStorageType",
      "zh-cn": "节点磁盘类型"
    }
  }
  EOT
}

variable "storage_size" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of per segment node. Unit: GB. Minimum is 50, max is 4000, step is 50."
    },
    "MinValue": 50,
    "Label": {
      "en": "StorageSize",
      "zh-cn": "节点存储容量"
    },
    "MaxValue": 4000
  }
  EOT
}

variable "encryption_key" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${EncryptionType}",
            "CloudDisk"
          ]
        }
      }
    },
    "Description": {
      "en": "If the EncryptionType parameter is set to CloudDisk, you must specify this parameter to the encryption key that is in the same region with the disks that is specified by the EncryptionType parameter. Otherwise, leave this parameter empty."
    },
    "Label": {
      "en": "EncryptionKey",
      "zh-cn": "加密密钥ID"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "Postpaid"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "Prepaid": {
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
          "Year": [
            1,
            2,
            3
          ]
        },
        "Postpaid": {}
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the instance. Default value: Postpaid. Valid values:\nPostpaid: pay-as-you-go\nPrepaid: subscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ]
  }
  EOT
}

variable "dbinstance_category" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "DB instance category, valid values: Basic, HighAvailability.\nThis parameter must be passed in to create a storage reservation mode instance."
    },
    "AllowedValues": [
      "HighAvailability",
      "Basic"
    ],
    "Label": {
      "en": "DBInstanceCategory",
      "zh-cn": "实例系列"
    }
  }
  EOT
}

variable "securityiplist" {
  type        = string
  default     = "127.0.0.1"
  description = <<EOT
  {
    "Description": {
      "en": "The whitelist of IP addresses that are allowed to access the instance. Default value:\n127.0.0.1."
    },
    "Label": {
      "en": "SecurityIPList",
      "zh-cn": "IP地址白名单"
    }
  }
  EOT
}

variable "dbinstance_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The db instance mode. Valid values: StorageElastic, Serverless, Classic."
    },
    "AllowedValues": [
      "StorageElastic",
      "Serverless",
      "Classic"
    ],
    "Label": {
      "en": "DBInstanceMode",
      "zh-cn": "实例资源类型"
    }
  }
  EOT
}

variable "dbinstance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the instance. The description cannot exceed 256 characters in length."
    },
    "Label": {
      "en": "DBInstanceDescription",
      "zh-cn": "实例描述"
    },
    "MaxLength": 256
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
          "Description": {
            "en": "The value of the tag."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The keyword of the tag."
          },
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
      "en": "The list of instance tags in the form of key/value pairs.\nYou can define a maximum of 20 tags for instance."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
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
      "en": "Unit of subscription period, it could be Month/Year. Default value is Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "订阅周期的单位"
    }
  }
  EOT
}

resource "alicloud_gpdb_elastic_instance" "elasticdbinstance" {
  encryption_type       = var.encryption_type
  instance_spec         = var.instance_spec
  engine_version        = var.engine_version
  zone_id               = var.zone_id
  vswitch_id            = var.vswitch_id
  seg_node_num          = var.seg_node_num
  payment_duration      = var.period
  seg_storage_type      = var.seg_storage_type
  storage_size          = var.storage_size
  encryption_key        = var.encryption_key
  payment_type          = var.pay_type
  tags                  = var.tags
  payment_duration_unit = var.period_unit
}

output "dbinstance_id" {
  value       = alicloud_gpdb_elastic_instance.elasticdbinstance.id
  description = "The ID of the instance."
}

output "port" {
  value       = alicloud_gpdb_elastic_instance.elasticdbinstance.port
  description = "The port used to connect to the instance."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order ID of the instance."
}

output "connection_string" {
  value       = alicloud_gpdb_elastic_instance.elasticdbinstance.connection_string
  description = "The endpoint of the instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

