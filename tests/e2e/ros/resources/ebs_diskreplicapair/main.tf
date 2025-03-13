variable "disk_replica_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the asynchronous replication relationship. The length must be 2 to 128 characters in length and must start with a letter or Chinese name. It cannot start with http:// or https. It can contain Chinese, English, numbers, half-width colons (:), underscores (_), half-width periods (.), or dashes (-)."
    },
    "Label": {
      "en": "DiskReplicaPairName",
      "zh-cn": "异步复制关系的名称"
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
      "en": "The description of the asynchronous replication relationship. 2 to 256 English or Chinese characters in length and cannot start with' http:// 'or' https."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "异步复制关系的描述信息"
    }
  }
  EOT
}

variable "destination_disk_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the standby disk."
    },
    "Label": {
      "en": "DestinationDiskId",
      "zh-cn": "目标云盘（从盘）的云盘ID"
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
      "en": "The ID of the resource group"
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID "
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
      "en": "The purchase duration of the asynchronous replication relationship. This parameter is required when 'ChargeType = PrePay. The duration unit is specified by'periodunit', and the value range is:\n- When 'PeriodUnit = Month', the value range of this parameter is 1, 2, 3, 6, 12, 24, 36, 60."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "rpo" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The RPO value set by the consistency group in seconds. Currently only 900 seconds are supported."
    },
    "Label": {
      "en": "RPO",
      "zh-cn": "复制对的RPO值"
    }
  }
  EOT
}

variable "destination_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region to which the disaster recovery site belongs."
    },
    "Label": {
      "en": "DestinationRegionId",
      "zh-cn": "目标云盘（从盘）所属的地域信息"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth for asynchronous data replication between cloud disks. The unit is Kbps. Value range:\n- 10240 Kbps: equal to 10 Mbps.\n- 20480 Kbps: equal to 20 Mbps.\n- 51200 Kbps: equal to 50 Mbps.\n- 102400 Kbps: equal to 100 Mbps.\nDefault value: 10240.\nThis parameter cannot be specified when the ChargeType value is PayAsYouGo The system value is 0, which indicates that the disk is dynamically allocated according to data write changes during asynchronous replication."
    },
    "AllowedValues": [
      10240,
      20480,
      51200,
      102400
    ],
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "异步复制时使用的带宽"
    }
  }
  EOT
}

variable "destination_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the zone to which the disaster recovery site belongs."
    },
    "Label": {
      "en": "DestinationZoneId",
      "zh-cn": "从盘所属的可用区"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The payment type of the resource"
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "source_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the zone to which the production site belongs."
    },
    "Label": {
      "en": "SourceZoneId",
      "zh-cn": "源云盘（主盘）所属的可用区ID"
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
      "en": "Tags of disk replica pair."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the purchase time of the asynchronous replication relationship. Value range:\n- Month.Default value: Month."
    },
    "AllowedValues": [
      "Month"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "预付费时长单位"
    }
  }
  EOT
}

variable "disk_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the primary disk."
    },
    "Label": {
      "en": "DiskId",
      "zh-cn": "源云盘（主盘）的云盘ID"
    }
  }
  EOT
}

resource "alicloud_ebs_disk_replica_pair" "extension_resource" {
  description           = var.description
  destination_disk_id   = var.destination_disk_id
  resource_group_id     = var.resource_group_id
  period                = var.period
  destination_region_id = var.destination_region_id
  bandwidth             = var.bandwidth
  destination_zone_id   = var.destination_zone_id
  payment_type          = var.payment_type
  source_zone_id        = var.source_zone_id
  period_unit           = var.period_unit
  disk_id               = var.disk_id
}

output "disk_replica_pair_name" {
  // Could not transform ROS Attribute DiskReplicaPairName to Terraform attribute.
  value       = null
  description = "The name of the asynchronous replication relationship."
}

output "description" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.description
  description = "The description of the asynchronous replication relationship."
}

output "destination_disk_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.destination_disk_id
  description = "The ID of the standby disk."
}

output "resource_group_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.resource_group_id
  description = "The ID of the resource group."
}

output "create_time" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.create_time
  description = "The creation time of the resource."
}

output "replica_pair_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.id
  description = "The ID of the disk replica pair."
}

output "rpo" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.rpo
  description = "The RPO value set by the consistency group in seconds."
}

output "destination_region_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.destination_region_id
  description = "The ID of the region to which the disaster recovery site belongs."
}

output "bandwidth" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.bandwidth
  description = "The bandwidth for asynchronous data replication between cloud disks."
}

output "destination_zone_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.destination_zone_id
  description = "The ID of the zone to which the disaster recovery site belongs."
}

output "payment_type" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.payment_type
  description = "The payment type of the resource."
}

output "source_zone_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.source_zone_id
  description = "The ID of the zone to which the production site belongs."
}

output "tags" {
  // Could not transform ROS Attribute Tags to Terraform attribute.
  value       = null
  description = "The tags of the disk replica pair."
}

output "disk_id" {
  value       = alicloud_ebs_disk_replica_pair.extension_resource.disk_id
  description = "The ID of the primary disk."
}

