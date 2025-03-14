variable "time_points" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The automatic snapshot creation schedule, and the unit of measurement is hour. Value range: [0, 23], which represents from 00:00 to 24:00, for example 1 indicates 01:00. When you want to schedule multiple automatic snapshot tasks for a disk in a day, you can set the TimePoints to an array.\nA maximum of 24 time points can be selected.\nThe format is a list of [0, 1, ..., 23] and the time points are separated by commas (,)."
    },
    "Label": {
      "en": "TimePoints",
      "zh-cn": "自动快照的创建时间点"
    }
  }
  EOT
}

variable "disk_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The disk ID. When you want to apply the automatic snapshot policy to multiple disks, you can set the DiskIds to an array. The format is list of [\"d-xxxxxxxxx\", \"d-yyyyyyyyy\", ..., \"d-zzzzzzzzz\"] and the IDs are separated by commas (,)."
    },
    "Label": {
      "en": "DiskIds",
      "zh-cn": "目标磁盘ID"
    }
  }
  EOT
}

variable "target_copy_regions" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The target region ID."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The target region of the snapshot is replicated across geographies. Setting a target region is currently supported."
    },
    "MaxLength": 1
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
      "zh-cn": "快照所属的资源组ID"
    }
  }
  EOT
}

variable "enable_cross_region_copy" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable cross-region copying of snapshots."
    }
  }
  EOT
}

variable "copy_encryption_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "KMSKeyId": {
          "Type": "String",
          "Description": {
            "en": "KMS key ID used for snapshot offsite encryption backup"
          },
          "Required": false
        },
        "Encrypted": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable remote encrypted backup of snapshots. Default: false."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The encryption configuration for copied snapshots."
    }
  }
  EOT
}

variable "retention_days" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The snapshot retention time, and the unit of measurement is day. Optional values:\n-1: The automatic snapshots are retained permanently.\n[1, 65536]: The number of days retained.\nDefault value: -1."
    },
    "MinValue": -1,
    "Label": {
      "en": "RetentionDays",
      "zh-cn": "自动快照的保留时间"
    },
    "MaxValue": 65536
  }
  EOT
}

variable "repeat_weekdays" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "Number",
        "Required": false,
        "MinValue": 1,
        "MaxValue": 7
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The automatic snapshot repetition dates. The unit of measurement is day and the repeating cycle is a week. Value range: [1, 7], which represents days starting from Monday to Sunday, for example 1 indicates Monday. When you want to schedule multiple automatic snapshot tasks for a disk in a week, you can set the RepeatWeekdays to an array.\nA maximum of seven time points can be selected.\nThe format is a list of [1, 2, ..., 7] and the time points are separated by commas (,)."
    },
    "Label": {
      "en": "RepeatWeekdays",
      "zh-cn": "自动快照的重复日期"
    }
  }
  EOT
}

variable "auto_snapshot_policy_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the automatic snapshot policy.\nIt can consist of [2, 128] English or Chinese characters.\nMust begin with an uppercase or lowercase letter or a Chinese character. Can contain numbers, periods (.), colons (:), underscores (_), and hyphens (-).\nCannot start with http:// or https://.\nDefault value: null."
    },
    "Label": {
      "en": "AutoSnapshotPolicyName",
      "zh-cn": "自动快照策略的名称"
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

variable "copied_snapshots_retention_days" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Retention time in days for replicated snapshots across geographies. Range:\n-1: Permanent storage\n1-65535: Specifies the number of days to save\nDefault value: -1"
    },
    "MinValue": -1,
    "MaxValue": 65536
  }
  EOT
}

resource "alicloud_ecs_auto_snapshot_policy" "auto_snapshot_policy" {
  time_points     = var.time_points
  retention_days  = var.retention_days
  repeat_weekdays = var.repeat_weekdays
  name            = var.auto_snapshot_policy_name
  tags            = var.tags
}

output "auto_snapshot_policy_id" {
  value       = alicloud_ecs_auto_snapshot_policy.auto_snapshot_policy.id
  description = "The automatic snapshot policy ID."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

