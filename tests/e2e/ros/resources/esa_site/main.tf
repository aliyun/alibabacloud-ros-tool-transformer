variable "site_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Site."
    },
    "Label": {
      "en": "SiteName",
      "zh-cn": "站点名称"
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
      "zh-cn": "资源组 ID"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the associated package instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例 ID"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Payment type."
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "coverage" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Acceleration area."
    },
    "Label": {
      "en": "Coverage",
      "zh-cn": "加速区域"
    }
  }
  EOT
}

variable "tags" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
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
      "en": "Tags of the site."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "站点绑定的标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "access_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Access Type of the Site."
    },
    "AllowedValues": [
      "CNAME",
      "NS"
    ],
    "Label": {
      "en": "AccessType",
      "zh-cn": "站点的接入类型"
    }
  }
  EOT
}

resource "alicloud_esa_site" "extension_resource" {
  site_name         = var.site_name
  resource_group_id = var.resource_group_id
  instance_id       = var.instance_id
  coverage          = var.coverage
  tags              = var.tags
  access_type       = var.access_type
}

output "site_id" {
  value       = alicloud_esa_site.extension_resource.id
  description = "The ID of the Site."
}

output "create_time" {
  value       = alicloud_esa_site.extension_resource.create_time
  description = "Creation time."
}

