variable "bandwidth_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Bandwidth allocation mode. Value: BandwidthPackage: Allocates bandwidth from the bandwidth package."
    },
    "Label": {
      "en": "BandwidthType",
      "zh-cn": "带宽的分配方式"
    }
  }
  EOT
}

variable "opposite_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the other interconnected region."
    },
    "Label": {
      "en": "OppositeRegionId",
      "zh-cn": "对端地域的ID"
    }
  }
  EOT
}

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

variable "bandwidth_limit" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth configured for the interconnected regions communication. Minimal value: 1"
    },
    "MinValue": 1,
    "Label": {
      "en": "BandwidthLimit",
      "zh-cn": "两个地域间互连带宽的峰值"
    }
  }
  EOT
}

variable "local_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the local region."
    },
    "Label": {
      "en": "LocalRegionId",
      "zh-cn": "本端地域的ID"
    }
  }
  EOT
}

resource "alicloud_cen_bandwidth_limit" "cen_bandwidth_limit" {
  instance_id     = var.cen_id
  bandwidth_limit = var.bandwidth_limit
}

