variable "enable_ipsec" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable IPsec-VPN. The IPsec-VPN feature provides a site-to-site connection. You can securely connect your local data center network to a private network or two proprietary networks by creating an IPsec tunnel. Value:\nTrue (default): Enables the IPsec-VPN feature.\nFalse: The IPsec-VPN function is not enabled."
    },
    "Label": {
      "en": "EnableIpsec",
      "zh-cn": "是否开启IPsec-VPN功能"
    }
  }
  EOT
}

variable "enable_ssl" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enable the SSL-VPN function. Provide point-to-site VPN connection, no need to configure customer gateway, terminal directly access. Value:\nTrue: Enable SSL-VPN.\nFalse (default): Does not enable SSL-VPN."
    },
    "Label": {
      "en": "EnableSsl",
      "zh-cn": "是否开启SSL-VPN功能"
    }
  }
  EOT
}

variable "vpn_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "VPN gateway type."
    },
    "Label": {
      "en": "VpnType",
      "zh-cn": "VPN网关类型"
    }
  }
  EOT
}

variable "ssl_connections" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of clients allowed to connect at the same time."
    },
    "Label": {
      "en": "SslConnections",
      "zh-cn": "允许同时连接的最大客户端数量"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the VPN gateway.\nThe length is 2-256 characters and must start with a letter or Chinese, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "VPN网关描述"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "disaster_recoveryvswitch_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The second vSwitch with which you want to associate the VPN gateway.\nIf you call this operation in a region that supports the dual-tunnel mode, this parameter is required.\nYou need to specify two vSwitches in different zones from the VPC associated with the VPN gateway to implement disaster recovery across zones.\nFor a region that supports only one zone, disaster recovery across zones is not supported. We recommend that you specify two vSwitches in the zone to implement high availability. You can specify the same vSwitch.\nFor more information about the regions and zones that support the dual-tunnel mode, see Upgrade a VPN gateway to enable the dual-tunnel mode."
    },
    "Label": {
      "en": "DisasterRecoveryVSwitchId",
      "zh-cn": "指定VPN网关实例关联的第二个交换机实例"
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
      "en": "Accounting type of the VPN gateway, the value is:\nPREPAY, POSTPAY"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "VPN网关的计费类型"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the VSwitch to which the VPN gateway belongs."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "VPN网关所属的交换机ID"
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
      "en": "Purchase time, value: 1~9|12|24|36.\nWhen the value of the InstanceChargeType parameter is PREPAY, this parameter is mandatory."
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

variable "auto_pay" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to automatically pay the bill of the VPN gateway, the value:\ntrue: Automatically pays the bill for the VPN gateway.\nfalse: Does not automatically pay the bill for the VPN gateway.\nDefault true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付VPN网关的账单 "
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of the VPN gateway. The default value is the ID of the VPN gateway.\nThe length is 2~100 English or Chinese characters. It must start with a large or small letter or Chinese. It can contain numbers, underscores (_) and dashes (-). It cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "VPN网关的名称"
    },
    "MinLength": 2,
    "MaxLength": 100
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
      "en": "VPC ID to which the VPN gateway belongs."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "VPN网关所属的专有网络ID"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The network type of the VPN gateway. Valid values: public|private"
    },
    "AllowedValues": [
      "public",
      "private"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "VPN网关的网络类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      5,
      10,
      20,
      50,
      100,
      200
    ],
    "Description": {
      "en": "The public network bandwidth of the VPN gateway, in Mbps.\nValue: 5|10|20|50|100|200."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "VPN网关的公网带宽"
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_vpn_gateway" "vpn_gateway" {
  enable_ipsec         = var.enable_ipsec
  enable_ssl           = var.enable_ssl
  vpn_type             = var.vpn_type
  ssl_connections      = var.ssl_connections
  description          = var.description
  instance_charge_type = var.instance_charge_type
  vswitch_id           = var.vswitch_id
  period               = var.period
  auto_pay             = var.auto_pay
  name                 = var.name
  vpc_id               = var.vpc_id
  network_type         = var.network_type
  bandwidth            = var.bandwidth
  tags                 = var.tags
}

output "vpn_type" {
  value       = alicloud_vpn_gateway.vpn_gateway.vpn_type
  description = "The type of the VPN gateway."
}

output "disaster_recoveryvswitch_id" {
  // Could not transform ROS Attribute DisasterRecoveryVSwitchId to Terraform attribute.
  value       = null
  description = "The ID of the second vSwitch associated with the VPN gateway.This attribute is returned only when the VPN gateway supports the dual-tunnel mode."
}

output "vpc_id" {
  value       = alicloud_vpn_gateway.vpn_gateway.vpc_id
  description = "The ID of the virtual private cloud (VPC) to which the VPN gateway belongs."
}

output "internet_ip" {
  value       = alicloud_vpn_gateway.vpn_gateway.internet_ip
  description = "The public IP address of the VPN gateway."
}

output "vpn_gateway_id" {
  value       = alicloud_vpn_gateway.vpn_gateway.id
  description = "ID of the VPN gateway."
}

output "disaster_recovery_internet_ip" {
  value       = alicloud_vpn_gateway.vpn_gateway.disaster_recovery_internet_ip
  description = "The second IP address assigned by the system to create an IPsec-VPN connection.This attribute is returned only when the VPN gateway supports the dual-tunnel mode."
}

output "vswitch_id" {
  value       = alicloud_vpn_gateway.vpn_gateway.vswitch_id
  description = "The ID of the vSwitch to which the VPN gateway belongs."
}

output "ssl_vpn_internet_ip" {
  value       = alicloud_vpn_gateway.vpn_gateway.ssl_vpn_internet_ip
  description = "The IP address of the SSL-VPN connection.This attribute is returned only when the VPN gateway is a public VPN gateway and supports only the single-tunnel mode. In addition, the VPN gateway must have the SSL-VPN feature enabled."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order ID."
}

output "spec" {
  // Could not transform ROS Attribute Spec to Terraform attribute.
  value       = null
  description = "The specification of the VPN gateway."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "ssl_max_connections" {
  // Could not transform ROS Attribute SslMaxConnections to Terraform attribute.
  value       = null
  description = "The maximum number of concurrent SSL-VPN connections."
}

