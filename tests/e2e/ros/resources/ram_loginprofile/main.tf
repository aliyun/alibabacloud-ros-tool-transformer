variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Enable or disable console password login. Valid values:\n- Activate (default): Enable.\n- Inactivate: Disable."
    },
    "AllowedValues": [
      "Activate",
      "Inactivate"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "开启或禁用控制台密码登录"
    }
  }
  EOT
}

variable "password_reset_required" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether RAM users must reset their password the next time they log in."
    },
    "Label": {
      "en": "PasswordResetRequired",
      "zh-cn": "RAM 用户在下次登录时是否必须重置密码"
    }
  }
  EOT
}

variable "user_principal_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The login name of the RAM user."
    },
    "Label": {
      "en": "UserPrincipalName",
      "zh-cn": "RAM 用户的登录名称"
    }
  }
  EOT
}

variable "generate_random_password" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to generate a random password for the RAM user."
    },
    "Label": {
      "en": "GenerateRandomPassword",
      "zh-cn": "是否为RAM用户生成一个随机密码"
    }
  }
  EOT
}

variable "mfabind_required" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to force RAM users to enable multi-factor authentication. Valid values:\n- true: This is required. RAM users must bind the multifactor authentication device the next time they log in.\n- false (default) : This is not required."
    },
    "Label": {
      "en": "MFABindRequired",
      "zh-cn": "是否强制要求 RAM 用户开启多因素认证"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The password of the RAM user."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "RAM 用户的控制台登录密码"
    }
  }
  EOT
}

resource "alicloud_ram_login_profile" "login_profile" {
  password_reset_required = var.password_reset_required
  password                = var.password
}

output "password" {
  // Could not transform ROS Attribute Password to Terraform attribute.
  value       = null
  description = "The password of the RAM user."
}

