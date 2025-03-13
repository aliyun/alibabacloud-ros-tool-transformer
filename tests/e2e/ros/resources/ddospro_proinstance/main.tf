variable "normal_qps" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The clean queries per second (QPS) provided by the instance.\nValid values: 3000 to 100000. The value must be a multiple of 100."
    },
    "MinValue": 3000,
    "Label": {
      "en": "NormalQps",
      "zh-cn": "正常业务QPS"
    },
    "MaxValue": 100000
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period of the firewallIf PeriodUnit is Month, the valid range is 1, 2, 3, 4, 5, 6, 12, 24\nIf PeriodUnit is Year, the valid range is 1, 2"
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      12,
      24
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "port_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of ports that you want to protect.\nValid values: 50 to 400. The value must be a multiple of 5."
    },
    "MinValue": 50,
    "Label": {
      "en": "PortCount",
      "zh-cn": "防护端口数"
    },
    "MaxValue": 400
  }
  EOT
}

variable "edition" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The mitigation plan of the instance. Set the value to coop, which indicates the Profession mitigation plan."
    },
    "Label": {
      "en": "Edition",
      "zh-cn": "防护套餐类型"
    }
  }
  EOT
}

variable "burst_bandwidth_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The metering method of the 95th percentile burstable clean bandwidth. Valid values:\n0: disables the burstable clean bandwidth feature.\n1: enables the burstable clean bandwidth feature and uses the daily 95th percentile metering method.\n2: enables the burstable clean bandwidth feature and uses the monthly 95th percentile metering method."
    },
    "AllowedValues": [
      "0",
      "1",
      "2"
    ],
    "Label": {
      "en": "BurstBandwidthMode",
      "zh-cn": "95弹性业务带宽计费模式"
    }
  }
  EOT
}

variable "service_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The clean bandwidth provided by the instance. Unit: Mbit/s.\nValid values: 100 to 5000. The value must be a multiple of 50."
    },
    "MinValue": 100,
    "Label": {
      "en": "ServiceBandwidth",
      "zh-cn": "业务带宽"
    },
    "MaxValue": 5000
  }
  EOT
}

variable "service_partner" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the protection line. Set the value to coop-line-001, which indicates the default protection line."
    },
    "Label": {
      "en": "ServicePartner",
      "zh-cn": "防护线路类型"
    }
  }
  EOT
}

variable "base_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The basic protection bandwidth. Unit: Gbit/s.\nValid values: 30, 60, 100, 300, 400, 500, and 600."
    },
    "AllowedValues": [
      30,
      60,
      100,
      300,
      400,
      500,
      600
    ],
    "Label": {
      "en": "BaseBandwidth",
      "zh-cn": "保底防护带宽"
    }
  }
  EOT
}

variable "function_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The function plan of the instance. Valid values:\n0: the Standard function plan\n1: the Enhanced function plan."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "en": "FunctionVersion",
      "zh-cn": "功能套餐类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The burstable protection bandwidth. Unit: Gbit/s.\nThe burstable protection bandwidth must be greater than or equal to the basic protection bandwidth. The value of Bandwidth varies based on the value of BaseBandwidth."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "弹性防护带宽"
    }
  }
  EOT
}

variable "address_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP version of the IP address. Valid values: Ipv4、Ipv6"
    },
    "AllowedValues": [
      "Ipv4",
      "Ipv6"
    ],
    "Label": {
      "en": "AddressType",
      "zh-cn": "IP地址的协议类型"
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

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "Month",
      "Year",
      "month",
      "year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "订阅持续时间的单位"
    }
  }
  EOT
}

variable "domain_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of domain names that you want to protect.\nValid values: 50 to 2000. The value must be a multiple of 10."
    },
    "MinValue": 50,
    "Label": {
      "en": "DomainCount",
      "zh-cn": "防护域名数"
    },
    "MaxValue": 2000
  }
  EOT
}

resource "alicloud_ddoscoo_instance" "pro_instance" {
  normal_qps        = var.normal_qps
  period            = var.period
  port_count        = var.port_count
  service_bandwidth = var.service_bandwidth
  base_bandwidth    = var.base_bandwidth
  function_version  = var.function_version
  bandwidth         = var.bandwidth
  address_type      = var.address_type
  domain_count      = var.domain_count
}

output "instance_id" {
  value       = alicloud_ddoscoo_instance.pro_instance.id
  description = "The ID of the instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

