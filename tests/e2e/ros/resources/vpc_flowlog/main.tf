variable "flow_log_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The flow log name."
    },
    "Label": {
      "en": "FlowLogName",
      "zh-cn": "流日志名称"
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
      "en": "The Description of flow log."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "流日志的描述"
    }
  }
  EOT
}

variable "log_store_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The log store name."
    },
    "Label": {
      "en": "LogStoreName",
      "zh-cn": "存储捕获到的流量的日志库名称"
    }
  }
  EOT
}

variable "resource_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resource id."
    },
    "Label": {
      "en": "ResourceId",
      "zh-cn": "要捕获流量的资源ID"
    }
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The project name."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "存储捕获到的流量的日志项目名称"
    }
  }
  EOT
}

variable "resource_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resource type."
    },
    "Label": {
      "en": "ResourceType",
      "zh-cn": "要捕获流量的资源类型"
    }
  }
  EOT
}

variable "traffic_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The traffic type."
    },
    "Label": {
      "en": "TrafficType",
      "zh-cn": "采集的流量类型"
    }
  }
  EOT
}

resource "alicloud_cen_flowlog" "vpcflow_log" {
  flow_log_name  = var.flow_log_name
  description    = var.description
  log_store_name = var.log_store_name
  project_name   = var.project_name
}

output "flow_log_name" {
  value       = alicloud_cen_flowlog.vpcflow_log.flow_log_name
  description = "The flow log name."
}

output "description" {
  value       = alicloud_cen_flowlog.vpcflow_log.description
  description = "The Description of flow log."
}

output "log_store_name" {
  value       = alicloud_cen_flowlog.vpcflow_log.log_store_name
  description = "The log store name."
}

output "resource_id" {
  // Could not transform ROS Attribute ResourceId to Terraform attribute.
  value       = null
  description = "The resource id."
}

output "project_name" {
  value       = alicloud_cen_flowlog.vpcflow_log.project_name
  description = "The project name."
}

output "resource_type" {
  // Could not transform ROS Attribute ResourceType to Terraform attribute.
  value       = null
  description = "The resource type."
}

output "flow_log_id" {
  value       = alicloud_cen_flowlog.vpcflow_log.id
  description = "The flow log ID."
}

output "traffic_type" {
  // Could not transform ROS Attribute TrafficType to Terraform attribute.
  value       = null
  description = "The traffic type."
}

