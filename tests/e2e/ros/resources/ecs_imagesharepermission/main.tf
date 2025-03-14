variable "keep_permission" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to keep the original sharing permissions when resource is deleted, default is true.If set to false, Accounts will be removed if Accounts is set and IsPublic will be changed if IsPublic is set."
    },
    "Label": {
      "en": "KeepPermission",
      "zh-cn": "删除资源时是否保留原有的共享权限"
    }
  }
  EOT
}

variable "is_public" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to publish or remove community mirrors. \nIf this property is not set, no changes will be made to the community image"
    },
    "Label": {
      "en": "IsPublic",
      "zh-cn": "是否发布或下架社区镜像"
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
      "en": "The shared custom image ID."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "被共享的自定义镜像ID"
    }
  }
  EOT
}

variable "accounts" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Alibaba Cloud account ID authorized to share the image."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Alibaba Cloud account IDs authorized to share the image."
    },
    "Label": {
      "en": "Accounts",
      "zh-cn": "授权共享镜像的阿里云账号ID"
    },
    "MinLength": 0,
    "MaxLength": 10
  }
  EOT
}

resource "alicloud_image_share_permission" "image_share_permission" {
  image_id = var.image_id
}

output "image_id" {
  value       = alicloud_image_share_permission.image_share_permission.image_id
  description = "The shared custom image ID."
}

