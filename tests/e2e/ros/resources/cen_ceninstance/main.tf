variable "protection_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The level of CIDR block overlapping. \nSet the value to REDUCED. REDUCED indicates that the \nCIDR blocks can overlap with each other but must not be the same."
    },
    "Label": {
      "en": "ProtectionLevel",
      "zh-cn": "网段重叠冲突的级别"
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
      "en": "The description of the instance.\nThe name can be 2-256 characters in length. It can start with an uppercase letter, lowercase letter, or Chinese character. It can contain numbers, underscores (_), and hyphens (-), but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "云企业网实例的描述信息"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "zh-cn": "云企业网实例的标签"
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
      "en": "The name of the instance.\nThe name can be 2-128 characters in length. It can start with an uppercase letter, lowercase letter, or Chinese character. It can contain numbers, underscores (_), and hyphens (-), but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "云企业网实例的名称"
    }
  }
  EOT
}

resource "alicloud_cen_instance" "cen_instance" {
  protection_level = var.protection_level
  description      = var.description
  tags             = var.tags
  name             = var.name
}

output "cen_id" {
  value       = alicloud_cen_instance.cen_instance.id
  description = "The ID of the request."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

