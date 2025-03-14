variable "policy_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the policy"
    },
    "Label": {
      "en": "PolicyType",
      "zh-cn": "权限策略类型"
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
      "en": "The ID of the resource group or the ID of the Alibaba Cloud account to which the resource group belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID或阿里云账号ID"
    }
  }
  EOT
}

variable "policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the policy"
    },
    "Label": {
      "en": "PolicyName",
      "zh-cn": "权限策略名称"
    }
  }
  EOT
}

variable "principal_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the object to which you want to attach the policy"
    },
    "Label": {
      "en": "PrincipalName",
      "zh-cn": "被授权对象名称"
    }
  }
  EOT
}

variable "principal_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the object to which you want to attach the policy. Valid values: IMSUser: RAM user, IMSGroup: RAM user group, ServiceRole: RAM role"
    },
    "Label": {
      "en": "PrincipalType",
      "zh-cn": "被授权对象类型"
    }
  }
  EOT
}

resource "alicloud_resource_manager_policy_attachment" "resource_manager_policy_attachment" {
  policy_type       = var.policy_type
  resource_group_id = var.resource_group_id
  policy_name       = var.policy_name
  principal_name    = var.principal_name
  principal_type    = var.principal_type
}

output "policy_type" {
  value       = alicloud_resource_manager_policy_attachment.resource_manager_policy_attachment.policy_type
  description = "The type of the policy"
}

output "description" {
  // Could not transform ROS Attribute Description to Terraform attribute.
  value       = null
  description = "Policy description"
}

output "resource_group_id" {
  value       = alicloud_resource_manager_policy_attachment.resource_manager_policy_attachment.resource_group_id
  description = "The ID of the resource group or the ID of the Alibaba Cloud account to which the resource group belongs."
}

output "attach_date" {
  // Could not transform ROS Attribute AttachDate to Terraform attribute.
  value       = null
  description = "Authorization time"
}

output "policy_name" {
  value       = alicloud_resource_manager_policy_attachment.resource_manager_policy_attachment.policy_name
  description = "The name of the policy"
}

output "principal_name" {
  value       = alicloud_resource_manager_policy_attachment.resource_manager_policy_attachment.principal_name
  description = "The name of the object to which you want to attach the policy"
}

output "principal_type" {
  value       = alicloud_resource_manager_policy_attachment.resource_manager_policy_attachment.principal_type
  description = "The type of the object to which you want to attach the policy. Valid values: IMSUser: RAM user, IMSGroup: RAM user group, ServiceRole: RAM role"
}

