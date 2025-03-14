variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the vSwitch.\nThe description must be 2 to 256 characters in length. It must start with a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "交换机的描述信息"
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
      "en": "The CIDR block of the vSwitch. Take note of the following limits:\nThe subnet mask must be 16 to 29 bits in length.\nThe CIDR block of the vSwitch must fall within the CIDR block of the VPC to which the vSwitch belongs.\nThe CIDR block of the vSwitch cannot be the same as the destination CIDR block in a route entry of the VPC. However, it can be a subset of the destination CIDR block."
    },
    "Label": {
      "en": "CidrBlock",
      "zh-cn": "交换机的网段"
    }
  }
  EOT
}

variable "vswitch_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the vSwitch. The name must meet the following requirements:\nThe name must be 2 to 128 characters in length.\nThe name must start with a letter and cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), and hyphens (-).\nDefault value: null."
    },
    "Label": {
      "en": "VSwitchName",
      "zh-cn": "交换机名称"
    }
  }
  EOT
}

variable "network_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the network to which the vSwitch that you want to create belongs."
    },
    "Label": {
      "en": "NetworkId",
      "zh-cn": "要创建的交换机所属的网络ID"
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
      "zh-cn": "ENS节点ID"
    }
  }
  EOT
}

resource "alicloud_ens_vswitch" "vswitch" {
  description   = var.description
  cidr_block    = var.cidr_block
  vswitch_name  = var.vswitch_name
  network_id    = var.network_id
  ens_region_id = var.ens_region_id
}

output "vswitch_id" {
  value       = alicloud_ens_vswitch.vswitch.id
  description = "The ID of the vSwitch."
}

