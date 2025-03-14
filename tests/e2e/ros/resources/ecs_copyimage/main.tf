variable "source_region_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::RegionId",
    "Description": {
      "en": "ID of the region to where the source image belongs. Default is current region ID."
    },
    "Label": {
      "en": "SourceRegionId",
      "zh-cn": "源自定义镜像所在的地域ID"
    }
  }
  EOT
}

variable "kmskey_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the key used to encrypt the image."
    },
    "Label": {
      "en": "KMSKeyId",
      "zh-cn": "加密自定义镜像使用的密钥ID"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the image copy belongs. If not provided, the image copy belongs to the default resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "allow_copy_in_same_region" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to allow copying images in the same region. \nIf set to true, the image will not be copied, the source image id will be returned, and the original image will not be deleted."
    },
    "Label": {
      "en": "AllowCopyInSameRegion",
      "zh-cn": "是否允许复制同一区域内的镜像"
    }
  }
  EOT
}

variable "destination_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::RegionId",
    "Description": {
      "en": "ID of the region to where the destination custom image belongs."
    },
    "Label": {
      "en": "DestinationRegionId",
      "zh-cn": "复制后的自定义镜像所在的地域ID"
    }
  }
  EOT
}

variable "encrypted" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to encrypt the image."
    },
    "Label": {
      "en": "Encrypted",
      "zh-cn": "是否加密复制后的自定义镜像"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "RegionId": "$${SourceRegionId}",
      "SupportedImageOwnerAlias": [
        "system",
        "self",
        "others"
      ]
    },
    "AssociationProperty": "ALIYUN::ECS::Image::ImageId",
    "Description": {
      "en": "ID of the source custom image."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "源自定义镜像ID"
    }
  }
  EOT
}

variable "destination_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the destination custom image.It cannot begin with http:// or https://.  Default value: null."
    },
    "Label": {
      "en": "DestinationDescription",
      "zh-cn": "复制后的自定义镜像的描述信息"
    }
  }
  EOT
}

variable "tag" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "Customize the label value of the image."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Custom image tag key."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Tag",
      "zh-cn": "标签"
    }
  }
  EOT
}

variable "destination_image_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of the destination custom image.The name is a string of 2 to 128 characters. It must begin with an English or a Chinese character. It can contain A-Z, a-z, Chinese characters, numbers, periods (.), colons (:), underscores (_), and hyphens (-).  Default value: null."
    },
    "Label": {
      "en": "DestinationImageName",
      "zh-cn": "复制后的自定义镜像的名称"
    }
  }
  EOT
}

resource "alicloud_image_copy" "copy_image" {
  source_region_id = var.source_region_id
  kms_key_id       = var.kmskey_id
  encrypted        = var.encrypted
  source_image_id  = var.image_id
  tags             = var.tag
  image_name       = var.destination_image_name
}

output "source_region_id" {
  // Could not transform ROS Attribute SourceRegionId to Terraform attribute.
  value       = null
  description = "ID of the region to where the source image belongs."
}

output "destination_region_id" {
  // Could not transform ROS Attribute DestinationRegionId to Terraform attribute.
  value       = null
  description = "ID of the region to where the destination custom image belongs."
}

output "image_id" {
  value       = alicloud_image_copy.copy_image.id
  description = "ID of the source custom image."
}

