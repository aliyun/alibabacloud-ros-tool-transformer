variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "管控策略描述"
    }
  }
  EOT
}

variable "policy_document" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "PolicyDocument"
    },
    "Label": {
      "en": "PolicyDocument",
      "zh-cn": "管控策略内容"
    }
  }
  EOT
}

variable "control_policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "PolicyName"
    },
    "Label": {
      "en": "ControlPolicyName",
      "zh-cn": "管控策略名称"
    }
  }
  EOT
}

variable "effect_scope" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "EffectScope"
    },
    "Label": {
      "en": "EffectScope",
      "zh-cn": "管控策略的生效范围"
    }
  }
  EOT
}

resource "alicloud_resource_manager_control_policy" "resource_manager_control_policy" {
  description         = var.description
  policy_document     = var.policy_document
  control_policy_name = var.control_policy_name
  effect_scope        = var.effect_scope
}

output "policy_type" {
  // Could not transform ROS Attribute PolicyType to Terraform attribute.
  value       = null
  description = "PolicyType"
}

output "description" {
  value       = alicloud_resource_manager_control_policy.resource_manager_control_policy.description
  description = "Description"
}

output "attachment_count" {
  // Could not transform ROS Attribute AttachmentCount to Terraform attribute.
  value       = null
  description = "AttachmentCount"
}

output "policy_document" {
  value       = alicloud_resource_manager_control_policy.resource_manager_control_policy.policy_document
  description = "PolicyDocument"
}

output "control_policy_name" {
  value       = alicloud_resource_manager_control_policy.resource_manager_control_policy.control_policy_name
  description = "PolicyName"
}

output "effect_scope" {
  value       = alicloud_resource_manager_control_policy.resource_manager_control_policy.effect_scope
  description = "EffectScope"
}

output "policy_id" {
  value       = alicloud_resource_manager_control_policy.resource_manager_control_policy.id
  description = "PolicyId"
}

