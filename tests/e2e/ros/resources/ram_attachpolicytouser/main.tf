variable "policy_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "System",
      "Custom"
    ],
    "Description": {
      "en": "Authorization policy type. Value: \"System\" or \"Custom\"."
    },
    "Label": {
      "en": "PolicyType",
      "zh-cn": "权限策略类型"
    }
  }
  EOT
}

variable "user_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::User",
    "Description": {
      "en": "User name.Example: dev."
    },
    "Label": {
      "en": "UserName",
      "zh-cn": "用户名"
    }
  }
  EOT
}

variable "policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Authorization policy name."
    },
    "Label": {
      "en": "PolicyName",
      "zh-cn": "权限策略名称"
    }
  }
  EOT
}

resource "alicloud_ram_user_policy_attachment" "attach_policy_to_user" {
  policy_type = var.policy_type
  user_name   = var.user_name
  policy_name = var.policy_name
}

