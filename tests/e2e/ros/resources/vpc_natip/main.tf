variable "nat_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The NAT IP address that you want to create.\nIf you do not specify an IP address, the system selects a random IP address from the\nspecified CIDR block."
    },
    "Label": {
      "en": "NatIp",
      "zh-cn": "创建的NAT IP地址"
    }
  }
  EOT
}

variable "nat_ip_cidr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The CIDR block to which the NAT IP address belongs."
    },
    "Label": {
      "en": "NatIpCidr",
      "zh-cn": "创建NAT IP地址的地址段"
    }
  }
  EOT
}

variable "nat_ip_cidr_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CIDR block to which the NAT IP address belongs."
    },
    "Label": {
      "en": "NatIpCidrId",
      "zh-cn": "创建NAT IP地址的地址段实例ID"
    }
  }
  EOT
}

variable "nat_ip_description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The description of the NAT IP address.\nThe description must be 2 to 256 characters in length. It must start with a letter\nbut cannot start with http:// or https://."
    },
    "Label": {
      "en": "NatIpDescription",
      "zh-cn": "创建的NAT IP地址的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "nat_ip_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the NAT IP address.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods\n(.), underscores (_), and hyphens (-). It must start with a letter. It cannot start\nwith http:// or https://."
    },
    "Label": {
      "en": "NatIpName",
      "zh-cn": "创建的NAT IP地址的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

variable "nat_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Virtual Private Cloud (VPC) NAT gateway for which you want to create\nthe NAT IP address."
    },
    "Label": {
      "en": "NatGatewayId",
      "zh-cn": "NAT IP地址所属的VPC NAT网关实例ID"
    }
  }
  EOT
}

resource "alicloud_vpc_nat_ip" "vpcnat_ip" {
  nat_ip             = var.nat_ip
  nat_ip_cidr        = var.nat_ip_cidr
  nat_ip_cidr_id     = var.nat_ip_cidr_id
  nat_ip_description = var.nat_ip_description
  nat_ip_name        = var.nat_ip_name
  nat_gateway_id     = var.nat_gateway_id
}

output "nat_ip" {
  value       = alicloud_vpc_nat_ip.vpcnat_ip.nat_ip
  description = "NAT IP address."
}

output "nat_ip_id" {
  value       = alicloud_vpc_nat_ip.vpcnat_ip.id
  description = "The ID of the NAT IP address."
}

