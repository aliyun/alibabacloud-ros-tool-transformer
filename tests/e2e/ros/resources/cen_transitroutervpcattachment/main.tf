variable "route_table_association_enabled" {
  type        = bool
  description = <<EOT
  {
    "Label": {
      "en": "RouteTableAssociationEnabled",
      "zh-cn": "是否启动路由关联转发关系"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete related resources, like vpc route entry, route table association, route propagation."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除VPC连接"
    }
  }
  EOT
}

variable "auto_create_vpc_route" {
  type        = bool
  description = <<EOT
  {
    "Label": {
      "en": "AutoCreateVpcRoute",
      "zh-cn": "是否自动创建VPC路由条目"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VpcId"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "VPC实例ID"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费方式"
    }
  }
  EOT
}

variable "route_table_propagation_enabled" {
  type        = bool
  description = <<EOT
  {
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
      "zh-cn": "VPC连接的名称"
    }
  }
  EOT
}

variable "zone_mappings" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "ZoneId"
          },
          "Required": true
        },
        "VSwitchId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}",
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
          "Type": "String",
          "Description": {
            "en": "VSwitchId"
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "ZoneMappingss",
      "zh-cn": "企业版转发路由器的主可用区和备可用区，您需要分别在企业版转发路由器的主备可用区中选择一个交换机实例。"
    },
    "Label": {
      "en": "ZoneMappings",
      "zh-cn": "企业版转发路由器的主可用区和备可用区"
    },
    "MaxLength": 3
  }
  EOT
}

variable "vpc_owner_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "VpcOwnerId"
    },
    "Label": {
      "en": "VpcOwnerId",
      "zh-cn": "VPC实例所属账号ID"
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
      "zh-cn": "VPC连接的描述信息"
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

resource "alicloud_cen_transit_router_vpc_attachment" "centransit_router_vpc_attachment" {
  route_table_association_enabled       = var.route_table_association_enabled
  vpc_id                                = var.vpc_id
  payment_type                          = var.charge_type
  route_table_propagation_enabled       = var.route_table_propagation_enabled
  cen_id                                = var.cen_id
  transit_router_attachment_name        = var.transit_router_attachment_name
  zone_mappings                         = var.zone_mappings
  vpc_owner_id                          = var.vpc_owner_id
  transit_router_attachment_description = var.transit_router_attachment_description
  transit_router_id                     = var.transit_router_id
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.transit_router_attachment_id
  description = "The first ID of the resource"
}

output "vpc_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.vpc_id
  description = "VpcId"
}

output "cen_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.cen_id
  description = "CenId"
}

output "transit_router_attachment_name" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.transit_router_attachment_name
  description = "TransitRouterAttachmentName"
}

output "resource_type" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.resource_type
  description = "ResourceType"
}

output "client_token" {
  // Could not transform ROS Attribute ClientToken to Terraform attribute.
  value       = null
  description = "ClientToken"
}

output "vpc_owner_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.vpc_owner_id
  description = "VpcOwnerId"
}

output "transit_router_attachment_description" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.transit_router_attachment_description
  description = "TransitRouterAttachmentDescription"
}

output "transit_router_id" {
  value       = alicloud_cen_transit_router_vpc_attachment.centransit_router_vpc_attachment.transit_router_id
  description = "TransitRouterId"
}

