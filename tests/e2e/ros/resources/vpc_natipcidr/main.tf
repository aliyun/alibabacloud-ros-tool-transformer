variable "nat_ip_cidr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The NAT CIDR block that you want to associate with the NAT gateway.\nThe new CIDR block must meet the following conditions:\nThe NAT CIDR block must fall within 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16, or their subnets.\nThe subnet mask must be 16 to 32 bits in length.\nThe NAT CIDR block cannot overlap with the private CIDR block of the VPC to which the NAT gateway belongs. If you want to use other IP addresses from the private CIDR block of the VPC to provide NAT services, create a vSwitch and attach the vSwitch to another VPC NAT gateway.\nIf you want to use public IP addresses to provide NAT services, make sure that the public IP addresses fall within a customer CIDR block of the VPC to which the VPC NAT gateway belongs. For more information, see What is customer CIDR block?."
    },
    "Label": {
      "en": "NatIpCidr",
      "zh-cn": "创建的NAT IP地址段"
    }
  }
  EOT
}

variable "nat_ip_cidr_description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The description of the NAT CIDR block.\nThe description must be 2 to 256 characters in length and start with a letter. The description cannot start with http:// or https://."
    },
    "Label": {
      "en": "NatIpCidrDescription",
      "zh-cn": "NAT IP地址段的描述信息"
    }
  }
  EOT
}

variable "nat_ip_cidr_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the CIDR block.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). It must start with a letter. The name must start with a letter and cannot start with http:// or https://."
    },
    "Label": {
      "en": "NatIpCidrName",
      "zh-cn": "NAT IP地址段的名称"
    }
  }
  EOT
}

variable "nat_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Virtual Private Cloud (VPC) NAT gateway with which you want to associate the CIDR block."
    },
    "Label": {
      "en": "NatGatewayId",
      "zh-cn": "创建NAT IP地址段所属的VPC NAT网关实例ID"
    }
  }
  EOT
}

resource "alicloud_vpc_nat_ip_cidr" "vpcnat_ip_cidr" {
  nat_ip_cidr             = var.nat_ip_cidr
  nat_ip_cidr_description = var.nat_ip_cidr_description
  nat_ip_cidr_name        = var.nat_ip_cidr_name
  nat_gateway_id          = var.nat_gateway_id
}

output "nat_ip_cidr_id" {
  value       = alicloud_vpc_nat_ip_cidr.vpcnat_ip_cidr.id
  description = "The ID of the NAT CIDR block."
}

