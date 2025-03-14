variable "comparison_operator" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Comparison Operator"
    },
    "AllowedValues": [
      ">=",
      "<=",
      ">",
      "<"
    ],
    "Label": {
      "en": "ComparisonOperator",
      "zh-cn": "报警比较符"
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
      "en": "Description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述"
    }
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the scaling group."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩组ID"
    }
  }
  EOT
}

variable "metric_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Metric Type"
    },
    "AllowedValues": [
      "system",
      "custom"
    ],
    "Label": {
      "en": "MetricType",
      "zh-cn": "标准类型"
    }
  }
  EOT
}

variable "evaluation_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Evaluation Count",
      "zh-cn": "连续探测几次都满足阈值条件时报警，默认3次。"
    },
    "MinValue": 1,
    "Label": {
      "en": "EvaluationCount",
      "zh-cn": "连续探测几次都满足阈值条件时报警"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Period",
      "zh-cn": "查询指标的周期，必须与定义的metric一致，默认300，单位为秒。"
    },
    "AllowedValues": [
      60,
      120,
      300,
      900
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "查询指标的周期"
    }
  }
  EOT
}

variable "dimensions" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DimensionValue": {
          "Type": "String",
          "Description": {
            "en": "DimensionValue"
          },
          "Required": true
        },
        "DimensionKey": {
          "Type": "String",
          "Description": {
            "en": "DimensionKey"
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Dimensions"
    },
    "Label": {
      "en": "Dimensions",
      "zh-cn": "报警规则对应实例列表"
    },
    "MinLength": 1
  }
  EOT
}

variable "statistics" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Statistics",
      "zh-cn": "统计方法，必须与定义的metric一致，例如Average。"
    },
    "AllowedValues": [
      "Average",
      "Minimum",
      "Maximum"
    ],
    "Label": {
      "en": "Statistics",
      "zh-cn": "统计方法"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "报警规则名称"
    }
  }
  EOT
}

variable "group_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Group Id"
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "组ID"
    }
  }
  EOT
}

variable "metric_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Metric Name",
      "zh-cn": "相应产品对应的监控项名称，参考各产品metric定义。"
    },
    "Label": {
      "en": "MetricName",
      "zh-cn": "相应产品对应的监控项名称"
    }
  }
  EOT
}

variable "alarm_action" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Alarm Action"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Alarm Actions"
    },
    "Label": {
      "en": "AlarmAction",
      "zh-cn": "报警动作列表"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "threshold" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Threshold",
      "zh-cn": "报警阈值，目前只开放数值类型功能。"
    },
    "Label": {
      "en": "Threshold",
      "zh-cn": "报警阈值"
    }
  }
  EOT
}

resource "alicloud_ess_alarm" "alarm_task" {
  comparison_operator    = var.comparison_operator
  description            = var.description
  scaling_group_id       = var.scaling_group_id
  metric_type            = var.metric_type
  evaluation_count       = var.evaluation_count
  period                 = var.period
  dimensions             = var.dimensions
  statistics             = var.statistics
  name                   = var.name
  cloud_monitor_group_id = var.group_id
  metric_name            = var.metric_name
  alarm_actions          = var.alarm_action
  threshold              = var.threshold
}

output "alarm_task_id" {
  value       = alicloud_ess_alarm.alarm_task.id
  description = "The alarm task ID"
}

