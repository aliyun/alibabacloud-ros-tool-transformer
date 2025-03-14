variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The status of the user. Valid values:\n- Enabled: The logon of the user is enabled. This is the default value.\n- Disabled: The logon of the user is disabled."
    },
    "AllowedValues": [
      "Enabled",
      "Disabled"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "用户的状态"
    }
  }
  EOT
}

variable "user_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the user. The name must be unique within the directory. The name cannot be changed.\nThe name can contain numbers, letters, and the following special characters: @_-.\nThe name can be up to 64 characters in length."
    },
    "AllowedPattern": "^[a-zA-Z0-9@._-]{1,64}$",
    "Label": {
      "en": "UserName",
      "zh-cn": "用户名称"
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
      "en": "The description of the user.\nThe description can be up to 1,024 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "用户的描述"
    },
    "MaxLength": 1024
  }
  EOT
}

variable "email" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The email address of the user. The email address must be unique within the directory.\nThe email address can be up to 128 characters in length."
    },
    "Label": {
      "en": "Email",
      "zh-cn": "用户的电子邮箱"
    },
    "MaxLength": 128
  }
  EOT
}

variable "first_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The first name of the user.\nThe name can be up to 64 characters in length."
    },
    "Label": {
      "en": "FirstName",
      "zh-cn": "用户的名"
    },
    "MaxLength": 64
  }
  EOT
}

variable "display_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The display name of the user.\nThe name can be up to 256 characters in length."
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "用户的显示名称"
    },
    "MaxLength": 256
  }
  EOT
}

variable "last_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The last name of the user.\nThe name can be up to 64 characters in length."
    },
    "Label": {
      "en": "LastName",
      "zh-cn": "用户的姓"
    },
    "MaxLength": 64
  }
  EOT
}

resource "alicloud_cloud_sso_user" "user" {
  status       = var.status
  user_name    = var.user_name
  directory_id = var.directory_id
  description  = var.description
  email        = var.email
  first_name   = var.first_name
  display_name = var.display_name
  last_name    = var.last_name
}

output "user_id" {
  value       = alicloud_cloud_sso_user.user.user_id
  description = "The ID of the user."
}

