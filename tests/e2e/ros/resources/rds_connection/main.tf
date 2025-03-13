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
      "zh-cn": "RDS实例ID"
    }
  }
  EOT
}

variable "port" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The port of the database service."
    },
    "MinValue": 1,
    "Label": {
      "en": "Port",
      "zh-cn": "外网连接端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "babelfish_port" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Tabular Data Stream (TDS) port of the instance for which Babelfish is enabled.\nNote This parameter applies only to ApsaraDB RDS for PostgreSQL instances. \nFor more information about Babelfish for ApsaraDB RDS for PostgreSQL, see Introduction to Babelfish."
    },
    "Label": {
      "en": "BabelfishPort",
      "zh-cn": "Babelfish for RDS PostgreSQL TDS端口号"
    }
  }
  EOT
}

variable "connection_string_prefix" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the endpoint. \nOnly the prefix of the CurrentConnectionString parameter value can be modified.\nThe prefix must be 5 to 40 characters in length and can contain letters, digits, and hyphens (-). "
    },
    "AllowedPattern": "[a-zA-Z0-9-]{5,40}",
    "Label": {
      "en": "ConnectionStringPrefix",
      "zh-cn": "外网连接地址的前缀"
    }
  }
  EOT
}

variable "general_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the dedicated cluster to which the instance belongs. \nThis parameter takes effect only when the instance runs MySQL on RDS \nStandard Edition and is created in a dedicated cluster."
    },
    "Label": {
      "en": "GeneralGroupName",
      "zh-cn": "专属集群MySQL通用版实例所属的组名"
    }
  }
  EOT
}

resource "alicloud_db_connection" "connection" {
  port           = var.port
  babelfish_port = var.babelfish_port
}

output "dbinstance_id" {
  value       = alicloud_db_connection.connection.instance_id
  description = "RDS instance ID."
}

output "port" {
  value       = alicloud_db_connection.connection.port
  description = "The port of the database service."
}

output "connection_string" {
  value       = alicloud_db_connection.connection.connection_string
  description = "Connection string"
}

output "babelfish_port" {
  value       = alicloud_db_connection.connection.babelfish_port
  description = "The name of the dedicated cluster to which the instance belongs."
}

