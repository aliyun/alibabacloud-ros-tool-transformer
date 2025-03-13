variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the bandwidth package.\nThe description can contain [2,256] characters, numbers, underscores, and hyphens, and the name must start with English letters, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "带宽包的描述"
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

variable "geographic_regionbid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "China",
      "North-America",
      "Asia-Pacific",
      "Europe",
      "Australia"
    ],
    "Description": {
      "en": "The other area B to connect.\nValid value: China | North-America | Asia-Pacific | Europe | Australia"
    },
    "Label": {
      "en": "GeographicRegionBId",
      "zh-cn": "网络实例所属的地域"
    }
  }
  EOT
}

variable "geographic_regionaid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "China",
      "North-America",
      "Asia-Pacific",
      "Europe",
      "Australia"
    ],
    "Description": {
      "en": "The other area A to connect.\nValid value: China | North-America | Asia-Pacific | Europe | Australia"
    },
    "Label": {
      "en": "GeographicRegionAId",
      "zh-cn": "网络实例所属地域"
    }
  }
  EOT
}

variable "pricing_cycle" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "PricingCycle"
    },
    "Description": {
      "en": "The pricing cycle."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "带宽包的计费周期"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether automatic renewal is enabled. Valid values:true: Automatic renewal is enabled.false: Automatic renewal is not enabled. You must renew the instance manually.Default value: false."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否开启自动续费"
    }
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
      "en": "The purchase period. The default value is 1."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "带宽包的购买时长"
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
      "en": "Whether to automatically pay the bill. Valid value:\ntrue (default)\nfalse"
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付账单"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the bandwidth package.\nThe name can contain 2-128 characters including a-z, A-Z, 0-9, periods, underlines, and hyphens. It must start with English letters, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "带宽包的名称"
    }
  }
  EOT
}

variable "auto_renew_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Duration of each automatic renewals. It takes effect when AutoRenew is true."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6
    ],
    "Label": {
      "en": "AutoRenewDuration",
      "zh-cn": "自动续费时长"
    }
  }
  EOT
}

variable "bandwidth_package_charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method. Valid value: PREPAY, POSTPAY (Default)"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "BandwidthPackageChargeType",
      "zh-cn": "带宽包的付费类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth in Mbps of the bandwidth package. The bandwidth cannot be less than 2 Mbps."
    },
    "MinValue": 2,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "带宽包的带宽峰值"
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
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_cen_bandwidth_package" "cen_bandwidth_package" {
  description            = var.description
  geographic_region_b_id = var.geographic_regionbid
  geographic_region_a_id = var.geographic_regionaid
  period                 = var.period
  name                   = var.name
  charge_type            = var.bandwidth_package_charge_type
  bandwidth              = var.bandwidth
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "cen_bandwidth_package_id" {
  value       = alicloud_cen_bandwidth_package.cen_bandwidth_package.id
  description = "The ID of the bandwidth package."
}

