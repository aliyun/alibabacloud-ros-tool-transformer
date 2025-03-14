variable "office_site_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the workspace."
    },
    "Label": {
      "en": "OfficeSiteId",
      "zh-cn": "办公网络ID"
    }
  }
  EOT
}

variable "promotion_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the sales promotion."
    },
    "Label": {
      "en": "PromotionId",
      "zh-cn": "优惠活动ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
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
      "en": "The maximum public bandwidth. Unit: Mbit/s.\nValid values for the pay-by-data-transfer type (PayByTraffic): 10 to 200. \n Valid values for the pay-by-bandwith type (PayByBandwidth): 10 to 1000."
    },
    "MinValue": 2,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "公网精品带宽的带宽大小"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The duration of the Internet access package."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method of the Internet access package. Enumeration Value:\nPostPaid\nPrePaid"
    },
    "AllowedValues": [
      "PostPaid",
      "PrePaid"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable automatic payment."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of duration that you want to use for the Internet access package. Enumeration Value:\nMonthYearWeek"
    },
    "AllowedValues": [
      "Month",
      "Year",
      "Week"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "包年包月精品带宽的购买时长单位"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "The metering method of the pay-as-you-go Internet access package. Valid values: \nPayByTraffic: pay-by-data-transfer.\nPayByBandwidth: pay-by-bandwidth. \nDefault value: PayByTraffic."
    },
    "AllowedValues": [
      "PayByTraffic",
      "PayByBandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "公网精品带宽的计费方式"
    }
  }
  EOT
}

resource "alicloud_ecd_network_package" "extension_resource" {
  office_site_id       = var.office_site_id
  bandwidth            = var.bandwidth
  internet_charge_type = var.internet_charge_type
}

output "network_package_id" {
  value       = alicloud_ecd_network_package.extension_resource.id
  description = "The ID of the Internet access package."
}

