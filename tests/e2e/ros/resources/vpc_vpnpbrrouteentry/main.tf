variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the VPN destination route."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "策略路由的描述信息"
    }
  }
  EOT
}

variable "route_dest" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The destination CIDR block of the destination route."
    },
    "Label": {
      "en": "RouteDest",
      "zh-cn": "策略路由的目标网段"
    }
  }
  EOT
}

variable "overlay_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The overlay mode."
    },
    "Label": {
      "en": "OverlayMode",
      "zh-cn": "覆盖模式"
    }
  }
  EOT
}

variable "vpn_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the VPN Gateway."
    },
    "Label": {
      "en": "VpnGatewayId",
      "zh-cn": "VPN网关的ID"
    }
  }
  EOT
}

variable "next_hop" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The next hop of the destination route entry."
    },
    "Label": {
      "en": "NextHop",
      "zh-cn": "策略路由的下一跳"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Policy priority for policy routing. Range: 1-100 Default value: 10.\nThe smaller the policy priority number, the higher the priority of the policy route."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "策略路由原始的策略优先级"
    },
    "MaxValue": 100
  }
  EOT
}

variable "route_source" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source CIDR block of the policy-based route."
    },
    "Label": {
      "en": "RouteSource",
      "zh-cn": "策略路由的源网段"
    }
  }
  EOT
}

variable "publish_vpc" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether to publish the destination route to the VPC. Valid values:\ntrue: Publish the destination route to the VPC.\nfalse: Do not publish the destination route to the VPC."
    },
    "Label": {
      "en": "PublishVpc",
      "zh-cn": "是否发布策略路由到VPC"
    }
  }
  EOT
}

variable "weight" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The weight of the destination route. Valid values: 0|100."
    },
    "Label": {
      "en": "Weight",
      "zh-cn": "策略路由的权重值"
    }
  }
  EOT
}

resource "alicloud_vpn_pbr_route_entry" "vpn_pbr_route_entry" {
  route_dest     = var.route_dest
  vpn_gateway_id = var.vpn_gateway_id
  next_hop       = var.next_hop
  route_source   = var.route_source
  publish_vpc    = var.publish_vpc
  weight         = var.weight
}

output "route_dest" {
  value       = alicloud_vpn_pbr_route_entry.vpn_pbr_route_entry.route_dest
  description = "The destination CIDR block of the destination route."
}

output "vpn_gateway_id" {
  value       = alicloud_vpn_pbr_route_entry.vpn_pbr_route_entry.vpn_gateway_id
  description = "The ID of the VPN Gateway."
}

output "next_hop" {
  value       = alicloud_vpn_pbr_route_entry.vpn_pbr_route_entry.next_hop
  description = "The next hop of the destination route entry."
}

output "route_source" {
  value       = alicloud_vpn_pbr_route_entry.vpn_pbr_route_entry.route_source
  description = "The destination CIDR block of the policy-based route."
}

