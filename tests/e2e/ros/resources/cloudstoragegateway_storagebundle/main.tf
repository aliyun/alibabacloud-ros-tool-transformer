variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the gateway cluster. The description must be 0 to 128 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "网关集群描述"
    }
  }
  EOT
}

variable "storage_bundle_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the gateway cluster. The name must be 1 to 60 characters in length and can contain letters, digits, periods (.), underscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "StorageBundleName",
      "zh-cn": "网关集群名"
    }
  }
  EOT
}

resource "alicloud_cloud_storage_gateway_storage_bundle" "extension_resource" {
  description         = var.description
  storage_bundle_name = var.storage_bundle_name
}

output "description" {
  value       = alicloud_cloud_storage_gateway_storage_bundle.extension_resource.description
  description = "Gateway cluster description."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "Create a gateway cluster timestamp."
}

output "storage_bundle_id" {
  value       = alicloud_cloud_storage_gateway_storage_bundle.extension_resource.id
  description = "The ID of the gateway cluster."
}

output "storage_bundle_name" {
  value       = alicloud_cloud_storage_gateway_storage_bundle.extension_resource.storage_bundle_name
  description = "Gateway cluster name."
}

