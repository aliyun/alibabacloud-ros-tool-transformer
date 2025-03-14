variable "status" {
  type        = string
  default     = "Enabled"
  description = <<EOT
  {
    "Description": {
      "en": "The new status of the SCIM credential. Valid values:\n- Enabled: The SCIM credential is enabled.\n- Disabled: The SCIM credential is disabled.\nThe default value is Enabled."
    },
    "AllowedValues": [
      "Enabled",
      "Disabled"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "SCIM密钥状态"
    }
  }
  EOT
}

variable "directory_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the directory."
    },
    "Label": {
      "en": "DirectoryId",
      "zh-cn": "目录ID"
    }
  }
  EOT
}

resource "alicloud_cloud_sso_scim_server_credential" "scim_server_credential" {
  status       = var.status
  directory_id = var.directory_id
}

output "credential_id" {
  value       = alicloud_cloud_sso_scim_server_credential.scim_server_credential.credential_id
  description = "The ID of the SCIM credential."
}

output "credential_secret" {
  // Could not transform ROS Attribute CredentialSecret to Terraform attribute.
  value       = null
  description = "The secret of the SCIM credential."
}

