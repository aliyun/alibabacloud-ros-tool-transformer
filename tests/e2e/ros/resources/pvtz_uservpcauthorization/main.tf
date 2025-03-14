variable "auth_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Verification code, if AuthChannel takes \"AUTH_CODE\" or is empty, it is mandatory."
    },
    "Label": {
      "en": "AuthCode",
      "zh-cn": "验证码"
    }
  }
  EOT
}

variable "auth_channel" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Authorization channel. Valid values:\nAUTH_CODE: Verification code authorization, to verify whether the verification code passed in by AuthCode is correct.\nRESOURCE_DIRECTORY: Resource directory authorization, verify whether the AuthorizedUserId and the current account have resource directory credit.When it is empty, it is the same as AUTH_CODE, that is, verification code authorization."
    },
    "Label": {
      "en": "AuthChannel",
      "zh-cn": "授权渠道"
    }
  }
  EOT
}

variable "authorized_user_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The account ID of the user who authorizes the resource."
    },
    "Label": {
      "en": "AuthorizedUserId",
      "zh-cn": "授权资源的所属阿里云账号ID"
    }
  }
  EOT
}

variable "auth_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Authorization type."
    },
    "Label": {
      "en": "AuthType",
      "zh-cn": "授权类型"
    }
  }
  EOT
}

variable "ignore_deletion_forbidden" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to ignore following deletion forbidden errors when deleting:- UserAuth.DeleteForbidden.ZoneVpcExists"
    },
    "Label": {
      "en": "IgnoreDeletionForbidden",
      "zh-cn": "是否忽略删除保护"
    }
  }
  EOT
}

resource "alicloud_pvtz_user_vpc_authorization" "user_vpc_authorization" {
  auth_channel       = var.auth_channel
  authorized_user_id = var.authorized_user_id
  auth_type          = var.auth_type
}

output "authorized_user_id" {
  value       = alicloud_pvtz_user_vpc_authorization.user_vpc_authorization.authorized_user_id
  description = "The account ID of the user who authorizes the resource."
}

output "auth_type" {
  value       = alicloud_pvtz_user_vpc_authorization.user_vpc_authorization.auth_type
  description = "Authorization type."
}

