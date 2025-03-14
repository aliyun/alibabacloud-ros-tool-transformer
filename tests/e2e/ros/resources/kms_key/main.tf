variable "policy" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The policy of key."
    },
    "Label": {
      "en": "Policy",
      "zh-cn": "密钥策略"
    }
  }
  EOT
}

variable "protection_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protection level of the CMK to create. Valid value: SOFTWARE and HSM. When this parameter is set to HSM:\nIf the Origin parameter is set to Aliyun_KMS, the CMK is created in Managed HSM.\nIf the Origin parameter is set to EXTERNAL, you can import external keys to Managed HSM."
    },
    "Label": {
      "en": "ProtectionLevel",
      "zh-cn": "密钥的保护级别"
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
      "en": "The description of the CMK. Length constraints: Minimum length of 0 characters. Maximum length of 8192 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "密钥的描述"
    },
    "MinLength": 0,
    "MaxLength": 8192
  }
  EOT
}

variable "rotation_interval" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time period for automatic rotation. The format is integer[unit], where integer represents the length of time and unit represents the time unit. The legal unit units are: d (day), h (hour), m (minute), s (second). 7d or 604800s both represent a 7-day cycle. Value: 7~730 days.",
      "zh-cn": "自动轮转的时间周期。例如：365d。"
    },
    "Label": {
      "en": "RotationInterval",
      "zh-cn": "自动轮转的时间周期"
    }
  }
  EOT
}

variable "enable_automatic_rotation" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable automatic key rotation. Valid value: true/false (default)"
    },
    "Label": {
      "en": "EnableAutomaticRotation",
      "zh-cn": "是否开启密钥自动轮转"
    }
  }
  EOT
}

variable "pending_window_in_days" {
  type        = number
  default     = 30
  description = <<EOT
  {
    "Description": {
      "en": "The waiting period, specified in number of days. During this period, you can cancel the CMK in PendingDeletion status. After the waiting period expires, you cannot cancel the deletion. The value must be between 7 and 366. Default value is 30.",
      "zh-cn": "密钥预删除周期。在这段时间内，您可以撤销删除处于待删除状态的密钥；预删除时间过后无法撤销删除。"
    },
    "MinValue": 7,
    "Label": {
      "en": "PendingWindowInDays",
      "zh-cn": "密钥预删除周期"
    },
    "MaxValue": 366
  }
  EOT
}

variable "key_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Key type. Valid value: Aliyun_AES_256/Aliyun_SM4/RSA_2048/EC_P256/EC_P256K/EC_SM2"
    },
    "Label": {
      "en": "KeySpec",
      "zh-cn": "密钥的类型"
    }
  }
  EOT
}

variable "enable" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the key is enabled. Defaults to true."
    },
    "Label": {
      "en": "Enable",
      "zh-cn": "将密钥设置为启用或禁用状态"
    }
  }
  EOT
}

variable "key_usage" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The usage of the CMK. Valid values:\nENCRYPT/DECRYPT: encrypts or decrypts data.\nSIGN/VERIFY: generates or verifies a digital signature.\nIf the CMK supports signature verification, the default value is SIGN/VERIFY. If the CMK does not support signature verification, the default value is ENCRYPT/DECRYPT."
    },
    "Label": {
      "en": "KeyUsage",
      "zh-cn": "密钥的用途"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the key. Default is false."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否开启删除保护"
    }
  }
  EOT
}

variable "dkmsinstance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the dedicated KMS instance."
    },
    "Label": {
      "en": "DKMSInstanceId",
      "zh-cn": "专属KMS的实例ID"
    }
  }
  EOT
}

resource "alicloud_kms_key" "key" {
  protection_level        = var.protection_level
  description             = var.description
  rotation_interval       = var.rotation_interval
  automatic_rotation      = var.enable_automatic_rotation
  deletion_window_in_days = var.pending_window_in_days
  key_spec                = var.key_spec
  is_enabled              = var.enable
  key_usage               = var.key_usage
}

output "key_id" {
  value       = alicloud_kms_key.key.id
  description = "The globally unique identifier for the CMK."
}

