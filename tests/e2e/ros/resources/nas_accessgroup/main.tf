variable "access_group_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Vpc",
      "Classic"
    ],
    "Description": {
      "en": "Permission group type, including the Vpc and Classic types"
    },
    "Label": {
      "en": "AccessGroupType",
      "zh-cn": "权限组类型"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Permission group description. It is the same as the permission group name by default.",
      "zh-cn": "权限组描述，默认和名称相同。"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "权限组描述"
    }
  }
  EOT
}

variable "file_system_type" {
  type        = string
  default     = "standard"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "NasFileSystemType"
    },
    "Description": {
      "en": "File system type.\nValues: standard (default), extreme"
    },
    "AllowedValues": [
      "standard",
      "extreme",
      "cpfs"
    ],
    "Label": {
      "en": "FileSystemType",
      "zh-cn": "文件系统类型"
    }
  }
  EOT
}

variable "access_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Permission group name"
    },
    "AllowedPattern": "^[_a-zA-Z0-9-]{3,64}$",
    "Label": {
      "en": "AccessGroupName",
      "zh-cn": "权限组名称"
    }
  }
  EOT
}

resource "alicloud_nas_access_group" "access_group" {
  access_group_type = var.access_group_type
  description       = var.description
  file_system_type  = var.file_system_type
  access_group_name = var.access_group_name
}

output "access_group_name" {
  value       = alicloud_nas_access_group.access_group.id
  description = "Permission group name"
}

