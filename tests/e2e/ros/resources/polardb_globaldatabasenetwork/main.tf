variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "db_cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the primary cluster."
    },
    "Label": {
      "en": "DbClusterId",
      "zh-cn": "主集群ID"
    }
  }
  EOT
}

variable "gdn_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the GDN."
    },
    "Label": {
      "en": "GdnDescription",
      "zh-cn": "GDN备注描述"
    }
  }
  EOT
}

resource "alicloud_polardb_global_database_network" "extension_resource" {
  db_cluster_id = var.db_cluster_id
  description   = var.gdn_description
}

output "connections" {
  // Could not transform ROS Attribute Connections to Terraform attribute.
  value       = null
  description = "The information about the connection to the cluster."
}

output "db_clusters" {
  // Could not transform ROS Attribute DbClusters to Terraform attribute.
  value       = null
  description = "The clusters that are included in the GDN."
}

output "db_version" {
  // Could not transform ROS Attribute DbVersion to Terraform attribute.
  value       = null
  description = "The version of the database engine."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The time at which the GDN was created."
}

output "gdn_id" {
  value       = alicloud_polardb_global_database_network.extension_resource.id
  description = "The ID of the GDN."
}

output "db_type" {
  // Could not transform ROS Attribute DbType to Terraform attribute.
  value       = null
  description = "The type of the database engine."
}

output "gdn_description" {
  // Could not transform ROS Attribute GdnDescription to Terraform attribute.
  value       = null
  description = "The description of the GDN."
}

