variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "InstanceId"
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "virtual_host" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the virtual host."
    },
    "Label": {
      "en": "VirtualHost",
      "zh-cn": "Vhost名称"
    },
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_amqp_virtual_host" "amqpvirtual_host" {
  instance_id = var.instance_id
}

output "virtual_host" {
  value       = alicloud_amqp_virtual_host.amqpvirtual_host.virtual_host_name
  description = "The name of the virtual host."
}

