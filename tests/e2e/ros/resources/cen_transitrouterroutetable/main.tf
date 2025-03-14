variable "transit_router_route_table_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteTableDescription"
    },
    "Label": {
      "en": "TransitRouterRouteTableDescription",
      "zh-cn": "自定义路由表的描述信息"
    }
  }
  EOT
}

variable "transit_router_route_table_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterRouteTableName"
    },
    "Label": {
      "en": "TransitRouterRouteTableName",
      "zh-cn": "自定义路由表名称"
    }
  }
  EOT
}

variable "transit_router_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterId"
    },
    "Label": {
      "en": "TransitRouterId",
      "zh-cn": "企业版转发路由器实例ID"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_route_table" "centransit_router_route_table" {
  transit_router_route_table_description = var.transit_router_route_table_description
  transit_router_route_table_name        = var.transit_router_route_table_name
  transit_router_id                      = var.transit_router_id
}

output "transit_router_route_table_id" {
  value       = alicloud_cen_transit_router_route_table.centransit_router_route_table.id
  description = "TransitRouterRouteTableId"
}

output "transit_router_route_table_type" {
  value       = alicloud_cen_transit_router_route_table.centransit_router_route_table.transit_router_route_table_type
  description = "TransitRouterRouteTableType"
}

output "transit_router_route_table_description" {
  value       = alicloud_cen_transit_router_route_table.centransit_router_route_table.transit_router_route_table_description
  description = "TransitRouterRouteTableDescription"
}

output "transit_router_route_table_name" {
  value       = alicloud_cen_transit_router_route_table.centransit_router_route_table.transit_router_route_table_name
  description = "TransitRouterRouteTableName"
}

output "client_token" {
  // Could not transform ROS Attribute ClientToken to Terraform attribute.
  value       = null
  description = "ClientToken"
}

output "transit_router_id" {
  value       = alicloud_cen_transit_router_route_table.centransit_router_route_table.transit_router_id
  description = "TransitRouterId"
}

