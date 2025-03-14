variable "product_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Product code for the resource."
    },
    "Label": {
      "en": "ProductCode",
      "zh-cn": "云市场资源的 Product Code"
    }
  }
  EOT
}

variable "preference" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Customized parameters."
    },
    "Label": {
      "en": "Preference",
      "zh-cn": "用户自定义参数"
    }
  }
  EOT
}

variable "sku_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Sku code for the resource."
    },
    "Label": {
      "en": "SkuCode",
      "zh-cn": "云市场资源的 sku code"
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
      "en": "Price cycle of the resource. This property has no default value. If ChargeType is specified as Postpaid, this value will be ignore."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "付费周期单位"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The resource charge type. Default value is Prepaid"
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

variable "quantity" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Resource number. Default value is 1"
    },
    "Label": {
      "en": "Quantity",
      "zh-cn": "购买该资源的数量"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Duration of the resource. If ChargeType is specified as Postpaid, this value will be ignore."
    },
    "MinValue": 1,
    "Label": {
      "en": "Duration",
      "zh-cn": "付费时长"
    },
    "MaxValue": 100
  }
  EOT
}

resource "alicloud_market_order" "order_market" {
  product_code    = var.product_code
  package_version = var.sku_code
  pricing_cycle   = var.pricing_cycle
  pay_type        = var.charge_type
  quantity        = var.quantity
  duration        = var.duration
}

output "order_id" {
  value       = alicloud_market_order.order_market.id
  description = "Order ID of created instance."
}

