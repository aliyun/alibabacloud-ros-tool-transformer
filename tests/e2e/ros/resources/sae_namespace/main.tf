variable "namespace_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Namespace name"
    },
    "Label": {
      "en": "NamespaceName",
      "zh-cn": "命名空间名称"
    }
  }
  EOT
}

variable "namespace_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Namespace ID. Format: \"regionId:logicalId\" or \"logicalId\"",
      "zh-cn": "命名空间ID，示例值：cn-hangzhou:test。"
    },
    "Label": {
      "en": "NamespaceId",
      "zh-cn": "命名空间ID"
    }
  }
  EOT
}

variable "namespace_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Namespace description"
    },
    "Label": {
      "en": "NamespaceDescription",
      "zh-cn": "描述"
    }
  }
  EOT
}

resource "alicloud_sae_namespace" "namespace" {
  namespace_name        = var.namespace_name
  namespace_id          = var.namespace_id
  namespace_description = var.namespace_description
}

output "namespace_id" {
  value       = alicloud_sae_namespace.namespace.id
  description = "Namespace ID"
}

