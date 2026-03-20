variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the custom list."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "列表描述"
    }
  }
  EOT
}

variable "list_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the custom list."
    },
    "Label": {
      "en": "ListName",
      "zh-cn": "列表名称"
    }
  }
  EOT
}

variable "kind" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "host",
      "ip",
      "asn"
    ],
    "Description": {
      "en": "The type of the custom list."
    },
    "Label": {
      "en": "Kind",
      "zh-cn": "列表种类"
    }
  }
  EOT
}

variable "items" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The item in the custom list."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The items in the custom list, which are displayed as an array."
    },
    "Label": {
      "en": "Items",
      "zh-cn": "列表内容"
    },
    "MinLength": 0,
    "MaxLength": 500
  }
  EOT
}

resource "alicloud_esa_list" "extension_resource" {
  description = var.description
  name        = var.list_name
  kind        = var.kind
  items       = var.items
}

output "list_id" {
  value       = alicloud_esa_list.extension_resource.id
  description = "The id of the custom list ."
}

