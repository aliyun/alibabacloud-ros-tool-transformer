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
      "zh-cn": "指定权限的类型"
    }
  }
  EOT
}

variable "role_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::Role",
    "Description": {
      "en": "Role name.Example: dev.",
      "zh-cn": "指定角色名，例如：dev。"
    },
    "Label": {
      "zh-cn": "适用此策略的角色"
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
      "zh-cn": "指定权限策略名称"
    }
  }
  EOT
}

resource "alicloud_ram_role_policy_attachment" "attach_policy_to_role" {
  policy_type = var.policy_type
  role_name   = var.role_name
  policy_name = var.policy_name
}

