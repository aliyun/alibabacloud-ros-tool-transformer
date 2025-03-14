variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Project description: <>'\"\\ is not supported, up to 64 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "日志项目的描述"
    },
    "MaxLength": 64
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the sls project belongs. If not provided, the project belongs to the default resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "Project 所属的资源组 ID"
    }
  }
  EOT
}

variable "data_redundancy_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Disaster recovery type.LRS: Local redundant storage.ZRS: Local redundant storage."
    },
    "AllowedValues": [
      "LRS",
      "ZRS"
    ],
    "Label": {
      "en": "DataRedundancyType",
      "zh-cn": "数据冗余类型"
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
      "en": "Tags to attach to project. Max support 20 tags to add during create project. Each tag with two properties Key and Value, and Key is required."
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
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9-]+$",
    "Label": {
      "en": "Name",
      "zh-cn": "日志项目的名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

resource "alicloud_log_project" "project" {
  description = var.description
  tags        = var.tags
  name        = var.name
}

output "name" {
  value       = alicloud_log_project.project.id
  description = "Project name."
}

