variable "account_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the privileged account."
    },
    "Label": {
      "en": "AccountDescription",
      "zh-cn": "数据库账号描述"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::GPDB::DBInstance::InstanceId",
    "Description": {
      "en": "The ID of the instance.\nNote You can call the DescribeDBInstances operation to query details of all AnalyticDB for PostgreSQL instances in a specific\nregion, including instance IDs."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "数据库实例ID"
    }
  }
  EOT
}

variable "account_password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "Password",
    "Description": {
      "en": "The password of the privileged account.\nThe password must contain at least three of the following character types: uppercase\nletters, lowercase letters, digits, and special characters.\nSpecial characters include ! @ # $ % ^ & * ( ) _ + - =\nThe password must be 8 to 32 characters in length."
    },
    "AllowedPattern": "^(?=.*[a-zA-Z])(?=.*[a-z0-9])(?=.*[a-z!@#$%^&*()_+=-])(?=.*[A-Z0-9])(?=.*[A-Z!@#$%^&*()_+=-])(?=.*[0-9!@#$%^&*()_+=-])[a-zA-Z0-9!@#$%^&*()_+=-]{8,32}$|^$",
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
      "en": "The name of the privileged account.\nThe name can contain lowercase letters, digits, and underscores (_).\nThe name must start with a lowercase letter and end with a lowercase letter or a digit.\nThe name cannot start with gp.\nThe name must be 2 to 16 characters in length."
    },
    "AllowedPattern": "^(?!root$)(?!gp)[a-z][a-z0-9_]{0,14}[a-z0-9]$",
    "Label": {
      "en": "AccountName",
      "zh-cn": "数据库账号名称"
    }
  }
  EOT
}

resource "alicloud_gpdb_account" "account" {
  account_description = var.account_description
  account_password    = var.account_password
  account_name        = var.account_name
}

output "dbinstance_id" {
  // Could not transform ROS Attribute DBInstanceId to Terraform attribute.
  value       = null
  description = "The ID of the instance."
}

output "account_name" {
  value       = alicloud_gpdb_account.account.account_name
  description = "The name of the account."
}

