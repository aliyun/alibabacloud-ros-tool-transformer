variable "auto_add_new_nodes" {
  type        = string
  default     = "Disable"
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether a newly added node is automatically added to this connection point.\nValid values: Enable, Disable.\nDefault value: Disable."
    },
    "AllowedValues": [
      "Disable",
      "Enable"
    ],
    "Label": {
      "en": "AutoAddNewNodes",
      "zh-cn": "新节点是否自动加入自定义集群地址"
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
      "en": "The ID of the ApsaraDB for POLARDB cluster for which a custom connection point is to be created."
    },
    "Label": {
      "en": "DBClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "endpoint_type" {
  type        = string
  default     = "Custom"
  description = <<EOT
  {
    "Description": {
      "en": "The type of the cluster connection point. Set this parameter to Custom."
    },
    "Label": {
      "en": "EndpointType",
      "zh-cn": "自定义集群地址类型"
    }
  }
  EOT
}

variable "read_write_mode" {
  type        = string
  default     = "ReadOnly"
  description = <<EOT
  {
    "Description": {
      "en": "The read/write mode of the cluster connection point. Valid values:\nReadWrite: receives and forwards read and write requests (automatic read-write splitting).\nReadOnly: receives and forwards only read requests.\nDefault value: ReadOnly."
    },
    "AllowedValues": [
      "ReadOnly",
      "ReadWrite"
    ],
    "Label": {
      "en": "ReadWriteMode",
      "zh-cn": "读写模式"
    }
  }
  EOT
}

variable "nodes" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The nodes to be added to this connection point to process read requests from this connection point. Add at least two nodes.\nIf you do not specify this parameter, all nodes of the cluster are added to this connection point by default."
    },
    "Label": {
      "en": "Nodes",
      "zh-cn": "用于处理读请求的节点"
    },
    "MinLength": 2
  }
  EOT
}

variable "endpoint_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DistributedTransaction": {
          "Type": "String",
          "Description": {
            "en": "Set up transaction splitting. Valid values:\non: Turn on transaction splitting (default value)\noff: Turn off transaction splitting"
          },
          "Required": false
        },
        "ConsistTimeoutAction": {
          "Type": "String",
          "Description": {
            "en": "Global consistency read timeout policy. Valid values: \n0: This request occurs to the master node (default).\n1: Sql error report."
          },
          "Required": false
        },
        "ConsistTimeout": {
          "Type": "String",
          "Description": {
            "en": "Global consistency read timeout."
          },
          "Required": false
        },
        "LoadBalancePolicy": {
          "Type": "String",
          "Description": {
            "en": "Set load balancing policy. Valid values:\n0: Load balancing based on the number of connections (default)\n1: Load balancing based on the number of active requests"
          },
          "Required": false
        },
        "ConnectionPersist": {
          "Type": "String",
          "Description": {
            "en": "Set up a connection pool. Valid values: \noff: Turn off the connection pool (default value) \nSession: Enable session-level connection pooling \nTransaction: Enable transaction-level connection pooling."
          },
          "Required": false
        },
        "ConsistLevel": {
          "Type": "String",
          "Description": {
            "en": "The consistency level of the cluster connection point. Valid values:\n0: eventual consistency\n1: session consistency2: Global consistency (strong)\nFor example, {\"ConsistLevel\": \"0\"}.\nNote If the ReadWriteMode parameter is set to ReadOnly, the value of this parameter must be 0."
          },
          "AllowedValues": [
            "0",
            "1",
            "2"
          ],
          "Required": false
        },
        "EnableOverloadThrottle": {
          "Type": "String",
          "Description": {
            "en": "Set whether to enable overload protection. Valid values: \non: Turn on overload protection.\noff: Turn off overload protection (default)."
          },
          "Required": false
        },
        "MasterAcceptReads": {
          "Type": "String",
          "Description": {
            "en": "Set whether the main library accepts reading. Valid values: \non: Indicates that the main library accepts reading.\noff: Indicates that the main library does not accept reading (default value)"
          },
          "Required": false
        },
        "MaxParallelDegree": {
          "Type": "String",
          "Description": {
            "en": "Set up parallel queries. Valid values: \non: Enable parallel query.\noff: Turn off parallel query (default)."
          },
          "Required": false
        },
        "EnableHtapImci": {
          "Type": "String",
          "Description": {
            "en": "Set up row/column storage to automatically divert traffic. Valid values: \non: Turn on the automatic traffic diversion function of row storage/column storage\noff: Turn off the automatic drainage function of row storage/column storage (default)"
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "EndpointConfig",
      "zh-cn": "一致性级别"
    }
  }
  EOT
}

resource "alicloud_polardb_endpoint" "dbcluster_endpoint" {
  auto_add_new_nodes = var.auto_add_new_nodes
  db_cluster_id      = var.dbcluster_id
  endpoint_type      = var.endpoint_type
  read_write_mode    = var.read_write_mode
  nodes              = var.nodes
  endpoint_config    = var.endpoint_config
}

output "addresses" {
  // Could not transform ROS Attribute Addresses to Terraform attribute.
  value       = null
  description = "The address items of the db cluster endpoint."
}

output "dbendpoint_id" {
  // Could not transform ROS Attribute DBEndpointId to Terraform attribute.
  value       = null
  description = "DB cluster endpoint ID. E.g. pe-xxxxxxxx."
}

output "connection_string" {
  // Could not transform ROS Attribute ConnectionString to Terraform attribute.
  value       = null
  description = "The first connection string of the db cluster endpoint."
}

