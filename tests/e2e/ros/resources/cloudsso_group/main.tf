variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the group.\nThe name can contain letters, digits, underscores (_), hyphens (-), and periods (.).\nThe name can be up to 128 characters in length."
    },
    "AllowedPattern": "^[a-zA-Z0-9._-]{1,128}$",
    "Label": {
      "en": "GroupName",
      "zh-cn": "用户组的名称"
    }
  }
  EOT
}

variable "directory_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the directory."
    },
    "Label": {
      "en": "DirectoryId",
      "zh-cn": "目录ID"
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
      "en": "The description of the group.\nThe description can be up to 1,024 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "用户组的描述"
    },
    "MaxLength": 1024
  }
  EOT
}

resource "alicloud_cloud_sso_group" "group" {
  group_name   = var.group_name
  directory_id = var.directory_id
  description  = var.description
}

output "group_id" {
  value       = alicloud_cloud_sso_group.group.group_id
  description = "The ID of the group."
}

