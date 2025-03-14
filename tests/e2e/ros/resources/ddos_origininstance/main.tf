variable "ip_addresses" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of ip addresses.\nWhen Edition is smb， IP Addresses ranges from 1 to 29.\nWhen Edition is enterprise, The minimum number of IP Addresses is 30."
    },
    "MinValue": 1,
    "Label": {
      "en": "IpAddresses",
      "zh-cn": "要防护的IP地址总个数"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The charge type of the instance. Valid values:\nPostPaid: Pay-as-you-go.\nPrePaid: Subscription."
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

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The period of the instance."
    },
    "MinValue": 1,
    "Label": {
      "en": "Period",
      "zh-cn": "实例的购买周期时长"
    },
    "MaxValue": 11
  }
  EOT
}

variable "enable_log" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable protection logs."
    },
    "Label": {
      "en": "EnableLog",
      "zh-cn": "是否开启保护日志"
    }
  }
  EOT
}

variable "network_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The network protocol of the instance. Valid values:\nv4: IPv4.\nv6: IPv6.\nv4_6: IPv4+IPv6."
    },
    "AllowedValues": [
      "v4",
      "v6",
      "v4_6"
    ],
    "Label": {
      "en": "NetworkProtocol",
      "zh-cn": "原生防护实例支持防护的IP协议类型"
    }
  }
  EOT
}

variable "clean_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The mitigation capability of Anti-DDoS is measured by the inbound or outbound clean bandwidth.\nWhen Edition is enterprise, CleanBandwidth ranges from 100 to 1000 Mbit/s.When Edition is smb， CleanBandwidth ranges from 50 to 1000 Mbit/s."
    },
    "MinValue": 50,
    "Label": {
      "en": "CleanBandwidth",
      "zh-cn": "要防护业务的正常业务规模（以网络带宽来衡量）"
    },
    "MaxValue": 1000
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

variable "edition" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "enterprise",
      "smb"
    ],
    "Description": {
      "en": "Edition of the instance. Valid values:\n - enterprise: Enterprise Edition.\n- smb: Affordable and general edition for small and medium-sized enterprises."
    },
    "Label": {
      "en": "Edition",
      "zh-cn": "版本"
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
      "en": "The period unit of the instance. Valid values:\nMonth: Month.\nYear: Year."
    },
    "AllowedValues": [
      "Month",
      "Year",
      "month",
      "year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "实例的购买周期单位"
    }
  }
  EOT
}

variable "protection_mode" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The mode of the protection. Valid values:\nunlimited: The Unlimited protection mode is intended for internal use within enterprises."
    },
    "Label": {
      "en": "ProtectionMode",
      "zh-cn": "防护模式"
    }
  }
  EOT
}

resource "alicloud_ddosbgp_instance" "instance" {
  period = var.period
}

output "instance_id" {
  value       = alicloud_ddosbgp_instance.instance.id
  description = "The ID of the instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

