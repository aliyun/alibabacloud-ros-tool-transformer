variable "status" {
  type        = string
  default     = "ENABLE"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Allowed values: [ENABLE, DISABLE]"
    },
    "AllowedValues": [
      "DISABLE",
      "ENABLE"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "状态"
    }
  }
  EOT
}

variable "rr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Host record, if you want to resolve @.exmaple.com, the host record should fill in \"@\" instead of empty"
    },
    "Label": {
      "en": "Rr",
      "zh-cn": "主机记录"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "A",
      "AAAA",
      "CNAME",
      "TXT",
      "MX",
      "PTR",
      "SRV"
    ],
    "Description": {
      "en": "Analyze record type, currently only supports A, AAAA, CNAME, TXT, MX, PTR, SRV"
    },
    "Label": {
      "en": "Type",
      "zh-cn": "解析记录类型"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Zone Id"
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "PrivateZone ZoneID"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  default     = 10
  description = <<EOT
  {
    "Description": {
      "en": "MX record priority, value range [1,99]. Default to 10."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "MX记录的优先级"
    },
    "MaxValue": 99
  }
  EOT
}

variable "value" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Record value"
    },
    "Label": {
      "en": "Value",
      "zh-cn": "记录值"
    }
  }
  EOT
}

variable "ttl" {
  type        = number
  default     = 60
  description = <<EOT
  {
    "Description": {
      "en": "Survival time, default is 60"
    },
    "Label": {
      "en": "Ttl",
      "zh-cn": "生存时间"
    }
  }
  EOT
}

resource "alicloud_pvtz_zone_record" "zone_record" {
  status          = var.status
  resource_record = var.rr
  type            = var.type
  zone_id         = var.zone_id
  priority        = var.priority
  value           = var.value
  ttl             = var.ttl
}

output "zone_id" {
  value       = alicloud_pvtz_zone_record.zone_record.zone_id
  description = "Zone ID."
}

output "record" {
  // Could not transform ROS Attribute Record to Terraform attribute.
  value       = null
  description = "Record data."
}

output "record_id" {
  value       = alicloud_pvtz_zone_record.zone_record.record_id
  description = "Parsing record Id"
}

