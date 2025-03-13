variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the bundle."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "桌面模板描述"
    }
  }
  EOT
}

variable "root_disk_size_gib" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The root disk size gib."
    },
    "Label": {
      "en": "RootDiskSizeGib",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "language" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The language. Valid values:\nzh-CN: Simplified Chinese\nzh-HK: Traditional Chinese (Hong Kong)\nen-US: English\nja-JP: Japanese"
    },
    "AllowedValues": [
      "zh-CN",
      "zh-HK",
      "en-US",
      "ja-JP"
    ],
    "Label": {
      "en": "Language",
      "zh-cn": "操作系统语言"
    }
  }
  EOT
}

variable "root_disk_performance_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The root disk performance level. Valid values:\nPL0\nPL1\nPL2\nPL3\n"
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "en": "RootDiskPerformanceLevel",
      "zh-cn": "系统盘的性能等级"
    }
  }
  EOT
}

variable "desktop_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Desktop specifications.You can call Describundles to query the desktop bundle and get the currently supported desktop specification from the returned desktopType.\nExplain that ordinary mirrors cannot choose the GPU specifications, and the GPU type mirror can only choose the GPU specification."
    },
    "Label": {
      "en": "DesktopType",
      "zh-cn": "桌面规格"
    }
  }
  EOT
}

variable "bundle_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the bundle."
    },
    "Label": {
      "en": "BundleName",
      "zh-cn": "桌面模板名称"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the image."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "user_disk_performance_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The user disk performance level.Valid values:\nPL0\nPL1\nPL2\nPL3\n"
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "en": "UserDiskPerformanceLevel",
      "zh-cn": "数据盘的性能等级"
    }
  }
  EOT
}

variable "user_disk_size_gib" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "Number",
        "Description": {
          "en": "user disk size."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The size of the data disk. Currently, only one data disk can be set. Unit: GiB.\n- The size of the data disk that supports the setting corresponds to the specification.\n- The data disk size (user_disk_size_gib) set in the template must be greater than the data disk size (data_disk_size) in the mirror."
    },
    "Label": {
      "en": "UserDiskSizeGib",
      "zh-cn": "数据盘大小"
    },
    "MaxLength": 1
  }
  EOT
}

resource "alicloud_ecd_bundle" "bundle" {
  description                 = var.description
  root_disk_size_gib          = var.root_disk_size_gib
  language                    = var.language
  root_disk_performance_level = var.root_disk_performance_level
  desktop_type                = var.desktop_type
  bundle_name                 = var.bundle_name
  image_id                    = var.image_id
  user_disk_performance_level = var.user_disk_performance_level
  user_disk_size_gib          = var.user_disk_size_gib
}

output "bundle_id" {
  value       = alicloud_ecd_bundle.bundle.id
  description = "Desktop bundle ID."
}

