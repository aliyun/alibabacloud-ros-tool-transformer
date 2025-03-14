variable "instance_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance name"
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "instance_spec" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance specification. For example: api.s1.small"
    },
    "Label": {
      "en": "InstanceSpec",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "https_policy" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "HTTPS security policy. Valid values: HTTPS2_TLS1_0, HTTPS2_TLS1_2, HTTPS1_1_TLS1_0"
    },
    "Label": {
      "en": "HttpsPolicy",
      "zh-cn": "HTTPS安全策略"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete the instance even if its status is START_FAILED. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除实例"
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
      "en": "Zone to which the instance belongs. For example: cn-beijing-MAZ2(f,g).\nPleas call DescribeZones to get supported zone list."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method of the router interface. Valid values: PrePaid (Subscription), PostPaid (default, Pay-As-You-Go). Default value: PostPaid."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
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
      "en": "Unit of the payment cycle. It could be Month (default) or Year."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "预付费实例的付费周期"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Prepaid time period. It could be from 1 to 9 when PricingCycle is Month, or 1 to 3 when PricingCycle is Year. Default value is 3."
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
      9
    ],
    "Label": {
      "en": "Duration",
      "zh-cn": "付费时长"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether automatic payment is enabled. Valid values:\nfalse: Automatic payment is disabled. You need to go to Orders to make the payment once an order is generated. \ntrue: Automatic payment is enabled. The payment is automatically made.\nDefault true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "到期是否自动续费"
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

resource "alicloud_api_gateway_instance" "instance" {
  instance_name = var.instance_name
  instance_spec = var.instance_spec
  https_policy  = var.https_policy
  zone_id       = var.zone_id
  pricing_cycle = var.pricing_cycle
  duration      = var.duration
}

output "egress_ipv6_enable" {
  value       = alicloud_api_gateway_instance.instance.egress_ipv6_enable
  description = "Whether enable egress IPV6."
}

output "vpc_egress_address" {
  // Could not transform ROS Attribute VpcEgressAddress to Terraform attribute.
  value       = null
  description = "VPC network egress address."
}

output "internet_egress_address" {
  // Could not transform ROS Attribute InternetEgressAddress to Terraform attribute.
  value       = null
  description = "Internet egress dddress."
}

output "instance_id" {
  value       = alicloud_api_gateway_instance.instance.id
  description = "Instance ID."
}

output "vpc_intranet_enable" {
  // Could not transform ROS Attribute VpcIntranetEnable to Terraform attribute.
  value       = null
  description = "Whether enable VPC intranet."
}

output "support_ipv6" {
  value       = alicloud_api_gateway_instance.instance.support_ipv6
  description = "Whether support IPV6."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "instance_type" {
  value       = alicloud_api_gateway_instance.instance.instance_type
  description = "Instance type."
}

output "vpc_slb_intranet_enable" {
  value       = alicloud_api_gateway_instance.instance.vpc_slb_intranet_enable
  description = "Whether enable VPC SLB intranet."
}

