variable "auto_publish_route_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to allow forwarding router instances to automatically publish route entries to IPsec connections. Default is true."
    },
    "Label": {
      "en": "AutoPublishRouteEnabled",
      "zh-cn": "是否允许转发路由器实例自动向IPsec连接发布路由条目"
    }
  }
  EOT
}

variable "route_table_association_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable route association and forwarding relationship."
    },
    "Label": {
      "en": "RouteTableAssociationEnabled",
      "zh-cn": "是否启动路由关联转发关系"
    }
  }
  EOT
}

variable "vpn_owner_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Alibaba Cloud account (main account) ID to which the IPsec connection belongs."
    },
    "Label": {
      "en": "VpnOwnerId",
      "zh-cn": "IPsec连接所属的阿里云账号（主账号）ID"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to forcefully delete the VPN connection."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除VPN连接"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Availability zone ID in the current region."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "route_table_propagation_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable route learning relationships."
    },
    "Label": {
      "en": "RouteTablePropagationEnabled",
      "zh-cn": "是否启用路由学习关系"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CEN instance."
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
      "en": "The name of the VPN connection."
    },
    "Label": {
      "en": "TransitRouterAttachmentName",
      "zh-cn": "VPN连接的名称"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to TransitRouterVpnAttachment. Max support 20 tags to add during create TransitRouterVpnAttachment. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签信息列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "transit_router_attachment_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of the VPN connection."
    },
    "Label": {
      "en": "TransitRouterAttachmentDescription",
      "zh-cn": "VPN连接的描述信息"
    }
  }
  EOT
}

variable "transit_router_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Forwarding router instance ID"
    },
    "Label": {
      "en": "TransitRouterId",
      "zh-cn": "转发路由器实例ID"
    }
  }
  EOT
}

variable "vpn_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "IPsec connection ID"
    },
    "Label": {
      "en": "VpnId",
      "zh-cn": "IPsec连接ID"
    }
  }
  EOT
}

resource "alicloud_cen_transit_router_vpn_attachment" "transit_router_vpn_attachment" {
  auto_publish_route_enabled            = var.auto_publish_route_enabled
  vpn_owner_id                          = var.vpn_owner_id
  zone                                  = var.zone_id
  cen_id                                = var.cen_id
  transit_router_attachment_name        = var.transit_router_attachment_name
  tags                                  = var.tags
  transit_router_attachment_description = var.transit_router_attachment_description
  transit_router_id                     = var.transit_router_id
  vpn_id                                = var.vpn_id
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_transit_router_vpn_attachment.transit_router_vpn_attachment.id
  description = "The ID of the VPN connection."
}

