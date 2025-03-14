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
      "zh-cn": "企业版转发路由器路由表ID"
    }
  }
  EOT
}

variable "transit_router_attachment_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterAttachmentId"
    },
    "Label": {
      "en": "TransitRouterAttachmentId",
      "zh-cn": "网络实例连接ID"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_route_table_association" "centransit_router_route_table_association" {
  transit_router_route_table_id = var.transit_router_route_table_id
  transit_router_attachment_id  = var.transit_router_attachment_id
}

output "transit_router_route_table_id" {
  value       = alicloud_cen_transit_router_route_table_association.centransit_router_route_table_association.transit_router_route_table_id
  description = "TransitRouterRouteTableId"
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_transit_router_route_table_association.centransit_router_route_table_association.transit_router_attachment_id
  description = "TransitRouterAttachmentId"
}

output "resource_id" {
  // Could not transform ROS Attribute ResourceId to Terraform attribute.
  value       = null
  description = "ResourceId"
}

output "resource_type" {
  // Could not transform ROS Attribute ResourceType to Terraform attribute.
  value       = null
  description = "ResourceType"
}

