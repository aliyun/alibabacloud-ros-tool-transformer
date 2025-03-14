variable "transit_router_route_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteTableId"
    },
    "Label": {
      "en": "TransitRouterRouteTableId",
      "zh-cn": "企业版转发路由器的路由表ID"
    }
  }
  EOT
}

variable "transit_router_route_entry_destination_cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteEntryDestinationCidrBlock"
    },
    "Label": {
      "en": "TransitRouterRouteEntryDestinationCidrBlock",
      "zh-cn": "路由条目的目标网段"
    }
  }
  EOT
}

variable "transit_router_route_entry_next_hop_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteEntryNextHopId"
    },
    "Label": {
      "en": "TransitRouterRouteEntryNextHopId",
      "zh-cn": "路由条目的下一跳所关联的网络实例连接ID"
    }
  }
  EOT
}

variable "transit_router_route_entry_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteEntryDescription"
    },
    "Label": {
      "en": "TransitRouterRouteEntryDescription",
      "zh-cn": "路由条目的描述"
    }
  }
  EOT
}

variable "transit_router_route_entry_next_hop_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteEntryNextHopType"
    },
    "Label": {
      "en": "TransitRouterRouteEntryNextHopType",
      "zh-cn": "路由条目的下一跳类型"
    }
  }
  EOT
}

variable "transit_router_route_entry_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteEntryName"
    },
    "Label": {
      "en": "TransitRouterRouteEntryName",
      "zh-cn": "路由条目的名称"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_route_entry" "centransit_router_route_entry" {
  transit_router_route_table_id                     = var.transit_router_route_table_id
  transit_router_route_entry_destination_cidr_block = var.transit_router_route_entry_destination_cidr_block
  transit_router_route_entry_next_hop_id            = var.transit_router_route_entry_next_hop_id
  transit_router_route_entry_description            = var.transit_router_route_entry_description
  transit_router_route_entry_next_hop_type          = var.transit_router_route_entry_next_hop_type
  transit_router_route_entry_name                   = var.transit_router_route_entry_name
}

output "transit_router_route_table_id" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_table_id
  description = "TransitRouterRouteTableId"
}

output "transit_router_route_entry_destination_cidr_block" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_entry_destination_cidr_block
  description = "TransitRouterRouteEntryDestinationCidrBlock"
}

output "transit_router_route_entry_next_hop_id" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_entry_next_hop_id
  description = "TransitRouterRouteEntryNextHopId"
}

output "transit_router_route_entry_type" {
  // Could not transform ROS Attribute TransitRouterRouteEntryType to Terraform attribute.
  value       = null
  description = "TransitRouterRouteEntryType"
}

output "transit_router_route_entry_description" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_entry_description
  description = "TransitRouterRouteEntryDescription"
}

output "transit_router_route_entry_next_hop_type" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_entry_next_hop_type
  description = "TransitRouterRouteEntryNextHopType"
}

output "transit_router_route_entry_name" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.transit_router_route_entry_name
  description = "TransitRouterRouteEntryName"
}

output "transit_router_route_entry_id" {
  value       = alicloud_cen_transit_router_route_entry.centransit_router_route_entry.id
  description = "The first ID of the resource"
}

