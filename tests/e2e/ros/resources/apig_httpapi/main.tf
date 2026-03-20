variable "http_api_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the API."
    },
    "Label": {
      "en": "HttpApiName",
      "zh-cn": "API 名称"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of HTTP API, Valid values:\n* Http\n* Rest\n* WebSocket\n* HttpIngress"
    },
    "AllowedValues": [
      "Http",
      "Rest",
      "WebSocket",
      "HttpIngress"
    ],
    "Label": {
      "en": "Type",
      "zh-cn": "HTTP API 的类型"
    }
  }
  EOT
}

variable "protocols" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "API protocol."
        },
        "AllowedValues": [
          "HTTP",
          "HTTPS"
        ],
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "List of API Access Protocols."
    },
    "Label": {
      "en": "Protocols",
      "zh-cn": "API 访问协议列表"
    },
    "MaxLength": 2
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of API."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "API 描述"
    },
    "MinLength": 0,
    "MaxLength": 225
  }
  EOT
}

variable "base_path" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The base path of the API should start with a /."
    },
    "Label": {
      "en": "BasePath",
      "zh-cn": "API 基础路径"
    }
  }
  EOT
}

resource "alicloud_apig_http_api" "extension_resource" {
  http_api_name = var.http_api_name
  type          = var.type
  protocols     = var.protocols
  description   = var.description
  base_path     = var.base_path
}

output "http_api_id" {
  value       = alicloud_apig_http_api.extension_resource.id
  description = "The ID of the API."
}

