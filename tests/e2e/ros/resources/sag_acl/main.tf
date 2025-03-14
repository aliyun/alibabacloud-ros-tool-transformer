variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Access control name.\nThe length is 2-128 characters. It must start with a letter or Chinese. It can contain numbers, periods (.), underscores (_) and dashes (-), but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "访问控制名称"
    }
  }
  EOT
}

resource "alicloud_sag_acl" "acl" {
  name = var.name
}

output "acl_id" {
  value       = alicloud_sag_acl.acl.id
  description = "Access control set ID."
}

