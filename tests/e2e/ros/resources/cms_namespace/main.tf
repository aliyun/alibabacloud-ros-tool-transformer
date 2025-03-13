variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the namespace."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "指标仓库描述"
    }
  }
  EOT
}

variable "specification" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The data retention period of the namespace. Valid values:\n- cms.s1.large: Data storage duration is 15 days.\n- cms.s1.xlarge: Data storage duration is 32 days.\n- cms.s1.2xlarge: Data storage duration 63 days.\n- cms.s1.3xlarge: Data storage duration 93 days.\n- cms.s1.6xlarge: Data storage duration 185 days.\n- cms.s1.12xlarge: Data storage duration 376 days."
    },
    "AllowedValues": [
      "cms.s1.large",
      "cms.s1.xlarge",
      "cms.s1.2xlarge",
      "cms.s1.3xlarge",
      "cms.s1.6xlarge",
      "cms.s1.12xlarge"
    ],
    "Label": {
      "en": "Specification",
      "zh-cn": "数据存储时长"
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
      "en": "The name of the namespace.\nThe name can contain lowercase letters, digits, and hyphens (-)."
    },
    "AllowedPattern": "^[-a-z0-9]+$",
    "Label": {
      "en": "Namespace",
      "zh-cn": "指标仓库名称"
    }
  }
  EOT
}

resource "alicloud_cms_namespace" "extension_resource" {
  description   = var.description
  specification = var.specification
  namespace     = var.namespace
}

output "modify_time" {
  // Could not transform ROS Attribute ModifyTime to Terraform attribute.
  value       = null
  description = "The timestamp that was generated when the namespace was last modified."
}

output "description" {
  value       = alicloud_cms_namespace.extension_resource.description
  description = "The description of the namespace."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = <<EOT
  "The timestamp that was generated when the namespace was created.\nUnit: milliseconds."
  EOT
}

output "specification" {
  value       = alicloud_cms_namespace.extension_resource.specification
  description = <<EOT
  "The data retention period of the namespace. Valid values:\n- cms.s1.large: Data storage duration is 15 days.\n- cms.s1.xlarge: Data storage duration is 32 days.\n- cms.s1.2xlarge: Data storage duration 63 days.\n- cms.s1.3xlarge: Data storage duration 93 days.\n- cms.s1.6xlarge: Data storage duration 185 days.\n- cms.s1.12xlarge: Data storage duration 376 days."
  EOT
}

output "namespace" {
  value       = alicloud_cms_namespace.extension_resource.id
  description = "The namespace for the Alibaba Cloud service."
}

