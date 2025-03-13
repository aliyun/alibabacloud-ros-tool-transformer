variable "folder_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the folder"
    },
    "Label": {
      "en": "FolderName",
      "zh-cn": "资源夹名称"
    }
  }
  EOT
}

variable "parent_folder_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the parent folder. If not set, the system default value will be used"
    },
    "Label": {
      "en": "ParentFolderId",
      "zh-cn": "父资源夹ID"
    }
  }
  EOT
}

resource "alicloud_resource_manager_folder" "resource_manager_folder" {
  folder_name      = var.folder_name
  parent_folder_id = var.parent_folder_id
}

output "folder_id" {
  value       = alicloud_resource_manager_folder.resource_manager_folder.id
  description = "The ID of the folder"
}

output "folder_name" {
  value       = alicloud_resource_manager_folder.resource_manager_folder.folder_name
  description = "The name of the folder"
}

output "parent_folder_id" {
  value       = alicloud_resource_manager_folder.resource_manager_folder.parent_folder_id
  description = "The ID of the parent folder. If not set, the system default value will be used"
}

