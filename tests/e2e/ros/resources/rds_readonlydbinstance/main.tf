variable "period_type" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Charge period for created instances."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodType",
      "zh-cn": "预付费实例类型"
    }
  }
  EOT
}

variable "target_dedicated_host_id_for_master" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the host on which the primary instance resides. This parameter is valid when you create the read-only instance in a dedicated cluster.",
      "zh-cn": "在专属集群内创建只读实例时，指定主实例的主机ID。"
    },
    "Label": {
      "en": "TargetDedicatedHostIdForMaster",
      "zh-cn": "在专属集群内创建只读实例时"
    }
  }
  EOT
}

variable "category" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The RDS edition of the read-only instance. Valid values:\nBasic: Basic Edition.\nHighAvailability: High-availability Edition. This is the default value.\nAlwaysOn: Cluster Edition.\nFinance: Enterprise Edition. This edition is available only on the China site (aliyun.com)."
    },
    "AllowedValues": [
      "Basic",
      "HighAvailability",
      "AlwaysOn",
      "Finance"
    ],
    "Label": {
      "en": "Category",
      "zh-cn": "实例系列"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of the database. The database and the master instance must have the same database version. Valid values: 5.6, 5.7, 8.0, 2017_ent, 2019_ent"
    },
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "数据库版本号"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The private IP address of the read-only instance. It must be within the IP address range provided by the switch. The system automatically assigns an IP address based on the VPCId and VSwitchId by default."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "只读实例的内网IP"
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

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The ID of the zone. You can call the DescribeRegions API operation to view the latest zones."
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
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the VPC."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "只读实例的专有网络ID"
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
      "en": "The type of the instance. For more information, see Instance type list. The type of the read-only instance must be no less than that of the master instance. Otherwise, the read-only instance incurs high latency and high load."
    },
    "Label": {
      "en": "DBInstanceClass",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "dedicated_host_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the dedicated cluster to which the read-only instance belongs. This parameter is valid when you create the read-only instance in a dedicated cluster."
    },
    "Label": {
      "en": "DedicatedHostGroupId",
      "zh-cn": "在专属集群内创建只读实例时指定专属集群ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal. Valid values: true and false. Note\n:Monthly subscription: The auto-renewal cycle is one month.\nAnnual subscription: The auto-renewal cycle is one year."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "实例是否自动续费"
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
      "en": "The ID of the VSwitch."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "只读实例的交换机ID"
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
      "en": "The subscription duration. Valid values:\nWhen PeriodType is Month, it could be from 1 to 12, 24, 36, 48, 60.\n When PeriodType is Year, it could be from 1 to 5."
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
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method."
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

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the read-only instance. Valid values:- **true**: enables the feature.- **false** (default): disables the feature."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否开启RDS释放保护功能"
    }
  }
  EOT
}

variable "dbinstance_storage_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of storage media that is used by the instance. Valid values:\nlocal_ssd: local SSDs\ncloud_ssd: standard SSDs\ncloud_essd: ESSDs of performance level 1 (PL1)\ncloud_essd2: ESSDs of PL2\ncloud_essd3: ESSDs of PL3"
    },
    "Label": {
      "en": "DBInstanceStorageType",
      "zh-cn": "实例存储类型"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the master instance."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "主实例ID"
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
      "en": "The storage space of the instance. Value range: 5 to 3000. The value must be a multiple of 5. Unit: GB."
    },
    "Label": {
      "en": "DBInstanceStorage",
      "zh-cn": "存储空间"
    }
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

variable "tags" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The tags of an instance.\nYou should input the information of the tag with the format of the Key-Value, such as {\"key1\":\"value1\",\"key2\":\"value2\", ... \"key5\":\"value5\"}.\nAt most 5 tags can be specified.\nKey\nIt can be up to 64 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCannot be a null string.\nValue\nIt can be up to 128 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCan be a null string."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例标签"
    }
  }
  EOT
}

resource "alicloud_db_readonly_instance" "read_onlydbinstance" {
  engine_version        = var.engine_version
  resource_group_id     = var.resource_group_id
  zone_id               = var.zone_id
  instance_type         = var.dbinstance_class
  auto_renew            = var.auto_renew
  vswitch_id            = var.vswitch_id
  period                = var.period
  deletion_protection   = var.deletion_protection
  master_db_instance_id = var.dbinstance_id
  instance_storage      = var.dbinstance_storage
  instance_name         = var.dbinstance_description
  tags                  = var.tags
}

output "dbinstance_id" {
  value       = alicloud_db_readonly_instance.read_onlydbinstance.id
  description = "The instance id of created database instance."
}

output "port" {
  value       = alicloud_db_readonly_instance.read_onlydbinstance.port
  description = "Intranet port of created DB instance."
}

output "connection_string" {
  value       = alicloud_db_readonly_instance.read_onlydbinstance.connection_string
  description = "DB instance connection url by Intranet."
}

