variable "login_session_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The validity period of the logon session of the RAM user.\nValid values: 6 to 24. Default value: 6. Unit: hours."
    },
    "Label": {
      "en": "LoginSessionDuration",
      "zh-cn": "RAM用户登录有效期"
    }
  }
  EOT
}

variable "allow_user_to_managemfadevices" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether RAM users can manage their MFA devices. Valid values:\ntrue: RAM users can manage their MFA devices. This is the default value.\nfalse: RAM users cannot manage their MFA devices."
    },
    "Label": {
      "en": "AllowUserToManageMFADevices",
      "zh-cn": "是否允许RAM用户自主管理多因素认证设备"
    }
  }
  EOT
}

variable "allow_user_to_manage_public_keys" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether RAM users can manage their public keys. Valid values:\ntrue: RAM users can manage their public keys.\nfalse: RAM users cannot manage their public keys. This is the default value.\nNote This parameter is valid only for the Japan site."
    },
    "Label": {
      "en": "AllowUserToManagePublicKeys",
      "zh-cn": "是否允许RAM用户自主管理公钥"
    }
  }
  EOT
}

variable "login_network_masks" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The subnet mask that specifies the IP addresses from which logon to the console is\nallowed. This parameter applies to password-based logon and single sign-on (SSO).\nHowever, this parameter does not apply to API calls that are authenticated based on\nAccessKey pairs.\nIf a subnet mask is specified, RAM users can log on to the console only by using the\nIP addresses in the subnet.\nIf you do not specify a subnet mask, RAM users can log on to the console by using\nall IP addresses.\nIf you want to specify multiple subnet masks, separate the subnet masks with semicolons\n(;). Example: 192.168.0.0/16;10.0.0.0/8.\nA maximum of 25 subnet masks can be set. The total length of the subnet masks can\nbe 1 to 512 characters."
    },
    "Label": {
      "en": "LoginNetworkMasks",
      "zh-cn": "登录掩码"
    }
  }
  EOT
}

variable "allow_user_to_change_password" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether RAM users can change their passwords. Valid values:\ntrue: RAM users can change their passwords. This is the default value.\nfalse: RAM users cannot change their passwords."
    },
    "Label": {
      "en": "AllowUserToChangePassword",
      "zh-cn": "是否允许RAM用户自主管理密码"
    }
  }
  EOT
}

variable "allow_user_to_manage_access_keys" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether RAM users can manage their AccessKey pairs. Valid values:\ntrue: RAM users can manage their AccessKey pairs.\nfalse: RAM users cannot manage their AccessKey pairs. This is the default value."
    },
    "Label": {
      "en": "AllowUserToManageAccessKeys",
      "zh-cn": "是否允许RAM用户自主管理访问密钥"
    }
  }
  EOT
}

variable "enable_savemfaticket" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether RAM users can save multi-factor authentication (MFA) security codes\nduring logon. The security codes are valid for 7 days. Valid values:\ntrue: RAM users can save MFA security codes during logon.\nfalse: RAM users cannot save MFA security codes during logon. This is the default\nvalue.",
      "zh-cn": "是否允许RAM用户在登录时保存多因素设备认证状态，有效期为7天。"
    },
    "Label": {
      "en": "EnableSaveMFATicket",
      "zh-cn": "是否允许RAM用户在登录时保存多因素设备认证状态"
    }
  }
  EOT
}

resource "alicloud_ram_security_preference" "security_preference" {
  login_session_duration           = var.login_session_duration
  allow_user_to_manage_mfa_devices = var.allow_user_to_managemfadevices
  login_network_masks              = var.login_network_masks
  allow_user_to_change_password    = var.allow_user_to_change_password
  allow_user_to_manage_access_keys = var.allow_user_to_manage_access_keys
  enforce_mfa_for_login            = var.enable_savemfaticket
}

output "login_session_duration" {
  value       = alicloud_ram_security_preference.security_preference.login_session_duration
  description = "The validity period of the logon session of the RAM user."
}

output "allow_user_to_managemfadevices" {
  value       = alicloud_ram_security_preference.security_preference.allow_user_to_manage_mfa_devices
  description = "Specifies whether RAM users can manage their MFA devices."
}

output "allow_user_to_manage_public_keys" {
  // Could not transform ROS Attribute AllowUserToManagePublicKeys to Terraform attribute.
  value       = null
  description = "Specifies whether RAM users can manage their public keys."
}

output "login_network_masks" {
  value       = alicloud_ram_security_preference.security_preference.login_network_masks
  description = "The subnet mask that specifies the IP addresses from which logon to the console is allowed."
}

output "allow_user_to_change_password" {
  value       = alicloud_ram_security_preference.security_preference.allow_user_to_change_password
  description = "Specifies whether RAM users can change their passwords."
}

output "allow_user_to_manage_access_keys" {
  value       = alicloud_ram_security_preference.security_preference.allow_user_to_manage_access_keys
  description = "Specifies whether RAM users can manage their AccessKey pairs."
}

output "enable_savemfaticket" {
  value       = alicloud_ram_security_preference.security_preference.enable_save_mfa_ticket
  description = "Specifies whether RAM users can save multi-factor authentication (MFA) security codes during logon."
}

