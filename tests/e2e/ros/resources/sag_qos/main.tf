variable "qos_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the QoS policy.\nThe name must be 2 to 100 characters in length and can contain letters, digits, periods\n(.), underscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "QosName",
      "zh-cn": "QoS策略实例的名称"
    }
  }
  EOT
}

variable "qos_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the QoS policy.\nThe description must be 1 to 512 characters in length and can contain letters, digits,\nunderscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "QosDescription",
      "zh-cn": "QoS策略实例的描述"
    }
  }
  EOT
}

resource "alicloud_sag_qos" "qos" {
  name = var.qos_name
}

output "qos_id" {
  value       = alicloud_sag_qos.qos.id
  description = "The ID of the QoS policy."
}

