variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "UserStatus"
    },
    "Label": {
      "en": "Status",
      "zh-cn": "用户状态"
    }
  }
  EOT
}

variable "uid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "UserAliYunUid"
    },
    "Label": {
      "en": "Uid",
      "zh-cn": "阿里云UID"
    }
  }
  EOT
}

variable "user_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "UserNickName"
    },
    "Label": {
      "en": "UserName",
      "zh-cn": "用户名"
    }
  }
  EOT
}

variable "role_names" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "UserRole"
    },
    "Label": {
      "en": "RoleNames",
      "zh-cn": "用户角色"
    }
  }
  EOT
}

variable "mobile" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "UserMobile"
    },
    "Label": {
      "en": "Mobile",
      "zh-cn": "电话"
    }
  }
  EOT
}

variable "tid" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "Tid",
      "zh-cn": "租户ID"
    }
  }
  EOT
}

resource "alicloud_dms_enterprise_user" "dmsenterprise_user" {
  status     = var.status
  uid        = var.uid
  user_name  = var.user_name
  role_names = var.role_names
  mobile     = var.mobile
  tid        = var.tid
}

output "uid" {
  value       = alicloud_dms_enterprise_user.dmsenterprise_user.uid
  description = "UserAliYunUid"
}

output "user_name" {
  value       = alicloud_dms_enterprise_user.dmsenterprise_user.user_name
  description = "UserNickName"
}

output "role_names" {
  value       = alicloud_dms_enterprise_user.dmsenterprise_user.role_names
  description = "UserRole"
}

output "user_id" {
  value       = alicloud_dms_enterprise_user.dmsenterprise_user.id
  description = "UserId"
}

output "role_ids" {
  // Could not transform ROS Attribute RoleIds to Terraform attribute.
  value       = null
  description = "UserRoleId"
}

output "mobile" {
  value       = alicloud_dms_enterprise_user.dmsenterprise_user.mobile
  description = "UserMobile"
}

output "parent_uid" {
  // Could not transform ROS Attribute ParentUid to Terraform attribute.
  value       = null
  description = "ParentAliYunUid"
}

