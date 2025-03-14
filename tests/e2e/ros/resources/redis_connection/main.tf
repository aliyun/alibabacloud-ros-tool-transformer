variable "connection_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ConnectionType"
    },
    "Description": {
      "en": "Allowed values:\n- Public: Public address.\n- Direct: Direct connection address. The instance is a cluster instance. You can apply for a direct connection endpoint as required."
    },
    "AllowedValues": [
      "Public",
      "Direct"
    ],
    "Label": {
      "en": "ConnectionType",
      "zh-cn": "服务连接类型"
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
      "en": "Instance ID (globally unique)"
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "port" {
  type        = number
  default     = 6379
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The service port number of the ApsaraDB for Redis instance. Valid values: 1024 to 65535."
    },
    "MinValue": 1024,
    "Label": {
      "en": "Port",
      "zh-cn": "Redis服务端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "connection_string_prefix" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the public endpoint. \nThe prefix must be 8 to 64 characters in length, \nand can contain lowercase letters and digits. \nIt must start with a lowercase letter."
    },
    "AllowedPattern": "^[a-z][a-z0-9-]{7,63}",
    "Label": {
      "en": "ConnectionStringPrefix",
      "zh-cn": "公网连接地址的前缀"
    }
  }
  EOT
}

resource "alicloud_kvstore_connection" "connection" {
  instance_id              = var.instance_id
  port                     = var.port
  connection_string_prefix = var.connection_string_prefix
}

output "connection_string" {
  value       = alicloud_kvstore_connection.connection.connection_string
  description = "The allocated connection string."
}

