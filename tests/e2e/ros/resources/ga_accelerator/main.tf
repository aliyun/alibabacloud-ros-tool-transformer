variable "bandwidth_billing_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Bandwidth billing method."
    },
    "Label": {
      "en": "BandwidthBillingType",
      "zh-cn": "带宽计费方式"
    }
  }
  EOT
}

variable "accelerator_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Name of the GA instance"
    },
    "Label": {
      "en": "AcceleratorName",
      "zh-cn": "名称"
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
      "en": "The ResourceGroup Id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "标准型全球加速实例所属资源组ID"
    }
  }
  EOT
}

variable "auto_use_coupon" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The AutoUseCoupon of the GA instance."
    },
    "Label": {
      "en": "AutoUseCoupon",
      "zh-cn": "是否自动使用优惠券"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "Global acceleration instance payment type, the default value is PREPAY (prepaid)."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "全球加速实例付费类型"
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
      "en": "Billing cycle."
    },
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "价格周期"
    }
  }
  EOT
}

variable "enable_cross_border" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the global acceleration instance enables the cross-border line function."
    },
    "Label": {
      "en": "EnableCrossBorder",
      "zh-cn": "全局加速实例是否启用跨界线功能"
    }
  }
  EOT
}

variable "duration" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Length of purchase."
    },
    "Label": {
      "en": "Duration",
      "zh-cn": "购买时长"
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
      "en": "Whether to pay automatically."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动付费"
    }
  }
  EOT
}

variable "ip_set_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AccessMode": {
          "Type": "String",
          "Description": {
            "en": "Accelerated regional access mode."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Accelerate zone configuration."
    },
    "Label": {
      "en": "IpSetConfig",
      "zh-cn": "加速区域配置"
    }
  }
  EOT
}

variable "spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifications of Global Acceleration Instances."
    },
    "Label": {
      "en": "Spec",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

resource "alicloud_ga_accelerator" "ga_accelerator" {
  bandwidth_billing_type = var.bandwidth_billing_type
  accelerator_name       = var.accelerator_name
  resource_group_id      = var.resource_group_id
  pricing_cycle          = var.pricing_cycle
  duration               = var.duration
  spec                   = var.spec
}

output "dns_name" {
  // Could not transform ROS Attribute DnsName to Terraform attribute.
  value       = null
  description = "The DNS name of the accelerator."
}

output "accelerator_name" {
  value       = alicloud_ga_accelerator.ga_accelerator.accelerator_name
  description = "The Name of the GA instance"
}

output "auto_use_coupon" {
  // Could not transform ROS Attribute AutoUseCoupon to Terraform attribute.
  value       = null
  description = "The AutoUseCoupon of the GA instance."
}

output "pricing_cycle" {
  // Could not transform ROS Attribute PricingCycle to Terraform attribute.
  value       = null
  description = "The PricingCycle of the GA instance."
}

output "payment_type" {
  value       = alicloud_ga_accelerator.ga_accelerator.payment_type
  description = "The Payment Typethe GA instance"
}

output "duration" {
  // Could not transform ROS Attribute Duration to Terraform attribute.
  value       = null
  description = "The Duration of the GA instance"
}

output "auto_pay" {
  // Could not transform ROS Attribute AutoPay to Terraform attribute.
  value       = null
  description = "The AutoPay of the GA instance."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The OrderId of the GA instance"
}

output "spec" {
  value       = alicloud_ga_accelerator.ga_accelerator.spec
  description = "The instance type of the GA instance"
}

output "accelerator_id" {
  value       = alicloud_ga_accelerator.ga_accelerator.id
  description = "The ID of the GA instance to query."
}

