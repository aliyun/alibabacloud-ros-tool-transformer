variable "snapshot_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the snapshot that you want to use to create the disk.\nThe following limits apply to the SnapshotId and Size parameters:\nIf the size of the snapshot specified by SnapshotId is greater than the specified Size value, the size of the created disk is equal to the specified snapshot size.\nIf the size of the snapshot specified by SnapshotId is smaller than the specified Size value, the size of the created disk is equal to the specified Size value."
    },
    "Label": {
      "en": "SnapshotId",
      "zh-cn": "创建云盘使用的快照"
    }
  }
  EOT
}

variable "category" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The category of the disk. Valid values:\ncloud_efficiency: ultra disk.\ncloud_ssd: all-flash disk."
    },
    "Label": {
      "en": "Category",
      "zh-cn": "磁盘种类"
    }
  }
  EOT
}

variable "kmskey_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Key Management Service (KMS) key that is used by the cloud disk.\nNote If you set the Encrypted parameter to true, the default service key is used when the KMSKeyId parameter is empty."
    },
    "Label": {
      "en": "KMSKeyId",
      "zh-cn": "云盘使用的KMS密钥ID"
    }
  }
  EOT
}

variable "encrypted" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to encrypt the new system disk. Valid values:\ntrue\nfalse (default): no"
    },
    "Label": {
      "en": "Encrypted",
      "zh-cn": "是否加密云盘"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  default     = "PostPaid"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "The billing method of the instance. Set the value to PostPaid."
    },
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例付费方式"
    }
  }
  EOT
}

variable "size" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The size of the disk. Unit: GiB."
    },
    "Label": {
      "en": "Size",
      "zh-cn": "磁盘大小"
    }
  }
  EOT
}

variable "disk_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the disk."
    },
    "Label": {
      "en": "DiskName",
      "zh-cn": "磁盘名称"
    }
  }
  EOT
}

variable "ens_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the edge node."
    },
    "Label": {
      "en": "EnsRegionId",
      "zh-cn": "节点ID"
    }
  }
  EOT
}

resource "alicloud_ens_disk" "disk" {
  snapshot_id   = var.snapshot_id
  category      = var.category
  encrypted     = var.encrypted
  size          = var.size
  disk_name     = var.disk_name
  ens_region_id = var.ens_region_id
}

output "disk_id" {
  value       = alicloud_ens_disk.disk.id
  description = "The ID of the instance."
}

