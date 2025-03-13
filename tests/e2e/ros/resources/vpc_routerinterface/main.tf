variable "opposite_interface_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the peer router interface."
    },
    "Label": {
      "en": "OppositeInterfaceId",
      "zh-cn": "对端路由器接口ID"
    }
  }
  EOT
}

variable "opposite_interface_owner_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Owner account ID of the connection peer RouterInterface. The default value is current user Id."
    },
    "Label": {
      "en": "OppositeInterfaceOwnerId",
      "zh-cn": "连接对端路由器接口的持有者账号ID"
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
      "en": "Custom description of the RouterInterface, [2, 256] characters. Don't fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "路由器接口描述"
    }
  }
  EOT
}

variable "opposite_router_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The router ID of the connection peer RouterInterface."
    },
    "Label": {
      "en": "OppositeRouterId",
      "zh-cn": "要连接的对端的路由器的ID"
    }
  }
  EOT
}

variable "opposite_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The region where the connection peer RouterInterface locates. The default value is region where stack is created."
    },
    "Label": {
      "en": "OppositeRegionId",
      "zh-cn": "要连接的对端所在的地域"
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
      "en": "The billing method of the router interface. Valid values: PrePaid (Subscription), PostPaid (default, Pay-As-You-Go)"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例的付费类型"
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
      "en": "Unit of the payment cycle. It could be Month (default) or Year."
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

variable "health_check_source_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source IP address of the packet for leased line HealthCheck in leased line disaster tolerance and ECMP scenarios. It is valid only for a VRouter RouterInterface with a peer on a VBR. The source IP address must be in the VPC of the local VRouter and is not used. HealthCheckSourceIp and HealthCheckTargetIp parameters must be both specified or left unspecified."
    },
    "Label": {
      "en": "HealthCheckSourceIp",
      "zh-cn": "专线容灾和ECMP场景下用来做专线健康检查的Packet的源IP"
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
      "en": "Prepaid time period. It could be from 1 to 9 when PricingCycle is Month, or 1 to 3 when PricingCycle is Year."
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
      9
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "router_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The router ID to create RouterInterface."
    },
    "Label": {
      "en": "RouterId",
      "zh-cn": "路由器ID"
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
      "en": "Indicates whether automatic payment is enabled. Valid values:\nfalse: Automatic payment is disabled. You need to go to Orders to make the payment once an order is generated. \ntrue: Automatic payment is enabled. The payment is automatically made.\nDefault: true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "自动付款"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Custom name of the RouterInterface, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "路由器接口显示名称"
    }
  }
  EOT
}

variable "role" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "InitiatingSide",
      "AcceptingSide"
    ],
    "Description": {
      "en": "RouterInterface role. Now support 'InitiatingSide|AcceptingSide'.",
      "zh-cn": "连接中扮演的角色。即，是连接发起端还是连接接受端。"
    },
    "Label": {
      "en": "Role",
      "zh-cn": "连接中扮演的角色"
    }
  }
  EOT
}

variable "opposite_router_type" {
  type        = string
  default     = "VRouter"
  description = <<EOT
  {
    "Description": {
      "en": "Router type of the connection peer router. Now support 'VRouter|VBR'. If 'RouterType' is specified as 'VBR', the value must be 'VRouter'."
    },
    "AllowedValues": [
      "VRouter",
      "VBR"
    ],
    "Label": {
      "en": "OppositeRouterType",
      "zh-cn": "要连接的对端路由器接口所属的路由器类型"
    }
  }
  EOT
}

variable "router_type" {
  type        = string
  default     = "VRouter"
  description = <<EOT
  {
    "Description": {
      "en": "Router type. Now support 'VRouter|VBR'"
    },
    "AllowedValues": [
      "VRouter",
      "VBR"
    ],
    "Label": {
      "en": "RouterType",
      "zh-cn": "所属的路由器类型"
    }
  }
  EOT
}

variable "access_point_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Access point ID. If 'RouterType' is specified as 'VBR', the value is required."
    },
    "Label": {
      "en": "AccessPointId",
      "zh-cn": "所属的接入点ID"
    }
  }
  EOT
}

variable "opposite_access_point_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Access point ID of the connection peer RouterInterface. If 'OppositeRouterType' is specified as 'VBR', the value is required."
    },
    "Label": {
      "en": "OppositeAccessPointId",
      "zh-cn": "对端所属的接入点ID"
    }
  }
  EOT
}

variable "spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "RouterInterface specification. If 'Role' is specified as 'InitiatingSide', the value is required. If 'Role' is specified as 'AcceptingSide', the value is set as 'Negative' by default."
    },
    "Label": {
      "en": "Spec",
      "zh-cn": "路由器接口的规格"
    }
  }
  EOT
}

variable "health_check_target_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Target IP address of the packet for leased line HealthCheck in leased line disaster tolerance and ECMP scenarios. It is valid only for a VRouter RouterInterface with a peer on a VBR. Usually you can use the CPE IP address of the leased line user's client (that is, the PeerGatewayIP on the VBR of the peer RouterInterface), you can also specify another IP address of the leased line user's client as the HealthCheck target IP address. HealthCheckSourceIp and HealthCheckTargetIp parameters must be both specified or left unspecified."
    },
    "Label": {
      "en": "HealthCheckTargetIp",
      "zh-cn": "专线容灾和ECMP场景下用来做专线健康检查的Packet的目标IP"
    }
  }
  EOT
}

resource "alicloud_router_interface" "router_interface" {
  opposite_interface_id       = var.opposite_interface_id
  opposite_interface_owner_id = var.opposite_interface_owner_id
  description                 = var.description
  opposite_router_id          = var.opposite_router_id
  opposite_region             = var.opposite_region_id
  instance_charge_type        = var.instance_charge_type
  health_check_source_ip      = var.health_check_source_ip
  period                      = var.period
  router_id                   = var.router_id
  name                        = var.name
  role                        = var.role
  opposite_router_type        = var.opposite_router_type
  router_type                 = var.router_type
  access_point_id             = var.access_point_id
  opposite_access_point_id    = var.opposite_access_point_id
  specification               = var.spec
  health_check_target_ip      = var.health_check_target_ip
}

output "router_interface_id" {
  value       = alicloud_router_interface.router_interface.id
  description = "The ID of created RouterInterface."
}

