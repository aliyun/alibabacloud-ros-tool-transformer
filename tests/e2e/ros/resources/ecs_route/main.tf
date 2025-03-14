variable "next_hop_type" {
  type        = string
  default     = "Instance"
  description = <<EOT
  {
    "Description": {
      "en": "The next hop type. Now support 'Instance|HaVip|RouterInterface|NetworkInterface|VpnGateway|IPv6Gateway|NatGateway|Attachment'. The default value is Instance.When the NextHopList is specified, the value will be ignored."
    },
    "Label": {
      "en": "NextHopType",
      "zh-cn": "自定义路由条目的下一跳类型"
    }
  }
  EOT
}

variable "route_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "RouteTableId of created route entry."
    },
    "Label": {
      "en": "RouteTableId",
      "zh-cn": "路由表ID"
    }
  }
  EOT
}

variable "next_hop_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The route entry's next hop. When the NextHopList is specified, the value will be ignored."
    },
    "Label": {
      "en": "NextHopId",
      "zh-cn": "自定义路由条目的下一跳实例ID"
    }
  }
  EOT
}

variable "next_hop_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "NextHopType": {
          "Type": "String",
          "Description": {
            "en": "Route entry next hop type. Now support 'RouterInterface'."
          },
          "Required": false,
          "Label": {
            "en": "NextHopType",
            "zh-cn": "ECMP路由条目的下一跳的类型"
          },
          "Default": "RouterInterface"
        },
        "NextHopId": {
          "Type": "String",
          "Description": {
            "en": "Route entry next hop Instance id or Tunnel id."
          },
          "Required": true,
          "Label": {
            "en": "NextHopId",
            "zh-cn": "ECMP路由条目的下一跳实例的ID"
          }
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The route entry's next hop list. If router is virtual border router, the value will be ignore. The list should contain 2-4 next hop. NextHopId of each next hop must be RouterInterface that VRouter forwards to VBR."
    },
    "Label": {
      "en": "NextHopList",
      "zh-cn": "自定义路由条目的下一跳的列表"
    }
  }
  EOT
}

variable "destination_cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The RouteEntry's target network segment."
    },
    "Label": {
      "en": "DestinationCidrBlock",
      "zh-cn": "自定义路由条目的目标网段"
    }
  }
  EOT
}

resource "alicloud_route_entry" "route_entry" {
  nexthop_type          = var.next_hop_type
  route_table_id        = var.route_table_id
  nexthop_id            = var.next_hop_id
  destination_cidrblock = var.destination_cidr_block
}

output "route_entry_id" {
  value       = alicloud_route_entry.route_entry.id
  description = "The ID of the route entry."
}

