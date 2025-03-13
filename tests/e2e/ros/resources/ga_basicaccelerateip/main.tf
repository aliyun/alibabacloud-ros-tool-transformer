variable "ip_set_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the acceleration region."
    },
    "Label": {
      "en": "IpSetId",
      "zh-cn": "基础型全球加速实例的加速地域实例ID"
    }
  }
  EOT
}

variable "accelerator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the basic GA instance."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "基础型全球加速实例ID"
    }
  }
  EOT
}

resource "alicloud_ga_basic_accelerate_ip" "extension_resource" {
  ip_set_id      = var.ip_set_id
  accelerator_id = var.accelerator_id
}

output "accelerate_ip_id" {
  value       = alicloud_ga_basic_accelerate_ip.extension_resource.id
  description = "The ID of the accelerated IP address."
}

