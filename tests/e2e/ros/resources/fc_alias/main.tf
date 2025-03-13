variable "version_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Version ID"
    },
    "Label": {
      "en": "VersionId",
      "zh-cn": "版本ID"
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
      "en": "Version description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "别名的描述"
    }
  }
  EOT
}

variable "service_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Service name"
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "函数计算服务名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "additional_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Additional version"
    },
    "Label": {
      "en": "AdditionalVersion",
      "zh-cn": "灰度版本"
    }
  }
  EOT
}

variable "alias_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Alias name"
    },
    "Label": {
      "en": "AliasName",
      "zh-cn": "别名"
    }
  }
  EOT
}

variable "additional_weight" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Traffic weight of additional version. From 0 to 100."
    },
    "MinValue": 0,
    "Label": {
      "en": "AdditionalWeight",
      "zh-cn": "灰度版本权重"
    },
    "MaxValue": 100
  }
  EOT
}

resource "alicloud_fc_alias" "alias" {
  description  = var.description
  service_name = var.service_name
  alias_name   = var.alias_name
}

output "version_id" {
  // Could not transform ROS Attribute VersionId to Terraform attribute.
  value       = null
  description = "The version ID"
}

output "service_name" {
  value       = alicloud_fc_alias.alias.service_name
  description = "The service name"
}

output "alias_name" {
  value       = alicloud_fc_alias.alias.alias_name
  description = "The alias name"
}

