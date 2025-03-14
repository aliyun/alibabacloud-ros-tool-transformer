variable "account_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the account.\nThe description cannot start with http://or https://.\nThe description can be up to 256 characters in length."
    },
    "Label": {
      "en": "AccountDescription",
      "zh-cn": "数据库账号描述"
    }
  }
  EOT
}

variable "dbcluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cluster."
    },
    "Label": {
      "en": "DBClusterId",
      "zh-cn": "数据库实例ID"
    }
  }
  EOT
}

variable "account_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSAccountType"
    },
    "Description": {
      "en": "Normal: standard account\nSuper: privileged account"
    },
    "AllowedValues": [
      "Normal",
      "Super"
    ],
    "Label": {
      "en": "AccountType",
      "zh-cn": "数据库账号类型"
    }
  }
  EOT
}

variable "account_password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The password of the account.\nThe password must contain uppercase letters, lowercase letters, digits, and special\ncharacters.\nSpecial characters include ! @ # $ % ^ & * ()  _ + - and =\nThe password must be 8 to 32 characters in length."
    },
    "Label": {
      "en": "AccountPassword",
      "zh-cn": "数据库账号名称的密码"
    }
  }
  EOT
}

variable "account_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the account."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "数据库账号名称"
    }
  }
  EOT
}

resource "alicloud_adb_account" "account" {
  account_description = var.account_description
  account_type        = var.account_type
  account_password    = var.account_password
  account_name        = var.account_name
}

output "dbcluster_id" {
  value       = alicloud_adb_account.account.db_cluster_id
  description = "The ID of the cluster."
}

output "account_type" {
  // Could not transform ROS Attribute AccountType to Terraform attribute.
  value       = null
  description = "The type of the account."
}

output "account_name" {
  value       = alicloud_adb_account.account.account_name
  description = "The name of the account."
}

