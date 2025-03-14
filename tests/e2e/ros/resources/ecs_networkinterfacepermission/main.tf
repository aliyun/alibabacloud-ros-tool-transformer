variable "account_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "the account id"
    },
    "Label": {
      "en": "AccountId",
      "zh-cn": "账号ID"
    }
  }
  EOT
}

variable "permission" {
  type        = string
  default     = "InstanceAttach"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "the permission"
    },
    "Label": {
      "en": "Permission",
      "zh-cn": "授权"
    }
  }
  EOT
}

variable "network_interface_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Network interface id"
    },
    "Label": {
      "en": "NetworkInterfaceId",
      "zh-cn": "弹性网卡ID"
    }
  }
  EOT
}

resource "alicloud_ecs_network_interface_permission" "eni_permission" {
  account_id           = var.account_id
  permission           = var.permission
  network_interface_id = var.network_interface_id
}

output "network_interface_permission_id" {
  value       = alicloud_ecs_network_interface_permission.eni_permission.id
  description = "the network interface permission id"
}

