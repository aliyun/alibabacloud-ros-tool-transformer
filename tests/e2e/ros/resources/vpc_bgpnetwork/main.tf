variable "dst_cidr_block" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The CIDR block of the virtual private cloud (VPC) or vSwitch that you want to connect\nto a data center."
    },
    "Label": {
      "en": "DstCidrBlock",
      "zh-cn": "需要和本地数据中心（IDC）互连的VPC或交换机的网段"
    }
  }
  EOT
}

variable "router_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the vRouter associated with the router interface."
    },
    "Label": {
      "en": "RouterId",
      "zh-cn": "路由器接口关联的路由器ID"
    }
  }
  EOT
}

resource "alicloud_vpc_bgp_network" "bgp_network" {
  dst_cidr_block = var.dst_cidr_block
  router_id      = var.router_id
}

output "dst_cidr_block" {
  value       = alicloud_vpc_bgp_network.bgp_network.dst_cidr_block
  description = <<EOT
  "The CIDR block of the virtual private cloud (VPC) or vSwitch that you want to connect\nto a data center."
  EOT
}

output "router_id" {
  value       = alicloud_vpc_bgp_network.bgp_network.id
  description = "The ID of the vRouter associated with the router interface."
}

