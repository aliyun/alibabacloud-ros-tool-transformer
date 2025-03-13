variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Optional. The description of the EIP. The description must be 2 to 256 characters in length. It must start with a letter. It cannot start with http://  or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "EIP的描述信息"
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

variable "zone" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Availability zone of the elastic public network IP."
    },
    "Label": {
      "en": "Zone",
      "zh-cn": "弹性公网IP可用分区"
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
      "en": "The resource charge type. Default value is Postpaid"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "EIP的付费方式"
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
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Prepaid"
          ]
        }
      }
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
      "zh-cn": "预付费的计费周期"
    }
  }
  EOT
}

variable "isp" {
  type        = string
  default     = "BGP"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "EIPIsp"
    },
    "Description": {
      "en": "The line type. You can set this parameter only when you create a pay-as-you-go EIP. Valid values:\nBGP: BGP (Multi-ISP) lines. Up to 89 high-quality BGP lines are available worldwide. Direct connections with multiple Internet Service Providers (ISPs), including Telecom, Unicom, Mobile, Railcom, Netcom, CERNET, China Broadcast Network, Dr. Peng, and Founder, can be established in all regions in mainland China.\nBGP_PRO: BGP (Multi-ISP) Pro lines. BGP (Multi-ISP) Pro lines optimize data transmission to China and improve connection quality for international services. Compared with traditional BGP (Multi-ISP) lines, BGP (Multi-ISP) Pro lines can be used to establish direct connections without using international ISP services. Therefore, BGP (Multi-ISP) Pro lines reduce network latency."
    },
    "AllowedValues": [
      "BGP",
      "BGP_PRO",
      "ChinaTelecom",
      "ChinaUnicom",
      "ChinaMobile",
      "BGP_FinanceCloud"
    ],
    "Label": {
      "en": "Isp",
      "zh-cn": "线路类型"
    }
  }
  EOT
}

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Prepaid"
          ]
        }
      }
    },
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period. While choose by pay by month, it could be from 1 to 9 or 12, 24, 36. \n  While choose pay by year, it could be from 1 to 3."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      12,
      24,
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "public_ip_address_pool_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the IP address pool. The EIP is allocated from the IP address pool."
    },
    "Label": {
      "en": "PublicIpAddressPoolId",
      "zh-cn": "IP地址池ID"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable deletion protection.\nDefault to False."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否开启删除保护功能"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Prepaid"
          ]
        }
      }
    },
    "Description": {
      "en": "Automatic Payment. Default is true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否开启自动付费"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the EIP. The name must be 2 to 128 characters in length. It must start with a letter. It can contain numbers, periods (.), underscores (_), and hyphens (-). It cannot start with http://  or https://"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "EIP的名称"
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
      "en": "The network charge type. Support 'PayByBandwidth' and 'PayByTraffic' only. Default is PayByBandwidth. PayByTraffic will charge by hour, PayByBandwidth will charge by day. "
    },
    "AllowedValues": [
      "PayByTraffic",
      "PayByBandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "EIP的计费方式"
    }
  }
  EOT
}

variable "netmode" {
  type        = string
  default     = "public"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "EIPSegmentNetmode"
    },
    "Description": {
      "en": "The network type. Valid value: public (public network)."
    },
    "AllowedValues": [
      "public"
    ],
    "Label": {
      "en": "Netmode",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  default     = 5
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InternetChargeType}",
            "PayByBandwidth"
          ]
        }
      }
    },
    "Description": {
      "en": "Bandwidth for the output network. Default is 5MB."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "EIP的带宽值"
    }
  }
  EOT
}

variable "security_protection_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "LocaleKey": "EIPSecurityProtectionType"
        },
        "Type": "String",
        "AllowedValues": [
          "AntiDDoS_Enhanced"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The edition of Anti-DDoS.\nIf you do not set this parameter, Anti-DDoS Origin Basic is used.\nIf you set the value to AntiDDoS_Enhanced, Anti-DDoS Pro/Premium is used."
    },
    "Label": {
      "en": "SecurityProtectionTypes",
      "zh-cn": "安全防护级别"
    },
    "MaxLength": 10
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
      "en": "Tags to attach to eip. Max support 20 tags to add during create eip. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_eip_address" "elastic_ip" {
  description               = var.description
  resource_group_id         = var.resource_group_id
  zone                      = var.zone
  instance_charge_type      = var.instance_charge_type
  pricing_cycle             = var.pricing_cycle
  isp                       = var.isp
  period                    = var.period
  public_ip_address_pool_id = var.public_ip_address_pool_id
  deletion_protection       = var.deletion_protection
  auto_pay                  = var.auto_pay
  address_name              = var.name
  internet_charge_type      = var.internet_charge_type
  netmode                   = var.netmode
  bandwidth                 = var.bandwidth
  security_protection_types = var.security_protection_types
  tags                      = var.tags
}

output "isp" {
  value       = alicloud_eip_address.elastic_ip.isp
  description = "The line type."
}

output "allocation_id" {
  value       = alicloud_eip_address.elastic_ip.id
  description = "ID that Aliyun assigns to represent the allocation of the address for use with VPC. Returned only for VPC elastic IP addresses."
}

output "eip_address" {
  // Could not transform ROS Attribute EipAddress to Terraform attribute.
  value       = null
  description = "IP address of created EIP."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Order ID of prepaid EIP instance."
}

