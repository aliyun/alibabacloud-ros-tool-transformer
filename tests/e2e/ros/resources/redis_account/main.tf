variable "account_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the account.\nThe description must start with a letter, and cannot start with http:// or https://.\nThe description can contain letters, underscores (_), hyphens (-), and digits.\nIt can be 2 to 256 characters in length."
    },
    "Label": {
      "en": "AccountDescription",
      "zh-cn": "账号描述"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::Redis::Instance::InstanceId",
    "Description": {
      "en": "The ID of the instance for which you want to create the account."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "account_privilege" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "AccountPrivilege"
    },
    "Description": {
      "en": "The permission of the account. Valid values:\nRoleReadOnly\nRoleReadWrite (default value)\nRoleRepl\nNote In addition to reading data from and writing data to the ApsaraDB for Redis instance,\nan account with the RoleRepl permission can run the SYNC and PSYNC commands. The RoleRepl\npermission can be granted to an account only in an ApsaraDB for Redis instance of\nthe standard edition in Redis 4.0."
    },
    "AllowedValues": [
      "RoleReadOnly",
      "RoleReadWrite",
      "RoleRepl"
    ],
    "Label": {
      "en": "AccountPrivilege",
      "zh-cn": "账号权限"
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
      "en": "The type of the account. Set this parameter to Normal."
    },
    "Label": {
      "en": "AccountType",
      "zh-cn": "账号类型"
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
      "en": "The name of the account. The name must start with a lowercase letter and can contain\nlowercase letters, digits, and underscores (_). The name can be 1 to 16 characters\nin length."
    },
    "Label": {
      "en": "AccountName",
      "zh-cn": "账号名称"
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
      "en": "The password of the account. The password can be 8 to 32 characters in length and\nmust contain at least three types of the following characters: uppercase letters,\nlowercase letters, digits, and special characters. Special characters include ! at signs (@), number signs (#), dollar signs ($), percent signs (%), carets (^),\nampersands (&), asterisks (*), parentheses (()), underscores (_), plus signs (+),\nhyphens (-), and equal signs (=)."
    },
    "Label": {
      "en": "AccountPassword",
      "zh-cn": "账号密码"
    }
  }
  EOT
}

resource "alicloud_kvstore_account" "account" {
  instance_id       = var.instance_id
  account_privilege = var.account_privilege
  account_type      = var.account_type
  account_name      = var.account_name
  account_password  = var.account_password
}

output "instance_id" {
  value       = alicloud_kvstore_account.account.instance_id
  description = "The name of the instance."
}

output "account_name" {
  value       = alicloud_kvstore_account.account.account_name
  description = "The name of the account."
}

