variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the access_group.\nThe value contains 0 to 100 characters"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "权限组描述"
    },
    "MaxLength": 100
  }
  EOT
}

variable "network_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The NetworkType of Access Group. Valid values: VPC."
    },
    "AllowedValues": [
      "VPC"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "权限组类型"
    }
  }
  EOT
}

variable "access_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Name of Access Group. The naming rules are as follows:\nThe value contains 6 to 100 characters.\nGlobally unique and cannot be an empty string."
    },
    "Label": {
      "en": "AccessGroupName",
      "zh-cn": "权限组名称"
    },
    "MinLength": 6,
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_dfs_access_group" "access_group" {
  description       = var.description
  network_type      = var.network_type
  access_group_name = var.access_group_name
}

output "access_group_id" {
  value       = alicloud_dfs_access_group.access_group.id
  description = "The ID of the access_group."
}

