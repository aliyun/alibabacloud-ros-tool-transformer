variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the schedule."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "定时调度描述"
    }
  }
  EOT
}

variable "flow_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Flow name."
    },
    "Label": {
      "en": "FlowName",
      "zh-cn": "定时调度绑定的工作流名称"
    }
  }
  EOT
}

variable "enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether enable schedule."
    },
    "Label": {
      "en": "Enable",
      "zh-cn": "定时调度是否启用"
    }
  }
  EOT
}

variable "payload" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Payload."
    },
    "Label": {
      "en": "Payload",
      "zh-cn": "定时调度触发消息"
    }
  }
  EOT
}

variable "cron_expression" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cron expression."
    },
    "Label": {
      "en": "CronExpression",
      "zh-cn": "cron表达式"
    }
  }
  EOT
}

variable "schedule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Schedule name."
    },
    "Label": {
      "en": "ScheduleName",
      "zh-cn": "定时调度名称"
    }
  }
  EOT
}

resource "alicloud_fnf_schedule" "schedule" {
  description     = var.description
  flow_name       = var.flow_name
  enable          = var.enable
  payload         = var.payload
  cron_expression = var.cron_expression
  schedule_name   = var.schedule_name
}

output "flow_name" {
  value       = alicloud_fnf_schedule.schedule.flow_name
  description = "Flow name."
}

output "schedule_id" {
  value       = alicloud_fnf_schedule.schedule.schedule_id
  description = "Schedule Id"
}

output "schedule_name" {
  value       = alicloud_fnf_schedule.schedule.schedule_name
  description = "Schedule name."
}

