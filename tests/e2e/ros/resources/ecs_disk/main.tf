variable "bursting_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether enable bursting."
    },
    "Label": {
      "en": "BurstingEnabled",
      "zh-cn": "是否启用突发"
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
      "en": "Description of the disk, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "云盘的描述"
    }
  }
  EOT
}

variable "kmskey_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "KMS key ID used by the cloud disk."
    },
    "Label": {
      "en": "KMSKeyId",
      "zh-cn": "云盘使用的KMS密钥ID"
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
      "zh-cn": "云盘所在的资源组ID"
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
      "en": "Create a pay-as-you-go cloud drive within the specified availability area.\n- If you do not set InstanceId, ZoneId is required.\n- You cannot specify both ZoneId and InstanceId."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "在指定可用区内创建一块按量付费磁盘"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "Create a cloud disk and automatically mount it to the specified InstanceId.\n- Once the instance ID is set, the ResourceGroupId, Tags, and KMSKeyId parameters you set are ignored.\n- You cannot specify both ZoneId and InstanceId.\nDefault value: null, meaning that a pay-as-you-go cloud drive is created, and the region of the drive is defined by the RegionId and ZoneId.",
      "zh-cn": "创建一块包年包月磁盘，并自动挂载到指定的包年包月实例（InstanceId）上。"
    },
    "Label": {
      "en": "Mounting InstanceId",
      "zh-cn": "挂载到ECS实例"
    }
  }
  EOT
}

variable "encrypted" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether disk is encrypted, default to false."
    },
    "Label": {
      "en": "Encrypted",
      "zh-cn": "是否加密云盘"
    }
  }
  EOT
}

variable "performance_level" {
  type        = string
  default     = "PL1"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "DiskPerformanceLevel"
    },
    "Description": {
      "en": "The performance level you select for an ESSD.Default value: PL1. Valid values:PL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.PL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.PL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.PL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS."
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "en": "PerformanceLevel",
      "zh-cn": "ESSD云盘性能等级"
    }
  }
  EOT
}

variable "size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the disk unit in GB."
    },
    "MinValue": 1,
    "Label": {
      "en": "Size",
      "zh-cn": "云盘的大小"
    }
  }
  EOT
}

variable "delete_auto_snapshot" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the auto snapshot is released with the disk. Default to false."
    },
    "Label": {
      "en": "DeleteAutoSnapshot",
      "zh-cn": "删除云盘时是否删除自动快照"
    }
  }
  EOT
}

variable "disk_category" {
  type        = string
  default     = "cloud"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Disk::DataDiskCategory",
    "Description": {
      "en": "The disk category, now support cloud/cloud_ssd/cloud_essd/cloud_efficiency/san_ssd/san_efficiency/cloud_auto, depends the region."
    },
    "AllowedValues": [
      "cloud",
      "cloud_essd",
      "cloud_efficiency",
      "cloud_ssd"
    ],
    "Label": {
      "en": "DiskCategory",
      "zh-cn": "云盘的类型"
    }
  }
  EOT
}

variable "storage_set_partition_number" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of storage set partitions."
    },
    "Label": {
      "en": "StorageSetPartitionNumber",
      "zh-cn": "存储集分区数"
    }
  }
  EOT
}

variable "auto_snapshot_policy_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Snapshot::AutoSnapshotPolicyId",
    "Description": {
      "en": "Auto snapshot policy ID."
    },
    "Label": {
      "en": "AutoSnapshotPolicyId",
      "zh-cn": "自动快照策略ID"
    }
  }
  EOT
}

variable "disk_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the disk, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "DiskName",
      "zh-cn": "云盘的名称"
    }
  }
  EOT
}

variable "provisioned_iops" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Provisioning IOPS."
    },
    "Label": {
      "en": "ProvisionedIops",
      "zh-cn": "预配的IOPS"
    }
  }
  EOT
}

variable "multi_attach" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the multi-attach feature for the disk. Valid values:\nDisabled: disables the multi-attach feature.\nEnabled: enables the multi-attach feature. Set the value to Enabled only for ESSDs.\nDefault value: Disabled."
    },
    "AllowedValues": [
      "Disabled",
      "Enabled"
    ],
    "Label": {
      "en": "MultiAttach",
      "zh-cn": "是否开启多重挂载特性"
    }
  }
  EOT
}

variable "snapshot_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Snapshot::SnapshotId",
    "Description": {
      "en": "If specified, the backup used as the source to create disk."
    },
    "Label": {
      "en": "SnapshotId",
      "zh-cn": "快照ID"
    }
  }
  EOT
}

variable "storage_set_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Storage set ID."
    },
    "Label": {
      "en": "StorageSetId",
      "zh-cn": "存储集ID"
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
      "en": "Tags to attach to disk. Max support 20 tags to add during create disk. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_disk" "disk" {
  description                  = var.description
  resource_group_id            = var.resource_group_id
  availability_zone            = var.zone_id
  instance_id                  = var.instance_id
  encrypted                    = var.encrypted
  performance_level            = var.performance_level
  size                         = var.size
  delete_auto_snapshot         = var.delete_auto_snapshot
  storage_set_partition_number = var.storage_set_partition_number
  disk_name                    = var.disk_name
  snapshot_id                  = var.snapshot_id
  storage_set_id               = var.storage_set_id
  tags                         = var.tags
}

output "status" {
  value       = alicloud_ecs_disk.disk.status
  description = "Created disk status."
}

output "disk_id" {
  value       = alicloud_ecs_disk.disk.id
  description = "Id of created disk."
}

