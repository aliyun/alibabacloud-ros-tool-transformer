variable "process_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the process."
    },
    "Label": {
      "en": "ProcessName",
      "zh-cn": "进程名称"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "process_user" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The user who launched the process."
    },
    "Label": {
      "en": "ProcessUser",
      "zh-cn": "执行进程的用户"
    }
  }
  EOT
}

resource "alicloud_cloud_monitor_service_group_monitoring_agent_process" "monitoring_agent_process" {
  process_name = var.process_name
}

