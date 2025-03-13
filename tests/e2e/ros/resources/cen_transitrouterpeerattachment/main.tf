variable "auto_publish_route_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "AutoPublishRouteEnabled"
    },
    "Label": {
      "en": "AutoPublishRouteEnabled",
      "zh-cn": "企业版转发路由器实例是否自动发布跨地域连接的路由到对端地域"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Bandwidth"
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "为跨地域连接分配的带宽"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
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

variable "transit_router_attachment_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterAttachmentName"
    },
    "Label": {
      "en": "TransitRouterAttachmentName",
      "zh-cn": "跨地域连接的名称"
    }
  }
  EOT
}

variable "peer_transit_router_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "PeerTransitRouterId"
    },
    "Label": {
      "en": "PeerTransitRouterId",
      "zh-cn": "对端转发路由器实例ID"
    }
  }
  EOT
}

variable "cen_bandwidth_package_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "BandwidthPackageId"
    },
    "Label": {
      "en": "CenBandwidthPackageId",
      "zh-cn": "跨地域连接要绑定的带宽包ID"
    }
  }
  EOT
}

variable "transit_router_attachment_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterAttachmentDescription"
    },
    "Label": {
      "en": "TransitRouterAttachmentDescription",
      "zh-cn": "跨地域连接的描述信息"
    }
  }
  EOT
}

variable "transit_router_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "TransitRouterId"
    },
    "Label": {
      "en": "TransitRouterId",
      "zh-cn": "本端企业版转发路由器实例ID"
    }
  }
  EOT
}

variable "peer_transit_router_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "PeerTransitRouterRegionId"
    },
    "Label": {
      "en": "PeerTransitRouterRegionId",
      "zh-cn": "对端转发路由器实例所属地域ID"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_peer_attachment" "centransit_router_peer_attachment" {
  auto_publish_route_enabled            = var.auto_publish_route_enabled
  bandwidth                             = var.bandwidth
  cen_id                                = var.cen_id
  transit_router_attachment_name        = var.transit_router_attachment_name
  peer_transit_router_id                = var.peer_transit_router_id
  cen_bandwidth_package_id              = var.cen_bandwidth_package_id
  transit_router_attachment_description = var.transit_router_attachment_description
  transit_router_id                     = var.transit_router_id
  peer_transit_router_region_id         = var.peer_transit_router_region_id
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.transit_router_attachment_id
  description = "The first ID of the resource"
}

output "geographic_span_id" {
  // Could not transform ROS Attribute GeographicSpanId to Terraform attribute.
  value       = null
  description = "GeographicSpanId"
}

output "peer_transit_router_owner_id" {
  // Could not transform ROS Attribute PeerTransitRouterOwnerId to Terraform attribute.
  value       = null
  description = "PeerTransitRouterOwnerId"
}

output "transit_router_attachment_name" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.transit_router_attachment_name
  description = "TransitRouterAttachmentName"
}

output "resource_type" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.resource_type
  description = "ResourceType"
}

output "auto_publish_route_enabled" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.auto_publish_route_enabled
  description = "AutoPublishRouteEnabled"
}

output "bandwidth" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.bandwidth
  description = "Bandwidth"
}

output "cen_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.cen_id
  description = "CenId"
}

output "peer_transit_router_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.peer_transit_router_id
  description = "PeerTransitRouterId"
}

output "client_token" {
  // Could not transform ROS Attribute ClientToken to Terraform attribute.
  value       = null
  description = "ClientToken"
}

output "cen_bandwidth_package_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.cen_bandwidth_package_id
  description = "BandwidthPackageId"
}

output "transit_router_attachment_description" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.transit_router_attachment_description
  description = "TransitRouterAttachmentDescription"
}

output "transit_router_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.transit_router_id
  description = "TransitRouterId"
}

output "peer_transit_router_region_id" {
  value       = alicloud_cen_transit_router_peer_attachment.centransit_router_peer_attachment.peer_transit_router_region_id
  description = "PeerTransitRouterRegionId"
}

