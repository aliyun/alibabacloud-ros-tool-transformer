variable "address" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The URL or IP address monitored by the monitoring task."
    },
    "Label": {
      "en": "Address",
      "zh-cn": "监控任务的URL或IP地址"
    }
  }
  EOT
}

variable "options_json" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The extended options of the protocol that is used by the site monitoring task. The\noptions vary based on the protocol.",
      "zh-cn": "监控任务对应协议类型的高级扩展选项。不同监控任务的协议类型对应不同的扩展选项。"
    },
    "Label": {
      "en": "OptionsJson",
      "zh-cn": "监控任务对应协议类型的高级扩展选项"
    }
  }
  EOT
}

variable "task_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the site monitoring task. The name must be 4 to 100 characters in length.\nIt can contain letters, digits, and underscores (_)."
    },
    "Label": {
      "en": "TaskName",
      "zh-cn": "监控任务名称"
    }
  }
  EOT
}

variable "task_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The protocol used by the site monitoring task. Valid values: HTTP, HTTPS, PING, TCP,\nUDP, DNS, SMTP, POP3, and FTP."
    },
    "Label": {
      "en": "TaskType",
      "zh-cn": "监控任务类型"
    }
  }
  EOT
}

variable "isp_cities" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Isp": {
          "Type": "String",
          "Required": true
        },
        "City": {
          "Type": "String",
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The information about detection points, which is specified in a JSON array. Example:\n[{\"city\":\"546\",\"isp\":\"465\"},{\"city\":\"572\",\"isp\":\"465\"},{\"city\":\"738\",\"isp\":\"465\"}]. The three city codes represent Beijing, Hangzhou, and Qingdao.\nNote You can call the DescribeSiteMonitorISPCityList API operation to query the detection\npoints that can be used to create site monitoring tasks. For more information, see\nDescribeSiteMonitorISPCityList . If this parameter is not specified, the system randomly selects three detection\npoints for site monitoring."
    },
    "Label": {
      "en": "IspCities",
      "zh-cn": "探针信息"
    }
  }
  EOT
}

variable "interval" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The interval at which detection requests are sent. Valid values: 1, 5, and 15. Unit:\nminutes. Default value: 1."
    },
    "Label": {
      "en": "Interval",
      "zh-cn": "监控频率"
    }
  }
  EOT
}

variable "alert_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of the alert rule. The ID of an existing alert rule to be associated with the\nsite monitoring task. You can call the DescribeMetricRuleList API operation to query\nthe IDs of existing alert rules. For more information, see DescribeMetricRuleList."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "AlertIds",
      "zh-cn": "报警规则ID"
    }
  }
  EOT
}

resource "alicloud_cms_site_monitor" "site_monitor" {
  address      = var.address
  options_json = var.options_json
  task_name    = var.task_name
  task_type    = var.task_type
  isp_cities   = var.isp_cities
  interval     = var.interval
  alert_ids    = var.alert_ids
}

output "task_id" {
  // Could not transform ROS Attribute TaskId to Terraform attribute.
  value       = null
  description = "The ID of the site monitoring task."
}

