variable "isp_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The line type of the elastic IP address (EIP) in the acceleration region. Valid values:\nBGP (default): BGP (Multi-ISP) lines.\nBGP_PRO: BGP (Multi-ISP) Pro lines.\nValid values if you are allowed to use single-ISP bandwidth:\nChinaTelecom\nChinaUnicom\nChinaMobile\nChinaTelecom_L2\nChinaUnicom_L2\nChinaMobile_L2"
    },
    "AllowedValues": [
      "BGP",
      "BGP_PRO",
      "ChinaTelecom",
      "ChinaUnicom",
      "ChinaMobile",
      "ChinaTelecom_L2",
      "ChinaUnicom_L2",
      "ChinaMobile_L2"
    ],
    "Label": {
      "en": "IspType",
      "zh-cn": "加速地域公网线路类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth that you want to allocate to the acceleration region. Unit: Mbit/s.You must allocate at least 2 Mbit/s of bandwidth to the acceleration region."
    },
    "MinValue": 2,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "加速地域带宽"
    }
  }
  EOT
}

variable "accelerate_region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the acceleration region."
    },
    "Label": {
      "en": "AccelerateRegionId",
      "zh-cn": "要加速的地域ID"
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

resource "alicloud_ga_basic_ip_set" "extension_resource" {
  isp_type             = var.isp_type
  bandwidth            = var.bandwidth
  accelerate_region_id = var.accelerate_region_id
  accelerator_id       = var.accelerator_id
}

output "ip_set_id" {
  value       = alicloud_ga_basic_ip_set.extension_resource.id
  description = "The ID of the acceleration region."
}

