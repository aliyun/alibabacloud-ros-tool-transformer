variable "opposite_interface_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Receiver RouterInterface ID to accept peer RouterInterface."
    },
    "Label": {
      "en": "OppositeInterfaceId",
      "zh-cn": "接收端路由器接口的ID"
    }
  }
  EOT
}

variable "router_interface_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Initiator RouterInterface ID to connect peer RouterInterface."
    },
    "Label": {
      "en": "RouterInterfaceId",
      "zh-cn": "发起端路由器接口的ID"
    }
  }
  EOT
}

resource "alicloud_router_interface_connection" "router_interface_connection" {
  opposite_interface_id = var.opposite_interface_id
  interface_id          = var.router_interface_id
}

output "opposite_interface_id" {
  value       = alicloud_router_interface_connection.router_interface_connection.opposite_interface_id
  description = "The receiver RouterInterface ID."
}

output "router_interface_id" {
  value       = alicloud_router_interface_connection.router_interface_connection.id
  description = "The initiator RouterInterface ID."
}

