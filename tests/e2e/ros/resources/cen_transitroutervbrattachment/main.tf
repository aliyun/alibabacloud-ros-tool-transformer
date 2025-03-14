variable "auto_publish_route_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "AutoPublishRouteEnabled"
    },
    "Label": {
      "en": "AutoPublishRouteEnabled",
      "zh-cn": "企业版转发路由器是否自动发布路由到VBR实例"
    }
  }
  EOT
}

variable "vbr_owner_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "VbrOwnerId"
    },
    "Label": {
      "en": "VbrOwnerId",
      "zh-cn": "VBR实例所属阿里云账号ID"
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
      "zh-cn": "VBR连接名称"
    }
  }
  EOT
}

variable "vbr_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "VbrId"
    },
    "Label": {
      "en": "VbrId",
      "zh-cn": "VBR实例ID"
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
      "zh-cn": "VBR连接描述"
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
      "zh-cn": "企业版转发路由器实例ID"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_vbr_attachment" "centransit_router_vbr_attachment" {
  auto_publish_route_enabled            = var.auto_publish_route_enabled
  vbr_owner_id                          = var.vbr_owner_id
  cen_id                                = var.cen_id
  transit_router_attachment_name        = var.transit_router_attachment_name
  vbr_id                                = var.vbr_id
  transit_router_attachment_description = var.transit_router_attachment_description
  transit_router_id                     = var.transit_router_id
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.transit_router_attachment_id
  description = "The first ID of the resource"
}

output "auto_publish_route_enabled" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.auto_publish_route_enabled
  description = "AutoPublishRouteEnabled"
}

output "vbr_owner_id" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.vbr_owner_id
  description = "VbrOwnerId"
}

output "cen_id" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.cen_id
  description = "CenId"
}

output "transit_router_attachment_name" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.transit_router_attachment_name
  description = "TransitRouterAttachmentName"
}

output "resource_type" {
  // Could not transform ROS Attribute ResourceType to Terraform attribute.
  value       = null
  description = "ResourceType"
}

output "vbr_id" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.vbr_id
  description = "VbrId"
}

output "client_token" {
  // Could not transform ROS Attribute ClientToken to Terraform attribute.
  value       = null
  description = "ClientToken"
}

output "transit_router_attachment_description" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.transit_router_attachment_description
  description = "TransitRouterAttachmentDescription"
}

output "transit_router_id" {
  value       = alicloud_cen_transit_router_vbr_attachment.centransit_router_vbr_attachment.transit_router_id
  description = "TransitRouterId"
}

