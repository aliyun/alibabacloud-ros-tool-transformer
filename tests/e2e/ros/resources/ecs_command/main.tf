variable "working_dir" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The path where command will be executed in the instance."
    },
    "Label": {
      "en": "WorkingDir",
      "zh-cn": "您创建的命令在ECS实例中运行的目录"
    }
  }
  EOT
}

variable "command_content" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The content of command. Content requires base64 encoding. Maximum size support 16KB."
    },
    "Label": {
      "en": "CommandContent",
      "zh-cn": "命令Base64编码后的内容"
    }
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of command."
    },
    "Label": {
      "en": "Type",
      "zh-cn": "命令的类型"
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
      "en": "The description of command."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "命令描述"
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
      "zh-cn": "命令所属的资源组ID"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Total timeout when the command is executed in the instance. Input the time unit as second. Default is 60s."
    },
    "Label": {
      "en": "Timeout",
      "zh-cn": "您创建的命令在ECS实例中执行时的超时时间"
    }
  }
  EOT
}

variable "enable_parameter" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the script contains custom parameters.\nDefault value: false"
    },
    "Label": {
      "en": "EnableParameter",
      "zh-cn": "创建的命令是否使用自定义参数"
    }
  }
  EOT
}

variable "content_encoding" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The encoding mode of script content (CommandContent). Valid values (case insensitive):\nPlainText: The script content is not encoded, and transmitted in plaintext.\nBase64: base64-encoded.\nDefault value: Base64. If the specified value of this parameter is invalid, Base64 is used by default."
    },
    "AllowedValues": [
      "PlainText",
      "Base64"
    ],
    "Label": {
      "en": "ContentEncoding",
      "zh-cn": "命令内容（CommandContent）的编码方式"
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
      "en": "Tags to attach to command. Max support 20 tags to add during create command. Each tag with two properties Key and Value, and Key is required.",
      "zh-cn": "实例的标签。最多支持添加20个标签。"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例的标签"
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
      "en": "The name of command."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "命令名称"
    }
  }
  EOT
}

resource "alicloud_ecs_command" "command" {
  working_dir      = var.working_dir
  command_content  = var.command_content
  type             = var.type
  description      = var.description
  timeout          = var.timeout
  enable_parameter = var.enable_parameter
  name             = var.name
}

output "command_id" {
  value       = alicloud_ecs_command.command.id
  description = "The id of command created."
}

