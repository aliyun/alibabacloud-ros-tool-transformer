variable "dhcp_options_set_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the DHCP options set.",
      "zh-cn": "DHCP选项集的ID。  关于DHCP选项集的更多信息，请参见DHCP选项集概述。"
    },
    "Label": {
      "en": "DhcpOptionsSetId",
      "zh-cn": "DHCP选项集的ID"
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
      "en": "The ID of the VPC network that is to be associated with the DHCP options set."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "DHCP选项集关联的VPC的ID"
    }
  }
  EOT
}

resource "alicloud_vpc_dhcp_options_set_attachment" "dhcp_options_set_attachment" {
  dhcp_options_set_id = var.dhcp_options_set_id
  vpc_id              = var.vpc_id
}

output "dhcp_options_set_id" {
  value       = alicloud_vpc_dhcp_options_set_attachment.dhcp_options_set_attachment.dhcp_options_set_id
  description = "The ID of the DHCP options set."
}

output "vpc_id" {
  value       = alicloud_vpc_dhcp_options_set_attachment.dhcp_options_set_attachment.vpc_id
  description = "The ID of the VPC network."
}

