variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the permission policy."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "access_control_rules" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "NetworkRules": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "The name of the access control rule."
              },
              "Required": true
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "NetworkRule list, Supports a maximum of 40 network control rules."
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 40
        }
      }
    },
    "Description": {
      "en": "Network Rules info."
    },
    "Label": {
      "en": "AccessControlRules",
      "zh-cn": "网络控制规则名称集合"
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
      "en": "The name of the permission policy."
    },
    "Label": {
      "en": "PolicyName",
      "zh-cn": "权限策略名称"
    }
  }
  EOT
}

variable "permissions" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "AllowedValues": [
          "RbacPermission/Template/CryptoServiceKeyUser",
          "RbacPermission/Template/CryptoServiceSecretUser"
        ],
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The operations that can be performed. Valid values:\nRbacPermission/Template/CryptoServiceKeyUser: allows you to perform cryptographic operations.\nRbacPermission/Template/CryptoServiceSecretUser: allows you to perform secret-related operations."
    },
    "Label": {
      "en": "Permissions",
      "zh-cn": "权限策略支持的操作"
    },
    "MinLength": 1,
    "MaxLength": 2
  }
  EOT
}

variable "kms_instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The scope of the permission policy. You need to specify the KMS instance that you want to access."
    },
    "Label": {
      "en": "KmsInstanceId",
      "zh-cn": "权限策略的作用域"
    }
  }
  EOT
}

variable "resources" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The key and secret that are allowed to access. Supports a maximum of 30 key and secret.\nKey: Enter a key in the key/$${KeyId} format. To allow access to all keys of a KMS instance, enter key/*. \nSecret: Enter a secret in the secret/$${SecretName} format. To allow access to all secrets of a KMS instance, enter secret/*."
    },
    "Label": {
      "en": "Resources",
      "zh-cn": "允许访问的密钥和凭据"
    },
    "MinLength": 1,
    "MaxLength": 30
  }
  EOT
}

resource "alicloud_kms_policy" "extension_resource" {
  description     = var.description
  policy_name     = var.policy_name
  permissions     = var.permissions
  kms_instance_id = var.kms_instance_id
  resources       = var.resources
}

output "description" {
  value       = alicloud_kms_policy.extension_resource.description
  description = "Description."
}

output "access_control_rules" {
  value       = alicloud_kms_policy.extension_resource.access_control_rules
  description = "Network Rules info."
}

output "policy_name" {
  value       = alicloud_kms_policy.extension_resource.policy_name
  description = "The name of the permission policy."
}

output "permissions" {
  value       = alicloud_kms_policy.extension_resource.permissions
  description = "RbacPermission Template, support RbacPermission/Template/CryptoServiceKeyUser and RbacPermission/Template/CryptoServiceSecretUser."
}

output "kms_instance_id" {
  value       = alicloud_kms_policy.extension_resource.kms_instance_id
  description = "The scope of the permission policy. You need to specify the KMS instance that you want to access."
}

output "resources" {
  value       = alicloud_kms_policy.extension_resource.resources
  description = "Resources that allowed access by this policy."
}

