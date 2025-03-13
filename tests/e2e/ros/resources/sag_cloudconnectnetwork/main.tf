variable "is_default" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether is created by system"
    },
    "Label": {
      "en": "IsDefault",
      "zh-cn": "云连接网是否由系统创建"
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
      "en": "The description of the CCN instance.\nThe description can contain 2 to 256 characters. The description cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "云连接网的描述"
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
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
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
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
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
      "en": "The name of the CCN instance.\nThe name can contain 2 to 128 characters including a-z, A-Z, 0-9, chinese, underlines, and hyphens. The name must start with an English letter, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "云连接网的名称"
    }
  }
  EOT
}

resource "alicloud_cloud_connect_network" "cloud_connect_network" {
  is_default  = var.is_default
  description = var.description
  name        = var.name
}

output "ccn_id" {
  value       = alicloud_cloud_connect_network.cloud_connect_network.id
  description = "The ID of the CCN instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

