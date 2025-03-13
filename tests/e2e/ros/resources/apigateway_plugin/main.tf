variable "plugin_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the plug-in that you want to create. It can contain uppercase English letters, lowercase English letters, Chinese characters, numbers, and underscores (). It must be 4 to 50 characters in length and cannot start with an underscore ()."
    },
    "Label": {
      "en": "PluginName",
      "zh-cn": "插件名称"
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
      "en": "The description of the plug-in, which cannot exceed 200 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "插件说明"
    }
  }
  EOT
}

variable "plugin_data" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The definition statement of the plug-in. Plug-in definition statements in the JSON and YAML formats are supported."
    },
    "Label": {
      "en": "PluginData",
      "zh-cn": "插件定义语句"
    }
  }
  EOT
}

variable "plugin_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the plug-in. Valid values: ipControl: indicates IP address-based access control. trafficControl: indicates throttling. backendSignature: indicates backend signature. jwtAuth: indicates JWT (OpenId Connect). cors: indicates cross-origin resource access (CORS). caching: indicates caching."
    },
    "Label": {
      "en": "PluginType",
      "zh-cn": "插件类型"
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

resource "alicloud_api_gateway_plugin" "api_gateway_plugin" {
  plugin_name = var.plugin_name
  description = var.description
  plugin_data = var.plugin_data
  plugin_type = var.plugin_type
  tags        = var.tags
}

output "description" {
  value       = alicloud_api_gateway_plugin.api_gateway_plugin.description
  description = "The description of the plug-in, which cannot exceed 200 characters."
}

output "plugin_name" {
  value       = alicloud_api_gateway_plugin.api_gateway_plugin.plugin_name
  description = "The name of the plug-in that you want to create. It can contain uppercase English letters, lowercase English letters, Chinese characters, numbers, and underscores (). It must be 4 to 50 characters in length and cannot start with an underscore ()."
}

output "plugin_data" {
  value       = alicloud_api_gateway_plugin.api_gateway_plugin.plugin_data
  description = "The definition statement of the plug-in. Plug-in definition statements in the JSON and YAML formats are supported."
}

output "plugin_id" {
  value       = alicloud_api_gateway_plugin.api_gateway_plugin.id
  description = "The generated plugin ID."
}

output "plugin_type" {
  value       = alicloud_api_gateway_plugin.api_gateway_plugin.plugin_type
  description = "The type of the plug-in. Valid values: ipControl: indicates IP address-based access control. trafficControl: indicates throttling. backendSignature: indicates backend signature. jwtAuth: indicates JWT (OpenId Connect). cors: indicates cross-origin resource access (CORS). caching: indicates caching."
}

