variable "dbproxy_instance_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of activated proxy instances, the value is: 1~16.Default value: 1.\nDescription More proxy instances can handle more requests, you can understand the load of proxy instances based on the monitoring data, and then set a reasonable number of proxy instances."
    },
    "MinValue": 1,
    "Label": {
      "en": "DBProxyInstanceNum",
      "zh-cn": "开通代理实例数量"
    },
    "MaxValue": 16
  }
  EOT
}

variable "persistent_connection_status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable connection hold.Value:\nEnabled: Turn on connection hold\nDisabled: Close connection hold\nillustrate\nOnly RDS MySQL supports this parameter.\nWhen modifying the connection remains, the ConfigDBProxyService value is Modify."
    },
    "AllowedValues": [
      "Disabled",
      "Enabled"
    ],
    "Label": {
      "en": "PersistentConnectionStatus",
      "zh-cn": "是否开启连接保持"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource Group ID."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组 ID"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance ID of the DB. DescribeDBInstances can be called to get it."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "数据库实例 ID"
    }
  }
  EOT
}

variable "vpcid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The VPC ID to which the instance belongs."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "实例所属 VPC ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The virtual switch ID to which the instance belongs."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "实例所属虚拟交换机 ID"
    }
  }
  EOT
}

variable "dbproxy_nodes" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "The Availability Zone ID where the node resides.\nThis parameter is required when selecting DBProxyNodes."
          },
          "Required": true
        },
        "CpuCores": {
          "Type": "Number",
          "Description": {
            "en": "The number of node CPU cores, the values are 1~16.\nThis parameter is required when selecting DBProxyNodes."
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 16
        },
        "NodeCounts": {
          "Type": "Number",
          "Description": {
            "en": "The number of proxy nodes in the Availability Zone, with values ranging from 1 to 2.\nThis parameter is required when selecting DBProxyNodes."
          },
          "AllowedValues": [
            1,
            2
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of proxy nodes."
    },
    "Label": {
      "en": "DBProxyNodes",
      "zh-cn": "代理节点列表"
    },
    "MaxLength": 2
  }
  EOT
}

variable "dbproxy_instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Database proxy instance type, value:\ncommon: general-purpose agent\nexclusive: exclusive proxy (default)"
    },
    "AllowedValues": [
      "common",
      "exclusive"
    ],
    "Label": {
      "en": "DBProxyInstanceType",
      "zh-cn": "数据库代理实例类型"
    }
  }
  EOT
}

resource "alicloud_rds_db_proxy" "dbproxy" {
  db_proxy_instance_num  = var.dbproxy_instance_num
  resource_group_id      = var.resource_group_id
  instance_id            = var.dbinstance_id
  vpc_id                 = var.vpcid
  vswitch_id             = var.vswitch_id
  db_proxy_instance_type = var.dbproxy_instance_type
}

