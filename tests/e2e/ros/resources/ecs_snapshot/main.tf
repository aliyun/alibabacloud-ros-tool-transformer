variable "instant_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the instant access feature. Valid values: \ntrue: enables the instant access feature. This feature can be enabled only for enhanced SSDs (ESSDs) \nfalse: disables the instant access feature. If InstantAccess is set to false, normal snapshots are created.\nDefault value: false.\nNote This parameter and the Category parameter cannot be specified at the same time. \nFor more information, see the \"Description\" section in this topic."
    },
    "Label": {
      "en": "InstantAccess",
      "zh-cn": "是否开启快照极速可用功能"
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
      "en": "The description of a snapshot can be 2 to 256 characters in length and cannot begin with http:// or https://. The description will appear on the console. By default, the value is zero."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "快照的描述"
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
      "zh-cn": "磁盘快照所属的资源组ID"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  default     = 200
  description = <<EOT
  {
    "Description": {
      "en": "The number of minutes to wait for create snapshot."
    },
    "MinValue": 200,
    "Label": {
      "en": "Timeout",
      "zh-cn": "创建快照的超时时间"
    },
    "MaxValue": 1440
  }
  EOT
}

variable "retention_days" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Set the retention period of a snapshot in days. The snapshot will be automatically released after the retention period expires.\nThe value ranges from 1 to 65536."
    },
    "MinValue": 1,
    "Label": {
      "en": "RetentionDays",
      "zh-cn": "设置快照的保留时间"
    },
    "MaxValue": 65536
  }
  EOT
}

variable "snapshot_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the snapshot, [2, 128] English or Chinese characters. It must begin with an uppercase/lowercase letter or a Chinese character, and may contain numbers, '_' or '-'. It cannot begin with http:// or https://."
    },
    "Label": {
      "en": "SnapshotName",
      "zh-cn": "快照的显示名称"
    }
  }
  EOT
}

variable "instant_access_retention_days" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the retention period of the instant access feature. After the retention period ends, \nthe snapshot is automatically released. This parameter takes effect only when InstantAccess \nis set to true. Unit: days.\nValid values: 1 to 65535. By default, the value of \nthis parameter is the same as that of RetentionDays.",
      "zh-cn": "设置快照极速可用功能的保留时间，保留时间到期后快照将自动释放。"
    },
    "Label": {
      "en": "InstantAccessRetentionDays",
      "zh-cn": "设置快照极速可用功能的保留时间"
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

variable "disk_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Indicates the ID of the specified disk."
    },
    "Label": {
      "en": "DiskId",
      "zh-cn": "将要创建磁盘快照的磁盘ID"
    }
  }
  EOT
}

resource "alicloud_ecs_snapshot" "snapshot" {
  instant_access                = var.instant_access
  description                   = var.description
  resource_group_id             = var.resource_group_id
  retention_days                = var.retention_days
  snapshot_name                 = var.snapshot_name
  instant_access_retention_days = var.instant_access_retention_days
  tags                          = var.tags
  disk_id                       = var.disk_id
}

output "snapshot_id" {
  value       = alicloud_ecs_snapshot.snapshot.id
  description = "The snapshot ID."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

