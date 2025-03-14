variable "user_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::User",
    "Description": {
      "en": "Specifies the user name, containing up to 64 characters."
    },
    "Label": {
      "en": "UserName",
      "zh-cn": "用户名"
    }
  }
  EOT
}

resource "alicloud_ram_access_key" "access_key" {
  user_name = var.user_name
}

output "status" {
  value       = alicloud_ram_access_key.access_key.status
  description = "Status of access key."
}

output "access_key_id" {
  value       = alicloud_ram_access_key.access_key.id
  description = "Id of access key."
}

output "access_key_secret" {
  // Could not transform ROS Attribute AccessKeySecret to Terraform attribute.
  value       = null
  description = "Secret of access key."
}

