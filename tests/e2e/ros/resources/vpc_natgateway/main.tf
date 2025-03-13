variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the NAT gateway, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "NAT网关的描述"
    }
  }
  EOT
}

variable "nat_gateway_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the NAT gateway, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "NatGatewayName",
      "zh-cn": "NAT网关的名称"
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
      "en": "The billing method. The default value is PostPaid (which means pay-as-you-go)."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "NAT网关的付费模式"
    }
  }
  EOT
}

variable "pricing_cycle" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Price cycle of the resource. This property has no default value."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ]
  }
  EOT
}

variable "eip_bind_mode" {
  type        = string
  default     = "MULTI_BINDED"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "EIPAssociationMode"
    },
    "Description": {
      "en": "The mode in which the EIP is associated with the NAT gateway. Valid values:MULTI_BINDED (default): the multi-EIP-to-ENI mode.\nNAT: NAT mode. IPv4 gateways are supported.\nNote If the EIP is associated with the NAT gateway in NAT mode, \nthe EIP occupies a private IP address of the vSwitch to which the NAT gateway belongs. \nMake sure that the vSwitch has sufficient private IP addresses. \nOtherwise, the EIP cannot be associated with the NAT gateway. \nIn NAT mode, a maximum number of 50 EIPs can be associated with each NAT gateway."
    },
    "AllowedValues": [
      "MULTI_BINDED",
      "NAT"
    ],
    "Label": {
      "en": "EipBindMode",
      "zh-cn": "NAT网关的EIP绑定模式"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The VSwitch id to create NAT gateway."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "NAT网关所属的交换机ID"
    }
  }
  EOT
}

variable "security_protection_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the firewall feature. Default: False"
    },
    "Label": {
      "en": "SecurityProtectionEnabled",
      "zh-cn": "是否开启防火墙功能"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "The subscription duration. While choose by pay by month, it could be from 1 to 9 or 12, 24, 36. While choose pay by year, it could be from 1 to 3."
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
    ]
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
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable automatic payment. Default is true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否开启自动付费"
    }
  }
  EOT
}

variable "nat_type" {
  type        = string
  default     = "Enhanced"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NatType"
    },
    "Description": {
      "en": "The type of the NAT gateway. Valid values:\n- Enhanced: enhanced NAT gateway."
    },
    "AllowedValues": [
      "Enhanced"
    ],
    "Label": {
      "en": "NatType",
      "zh-cn": "NAT网关的类型"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  default     = "PayByLcu"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "The billing method for the NAT gateway. Valid values:\nPayBySpec: billed on a pay-by-specification basis."
    },
    "AllowedValues": [
      "PayByLcu",
      "PayBySpec"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "NAT网关的计费类型"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete the relative snat and dnat entries in the net gateway and unbind eips. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除NAT网关"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC id to create NAT gateway."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "需要创建NAT网关的专有网络ID"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  default     = "internet"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NatGatewayNetworkType"
    },
    "Description": {
      "en": "The type of the created NAT gateway.\nInternet: public network NAT gateway.\nIntranet: VPC NAT gateway."
    },
    "AllowedValues": [
      "internet",
      "intranet"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "NAT网关的网络类型"
    }
  }
  EOT
}

variable "icmp_reply_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the ICMP non-retrieval feature. Default: True"
    },
    "Label": {
      "en": "IcmpReplyEnabled",
      "zh-cn": "是否开启ICMP不代回功能"
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
      "en": "Tags to attach to natgateway. Max support 20 tags to add during create natgateway. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_nat_gateway" "vpc_nat_gateway" {
  description          = var.description
  name                 = var.nat_gateway_name
  instance_charge_type = var.instance_charge_type
  eip_bind_mode        = var.eip_bind_mode
  vswitch_id           = var.vswitch_id
  period               = var.duration
  deletion_protection  = var.deletion_protection
  nat_type             = var.nat_type
  internet_charge_type = var.internet_charge_type
  vpc_id               = var.vpc_id
  network_type         = var.network_type
  tags                 = var.tags
}

output "nat_gateway_id" {
  value       = alicloud_nat_gateway.vpc_nat_gateway.id
  description = "The Id of created NAT gateway."
}

output "snat_table_id" {
  // Could not transform ROS Attribute SNatTableId to Terraform attribute.
  value       = null
  description = "The SNAT table id."
}

output "forward_table_id" {
  // Could not transform ROS Attribute ForwardTableId to Terraform attribute.
  value       = null
  description = "The forward table id."
}

