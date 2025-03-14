variable "display_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The display name of the resource group"
    },
    "Label": {
      "zh-cn": "资源组显示名称"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The unique identifier of the resource group"
    },
    "Label": {
      "zh-cn": "资源组唯一标识"
    }
  }
  EOT
}

resource "alicloud_resource_manager_resource_group" "resource_manager_resource_group" {
  display_name = var.display_name
  name         = var.name
}

output "region_statuses" {
  value       = alicloud_resource_manager_resource_group.resource_manager_resource_group.region_statuses
  description = "The status of the resource group in all regions"
}

output "account_id" {
  value       = alicloud_resource_manager_resource_group.resource_manager_resource_group.account_id
  description = "The ID of the Alibaba Cloud account to which the resource group belongs"
}

output "display_name" {
  value       = alicloud_resource_manager_resource_group.resource_manager_resource_group.display_name
  description = "The display name of the resource group"
}

output "id" {
  value       = alicloud_resource_manager_resource_group.resource_manager_resource_group.id
  description = "The ID of the resource group"
}

output "name" {
  value       = alicloud_resource_manager_resource_group.resource_manager_resource_group.name
  description = "The unique identifier of the resource group"
}

