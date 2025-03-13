variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Domain name group name"
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "域名分组名称"
    }
  }
  EOT
}

resource "alicloud_dns_group" "domain_group" {
  name = var.group_name
}

output "group_id" {
  value       = alicloud_dns_group.domain_group.id
  description = "Domain name group ID"
}

