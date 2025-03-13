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

variable "user_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the user."
    },
    "Label": {
      "en": "UserId",
      "zh-cn": "用户ID"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "用户组ID"
    }
  }
  EOT
}

resource "alicloud_cloud_sso_user_attachment" "user_to_group_addition" {
  directory_id = var.directory_id
  user_id      = var.user_id
  group_id     = var.group_id
}

