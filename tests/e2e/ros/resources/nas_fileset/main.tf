variable "file_system_path" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The absolute path of Fileset to be created.\nThe parent catalog of specified the directory must be a directory in the file system.\nThe length is 2 to 1024 characters.\nSpecify the directory must start with positive (/)."
    },
    "Label": {
      "en": "FileSystemPath",
      "zh-cn": "待创建的Fileset的绝对路径"
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
      "en": "Fileset description information.\nThe length is 2 to 128 English or Chinese characters.\nStart with a lowercase letter or Chinese, and you cannot start with http:// and https: //.\nIt can contain numbers, half-horn colon (:), down line (_) or short lines (-)."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "Fileset的描述信息"
    }
  }
  EOT
}

variable "file_system_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "File system ID."
    },
    "Label": {
      "en": "FileSystemId",
      "zh-cn": "文件系统ID"
    }
  }
  EOT
}

resource "alicloud_nas_fileset" "fileset" {
  file_system_path = var.file_system_path
  description      = var.description
  file_system_id   = var.file_system_id
}

output "fset_id" {
  // Could not transform ROS Attribute FsetId to Terraform attribute.
  value       = null
  description = "Fileset ID."
}

output "file_system_path" {
  value       = alicloud_nas_fileset.fileset.file_system_path
  description = "File system path."
}

output "file_system_id" {
  value       = alicloud_nas_fileset.fileset.id
  description = "File system ID."
}

