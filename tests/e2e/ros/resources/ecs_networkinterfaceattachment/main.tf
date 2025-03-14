variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "ECS instance id"
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "trunk_network_instance_id" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "TrunkNetworkInstanceId",
      "zh-cn": "Trunk网卡ID"
    }
  }
  EOT
}

variable "ecs_restart_option" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Control whether to restart the ECS instance when binding an elastic network card.Only effective for ENI that does not support hot swapping."
    },
    "AllowedValues": [
      "Auto",
      "NotRestart",
      "Restart"
    ],
    "Label": {
      "en": "EcsRestartOption",
      "zh-cn": "控制绑定弹性网卡时是否重启ECS实例"
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

resource "alicloud_ecs_network_interface_attachment" "eni_attachment" {
  instance_id               = var.instance_id
  trunk_network_instance_id = var.trunk_network_instance_id
  network_interface_id      = var.network_interface_id
}

output "trunk_network_instance_id" {
  value       = alicloud_ecs_network_interface_attachment.eni_attachment.trunk_network_instance_id
  description = "ID of Trunk Network Interface."
}

output "instance_id" {
  value       = alicloud_ecs_network_interface_attachment.eni_attachment.instance_id
  description = "ID of ECS instance."
}

output "network_interface_id" {
  value       = alicloud_ecs_network_interface_attachment.eni_attachment.network_interface_id
  description = "ID of your Network Interface."
}

