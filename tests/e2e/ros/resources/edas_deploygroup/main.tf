variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Group name, maximum length of 64."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "分组名称"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "app_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Application ID"
    },
    "Label": {
      "en": "AppId",
      "zh-cn": "应用ID"
    }
  }
  EOT
}

resource "alicloud_edas_deploy_group" "deploy_group" {
  group_name = var.group_name
  app_id     = var.app_id
}

output "group_name" {
  value       = alicloud_edas_deploy_group.deploy_group.group_name
  description = "Deploy group name"
}

output "app_id" {
  value       = alicloud_edas_deploy_group.deploy_group.app_id
  description = "Application ID"
}

output "id" {
  // Could not transform ROS Attribute Id to Terraform attribute.
  value       = null
  description = "Deploy group ID"
}

