variable "payer_account_id" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "PayerAccountId",
      "zh-cn": "结算账号ID"
    }
  }
  EOT
}

variable "display_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Member name"
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "成员名称"
    }
  }
  EOT
}

variable "folder_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the parent folder"
    },
    "Label": {
      "en": "FolderId",
      "zh-cn": "资源夹ID"
    }
  }
  EOT
}

variable "delete_account" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether delete the account. Default value is false."
    },
    "Label": {
      "en": "DeleteAccount",
      "zh-cn": "是否删除账户"
    }
  }
  EOT
}

resource "alicloud_resource_manager_account" "resource_manager_account" {
  payer_account_id = var.payer_account_id
  display_name     = var.display_name
  folder_id        = var.folder_id
}

output "join_method" {
  value       = alicloud_resource_manager_account.resource_manager_account.join_method
  description = "Ways for members to join the resource directory. Valid values: invited, created"
}

output "resource_directory_id" {
  value       = alicloud_resource_manager_account.resource_manager_account.resource_directory_id
  description = "Resource directory ID"
}

output "type" {
  value       = alicloud_resource_manager_account.resource_manager_account.type
  description = "Member type. The value of ResourceAccount indicates the resource account"
}

output "account_id" {
  value       = alicloud_resource_manager_account.resource_manager_account.id
  description = "This ID of Resource Manager Account"
}

output "display_name" {
  value       = alicloud_resource_manager_account.resource_manager_account.display_name
  description = "Member name"
}

output "folder_id" {
  value       = alicloud_resource_manager_account.resource_manager_account.folder_id
  description = "The ID of the parent folder"
}

