variable "peer_gateway_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IP address of the peer router interface of the VBR.\nOnly the owner of the VBR can set or modify the value.\nThis parameter is required when you create a VBR for the owner of the physical connection.\nYou can ignore this parameter when you create a VBR for another Alibaba Cloud account."
    },
    "Label": {
      "en": "PeerGatewayIp",
      "zh-cn": "VBR的客户侧互联IP"
    }
  }
  EOT
}

variable "local_gateway_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IP address of the VBR on the Alibaba Cloud side."
    },
    "Label": {
      "en": "LocalGatewayIp",
      "zh-cn": "VBR的阿里云侧互联IP"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the VBR.\nThe description must be 2 to 256 characters in length. It must start with a letter\nbut cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "VBR的描述信息"
    }
  }
  EOT
}

variable "circuit_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The circuit code provided by the Internet service provider (ISP) for the physical\nconnection.\nNote Only the owner of the physical connection can set this parameter."
    },
    "Label": {
      "en": "CircuitCode",
      "zh-cn": "运营商为物理专线提供的电路编码"
    }
  }
  EOT
}

variable "physical_connection_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the physical connection."
    },
    "Label": {
      "en": "PhysicalConnectionId",
      "zh-cn": "物理专线实例ID"
    }
  }
  EOT
}

variable "peering_subnet_mask" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The subnet mask for the IP addresses of the VBR on the Alibaba Cloud side and on the\nuser side.\nThe two IP addresses must fall within the same subnet."
    },
    "Label": {
      "en": "PeeringSubnetMask",
      "zh-cn": "VBR的阿里云侧和客户侧互联IP的子网掩码"
    }
  }
  EOT
}

variable "vlan_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The VLAN ID of the VBR. Valid values: 0 to 2999.\nNote Only the owner of the physical connection can set this parameter. The VLAN IDs of\ntwo VBRs of the same physical connection must be different."
    },
    "MinValue": 0,
    "Label": {
      "en": "VlanId",
      "zh-cn": "VBR的VLAN ID"
    },
    "MaxValue": 2999
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the VBR.\nThe name must be 2 to 128 characters in length, and can contain, digits, periods (.),\nunderscores (_), and hyphens (-). The name cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "VBR的名称"
    }
  }
  EOT
}

resource "alicloud_express_connect_virtual_border_router" "virtual_border_router" {
  peer_gateway_ip        = var.peer_gateway_ip
  local_gateway_ip       = var.local_gateway_ip
  description            = var.description
  circuit_code           = var.circuit_code
  physical_connection_id = var.physical_connection_id
  peering_subnet_mask    = var.peering_subnet_mask
  vlan_id                = var.vlan_id
}

output "route_table_id" {
  value       = alicloud_express_connect_virtual_border_router.virtual_border_router.route_table_id
  description = "The ID of the route table of the VBR."
}

output "vlan_interface_id" {
  // Could not transform ROS Attribute VlanInterfaceId to Terraform attribute.
  value       = null
  description = "The ID of the VBR interface."
}

output "vbr_id" {
  value       = alicloud_express_connect_virtual_border_router.virtual_border_router.id
  description = "The ID of the VBR."
}

output "name" {
  // Could not transform ROS Attribute Name to Terraform attribute.
  value       = null
  description = "The name of the VBR."
}

