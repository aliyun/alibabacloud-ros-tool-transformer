variable "ipv4_gateway_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Resource name."
    },
    "Label": {
      "en": "Ipv4GatewayName",
      "zh-cn": "创建的IPv4网关的名称"
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
      "en": "The ID of the VPC associated with the IPv4 Gateway."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "创建的IPv4网关所在VPC的ID"
    }
  }
  EOT
}

variable "ipv4_gateway_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description information."
    },
    "Label": {
      "en": "Ipv4GatewayDescription",
      "zh-cn": "创建的IPv4网关的描述信息"
    }
  }
  EOT
}

resource "alicloud_vpc_ipv4_gateway" "extension_resource" {
  ipv4_gateway_name        = var.ipv4_gateway_name
  vpc_id                   = var.vpc_id
  ipv4_gateway_description = var.ipv4_gateway_description
}

output "ipv4_gateway_name" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.ipv4_gateway_name
  description = "Resource name."
}

output "ipv4_gateway_route_table_id" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.ipv4_gateway_route_table_id
  description = "ID of the route table associated with IPv4 Gateway."
}

output "ipv4_gateway_id" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.id
  description = "The resource attribute field that represents the resource level 1 ID."
}

output "vpc_id" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.vpc_id
  description = "The ID of the VPC associated with the IPv4 Gateway."
}

output "create_time" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.create_time
  description = "The creation time of the resource."
}

output "ipv4_gateway_description" {
  value       = alicloud_vpc_ipv4_gateway.extension_resource.ipv4_gateway_description
  description = "Description information."
}

