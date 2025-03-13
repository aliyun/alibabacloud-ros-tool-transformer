variable "vault_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "STANDARD",
      "OTS_BACKUP"
    ],
    "Description": {
      "en": "The type of the backup vault. Valid values:\n- **STANDARD**: standard backup vault.\n- **OTS_BACKUP**: backup vault for Tablestore."
    },
    "Label": {
      "en": "VaultType",
      "zh-cn": "备份仓库类型"
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
      "en": "The description of the backup vault. The description must be 0 to 255 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "备份仓库描述信息"
    },
    "MaxLength": 255
  }
  EOT
}

variable "encrypt_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The method that is used to encrypt the source data. This parameter is valid only if you set the VaultType parameter to STANDARD or OTS_BACKUP. \nValid values:- **HBR_PRIVATE**: The source data is encrypted by using the built-in encryption method of Hybrid Backup Recovery (HBR).\n- **KMS**: The source data is encrypted by using Key Management Service (KMS)."
    },
    "AllowedValues": [
      "HBR_PRIVATE",
      "KMS"
    ],
    "Label": {
      "en": "EncryptType",
      "zh-cn": "源端加密类型"
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

variable "kms_key_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The customer master key (CMK) created in KMS or the alias of the key. This parameter is required only if you set the EncryptType parameter to KMS."
    },
    "Label": {
      "en": "KmsKeyId",
      "zh-cn": "阿里云KMS服务自定义密钥Key或Alias"
    }
  }
  EOT
}

variable "vault_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the backup vault. The name must be 1 to 64 characters in length."
    },
    "Label": {
      "en": "VaultName",
      "zh-cn": "备份仓库名称"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "redundancy_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The data redundancy type of the backup vault. Valid values:\n- **LRS**: Locally redundant storage (LRS) is enabled for the backup vault. HBR stores the copies of each object on multiple devices of different facilities in the same zone. This way, HBR ensures data durability and availability even if hardware failures occur.\n- **ZRS**: Zone-redundant storage (ZRS) is enabled for the backup vault. HBR uses the multi-zone mechanism to distribute data across three zones within the same region. If a zone fails, the data that is stored in the other two zones is still accessible."
    },
    "AllowedValues": [
      "LRS",
      "ZRS"
    ],
    "Label": {
      "en": "RedundancyType",
      "zh-cn": "备份仓库的数据冗余存储方式"
    }
  }
  EOT
}

variable "vault_storage_class" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The storage type of the backup vault. The value is only **STANDARD**, which indicates STANDARD storage."
    },
    "Label": {
      "en": "VaultStorageClass",
      "zh-cn": "备份仓库存储类型"
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
      "en": "Tags of The resource attribute field representing the resource tag.."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_hbr_vault" "extension_resource" {
  vault_type          = var.vault_type
  description         = var.description
  encrypt_type        = var.encrypt_type
  kms_key_id          = var.kms_key_id
  vault_name          = var.vault_name
  redundancy_type     = var.redundancy_type
  vault_storage_class = var.vault_storage_class
}

output "description" {
  value       = alicloud_hbr_vault.extension_resource.description
  description = "The description of the backup vault."
}

output "resource_group_id" {
  // Could not transform ROS Attribute ResourceGroupId to Terraform attribute.
  value       = null
  description = "The ID of the resource group."
}

output "trial_info" {
  // Could not transform ROS Attribute TrialInfo to Terraform attribute.
  value       = null
  description = "The free trial information."
}

output "replication_source_region_id" {
  // Could not transform ROS Attribute ReplicationSourceRegionId to Terraform attribute.
  value       = null
  description = "The ID of the region where the remote backup vault resides."
}

output "index_update_time" {
  // Could not transform ROS Attribute IndexUpdateTime to Terraform attribute.
  value       = null
  description = "The time when the index was updated."
}

output "vault_id" {
  value       = alicloud_hbr_vault.extension_resource.id
  description = "The ID of the backup vault."
}

output "retention" {
  // Could not transform ROS Attribute Retention to Terraform attribute.
  value       = null
  description = "The retention period of the backup vault. Unit: days."
}

output "dedup" {
  // Could not transform ROS Attribute Dedup to Terraform attribute.
  value       = null
  description = "Indicates whether the deduplication feature is enabled."
}

output "vault_status_message" {
  // Could not transform ROS Attribute VaultStatusMessage to Terraform attribute.
  value       = null
  description = <<EOT
  "The status message that is returned when the backup vault is in the ERROR state. This parameter is available only for remote backup vaults. Valid values:\n- **UNKNOWN_ERROR*: An unknown error occurs.\n- **SOURCE_VAULT_ALREADY_HAS_REPLICATION**: A mirror vault is configured for the source vault."
  EOT
}

output "bytes_done" {
  // Could not transform ROS Attribute BytesDone to Terraform attribute.
  value       = null
  description = "The amount of data that is backed up. Unit: bytes."
}

output "replication_progress" {
  // Could not transform ROS Attribute ReplicationProgress to Terraform attribute.
  value       = null
  description = "The progress of data synchronization from the backup vault to the mirror vault."
}

output "payment_type" {
  // Could not transform ROS Attribute PaymentType to Terraform attribute.
  value       = null
  description = "PaymentType."
}

output "backup_plan_statistics" {
  // Could not transform ROS Attribute BackupPlanStatistics to Terraform attribute.
  value       = null
  description = "The statistics of backup plans that use the backup vault."
}

output "tags" {
  // Could not transform ROS Attribute Tags to Terraform attribute.
  value       = null
  description = "The tags of the backup vault."
}

output "vault_name" {
  value       = alicloud_hbr_vault.extension_resource.vault_name
  description = "The name of the backup vault."
}

output "redundancy_type" {
  // Could not transform ROS Attribute RedundancyType to Terraform attribute.
  value       = null
  description = <<EOT
  "The data redundancy type of the backup vault. Valid values:\n- **LRS**: Locally redundant storage (LRS) is enabled for the backup vault. HBR stores the copies of each object on multiple devices of different facilities in the same zone. This way, HBR ensures data durability and availability even if hardware failures occur.\n- **ZRS**: Zone-redundant storage (ZRS) is enabled for the backup vault. HBR uses the multi-zone mechanism to distribute data across three zones within the same region. If a zone fails, the data that is stored in the other two zones is still accessible."
  EOT
}

output "vault_storage_class" {
  value       = alicloud_hbr_vault.extension_resource.vault_storage_class
  description = "The storage type of the backup vault. Valid value: **STANDARD**, which indicates standard storage."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The time when the backup vault was created. This value is a UNIX timestamp. Unit: seconds."
}

output "storage_size" {
  // Could not transform ROS Attribute StorageSize to Terraform attribute.
  value       = null
  description = "The usage of the backup vault. Unit: bytes."
}

output "replication_source_vault_id" {
  // Could not transform ROS Attribute ReplicationSourceVaultId to Terraform attribute.
  value       = null
  description = "The ID of the source vault that corresponds to the remote backup vault."
}

output "vault_type" {
  value       = alicloud_hbr_vault.extension_resource.vault_type
  description = "The type of the backup vault. Valid value: **STANDARD**, which indicates a standard backup vault."
}

output "latest_replication_time" {
  // Could not transform ROS Attribute LatestReplicationTime to Terraform attribute.
  value       = null
  description = "The time when the last remote backup was synchronized. This value is a UNIX timestamp. Unit: seconds."
}

output "replication" {
  // Could not transform ROS Attribute Replication to Terraform attribute.
  value       = null
  description = <<EOT
  "Indicates whether the backup vault is a remote backup vault. Valid values:\n- **true**: The backup vault is a remote backup vault.\n- **false**: The backup vault is an on-premises backup vault."
  EOT
}

output "index_level" {
  // Could not transform ROS Attribute IndexLevel to Terraform attribute.
  value       = null
  description = <<EOT
  "The index level.\n- **OFF**: No indexes are created.\n- **META**: Metadata indexes are created.\n- **ALL**: Full-text indexes are created."
  EOT
}

output "updated_time" {
  // Could not transform ROS Attribute UpdatedTime to Terraform attribute.
  value       = null
  description = "The time when the backup vault was updated. This value is a UNIX timestamp. Unit: seconds."
}

output "source_types" {
  // Could not transform ROS Attribute SourceTypes to Terraform attribute.
  value       = null
  description = "The information about the data source."
}

output "index_available" {
  // Could not transform ROS Attribute IndexAvailable to Terraform attribute.
  value       = null
  description = "Indicates whether indexes are available. Indexes are available when they are not being updated."
}

output "search_enabled" {
  // Could not transform ROS Attribute SearchEnabled to Terraform attribute.
  value       = null
  description = "Indicates whether the backup search feature is enabled."
}

