variable "topology_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "1azone",
      "3azones"
    ],
    "Description": {
      "en": "The topology type of the instance. Valid values: 3azones: The instance is deployed in three zones. 1azone: The instance is deployed in only one zone."
    },
    "Label": {
      "en": "TopologyType",
      "zh-cn": "拓扑类型"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of the database engine."
    },
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "数据库引擎版本"
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
      "en": "The ID of resource group"
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "en": "The ID of the VPC to which the instance belongs."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "专有网络ID"
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
      "en": "The ID of the vSwitch."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "虚拟交换机ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal for the instance. Default value: true. true: Enable auto-renewal. false: Disable auto-renewal."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The unit of the billing cycle for the instance. The valid values vary based on the billing method. If you use the subscription billing method, set the value to Year or Month. If you use the pay-as-you-go billing method, the value is automatically set to Hour."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "收费周期"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method of the instance. Default: POSTPAY.Valid values: PREPAY: subscription POSTPAY: pay-as-you-go"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "实例付费类型"
    }
  }
  EOT
}

variable "dbnode_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the nodes in the instance you want to create."
    },
    "Label": {
      "en": "DBNodeClass",
      "zh-cn": "节点规格"
    }
  }
  EOT
}

variable "secondary_zone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secondary zone."
    },
    "Label": {
      "en": "SecondaryZone",
      "zh-cn": "次可用区"
    }
  }
  EOT
}

variable "tertiary_zone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The tertiary zone."
    },
    "Label": {
      "en": "TertiaryZone",
      "zh-cn": "第三可用区"
    }
  }
  EOT
}

variable "security_ip_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "GroupName": {
          "Type": "String",
          "Description": {
            "en": "The whitelist group name of the instance."
          },
          "Required": false
        },
        "SecurityIPList": {
          "Type": "String",
          "Description": {
            "en": "The IP list in the whitelist group, multiple IP whitelists are separated by commas (,)."
          },
          "Required": false
        },
        "ModifyMode": {
          "Type": "String",
          "Description": {
            "en": "Whitelist modification mode, the value range is as follows:\n0: Overwrite and modify the whitelist group;1: Add a whitelist group;2: Delete the whitelist group."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Instance whitelist configuration."
    },
    "Label": {
      "en": "SecurityIpConfig",
      "zh-cn": "实例白名单配置"
    }
  }
  EOT
}

variable "dbnode_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The number of nodes in the instance you want to create."
    },
    "MinValue": 2,
    "Label": {
      "en": "DBNodeCount",
      "zh-cn": "实例节点数量"
    }
  }
  EOT
}

variable "used_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The subscription period of the instance. Unit: month or year. Note When period is set to year, the supported values of this parameter are 1, 2 and 3."
    },
    "Label": {
      "en": "UsedTime",
      "zh-cn": "预付费时长"
    }
  }
  EOT
}

variable "primary_zone" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The primary zone."
    },
    "Label": {
      "en": "PrimaryZone",
      "zh-cn": "主可用区"
    }
  }
  EOT
}

variable "dbinstance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the instance."
    },
    "Label": {
      "en": "DBInstanceDescription",
      "zh-cn": "实例备注描述"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

resource "alicloud_drds_polardbx_instance" "dbinstance" {
  topology_type     = var.topology_type
  resource_group_id = var.resource_group_id
  vpc_id            = var.vpcid
  vswitch_id        = var.vswitch_id
  secondary_zone    = var.secondary_zone
  tertiary_zone     = var.tertiary_zone
  primary_zone      = var.primary_zone
}

output "port" {
  // Could not transform ROS Attribute Port to Terraform attribute.
  value       = null
  description = "Intranet connection port."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The ID of the order."
}

output "connection_string" {
  // Could not transform ROS Attribute ConnectionString to Terraform attribute.
  value       = null
  description = "Intranet connection string."
}

output "dbinstance_name" {
  value       = alicloud_drds_polardbx_instance.dbinstance.id
  description = "The name of the instance that you create."
}

