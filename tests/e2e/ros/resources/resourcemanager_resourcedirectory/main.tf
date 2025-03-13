resource "alicloud_resource_manager_resource_directory" "resource_manager_resource_directory" {}

output "resource_directory_id" {
  value       = alicloud_resource_manager_resource_directory.resource_manager_resource_directory.id
  description = "The ID of the resource directory"
}

output "root_folder_id" {
  value       = alicloud_resource_manager_resource_directory.resource_manager_resource_directory.root_folder_id
  description = "The ID of the root folder"
}

output "master_account_name" {
  value       = alicloud_resource_manager_resource_directory.resource_manager_resource_directory.master_account_name
  description = "The name of the master account"
}

output "master_account_id" {
  value       = alicloud_resource_manager_resource_directory.resource_manager_resource_directory.master_account_id
  description = "The ID of the master account"
}

