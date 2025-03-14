variable "editing_project_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the online editing project."
    },
    "Label": {
      "en": "EditingProjectName",
      "zh-cn": "在线编辑项目的名称"
    }
  }
  EOT
}

variable "timeline" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The timeline of the online editing project, in JSON format.\nIf you do not specify this parameter, an empty timeline is created and the duration of the online editing project is zero."
    },
    "Label": {
      "en": "Timeline",
      "zh-cn": "云剪辑工程时间线"
    }
  }
  EOT
}

variable "title" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The title of the online editing project."
    },
    "Label": {
      "en": "Title",
      "zh-cn": "云剪辑工程标题"
    }
  }
  EOT
}

resource "alicloud_vod_editing_project" "extension_resource" {
  editing_project_name = var.editing_project_name
  timeline             = var.timeline
  title                = var.title
}

output "editing_project_name" {
  value       = alicloud_vod_editing_project.extension_resource.editing_project_name
  description = "The name of the online editing project."
}

output "timeline" {
  value       = alicloud_vod_editing_project.extension_resource.timeline
  description = "The timeline of the online editing project."
}

output "modified_time" {
  // Could not transform ROS Attribute ModifiedTime to Terraform attribute.
  value       = null
  description = <<EOT
  "The last time when the online editing project was modified.\nThe time follows the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time is displayed in UTC."
  EOT
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = <<EOT
  "The time when the online editing project was created.\nThe time follows the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time is displayed in UTC."
  EOT
}

output "title" {
  value       = alicloud_vod_editing_project.extension_resource.title
  description = "The title of the online editing project."
}

output "editing_project_id" {
  value       = alicloud_vod_editing_project.extension_resource.id
  description = "The ID of the online editing project."
}

