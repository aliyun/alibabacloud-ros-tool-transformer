variable "network_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the network. The name must meet the following requirements:\nThe name must be 2 to 128 characters in length.\nThe name must start with a letter but cannot start with http:// or https://.\nThe name can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "NetworkName",
      "zh-cn": "网络名称"
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
      "en": "The description of the network.\nThe description must be 2 to 256 characters in length. It must start with a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The CIDR block of the network. You can use one of the following CIDR blocks or their subnets as the CIDR block of the network:\n10.0.0.0/8 (default)\n172.16.0.0/12\n192.168.0.0/16"
    },
    "Label": {
      "en": "CidrBlock",
      "zh-cn": "网络的网段"
    }
  }
  EOT
}

variable "ens_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the edge node."
    },
    "Label": {
      "en": "EnsRegionId",
      "zh-cn": "ENS的节点ID"
    }
  }
  EOT
}

resource "alicloud_ens_network" "network" {
  network_name  = var.network_name
  description   = var.description
  cidr_block    = var.cidr_block
  ens_region_id = var.ens_region_id
}

output "network_id" {
  value       = alicloud_ens_network.network.id
  description = "The ID of the network."
}

