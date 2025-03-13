variable "cen_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CEN instance."
    },
    "Label": {
      "en": "CenId",
      "zh-cn": "云企业网实例的ID"
    }
  }
  EOT
}

variable "cen_bandwidth_package_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the bandwidth package."
    },
    "Label": {
      "en": "CenBandwidthPackageId",
      "zh-cn": "带宽包的ID"
    }
  }
  EOT
}

resource "alicloud_cen_bandwidth_package_attachment" "cen_bandwidth_package_association" {
  instance_id          = var.cen_id
  bandwidth_package_id = var.cen_bandwidth_package_id
}

