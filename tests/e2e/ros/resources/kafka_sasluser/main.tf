variable "type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the Simple Authentication and Security Layer (SASL) user. Valid values:\nplain: a simple mechanism that uses usernames and passwords to verify user identities. ApsaraMQ for Kafka provides an improved PLAIN mechanism that allows you to dynamically add SASL users without the need to restart an instance.\nSCRAM: a mechanism that uses usernames and passwords to verify user identities. Compared with the PLAIN mechanism, this mechanism provides better security protection. ApsaraMQ for Kafka uses the SCRAM-SHA-256 algorithm.\nLDAP: This value is available only for the SASL users of ApsaraMQ for Confluent instances.\nDefault value: plain."
    },
    "AllowedValues": [
      "LDAP",
      "plain",
      "scram"
    ],
    "Label": {
      "en": "Type",
      "zh-cn": "类型。取值："
    }
  }
  EOT
}

variable "username" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the SASL user."
    },
    "AllowedPattern": "^[a-zA-Z][a-zA-Z0-9_]{2,63}$",
    "Label": {
      "en": "Username",
      "zh-cn": "用户名"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The instance ID."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例 ID"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "mechanism" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The encryption method. Valid values:\nSCRAM-SHA-512 (default)\nSCRAM-SHA-256\nNote\nThis parameter is available only for ApsaraMQ for Kafka V3 serverless instances."
    },
    "AllowedValues": [
      "SCRAM-SHA-512",
      "SCRAM-SHA-256"
    ],
    "Label": {
      "en": "Mechanism",
      "zh-cn": "加密方式"
    }
  }
  EOT
}

variable "password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The password of the SASL user."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "密码"
    }
  }
  EOT
}

resource "alicloud_alikafka_sasl_user" "sasl_user" {
  type        = var.type
  username    = var.username
  instance_id = var.instance_id
  password    = var.password
}

output "instance_id" {
  value       = alicloud_alikafka_sasl_user.sasl_user.instance_id
  description = "The instance ID."
}

output "username" {
  value       = alicloud_alikafka_sasl_user.sasl_user.username
  description = "The user name of the instance."
}

