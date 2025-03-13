variable "dashboard_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Dashboard name."
    },
    "Label": {
      "en": "DashboardName",
      "zh-cn": "仪表盘ID"
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
      "en": "Dashboard description."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "仪表盘描述"
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
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "display_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Dashboard display name."
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "仪表盘显示名称"
    },
    "MinLength": 1
  }
  EOT
}

variable "charts" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {},
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Chart list."
    },
    "Label": {
      "en": "Charts",
      "zh-cn": "统计图表列表"
    },
    "MinLength": 1
  }
  EOT
}

resource "alicloud_log_dashboard" "dashboard" {
  dashboard_name = var.dashboard_name
  project_name   = var.project_name
  display_name   = var.display_name
}

output "dashboard_name" {
  value       = alicloud_log_dashboard.dashboard.id
  description = "Dashboard name."
}

output "display_name" {
  value       = alicloud_log_dashboard.dashboard.display_name
  description = "Display name."
}

