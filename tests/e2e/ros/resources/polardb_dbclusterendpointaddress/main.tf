variable "dbendpoint_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cluster connection point."
    },
    "Label": {
      "en": "DBEndpointId",
      "zh-cn": "集群访问地址ID"
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
      "en": "The ID of the ApsaraDB for POLARDB cluster for which a public connection point is to be created."
    },
    "Label": {
      "en": "DBClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "connection_string_prefix" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the connection string. The prefix must comply with the following rules:\nIt must start with a letter and consist of lowercase letters, digits, and hyphens(-), cannot end with a dash.\nThe length is 6~30 characters."
    },
    "AllowedPattern": "[a-z][-a-z0-9]{4,28}[a-z0-9]",
    "Label": {
      "en": "ConnectionStringPrefix",
      "zh-cn": "集群连接地址的前缀"
    }
  }
  EOT
}

variable "net_type" {
  type        = string
  default     = "Public"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetType"
    },
    "Description": {
      "en": "The network type of the connection string. \nIf set to Public, ROS will create, modify and delete Public address for you.\nIf set to Private, ROS will only modify Private address for you.\nDefault to Public."
    },
    "AllowedValues": [
      "Public",
      "Private"
    ],
    "Label": {
      "en": "NetType",
      "zh-cn": "集群连接地址的网络类型"
    }
  }
  EOT
}

resource "alicloud_polardb_endpoint_address" "dbcluster_endpoint_address" {
  db_endpoint_id    = var.dbendpoint_id
  db_cluster_id     = var.dbcluster_id
  connection_prefix = var.connection_string_prefix
  net_type          = var.net_type
}

output "address" {
  // Could not transform ROS Attribute Address to Terraform attribute.
  value       = null
  description = "The details of the endpoint address."
}

output "connection_string" {
  value       = alicloud_polardb_endpoint_address.dbcluster_endpoint_address.connection_string
  description = "The connection string of the endpoint address."
}

