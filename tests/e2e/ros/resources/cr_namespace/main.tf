variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the enterprise edition instance which namespace belongs to. If not provided, will use personal edition instance as default."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "auto_create" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically create an image repository."
    },
    "Label": {
      "en": "AutoCreate",
      "zh-cn": "是否自动创建仓库"
    }
  }
  EOT
}

variable "default_visibility" {
  type        = string
  default     = "PRIVATE"
  description = <<EOT
  {
    "Description": {
      "en": "The default type of the repository that is automatically created. Valid values: PUBLIC, PRIVATE."
    },
    "AllowedValues": [
      "PUBLIC",
      "PRIVATE"
    ],
    "Label": {
      "en": "DefaultVisibility",
      "zh-cn": "默认的仓库属性"
    }
  }
  EOT
}

variable "namespace" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the namespace."
    },
    "Label": {
      "en": "Namespace",
      "zh-cn": "命名空间名称"
    },
    "MinLength": 2,
    "MaxLength": 30
  }
  EOT
}

resource "alicloud_cr_namespace" "crnamespace" {
  auto_create        = var.auto_create
  default_visibility = var.default_visibility
  name               = var.namespace
}

output "instance_id" {
  // Could not transform ROS Attribute InstanceId to Terraform attribute.
  value       = null
  description = "The ID of the enterprise edition instance which namespace belongs to."
}

output "namespace_id" {
  value       = alicloud_cr_namespace.crnamespace.id
  description = "The namespace ID."
}

output "namespace" {
  // Could not transform ROS Attribute Namespace to Terraform attribute.
  value       = null
  description = "The namespace."
}

