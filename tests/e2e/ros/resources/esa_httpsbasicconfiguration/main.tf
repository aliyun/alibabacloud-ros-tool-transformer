variable "site_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Site ID, which can be obtained by calling the [ListSites](~~ListSites~~) interface."
    },
    "Label": {
      "en": "SiteId",
      "zh-cn": "站点 ID"
    }
  }
  EOT
}

variable "ciphersuite" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Custom cipher suite, indicating the specific encryption algorithm selected when CiphersuiteGroup is set to custom."
    },
    "Label": {
      "en": "Ciphersuite",
      "zh-cn": "自定义加密套件"
    }
  }
  EOT
}

variable "rule_enable" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule switch. When adding global configuration, this parameter does not need to be set. Value range:\n- on: open.\n- off: close."
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

variable "http3" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable HTTP3, which is enabled by default. The value can be:\n- on: Enabled. \n- off: Disabled."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Http3",
      "zh-cn": "是否开启 HTTP3"
    }
  }
  EOT
}

variable "https" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable HTTPS. Default is enabled. Possible values:\n- on: Enable.\n- off: Disable."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Https",
      "zh-cn": "是否开启 HTTPS"
    }
  }
  EOT
}

variable "http2" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether HTTP2 is enabled. Default is on. Possible values:\n- on: Enabled.\n- off: Disabled."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Http2",
      "zh-cn": "是否开启 HTTP2"
    }
  }
  EOT
}

variable "tls10" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable TLS1.0. Default is disabled. Possible values:\n- on: Enable.\n- off: Disable."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Tls10",
      "zh-cn": "是否开启 TLS1.0"
    }
  }
  EOT
}

variable "tls11" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable TLS1.1. Default is enabled. Possible values:\n- on: Enable.\n- off: Disable."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Tls11",
      "zh-cn": "是否开启 TLS1.1"
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

variable "tls12" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable TLS1.2. Default is enabled. Possible values:\n- on: Enable.\n- off: Disable."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Tls12",
      "zh-cn": "是否开启 TLS1.2"
    }
  }
  EOT
}

variable "tls13" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable TLS1.3. Default is enabled. Possible values:\n- on: Enable.\n- off: Disable."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Tls13",
      "zh-cn": "是否开启 TLS1.3"
    }
  }
  EOT
}

variable "ciphersuite_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cipher suite group. Default is all cipher suites. Possible values:\n- all: All cipher suites.\n- strict: Strong cipher suites.\n- custom: Custom cipher suites."
    },
    "AllowedValues": [
      "all",
      "strict",
      "custom"
    ],
    "Label": {
      "en": "CiphersuiteGroup",
      "zh-cn": "加密套件组"
    }
  }
  EOT
}

variable "rule" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Rule content, using conditional expressions to match user requests. When adding global configuration, this parameter does not need to be set. There are two usage scenarios:\n-  Match all incoming requests: value set to true\n-  Match specified request: Set the value to a custom expression, for example: (http.host eq \\\"video.example.com\\\")."
    },
    "Label": {
      "en": "Rule",
      "zh-cn": "规则内容"
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

variable "ocsp_stapling" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether OCSP is enabled. Default is off. Possible values:\n- on: Enabled.\n- off: Disabled."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "OcspStapling",
      "zh-cn": "是否开启 OCSP"
    }
  }
  EOT
}

resource "alicloud_esa_https_basic_configuration" "extension_resource" {
  site_id           = var.site_id
  ciphersuite       = var.ciphersuite
  rule_enable       = var.rule_enable
  http3             = var.http3
  https             = var.https
  http2             = var.http2
  tls10             = var.tls10
  tls11             = var.tls11
  sequence          = var.sequence
  tls12             = var.tls12
  tls13             = var.tls13
  ciphersuite_group = var.ciphersuite_group
  rule              = var.rule
  rule_name         = var.rule_name
  ocsp_stapling     = var.ocsp_stapling
}

output "config_id" {
  value       = alicloud_esa_https_basic_configuration.extension_resource.config_id
  description = "ConfigId of the configuration."
}

