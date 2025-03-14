variable "transit_router_attachment_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the network instance connection."
    },
    "Label": {
      "en": "TransitRouterAttachmentId",
      "zh-cn": "网络实例连接ID"
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
      "en": "The ID of the route table configured on the network instance."
    },
    "Label": {
      "en": "RouteTableId",
      "zh-cn": "网络实例的路由表ID"
    }
  }
  EOT
}

variable "cen_id" {
  type        = string
  nullable    = false
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

variable "destination_cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The destination CIDR block of the route."
    },
    "Label": {
      "en": "DestinationCidrBlock",
      "zh-cn": "路由条目的目标网段"
    }
  }
  EOT
}

resource "alicloud_cen_child_instance_route_entry_to_attachment" "child_instance_route_entry_to_attachment" {
  transit_router_attachment_id = var.transit_router_attachment_id
  cen_id                       = var.cen_id
  destination_cidr_block       = var.destination_cidr_block
}

output "transit_router_attachment_id" {
  value       = alicloud_cen_child_instance_route_entry_to_attachment.child_instance_route_entry_to_attachment.transit_router_attachment_id
  description = "The ID of the network instance connection."
}

output "route_table_id" {
  // Could not transform ROS Attribute RouteTableId to Terraform attribute.
  value       = null
  description = "The ID of the route table configured on the network instance."
}

output "cen_id" {
  value       = alicloud_cen_child_instance_route_entry_to_attachment.child_instance_route_entry_to_attachment.cen_id
  description = "The ID of the CEN instance."
}

output "destination_cidr_block" {
  value       = alicloud_cen_child_instance_route_entry_to_attachment.child_instance_route_entry_to_attachment.destination_cidr_block
  description = "The destination CIDR block of the route."
}

