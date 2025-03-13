variable "note" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Remarks"
    },
    "Label": {
      "en": "Note",
      "zh-cn": "备注"
    }
  }
  EOT
}

variable "target_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Type of account being invited. Valid values: Account, Email"
    },
    "Label": {
      "en": "TargetType",
      "zh-cn": "被邀请账号类型"
    }
  }
  EOT
}

variable "target_entity" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Invited account ID or login email"
    },
    "Label": {
      "en": "TargetEntity",
      "zh-cn": "被邀请账号ID或登录邮箱"
    }
  }
  EOT
}

resource "alicloud_resource_manager_handshake" "resource_manager_handshake" {
  note          = var.note
  target_type   = var.target_type
  target_entity = var.target_entity
}

output "resource_directory_id" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.resource_directory_id
  description = "Resource directory ID"
}

output "handshake_id" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.id
  description = "This ID of Resource Manager handshake"
}

output "note" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.note
  description = "Remarks"
}

output "master_account_name" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.master_account_name
  description = "The name of the main account of the resource directory"
}

output "target_type" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.target_type
  description = "Type of account being invited. Valid values: Account, Email"
}

output "master_account_id" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.master_account_id
  description = "Resource account master account ID"
}

output "target_entity" {
  value       = alicloud_resource_manager_handshake.resource_manager_handshake.target_entity
  description = "Invited account ID or login email"
}

