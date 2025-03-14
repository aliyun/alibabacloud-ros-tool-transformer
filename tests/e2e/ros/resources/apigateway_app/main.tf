variable "app_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The app code of the APP.\nThe length is 8~128 English characters, which can contain numbers, underscores (_) and dashes (-),and AppCode is globally unique."
    },
    "AllowedPattern": "^[-_a-zA-Z0-9]{8,128}$",
    "Label": {
      "en": "AppCode",
      "zh-cn": "应用的AppCode"
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
      "en": "Description of the App, less than 180 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "App描述信息"
    }
  }
  EOT
}

variable "app_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The key of the APP. \nThe length is 8~128 English characters, which can contain numbers, underscores (_) and dashes (-),\nand AppKey is globally unique."
    },
    "AllowedPattern": "^[-_a-zA-Z0-9]{8,128}$",
    "Label": {
      "en": "AppKey",
      "zh-cn": "App的密钥"
    }
  }
  EOT
}

variable "app_secret" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secret of the APP. \nThe length is 8~128 English characters, which can contain numbers, underscores (_) and dashes (-)."
    },
    "AllowedPattern": "^[-_a-zA-Z0-9]{8,128}$",
    "Label": {
      "en": "AppSecret",
      "zh-cn": "App密码"
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
      "en": "Tags to attach to app. Max support 20 tags to add during create app. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "app_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the App.Need [4, 26] Chinese\\English\\Number characters or \"_\",and should start with Chinese/English character."
    },
    "Label": {
      "en": "AppName",
      "zh-cn": "App的名称"
    }
  }
  EOT
}

resource "alicloud_api_gateway_app" "app" {
  description = var.description
  tags        = var.tags
  name        = var.app_name
}

output "app_code" {
  // Could not transform ROS Attribute AppCode to Terraform attribute.
  value       = null
  description = "The code of the APP."
}

output "app_id" {
  value       = alicloud_api_gateway_app.app.id
  description = "The id of the created APP"
}

output "app_key" {
  // Could not transform ROS Attribute AppKey to Terraform attribute.
  value       = null
  description = "The key of the APP"
}

output "app_secret" {
  // Could not transform ROS Attribute AppSecret to Terraform attribute.
  value       = null
  description = "The secret of the APP"
}

output "tags" {
  value       = alicloud_api_gateway_app.app.tags
  description = "Tags of app"
}

