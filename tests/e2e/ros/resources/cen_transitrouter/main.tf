variable "cen_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "CenId"
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例ID"
    }
  }
  EOT
}

variable "transit_router_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterDescription"
    },
    "Label": {
      "en": "TransitRouterDescription",
      "zh-cn": "转发路由器实例的描述"
    }
  }
  EOT
}

variable "transit_router_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterName"
    },
    "Label": {
      "en": "TransitRouterName",
      "zh-cn": "转发路由器实例的名称"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router" "centransit_router" {
  cen_id                     = var.cen_id
  transit_router_description = var.transit_router_description
  transit_router_name        = var.transit_router_name
}

output "type" {
  value       = alicloud_cen_transit_router.centransit_router.type
  description = "Type"
}

output "cen_id" {
  value       = alicloud_cen_transit_router.centransit_router.cen_id
  description = "CenId"
}

output "transit_router_description" {
  value       = alicloud_cen_transit_router.centransit_router.transit_router_description
  description = "TransitRouterDescription"
}

output "transit_router_name" {
  value       = alicloud_cen_transit_router.centransit_router.transit_router_name
  description = "TransitRouterName"
}

output "system_transit_router_route_table_id" {
  // Could not transform ROS Attribute SystemTransitRouterRouteTableId to Terraform attribute.
  value       = null
  description = "The system route table ID of transit router."
}

output "transit_router_id" {
  value       = alicloud_cen_transit_router.centransit_router.id
  description = "TransitRouterId"
}

output "ali_uid" {
  // Could not transform ROS Attribute AliUid to Terraform attribute.
  value       = null
  description = "AliUid"
}

