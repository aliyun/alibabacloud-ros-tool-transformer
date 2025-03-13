variable "approved_patches" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Approve the name of the patch."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Approved patch list."
    },
    "Label": {
      "en": "ApprovedPatches",
      "zh-cn": "批准补丁的列表"
    }
  }
  EOT
}

variable "rejected_patches_action" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The operation of rejecting the patch."
    },
    "Label": {
      "en": "RejectedPatchesAction",
      "zh-cn": "拒绝补丁的操作"
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
      "en": "The description of the patch baseline."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "补丁基线描述信息"
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
      "en": "Resource group id"
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

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

variable "approved_patches_enable_non_security" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Approve whether the patch includes updates other than security."
    },
    "Label": {
      "en": "ApprovedPatchesEnableNonSecurity",
      "zh-cn": "批准补丁是否包括除安全性之外的更新"
    }
  }
  EOT
}

variable "operation_system" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the operating system."
    },
    "Label": {
      "en": "OperationSystem",
      "zh-cn": "操作系统类型"
    }
  }
  EOT
}

variable "approval_rules" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The rules of scanning and installing patches for the specified operating system."
    },
    "Label": {
      "en": "ApprovalRules",
      "zh-cn": "接受规则"
    }
  }
  EOT
}

variable "sources" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Patch source configuration."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Patch source configuration list."
    },
    "Label": {
      "en": "Sources",
      "zh-cn": "补丁源配置列表"
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
      "en": "Tags of patch baseline."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "rejected_patches" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Reject the name of the patch."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Rejected patch list."
    },
    "Label": {
      "en": "RejectedPatches",
      "zh-cn": "拒绝补丁的名称"
    }
  }
  EOT
}

resource "alicloud_oos_patch_baseline" "extension_resource" {
  approved_patches                     = var.approved_patches
  rejected_patches_action              = var.rejected_patches_action
  description                          = var.description
  resource_group_id                    = var.resource_group_id
  patch_baseline_name                  = var.patch_baseline_name
  approved_patches_enable_non_security = var.approved_patches_enable_non_security
  operation_system                     = var.operation_system
  approval_rules                       = var.approval_rules
  sources                              = var.sources
  tags                                 = var.tags
  rejected_patches                     = var.rejected_patches
}

output "is_default" {
  // Could not transform ROS Attribute IsDefault to Terraform attribute.
  value       = null
  description = "Indicates whether the patch baseline is set as the default patch baseline."
}

output "description" {
  value       = alicloud_oos_patch_baseline.extension_resource.description
  description = "The description of the patch baseline."
}

output "created_by" {
  // Could not transform ROS Attribute CreatedBy to Terraform attribute.
  value       = null
  description = "The creator of the patch baseline."
}

output "resource_group_id" {
  value       = alicloud_oos_patch_baseline.extension_resource.resource_group_id
  description = "Approve whether the patch includes updates other than security"
}

output "updated_date" {
  // Could not transform ROS Attribute UpdatedDate to Terraform attribute.
  value       = null
  description = "The time when the patch baseline was last modified."
}

output "create_time" {
  value       = alicloud_oos_patch_baseline.extension_resource.create_time
  description = "The time when the patch baseline was created."
}

output "operation_system" {
  value       = alicloud_oos_patch_baseline.extension_resource.operation_system
  description = "The type of the operating system."
}

output "approval_rules" {
  value       = alicloud_oos_patch_baseline.extension_resource.approval_rules
  description = "The rules of scanning and installing patches for the specified operating system."
}

output "sources" {
  value       = alicloud_oos_patch_baseline.extension_resource.sources
  description = "Patch source configuration list."
}

output "rejected_patches" {
  value       = alicloud_oos_patch_baseline.extension_resource.rejected_patches
  description = "Reject the name of the patch."
}

output "approved_patches" {
  value       = alicloud_oos_patch_baseline.extension_resource.approved_patches
  description = "Approved patch list."
}

output "rejected_patches_action" {
  value       = alicloud_oos_patch_baseline.extension_resource.rejected_patches_action
  description = "The ID of the resource group."
}

output "updated_by" {
  // Could not transform ROS Attribute UpdatedBy to Terraform attribute.
  value       = null
  description = "The user who last modified the patch baseline."
}

output "patch_baseline_name" {
  value       = alicloud_oos_patch_baseline.extension_resource.id
  description = "The name of the patch baseline."
}

output "approved_patches_enable_non_security" {
  // Could not transform ROS Attribute ApprovedPatchesEnableNonSecurity to Terraform attribute.
  value       = null
  description = "Approve whether the patch includes updates other than security."
}

output "patch_baseline_id" {
  // Could not transform ROS Attribute PatchBaselineId to Terraform attribute.
  value       = null
  description = "The ID of the patch baseline."
}

output "tags" {
  value       = alicloud_oos_patch_baseline.extension_resource.tags
  description = "Tags of patch baseline."
}

output "share_type" {
  // Could not transform ROS Attribute ShareType to Terraform attribute.
  value       = null
  description = "The share type of the patch baseline."
}

