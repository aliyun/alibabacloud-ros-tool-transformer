variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the elasticity assurance. The description must be 2 to 256 characters in length and cannot start with http:// or https://.\nThis parameter is empty by default."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "弹性保障服务的描述信息"
    }
  }
  EOT
}

variable "instance_amount" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The total number of instances for which to reserve capacity of an instance type.\nValid values: 1 to 1000.",
      "zh-cn": "在一个实例规格内，需要预留的实例的总数量。"
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceAmount",
      "zh-cn": "在一个实例规格内"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "private_pool_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MatchCriteria": {
          "Type": "String",
          "Description": {
            "en": "The type of the private pool with which to associate the elasticity assurance. Valid values:\nOpen: open private pool\nTarget: targeted private pool\nDefault value: Open."
          },
          "AllowedValues": [
            "Open",
            "Target"
          ],
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the elasticity assurance. The description must be 2 to 128 characters in length. The description must start with a letter but cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "PrivatePoolOptions",
      "zh-cn": "弹性保障服务的配置"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone ID of the elasticity assurance. Currently, an elasticity assurance can be used to reserve resources within a single zone."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "弹性保障服务所属地域下的可用区ID"
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
      "en": "The ID of the resource group to which to assign the elasticity assurance."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "弹性保障服务所在的企业资源组ID"
    }
  }
  EOT
}

variable "start_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the elasticity assurance takes effect. The default value is the time when the CreateElasticityAssurance operation is called to create the elasticity assurance. Specify the time in the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time must be in UTC. For more information, see ISO 8601."
    },
    "Label": {
      "en": "StartTime",
      "zh-cn": "弹性保障服务生效时间"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The effective duration of the elasticity assurance. The unit of the effective duration is determined by the PeriodUnit value. Valid values:\nWhen the PeriodUnit parameter is set to Month, the valid values are 1, 2, 3, 4, 5, 6, 7, 8, and 9.\nWhen the PeriodUnit parameter is set to Year, the valid values are 1, 2, 3, 4, and 5.\nDefault value: 1."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "instance_types" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Instance type. Currently, an elasticity assurance can be created to reserve the capacity of a single instance type."
    },
    "Label": {
      "en": "InstanceTypes",
      "zh-cn": "实例规格"
    },
    "MinLength": 1,
    "MaxLength": 1
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
          "Description": {
            "en": "The value of tag N to add to the elasticity assurance. Valid values of N: 1 to 20. The tag value can be an empty string. The tag value can be up to 128 characters in length and cannot start with acs:. The tag value cannot contain http:// or https://."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The key of tag N to add to the elasticity assurance. Valid values of N: 1 to 20. The tag key cannot be an empty string. The tag key must be 1 to 128 characters in length and cannot contain http:// or https://. The tag key cannot start with acs: or aliyun."
          },
          "Required": false
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
    "Label": {
      "en": "Tags",
      "zh-cn": "实例的标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the effective duration of the elasticity assurance. Valid values:\nMonth\nYear\nDefault value: Year."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "时长单位"
    }
  }
  EOT
}

resource "alicloud_ecs_elasticity_assurance" "elasticity_assurance" {
  description       = var.description
  instance_amount   = var.instance_amount
  resource_group_id = var.resource_group_id
  start_time        = var.start_time
  period            = var.period
  tags              = var.tags
  period_unit       = var.period_unit
}

output "private_pool_options_id" {
  value       = alicloud_ecs_elasticity_assurance.elasticity_assurance.id
  description = "The ID of the elasticity assurance."
}

