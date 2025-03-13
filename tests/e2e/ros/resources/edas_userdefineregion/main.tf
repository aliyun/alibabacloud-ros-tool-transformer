variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Logic region (or namespace) description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "逻辑地域（命名空间）描述信息"
    }
  }
  EOT
}

variable "region_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logical region (or namespace) name"
    },
    "Label": {
      "en": "RegionName",
      "zh-cn": "逻辑地域（命名空间）名称"
    }
  }
  EOT
}

variable "region_tag" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logic region (or namespace) ID (format: \"physical region ID: logical zone identifier\", or \"logical zone identifier\")"
    },
    "Label": {
      "en": "RegionTag",
      "zh-cn": "逻辑地域（命名空间）ID"
    }
  }
  EOT
}

variable "debug_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether debug is enable"
    },
    "Label": {
      "en": "DebugEnable",
      "zh-cn": "是否允许远程调试"
    }
  }
  EOT
}

resource "alicloud_edas_namespace" "user_define_region" {
  description          = var.description
  namespace_name       = var.region_name
  namespace_logical_id = var.region_tag
  debug_enable         = var.debug_enable
}

output "region_name" {
  value       = alicloud_edas_namespace.user_define_region.namespace_name
  description = "Region name"
}

output "user_id" {
  // Could not transform ROS Attribute UserId to Terraform attribute.
  value       = null
  description = "User account ID"
}

output "debug_enable" {
  value       = alicloud_edas_namespace.user_define_region.debug_enable
  description = "Whether debug is enable"
}

output "id" {
  value       = alicloud_edas_namespace.user_define_region.id
  description = "Resource ID"
}

output "belong_region" {
  // Could not transform ROS Attribute BelongRegion to Terraform attribute.
  value       = null
  description = "Under the physical region ID"
}

