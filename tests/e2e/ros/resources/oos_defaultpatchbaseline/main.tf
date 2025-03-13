variable "patch_baseline_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the patch baseline."
    },
    "Label": {
      "en": "PatchBaselineName",
      "zh-cn": "补丁基线名称"
    }
  }
  EOT
}

resource "alicloud_oos_default_patch_baseline" "default_patch_baseline" {
  patch_baseline_name = var.patch_baseline_name
}

output "updated_by" {
  // Could not transform ROS Attribute UpdatedBy to Terraform attribute.
  value       = null
  description = "The user who last modified the patch baseline."
}

output "description" {
  // Could not transform ROS Attribute Description to Terraform attribute.
  value       = null
  description = "The description of the patch baseline."
}

output "created_by" {
  // Could not transform ROS Attribute CreatedBy to Terraform attribute.
  value       = null
  description = "The creator of the patch baseline."
}

output "updated_date" {
  // Could not transform ROS Attribute UpdatedDate to Terraform attribute.
  value       = null
  description = "The time when the patch baseline was last modified."
}

output "patch_baseline_name" {
  value       = alicloud_oos_default_patch_baseline.default_patch_baseline.patch_baseline_name
  description = "The name of the patch baseline."
}

output "created_date" {
  // Could not transform ROS Attribute CreatedDate to Terraform attribute.
  value       = null
  description = "The time when the patch baseline was created."
}

output "operation_system" {
  // Could not transform ROS Attribute OperationSystem to Terraform attribute.
  value       = null
  description = "The type of the operating system."
}

output "approval_rules" {
  // Could not transform ROS Attribute ApprovalRules to Terraform attribute.
  value       = null
  description = "The rules of scanning and installing patches for the specified operating system."
}

output "patch_baseline_id" {
  value       = alicloud_oos_default_patch_baseline.default_patch_baseline.id
  description = "The ID of the patch baseline."
}

output "share_type" {
  // Could not transform ROS Attribute ShareType to Terraform attribute.
  value       = null
  description = "The share type of the patch baseline."
}

