variable "bandwidth_billing_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth billing method. Valid values:\nBandwidthPackage: billed based on bandwidth plans.\nCDT: billed based on data transfer. The bills are managed by using Cloud Data Transfer (CDT).\nCDT95: billed based on the 95th percentile bandwidth. The bills are managed by using Cloud Data Transfer (CDT). This bandwidth billing method is not available by default. Contact your Alibaba Cloud account manager for more information."
    },
    "AllowedValues": [
      "BandwidthPackage",
      "CDT",
      "CDT95"
    ],
    "Label": {
      "en": "BandwidthBillingType",
      "zh-cn": "带宽计费方式"
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
      "en": "The ID of the resource group to which the basic GA instance belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "基础型全球加速实例所属资源组 ID"
    }
  }
  EOT
}

variable "auto_use_coupon" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically apply coupons to your bills. Valid values:\ntrue: automatically applies coupons to your bills.\nfalse: does not automatically apply coupons to your bills. This is the default value."
    },
    "Label": {
      "en": "AutoUseCoupon",
      "zh-cn": "是否使用优惠券自动支付账单"
    }
  }
  EOT
}

variable "promotion_option_no" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The code of the coupon."
    },
    "Label": {
      "en": "PromotionOptionNo",
      "zh-cn": "优惠券号码"
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
      "en": "The billing cycle. Valid values:\nMonth\nYear"
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "计费周期"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method. Valid values:\nPREPAY (default)POSTPAY"
    },
    "AllowedValues": [
      "POSTPAY",
      "PREPAY"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal for the basic GA instance. Valid values:\ntrue: enables auto-renewal for the basic GA instance.\nfalse: disables auto-renewal for the basic GA instance. This is the default value."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否开启自动续费"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The subscription duration of the GA instance.\nIf you set PricingCycle to Month, the valid values for Duration are 1 to 9.\nIf you set PricingCycle to Year, the valid values for Duration are 1 to 3."
    },
    "MinValue": 1,
    "Label": {
      "en": "Duration",
      "zh-cn": "购买时长"
    },
    "MaxValue": 9
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable automatic payment. Valid values:\nfalse: disables automatic payment. If you select this option, you must go to the Order Center to complete the payment after an order is generated. This is the default value.\ntrue: enables automatic payment. Payments are automatically completed."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动付费"
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
          "Description": {
            "en": "The tag value. The tag value cannot be an empty string.The tag value can be up to 128 characters in length and cannot contain http:// or https://. It cannot start with acs: or aliyun.You can specify up to 20 tag values."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The tag key. The tag key cannot be an empty string.The tag key can be up to 64 characters in length and cannot contain http:// or https://. The tag key cannot start with aliyun or acs:.You can specify up to 20 tag keys."
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
    "Description": {
      "en": "The tags of the basic GA instance."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "基础型全球加速实例的标签"
    },
    "MinLength": 0,
    "MaxLength": 20
  }
  EOT
}

variable "auto_renew_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The auto-renewal duration. Unit: months.Valid values: 1 to 12. Default value: 1."
    },
    "MinValue": 1,
    "Label": {
      "en": "AutoRenewDuration",
      "zh-cn": "自动续费时长"
    },
    "MaxValue": 12
  }
  EOT
}

resource "alicloud_ga_basic_accelerator" "extension_resource" {
  bandwidth_billing_type = var.bandwidth_billing_type
  resource_group_id      = var.resource_group_id
  auto_use_coupon        = var.auto_use_coupon
  promotion_option_no    = var.promotion_option_no
  pricing_cycle          = var.pricing_cycle
  auto_renew             = var.auto_renew
  duration               = var.duration
  auto_pay               = var.auto_pay
  tags                   = var.tags
  auto_renew_duration    = var.auto_renew_duration
}

output "accelerator_id" {
  value       = alicloud_ga_basic_accelerator.extension_resource.id
  description = "The ID of the accelerated IP address."
}

