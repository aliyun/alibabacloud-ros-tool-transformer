variable "snapshot_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Snapshot ID"
    },
    "Label": {
      "en": "SnapshotId",
      "zh-cn": "快照ID"
    }
  }
  EOT
}

variable "target_client_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Target client ID. It should be provided when RestoreType=FILE."
    },
    "Label": {
      "en": "TargetClientId",
      "zh-cn": "目标客户端ID"
    }
  }
  EOT
}

variable "target_path" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Target path. For instance, \"/\".",
      "zh-cn": "恢复路径，将备份数据恢复到指定目录。"
    },
    "Label": {
      "en": "TargetPath",
      "zh-cn": "恢复路径"
    }
  }
  EOT
}

variable "source_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "FILE",
      "ECS_FILE"
    ],
    "Description": {
      "en": "Source type"
    },
    "Label": {
      "en": "SourceType",
      "zh-cn": "源文件类型"
    }
  }
  EOT
}

variable "source_client_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source client ID. It should be provided when SourceType=FILE."
    },
    "Label": {
      "en": "SourceClientId",
      "zh-cn": "源客户端ID"
    }
  }
  EOT
}

variable "target_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Target instance ID. It should be provided when RestoreType=ECS_FILE."
    },
    "Label": {
      "en": "TargetInstanceId",
      "zh-cn": "目标客户端ID"
    }
  }
  EOT
}

variable "vault_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Vault ID"
    },
    "Label": {
      "en": "VaultId",
      "zh-cn": "待恢复的源客户端所在的备份库"
    }
  }
  EOT
}

variable "source_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source instance ID. It should be provided when SourceType=ECS_FILE."
    },
    "Label": {
      "en": "SourceInstanceId",
      "zh-cn": "源实例ID"
    }
  }
  EOT
}

variable "restore_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "FILE",
      "ECS_FILE"
    ],
    "Description": {
      "en": "Restore type"
    },
    "Label": {
      "en": "RestoreType",
      "zh-cn": "恢复类型"
    }
  }
  EOT
}

resource "alicloud_hbr_restore_job" "restore_job" {
  snapshot_id        = var.snapshot_id
  target_client_id   = var.target_client_id
  target_path        = var.target_path
  source_type        = var.source_type
  target_instance_id = var.target_instance_id
  vault_id           = var.vault_id
  restore_type       = var.restore_type
}

output "status" {
  value       = alicloud_hbr_restore_job.restore_job.status
  description = "Restore job status"
}

output "source_type" {
  value       = alicloud_hbr_restore_job.restore_job.source_type
  description = "Source type"
}

output "restore_id" {
  value       = alicloud_hbr_restore_job.restore_job.id
  description = "Restore job ID"
}

output "error_message" {
  // Could not transform ROS Attribute ErrorMessage to Terraform attribute.
  value       = null
  description = "Error message of restore job"
}

output "restore_type" {
  value       = alicloud_hbr_restore_job.restore_job.restore_type
  description = "Restore type"
}

