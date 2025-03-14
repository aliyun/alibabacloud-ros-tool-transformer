variable "min_bandwidth_abs" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The minimum bandwidth. This parameter is required when LimitType is set to Absolute."
    },
    "Label": {
      "en": "MinBandwidthAbs",
      "zh-cn": "最小带宽"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the traffic throttling policy."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "QoS限速规则的描述"
    }
  }
  EOT
}

variable "max_bandwidth_percent" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum percentage that is based on the maximum upstream bandwidth of the SAG\ninstance.\nThis parameter is required when LimitType is set to Percent."
    },
    "Label": {
      "en": "MaxBandwidthPercent",
      "zh-cn": "最大带宽百分比"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the traffic throttling policy. A smaller value represents a higher\npriority. If policies are assigned the same priority, the one applied the earliest\nprevails. Valid values: 1 to 7."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "规则的优先级"
    },
    "MaxValue": 7
  }
  EOT
}

variable "max_bandwidth_abs" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum bandwidth. This parameter is required when LimitType is set to Absolute."
    },
    "Label": {
      "en": "MaxBandwidthAbs",
      "zh-cn": "最大带宽"
    }
  }
  EOT
}

variable "qos_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the QoS policy."
    },
    "Label": {
      "en": "QosId",
      "zh-cn": "QoS策略的实例ID"
    }
  }
  EOT
}

variable "percent_source_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If the policy throttles traffic based on a specified bandwidth percentage, the following\noptions are available:\nCcnBandwidth: Cloud Enterprise Network (CCN) bandwidth.\nInternetUpBandwidth: Internet upstream bandwidth."
    },
    "AllowedValues": [
      "CcnBandwidth",
      "InternetUpBandwidth"
    ],
    "Label": {
      "en": "PercentSourceType",
      "zh-cn": "按百分比限速时的带宽类型"
    }
  }
  EOT
}

variable "min_bandwidth_percent" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The minimum percentage that is based on the maximum upstream bandwidth of the SAG\ninstance.\nThis parameter is required when LimitType is set to Percent."
    },
    "Label": {
      "en": "MinBandwidthPercent",
      "zh-cn": "最小带宽百分比"
    }
  }
  EOT
}

variable "limit_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Absolute",
      "Percent"
    ],
    "Description": {
      "en": "The type of the traffic throttling policy. Valid values:\nAbsolute: throttles traffic by a specific bandwidth range.\nPercent: throttles traffic by a specific range of bandwidth percentage."
    },
    "Label": {
      "en": "LimitType",
      "zh-cn": "限速类型"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the traffic throttling policy. The name must be 2 to 128 characters in\nlength, and can contain Chinese characters, letters, digits, periods (.), underscores\n(_), and hyphens (-)."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "QoS限速规则名称"
    }
  }
  EOT
}

resource "alicloud_sag_qos_car" "qos_car" {
  min_bandwidth_abs     = var.min_bandwidth_abs
  description           = var.description
  max_bandwidth_percent = var.max_bandwidth_percent
  priority              = var.priority
  max_bandwidth_abs     = var.max_bandwidth_abs
  qos_id                = var.qos_id
  percent_source_type   = var.percent_source_type
  min_bandwidth_percent = var.min_bandwidth_percent
  limit_type            = var.limit_type
  name                  = var.name
}

output "qos_car_id" {
  value       = alicloud_sag_qos_car.qos_car.id
  description = "The ID of the traffic throttling policy."
}

