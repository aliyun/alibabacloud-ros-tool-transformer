variable "bandwidth_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "the bandwidth BandwidthType of the bandwidth"
    },
    "Label": {
      "en": "BandwidthType",
      "zh-cn": "带宽类型"
    }
  }
  EOT
}

variable "cbn_geographic_region_id_b" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The CbnGeographicRegionIdB of the bandwidth"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the bandwidth plan"
    },
    "Label": {
      "en": "Type",
      "zh-cn": "带宽包的类型"
    }
  }
  EOT
}

variable "cbn_geographic_region_id_a" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The CbnGeographicRegionIdA  of the bandwidth"
    }
  }
  EOT
}

variable "auto_use_coupon" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The AutoUseCoupon  of the bandwidth"
    },
    "Label": {
      "en": "AutoUseCoupon",
      "zh-cn": "是否自动使用优惠券"
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
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "价格周期"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ChargeType of the bandwidth"
    },
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
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
      "en": "The bandwidth provided by the bandwidth plan."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "带宽包的带宽值"
    }
  }
  EOT
}

variable "ratio" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Ratio of the bandwidth"
    },
    "Label": {
      "en": "Ratio",
      "zh-cn": "保底百分比"
    }
  }
  EOT
}

variable "duration" {
  type        = string
  description = <<EOT
  {
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
      "en": "Specifies whether to enable automatic payment."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动付费"
    }
  }
  EOT
}

variable "billing_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The BillingType of the bandwidth"
    },
    "Label": {
      "en": "BillingType",
      "zh-cn": "计量方式"
    }
  }
  EOT
}

resource "alicloud_ga_bandwidth_package" "ga_bandwidth_package" {
  bandwidth_type = var.bandwidth_type
  type           = var.type
  bandwidth      = var.bandwidth
  ratio          = var.ratio
  duration       = var.duration
  auto_pay       = var.auto_pay
  billing_type   = var.billing_type
}

output "bandwidth_package_name" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.bandwidth_package_name
  description = "The Resource name of the bandwidth"
}

output "cbn_geographic_region_id_b" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.cbn_geographic_region_idb
  description = "The CbnGeographicRegionIdB of the bandwidth"
}

output "cbn_geographic_region_id_a" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.cbn_geographic_region_ida
  description = "The CbnGeographicRegionIdA  of the bandwidth"
}

output "auto_pay" {
  // Could not transform ROS Attribute AutoPay to Terraform attribute.
  value       = null
  description = "The AutoPay of the bandwidth"
}

output "bandwidth_type" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.bandwidth_type
  description = "the bandwidth BandwidthType of the bandwidth"
}

output "type" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.type
  description = "The type of the bandwidth plan"
}

output "auto_use_coupon" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.auto_use_coupon
  description = "The AutoUseCoupon  of the bandwidth"
}

output "charge_type" {
  // Could not transform ROS Attribute ChargeType to Terraform attribute.
  value       = null
  description = "The ChargeType of the bandwidth"
}

output "bandwidth" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.bandwidth
  description = "The bandwidth provided by the bandwidth plan."
}

output "payment_type" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.payment_type
  description = "The Payment Type of the bandwidth"
}

output "bandwidth_package_id" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.id
  description = "The Resource ID of the bandwidth"
}

output "ratio" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.ratio
  description = "The Ratio of the bandwidth"
}

output "billing_type" {
  value       = alicloud_ga_bandwidth_package.ga_bandwidth_package.billing_type
  description = "The BillingType of the bandwidth"
}

