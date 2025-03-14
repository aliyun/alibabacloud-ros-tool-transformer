variable "description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the DRDS instance, 2-128 characters"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "实例描述"
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
      "en": "Availability zone, an available zone belongs to a certain zone, such as Hangzhou Availability Zone A (cn-hangzhou-a) belongs to the region Hangzhou (cn-hangzhou)"
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "pricing_cycle" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "PricingCycle"
    },
    "Description": {
      "en": "The unit of the order period, year: year, month: month. The parameter takes effect when the payment type is drdsPre."
    },
    "AllowedValues": [
      "year",
      "month",
      "Year",
      "Month"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "订购的周期单位"
    }
  }
  EOT
}

variable "instance_series" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "drds.sn1.4c8g Starter Edition; drds.sn1.8c16g Standard Edition; drds.sn1.16c32g Business Edition; drds.sn1.32c64g Ultimate Edition",
      "zh-cn": "实例系列。更多信息，请参见《实例系列参数》。"
    },
    "Label": {
      "en": "InstanceSeries",
      "zh-cn": "实例系列"
    }
  }
  EOT
}

variable "specification" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The example specification, for example, drds.sn1.4c8g.8C16G, consists of the DRDS instance series (drds.sn1.4c8g) plus a specific example specification (8C16G). For the DRDS instance specification value range, see: Distributed Relational Database Service Specifications and Pricing",
      "zh-cn": "实例规格。例如：drds.sn1.4c8g.8C16G由实例系列（drds.sn1.4c8g）加上具体的实例规格（8C16G）组成。"
    },
    "Label": {
      "en": "Specification",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of cycles ordered. When PricingCycle=year, the value is 1-3; when PricingCycle=month, the value is 1-9. The parameter takes effect when the payment type is drdsPre."
    },
    "MinValue": 1,
    "Label": {
      "en": "Duration",
      "zh-cn": "订购的周期数量"
    },
    "MaxValue": 9
  }
  EOT
}

variable "pay_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "drdsPost",
      "drdsPre"
    ],
    "Description": {
      "en": "For the type of payment, see \"Payment Type Parameter Table\""
    },
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Virtual switch ID, must be specified when creating a DRDS for VPC network type"
    },
    "Label": {
      "en": "VswitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "0",
      "1",
      "PRIVATE",
      "PUBLIC"
    ],
    "Description": {
      "en": "Instance type, instance type 0 - shared instance 1 - exclusive instance, in addition, this parameter can also pass PRIVATE and PUBLIC to represent exclusive instance and shared instance respectively"
    },
    "Label": {
      "en": "Type",
      "zh-cn": "实例类型"
    }
  }
  EOT
}

variable "mysqlversion" {
  type        = string
  default     = "5"
  description = <<EOT
  {
    "Description": {
      "en": "The MySQL protocol version supported by DRDS. Valid values: 5 and 8. Default value: 5. This parameter is valid only when the primary instance is created. The read-only instance is the same as the primary instance by default."
    },
    "Label": {
      "en": "MySQLVersion",
      "zh-cn": "MySQL协议版本"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "Virtual private network ID, must be specified when creating a DRDS for VPC network type"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "is_auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to renew the fee automatically, if it is purchased on a monthly basis, it will automatically renew for one month, and if it is purchased on an annual basis, it will automatically renew for one year. The parameter takes effect when the payment type is drdsPre."
    },
    "Label": {
      "en": "IsAutoRenew",
      "zh-cn": "是否自动续费"
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_drds_instance" "drds_instance" {
  description     = var.description
  zone_id         = var.zone_id
  instance_series = var.instance_series
  specification   = var.specification
  vswitch_id      = var.vswitch_id
  vpc_id          = var.vpc_id
}

output "drds_instance_id" {
  value       = alicloud_drds_instance.drds_instance.id
  description = "instance id"
}

output "internet_endpoint" {
  // Could not transform ROS Attribute InternetEndpoint to Terraform attribute.
  value       = null
  description = "Public endpoint"
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "order number"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "intranet_endpoint" {
  // Could not transform ROS Attribute IntranetEndpoint to Terraform attribute.
  value       = null
  description = "VPC endpoint"
}

