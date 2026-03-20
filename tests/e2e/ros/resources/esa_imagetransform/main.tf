variable "site_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The site ID, which can be obtained by calling the ListSites API."
    },
    "Label": {
      "en": "SiteId",
      "zh-cn": "站点 ID"
    }
  }
  EOT
}

variable "rule_enable" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule switch. When adding global configuration, this parameter does not need to be set. Value range:\non: Enabled.\noff: Disabled."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "RuleEnable",
      "zh-cn": "规则开关"
    }
  }
  EOT
}

variable "enable" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the image transformations feature is enabled. Valid values:\non: Enabled.\noff: Disabled."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Enable",
      "zh-cn": "是否开启图片转换"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Payment Type."
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付款类型"
    }
  }
  EOT
}

variable "sequence" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Order of rule execution. The smaller the value, the higher the priority for execution."
    },
    "Label": {
      "en": "Sequence",
      "zh-cn": "规则执行顺序"
    }
  }
  EOT
}

variable "rule" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule content, using conditional expressions to match user requests. When adding global configuration, this parameter does not need to be set. There are two usage scenarios:\nMatch all incoming requests: value set to true\nMatch specified request: Set the value to a custom expression, for example: (http.host eq \\\"video.example.com\\\")."
    },
    "Label": {
      "en": "Rule",
      "zh-cn": "规则内容"
    }
  }
  EOT
}

variable "site_version" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The version number of the site configuration. For sites that have enabled configuration version management, this parameter can be used to specify the effective version of the configuration site, which defaults to version 0."
    },
    "Label": {
      "en": "SiteVersion",
      "zh-cn": "站点配置的版本号"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule name. When adding global configuration, this parameter does not need to be set."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "规则名称"
    }
  }
  EOT
}

resource "alicloud_esa_image_transform" "extension_resource" {
  site_id      = var.site_id
  rule_enable  = var.rule_enable
  enable       = var.enable
  rule         = var.rule
  site_version = var.site_version
  rule_name    = var.rule_name
}

output "config_id" {
  value       = alicloud_esa_image_transform.extension_resource.config_id
  description = "Config Id."
}

