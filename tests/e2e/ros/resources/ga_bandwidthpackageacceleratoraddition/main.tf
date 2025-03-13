variable "bandwidth_package_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the bandwidth package to associate."
    },
    "Label": {
      "en": "BandwidthPackageId",
      "zh-cn": "与全球加速实例绑定的带宽包的ID"
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
      "en": "The ID of the Global Accelerator instance with which you want to associate the bandwidth\nplan."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "要与带宽包绑定的全球加速实例的ID"
    }
  }
  EOT
}

resource "alicloud_ga_bandwidth_package_attachment" "bandwidth_package_accelerator_addition" {
  bandwidth_package_id = var.bandwidth_package_id
  accelerator_id       = var.accelerator_id
}

output "bandwidth_package_id" {
  value       = alicloud_ga_bandwidth_package_attachment.bandwidth_package_accelerator_addition.id
  description = "The ID of the bandwidth package which is associated"
}

output "accelerator_id" {
  value       = alicloud_ga_bandwidth_package_attachment.bandwidth_package_accelerator_addition.accelerator_id
  description = "The ID of the Global Accelerator instance"
}

