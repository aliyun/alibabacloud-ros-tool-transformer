variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the encryption parameter. The description must be 1 to 200 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "参数的描述信息"
    }
  }
  EOT
}

variable "constraints" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The constraints of the encryption parameter."
    },
    "Label": {
      "en": "Constraints",
      "zh-cn": "参数的约束条件"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "secret_parameter_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the encryption parameter. The name must be 1 to 180 characters in length, and can contain letters, digits, hyphens (-), and underscores (_). It cannot start with ALIYUN, ACS, ALIBABA, ALICLOUD, or OOS."
    },
    "Label": {
      "en": "SecretParameterName",
      "zh-cn": "参数名称"
    }
  }
  EOT
}

variable "value" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The value of the encryption parameter. The value must be 1 to 4096 characters in length."
    },
    "Label": {
      "en": "Value",
      "zh-cn": "参数内容"
    }
  }
  EOT
}

variable "key_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Customer Master Key (CMK) of Key Management Service (KMS) that is used to encrypt the parameter."
    },
    "Label": {
      "en": "KeyId",
      "zh-cn": "加密使用的KMS的KeyId"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags of encryption parameter."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_oos_secret_parameter" "extension_resource" {
  description           = var.description
  constraints           = var.constraints
  resource_group_id     = var.resource_group_id
  secret_parameter_name = var.secret_parameter_name
  value                 = var.value
  key_id                = var.key_id
  tags                  = var.tags
}

output "description" {
  value       = alicloud_oos_secret_parameter.extension_resource.description
  description = "The description of the encryption parameter."
}

output "created_by" {
  // Could not transform ROS Attribute CreatedBy to Terraform attribute.
  value       = null
  description = "The user who created the encryption parameter."
}

output "resource_group_id" {
  value       = alicloud_oos_secret_parameter.extension_resource.resource_group_id
  description = "The ID of resource group."
}

output "secret_parameter_name" {
  value       = alicloud_oos_secret_parameter.extension_resource.id
  description = "The name of the encryption parameter."
}

output "updated_date" {
  // Could not transform ROS Attribute UpdatedDate to Terraform attribute.
  value       = null
  description = "The time when the encryption parameter was updated."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The time when the encryption parameter was created."
}

output "key_id" {
  value       = alicloud_oos_secret_parameter.extension_resource.key_id
  description = "The Customer Master Key (CMK) of Key Management Service (KMS) that is used to encrypt the parameter."
}

output "secret_parameter_id" {
  // Could not transform ROS Attribute SecretParameterId to Terraform attribute.
  value       = null
  description = "The ID of the encryption parameter."
}

output "updated_by" {
  // Could not transform ROS Attribute UpdatedBy to Terraform attribute.
  value       = null
  description = "The user who updated the encryption parameter."
}

output "type" {
  value       = alicloud_oos_secret_parameter.extension_resource.type
  description = "The data type of the encryption parameter."
}

output "constraints" {
  value       = alicloud_oos_secret_parameter.extension_resource.constraints
  description = "The constraints of the encryption parameter."
}

output "parameter_version" {
  // Could not transform ROS Attribute ParameterVersion to Terraform attribute.
  value       = null
  description = "The version number of the encryption parameter."
}

output "tags" {
  value       = alicloud_oos_secret_parameter.extension_resource.tags
  description = "Tags of encryption parameter."
}

output "share_type" {
  // Could not transform ROS Attribute ShareType to Terraform attribute.
  value       = null
  description = "The share type of the encryption parameter."
}

