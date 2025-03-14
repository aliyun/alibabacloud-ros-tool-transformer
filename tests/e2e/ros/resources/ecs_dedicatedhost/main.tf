variable "auto_renew_period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "The time period of auto renew. When the parameter InstanceChargeType is PrePaid, it will take effect.It could be 1, 2, 3, 6, 12, 24, 36, 48, 60. Default value is 1."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "单次自动续费的周期"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of host."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "专有宿主机的描述"
    }
  }
  EOT
}

variable "network_attributes_slb_udp_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The duration of UDP timeout for sessions between Server Load Balancer (SLB) and the dedicated host. Unit: seconds. Valid values: 15 to 310."
    },
    "MinValue": 15,
    "Label": {
      "en": "NetworkAttributesSlbUdpTimeout",
      "zh-cn": "负载均衡连接的UDP会话超时时间"
    },
    "MaxValue": 310
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "专有宿主机要加入的资源组ID"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone to create the host."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "专有宿主机所属的可用区ID"
    }
  }
  EOT
}

variable "network_attributes_udp_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The duration of UDP timeout for sessions between users and instances on the dedicated host. Unit: seconds. Valid values: 15 to 310."
    },
    "MinValue": 15,
    "Label": {
      "en": "NetworkAttributesUdpTimeout",
      "zh-cn": "为专有宿主机上运行的云服务设置用户访问的UDP会话超时时间"
    },
    "MaxValue": 310
  }
  EOT
}

variable "auto_renew" {
  type        = string
  default     = "False"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether renew the fee automatically? When the parameter InstanceChargeType is PrePaid, it will take effect. Range of value:True: automatic renewal.False: no automatic renewal. Default value is False."
    },
    "AllowedValues": [
      "True",
      "False"
    ],
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费预付费的专有宿主机"
    }
  }
  EOT
}

variable "auto_placement" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the dedicated host is added to the resource pool for automatic deployment. If you do not specify the DedicatedHostId parameter when you create an instance on a dedicated host, Alibaba Cloud automatically selects a dedicated host from the resource pool to host the instance. For more information, see Automatic deployment. Valid values:on: The dedicated host is added to the resource pool for automatic deployment.off: The dedicated host is not added to the resource pool for automatic deployment.Default value: on.Note When you create a dedicated host: If you do not specify this parameter, the dedicated host is added to the automatic deployment resource pool.If you do not want to add the dedicated host to the automatic deployment resource pool, set the value to off."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "AutoPlacement",
      "zh-cn": "专有宿主机是否加入自动部署资源池"
    }
  }
  EOT
}

variable "quantity" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "The number of dedicated hosts that you want to create. Valid values: 1 to 100.Default value: 1."
    },
    "MinValue": 1,
    "Label": {
      "en": "Quantity",
      "zh-cn": "本次创建的专有宿主机的数量"
    },
    "MaxValue": 100
  }
  EOT
}

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period. Unit is month, it could be from 1 to 9 or 12, 24, 36, 48, 60. Default value is 1."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费时长"
    }
  }
  EOT
}

variable "dedicated_host_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The instance type of host."
    },
    "Label": {
      "en": "DedicatedHostType",
      "zh-cn": "专有宿主机的类型"
    }
  }
  EOT
}

variable "dedicated_host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the dedicated host, [2, 128] English or Chinese characters. It must begin with an uppercase/lowercase letter or a Chinese character, and may contain numbers, '_' or '-'. It cannot begin with http:// or https://."
    },
    "Label": {
      "en": "DedicatedHostName",
      "zh-cn": "专有宿主机的名称"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  default     = "PostPaid"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PostPaid": {},
        "PrePaid": {
          "Month": [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            12,
            24,
            36,
            48,
            60
          ],
          "Week": [
            1,
            2,
            3,
            4
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Instance Charge type, allowed value: Prepaid and Postpaid. If specified Prepaid, please ensure you have sufficient balance in your account. Or instance creation will be failure. Default value is Postpaid."
    },
    "AllowedValues": [
      "PrePaid",
      "PostPaid"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "专有宿主机的计费方式"
    }
  }
  EOT
}

variable "action_on_maintenance" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The policy used to migrate the instances from the dedicated hostwhen the dedicated host fails or needs to be repaired online.Valid values: Migrate: Instances are migrated to another physical server and restarted.If the dedicated host is attached with disks that are not local disks, the default value is Migrate.Stop: Instances on the dedicated host are stopped. If the dedicated host cannot be repaired,the instances are migrated to another physical server and restarted.If the dedicated host is attached with local disks, the default value is Stop.",
      "zh-cn": "当专有宿主机发生故障或者在线修复时，为其所宿实例设置迁移方案。"
    },
    "AllowedValues": [
      "Migrate",
      "Stop"
    ],
    "Label": {
      "en": "ActionOnMaintenance",
      "zh-cn": "当专有宿主机发生故障或者在线修复时"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to DedicatedHost. Max support 20 tags to add during create DedicatedHost. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of prepaid time period, it could be Week/Month/Year. Default value is Month."
    },
    "AllowedValues": [
      "Week",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "续费单位"
    }
  }
  EOT
}

variable "auto_release_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Auto release time for created host, Follow ISO8601 standard using UTC time. format is 'yyyy-MM-ddTHH:mm:ssZ'. Not bigger than 3 years from this day onwards"
    },
    "Label": {
      "en": "AutoReleaseTime",
      "zh-cn": "自动释放时间"
    }
  }
  EOT
}

resource "alicloud_ecs_dedicated_host" "host" {
  auto_renew_period     = var.auto_renew_period
  description           = var.description
  resource_group_id     = var.resource_group_id
  zone_id               = var.zone_id
  auto_renew            = var.auto_renew
  auto_placement        = var.auto_placement
  dedicated_host_type   = var.dedicated_host_type
  dedicated_host_name   = var.dedicated_host_name
  action_on_maintenance = var.action_on_maintenance
  tags                  = var.tags
  sale_cycle            = var.period_unit
  auto_release_time     = var.auto_release_time
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order id list of created instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "dedicated_host_ids" {
  value       = alicloud_ecs_dedicated_host.host.id
  description = "The host id list of created hosts"
}

