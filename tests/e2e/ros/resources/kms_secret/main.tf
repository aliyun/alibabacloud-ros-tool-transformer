variable "version_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version number of the initial version. Version numbers are unique in each secret\nobject."
    },
    "Label": {
      "en": "VersionId",
      "zh-cn": "初始版本的版本号"
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
      "en": "The description of the secret."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "凭据的描述信息"
    }
  }
  EOT
}

variable "rotation_interval" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The interval for automatic rotation. Valid values: 6 hours to 8,760 hours (365 days).\nThe value is in the integer[unit] format.\nThe unit can be d (day), h (hour), m (minute), or s (second). For example, both 7d and 604800s indicate a seven-day interval."
    },
    "Label": {
      "en": "RotationInterval",
      "zh-cn": "凭据自动轮转的周期"
    }
  }
  EOT
}

variable "secret_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the secret. Valid values:\nGeneric: specifies a generic secret.\nRds: specifies a managed ApsaraDB RDS secret.\nRAMCredentials: specifies a managed RAM secret.\nECS: specifies a managed ECS secret."
    },
    "Label": {
      "en": "SecretType",
      "zh-cn": "凭据类型"
    }
  }
  EOT
}

variable "secret_data_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SecretDataType"
    },
    "Description": {
      "en": "The type of the secret value. Valid values:\ntext (default value)\nbinary"
    },
    "AllowedValues": [
      "text",
      "binary"
    ],
    "Label": {
      "en": "SecretDataType",
      "zh-cn": "凭据值类型"
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

variable "version_stages" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false,
        "MinLength": 1,
        "MaxLength": 64
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The stage labels that mark the secret version. ACSCurrent will be marked as DefaultIf you do not specify it, Secrets Manager marks it with \"ACSCurrent\"."
    },
    "Label": {
      "en": "VersionStages",
      "zh-cn": "版本的状态标记"
    },
    "MinLength": 1,
    "MaxLength": 7
  }
  EOT
}

variable "secret_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the secret."
    },
    "Label": {
      "en": "SecretName",
      "zh-cn": "凭据名称"
    }
  }
  EOT
}

variable "enable_automatic_rotation" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable automatic rotation. Valid values:\ntrue: specifies to enable automatic rotation.\nfalse: specifies to disable automatic rotation. This is the default value."
    },
    "Label": {
      "en": "EnableAutomaticRotation",
      "zh-cn": "是否开启自动密钥轮转"
    }
  }
  EOT
}

variable "extended_config" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The extended configuration of the secret. This parameter specifies the properties of the secret of the specific type."
    },
    "Label": {
      "en": "ExtendedConfig",
      "zh-cn": "凭据的拓展配置"
    }
  }
  EOT
}

variable "secret_data" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The value of the secret that you want to create. Secrets Manager encrypts the secret\nvalue and stores it in the initial version.",
      "zh-cn": "新创建凭据的凭据值。凭据管家将其加密后，存入初始版本中。"
    },
    "Label": {
      "en": "SecretData",
      "zh-cn": "新创建凭据的凭据值"
    }
  }
  EOT
}

variable "encryption_key_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the KMS CMK that is used to encrypt the secret value.\nIf you do not specify this parameter, Secrets Manager automatically creates an encryption\nkey to encrypt the secret.\nNote The KMS CMK must be a symmetric key."
    },
    "Label": {
      "en": "EncryptionKeyId",
      "zh-cn": "用于加密保护凭据值的KMS主密钥的标识符"
    }
  }
  EOT
}

variable "recovery_window_in_days" {
  type        = number
  default     = 30
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the recovery period of the secret if you do not forcibly delete it. Default value: 30",
      "zh-cn": "按照可恢复的方式删除凭据，且指定可恢复的窗口。"
    },
    "Label": {
      "en": "RecoveryWindowInDays",
      "zh-cn": "按照可恢复的方式删除凭据"
    }
  }
  EOT
}

variable "force_delete_without_recovery" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to forcibly delete the secret. If this parameter is set to true, the secret cannot be recovered. Valid values:\ntrue\nfalse (default value)",
      "zh-cn": "是否强制删除凭据，且不允许恢复。"
    },
    "Label": {
      "en": "ForceDeleteWithoutRecovery",
      "zh-cn": "是否强制删除凭据"
    }
  }
  EOT
}

resource "alicloud_kms_secret" "secret" {
  version_id                    = var.version_id
  description                   = var.description
  rotation_interval             = var.rotation_interval
  secret_type                   = var.secret_type
  secret_data_type              = var.secret_data_type
  version_stages                = var.version_stages
  secret_name                   = var.secret_name
  enable_automatic_rotation     = var.enable_automatic_rotation
  secret_data                   = var.secret_data
  encryption_key_id             = var.encryption_key_id
  recovery_window_in_days       = var.recovery_window_in_days
  force_delete_without_recovery = var.force_delete_without_recovery
}

output "secret_name" {
  value       = alicloud_kms_secret.secret.id
  description = "The name of the secret."
}

output "arn" {
  value       = alicloud_kms_secret.secret.arn
  description = "The Alibaba Cloud Resource Name (ARN)."
}

