variable "period_type" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The subscription type of the subscription cluster. Valid values:\nYear: subscription on a yearly basis.\nMonth: subscription on a monthly basis.\nNote This parameter must be specified when PayType is set to Prepaid."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodType",
      "zh-cn": "指定包年包月集群为包年或包月类型"
    }
  }
  EOT
}

variable "enable_default_resource_pool" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to allocate all reserved computing resources to the user_default resource group. Valid values:\ntrue (default)\nfalse"
    },
    "Label": {
      "en": "EnableDefaultResourcePool",
      "zh-cn": "计算预留资源是否全部分配给默认资源组"
    }
  }
  EOT
}

variable "storage_resource" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The amount of reserved storage resources. Unit: AnalyticDB compute units (ACUs). Valid values: 0ACU to 2064ACU. The value must be in increments of 24 ACUs. Each ACU is equivalent to 1 core and 4 GB memory.\nNote This parameter must be specified with a unit."
    },
    "Label": {
      "en": "StorageResource",
      "zh-cn": "存储预留资源"
    }
  }
  EOT
}

variable "restore_to_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The point in time to which you want to restore data from the backup set."
    },
    "Label": {
      "en": "RestoreToTime",
      "zh-cn": "基于备份集恢复的时间点"
    }
  }
  EOT
}

variable "clone_source_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the source region where the cluster is located."
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
      "en": "The resource group ID."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "en": "The zone ID.\nNote You can call the  DescribeRegions  operation to query the most recent zone list."
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
    "Description": {
      "en": "The virtual private cloud (VPC) ID of the cluster."
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
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The vSwitch ID of the cluster."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "虚拟交换机ID"
    }
  }
  EOT
}

variable "dbcluster_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the cluster.\nThe description cannot start with http:// or https://.\nThe description must be 2 to 256 characters in length"
    },
    "Label": {
      "en": "DBClusterDescription",
      "zh-cn": "集群描述"
    }
  }
  EOT
}

variable "product_form" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Valid values:\nIntegrationForm\nLegacyForm"
    },
    "AllowedValues": [
      "IntegrationForm",
      "LegacyForm"
    ]
  }
  EOT
}

variable "reserved_node_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of each reserved node."
    },
    "AllowedValues": [
      8,
      12,
      16,
      24,
      32
    ]
  }
  EOT
}

variable "compute_resource" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The amount of reserved computing resources. Unit: ACUs. Valid values: 0ACU to 4096ACU. The value must be in increments of 16 ACUs. Each ACU is equivalent to 1 core and 4 GB memory.\nNote This parameter must be specified with a unit."
    },
    "Label": {
      "en": "ComputeResource",
      "zh-cn": "计算预留资源"
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription duration of the subscription cluster.\nValid values when Period is set to Year: 1 to 3 (integer).\nValid values when Period is set to Month: 1 to 9 (integer).\nNote This parameter must be specified when PayType is set to Prepaid."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "指定包年包月集群的购买时长"
    }
  }
  EOT
}

variable "dbcluster_network_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The network type of the cluster. Valid values:\nVPC"
    },
    "AllowedValues": [
      "VPC"
    ]
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "Postpaid"
  nullable    = false
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
            9
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
      "en": "The billing method of the cluster. Valid values:\nPostpaid: pay-as-you-go.\nPrepaid: subscription."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "backup_set_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the backup set that you want to use to restore data.\nNote You can call the  DescribeBackups  operation to query the backup sets of the cluster."
    },
    "Label": {
      "en": "BackupSetId",
      "zh-cn": "备份集的ID"
    }
  }
  EOT
}

variable "reserved_node_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of reserved nodes. Must be 1 for basic version and multiple \nof 3 for enterprise version."
    },
    "MinValue": 1,
    "MaxValue": 2147483646
  }
  EOT
}

variable "disk_encryption" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to encrypt the disk. Valid values:\ntrue\nfalse (default)"
    }
  }
  EOT
}

variable "dbcluster_version" {
  type        = string
  default     = "5.0"
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The version of the cluster. Set the value to 5.0."
    },
    "Label": {
      "en": "DBClusterVersion",
      "zh-cn": "AnalyticDB MySQL湖仓版集群的版本"
    }
  }
  EOT
}

variable "kms_id" {
  type = string
}

variable "restore_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The method that you want to use to restore data. Valid values:\nbackup: restores data from a backup set. You must also specify the BackupSetId and SourceDBClusterId parameters.\ntimepoint: restores data to a point in time. You must also specify the RestoreToTime and SourceDBClusterId parameters."
    },
    "AllowedValues": [
      "backup",
      "timepoint"
    ],
    "Label": {
      "en": "RestoreType",
      "zh-cn": "恢复方式"
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
      "en": "Tags to attach to cluster. Max support 20 tags to add during create cluster. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表信息"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_adb_db_cluster_lake_version" "dbcluster" {
  storage_resource  = var.storage_resource
  restore_to_time   = var.restore_to_time
  resource_group_id = var.resource_group_id
  zone_id           = var.zone_id
  vswitch_id        = var.vswitch_id
  compute_resource  = var.compute_resource
  backup_set_id     = var.backup_set_id
  restore_type      = var.restore_type
}

output "dbcluster_id" {
  value       = alicloud_adb_db_cluster_lake_version.dbcluster.id
  description = "The ID of the AnalyticDB for MySQL Data Lakehouse Edition (V3.0) cluster."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order ID."
}

output "connection_string" {
  value       = alicloud_adb_db_cluster_lake_version.dbcluster.connection_string
  description = "The public endpoint that is used to connect to the cluster."
}

