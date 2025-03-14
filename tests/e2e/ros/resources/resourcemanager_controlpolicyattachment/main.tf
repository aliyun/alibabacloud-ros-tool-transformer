variable "target_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "TargetId"
    },
    "Label": {
      "en": "TargetId",
      "zh-cn": "目标节点"
    }
  }
  EOT
}

variable "policy_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "PolicyId"
    },
    "Label": {
      "en": "PolicyId",
      "zh-cn": "管控策略ID"
    }
  }
  EOT
}

resource "alicloud_resource_manager_control_policy_attachment" "resource_manager_control_policy_attachment" {
  target_id = var.target_id
  policy_id = var.policy_id
}

output "policy_type" {
  // Could not transform ROS Attribute PolicyType to Terraform attribute.
  value       = null
  description = "PolicyType"
}

output "description" {
  // Could not transform ROS Attribute Description to Terraform attribute.
  value       = null
  description = "Description"
}

output "attach_date" {
  // Could not transform ROS Attribute AttachDate to Terraform attribute.
  value       = null
  description = "AttachDate"
}

output "policy_name" {
  // Could not transform ROS Attribute PolicyName to Terraform attribute.
  value       = null
  description = "PolicyName"
}

output "target_id" {
  value       = alicloud_resource_manager_control_policy_attachment.resource_manager_control_policy_attachment.target_id
  description = "TargetId"
}

output "policy_id" {
  value       = alicloud_resource_manager_control_policy_attachment.resource_manager_control_policy_attachment.policy_id
  description = "PolicyId"
}

