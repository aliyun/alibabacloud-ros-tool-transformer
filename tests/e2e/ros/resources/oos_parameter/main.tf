variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "String",
      "StringList"
    ],
    "Description": {
      "en": "The data type of the common parameter. \nValid values: String and StringList."
    },
    "Label": {
      "en": "Type",
      "zh-cn": "参数类型"
    }
  }
  EOT
}

variable "constraints" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The constraints of the parameter. \nBy default, this parameter is null. Valid values:\nAllowedValues: The value that is allowed for the parameter. It must be an array string.\nAllowedPattern: The pattern that is allowed for the parameter. It must be a regular expression.\nMinLength: The minimum length of the parameter.\nMaxLength: The maximum length of the parameter."
    },
    "Label": {
      "en": "Constraints",
      "zh-cn": "参数的约束条件"
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
      "en": "The description of the parameter. \nThe description must be 1 to 200 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "参数的描述信息"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "en": "The value of the parameter. \nThe value must be 1 to 4096 characters in length."
    },
    "Label": {
      "en": "Value",
      "zh-cn": "参数值"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the parameter. \nThe name must be 1 to 200 characters in length,and can contain letters, digits, hyphens (-), and underscores (_). \nIt cannot start with ALIYUN, ACS, ALIBABA, ALICLOUD, or OOS."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "参数名称"
    }
  }
  EOT
}

resource "alicloud_oos_parameter" "parameter" {
  type              = var.type
  constraints       = var.constraints
  description       = var.description
  resource_group_id = var.resource_group_id
  value             = var.value
  parameter_name    = var.name
}

output "value" {
  value       = alicloud_oos_parameter.parameter.value
  description = "The Value of the parameter."
}

output "name" {
  value       = alicloud_oos_parameter.parameter.id
  description = "The Name of the parameter."
}

