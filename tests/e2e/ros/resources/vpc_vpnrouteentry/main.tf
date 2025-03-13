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
      "zh-cn": "VPN目的路由的描述信息"
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
      "zh-cn": "目的路由的目标网段"
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
      "zh-cn": "目的路由的下一跳"
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
      "zh-cn": "是否发布目的路由到VPC"
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
      "zh-cn": "目的路由的权重值"
    }
  }
  EOT
}

resource "alicloud_vpn_route_entry" "vpn_route_entry" {
  route_dest     = var.route_dest
  vpn_gateway_id = var.vpn_gateway_id
  next_hop       = var.next_hop
  publish_vpc    = var.publish_vpc
  weight         = var.weight
}

output "route_dest" {
  value       = alicloud_vpn_route_entry.vpn_route_entry.route_dest
  description = "The destination CIDR block of the destination route."
}

output "vpn_gateway_id" {
  value       = alicloud_vpn_route_entry.vpn_route_entry.vpn_gateway_id
  description = "The ID of the VPN Gateway."
}

output "next_hop" {
  value       = alicloud_vpn_route_entry.vpn_route_entry.next_hop
  description = "The next hop of the destination route entry."
}

