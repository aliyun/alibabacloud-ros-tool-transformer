variable "account_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Account remarks.\nIt cannot begin with http:// or https://.\nIt must start with a Chinese character or English letter.\nIt can include Chinese and English characters/letters, underscores (_), hyphens (-), and digits.\nThe length may be 2-256 characters."
    },
    "Label": {
      "en": "AccountDescription",
      "zh-cn": "账号描述"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RDS::Instance::InstanceId",
    "Description": {
      "en": "RDS instance ID."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "account_type" {
  type        = string
  default     = "Normal"
  description = <<EOT
  {
    "Description": {
      "en": "Privilege type of account.\nNormal: Common privilege.\nSuper: High privilege. And the default value is Normal.\nSysadmin: Super privileges (SA) (only supported by SQL Server)\nThis parameter is valid for MySQL 5.5/5.6 only.\nMySQL 5.7, SQL Server 2012/2016, PostgreSQL, and PPAS each can have only one initial account. Other accounts are created by the initial account that has logged on to the database."
    },
    "AllowedValues": [
      "Normal",
      "Super",
      "Sysadmin"
    ],
    "Label": {
      "en": "AccountType",
      "zh-cn": "账号类型"
    }
  }
  EOT
}

variable "account_password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RDS::Instance::AccountPassword",
    "Description": {
      "en": "The account password for the database instance. It may consist of letters, digits, or underlines, with a length of 8 to 32 characters."
    },
    "Label": {
      "en": "AccountPassword",
      "zh-cn": "账号密码"
    },
    "MinLength": 8,
    "MaxLength": 32
  }
  EOT
}

variable "account_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Account name, which must be unique and meet the following requirements:\nStart with a letter;\nConsist of lower-case letters, digits, and underscores (_);\nLength:\nMySQL 8.0 and 5.7: 2-32 characters.\nMySQL 5.6、MariaDB and PostgreSQL Local version: 2-16 characters.\nSQL Server: 2-64 characters.\nPostgreSQL Cloud version: 2-63 characters."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "账号名称"
    }
  }
  EOT
}

resource "alicloud_rds_account" "account" {
  account_description = var.account_description
  db_instance_id      = var.dbinstance_id
  account_type        = var.account_type
  account_password    = var.account_password
  account_name        = var.account_name
}

output "account_name" {
  value       = alicloud_rds_account.account.account_name
  description = "Account name"
}

