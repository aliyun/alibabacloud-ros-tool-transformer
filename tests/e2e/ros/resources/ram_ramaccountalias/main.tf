variable "account_alias" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The alias of the Alibaba Cloud account.\nThe alias must be 1 to 50 characters in length, and can contain lowercase letters,\ndigits, hyphens (-), periods (.) and underscores (_).\nNote It cannot start or end with a hyphen (-).The default domain name cannot start or end with a \nhyphen (-) and cannot have two consecutive hyphens (-)."
    },
    "AllowedPattern": "[-0-9.a-zA-Z_]{1,50}",
    "Label": {
      "en": "AccountAlias",
      "zh-cn": "账号别名"
    },
    "MinLength": 1,
    "MaxLength": 50
  }
  EOT
}

resource "alicloud_ram_account_alias" "ram_account_alias" {
  account_alias = var.account_alias
}

output "account_alias" {
  value       = alicloud_ram_account_alias.ram_account_alias.id
  description = "The alias of the Alibaba Cloud account."
}

