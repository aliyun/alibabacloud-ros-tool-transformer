variable "component_type" {
  type        = string
  default     = "Build"
  description = <<EOT
  {
    "Description": {
      "en": "The type of the image component. Only image build components are supported. Set the value to Build.Default value: Build."
    },
    "AllowedValues": [
      "Build"
    ],
    "Label": {
      "en": "ComponentType",
      "zh-cn": "组件类型"
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
      "en": "The description. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "企业资源组ID"
    }
  }
  EOT
}

variable "content" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The content of the image component. The content consists of up to 127 commands."
    },
    "Label": {
      "en": "Content",
      "zh-cn": "组件内容"
    }
  }
  EOT
}

variable "system_type" {
  type        = string
  default     = "Linux"
  description = <<EOT
  {
    "Description": {
      "en": "The operating system type supported by the image component. Only Linux is supported. Set the value to Linux.Default value: Linux."
    },
    "AllowedValues": [
      "Linux"
    ],
    "Label": {
      "en": "SystemType",
      "zh-cn": "组件支持的操作系统"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The value of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag value can be an empty string. The tag value can be up to 128 characters in length and cannot start with acs:. The tag value cannot contain http:// or https://."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The key of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag key cannot be an empty string. The tag key can be up to 128 characters in length and cannot contain http:// or https://. It cannot start with acs: or aliyun."
          },
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The component name. The name must be 2 to 128 characters in length. The name must start with a letter but cannot start with http:// or https://.The name can contain letters, digits, colons (:), underscores (_), periods (.), and hyphens (-).\nNote If you do not configure Name, the return value of ImageComponentId is used."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "组件名称"
    }
  }
  EOT
}

resource "alicloud_ecs_image_component" "image_component" {
  component_type    = var.component_type
  description       = var.description
  resource_group_id = var.resource_group_id
  content           = var.content
  system_type       = var.system_type
  tags              = var.tags
}

output "image_component_id" {
  value       = alicloud_ecs_image_component.image_component.id
  description = "The ID of the image component."
}

