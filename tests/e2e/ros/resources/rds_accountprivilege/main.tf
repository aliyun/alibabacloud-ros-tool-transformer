variable "account_privilege" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "RDS account privilege. The specified number must be the same as the number of DbName"
    },
    "Label": {
      "en": "AccountPrivilege",
      "zh-cn": "账号权限"
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

variable "dbname" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "RDS database name. Separate multiple database names with commas (,)."
    },
    "Label": {
      "en": "DBName",
      "zh-cn": "需要授权访问的数据库名称"
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
      "en": "RDS account name."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "账号名称"
    }
  }
  EOT
}

resource "alicloud_db_account_privilege" "rdsaccount_privilege" {
  privilege    = var.account_privilege
  instance_id  = var.dbinstance_id
  account_name = var.account_name
}

