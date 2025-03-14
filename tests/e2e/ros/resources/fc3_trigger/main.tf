variable "trigger_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Type of the trigger."
    },
    "Label": {
      "en": "TriggerType",
      "zh-cn": "触发器的类型"
    }
  }
  EOT
}

variable "function_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the function."
    },
    "Label": {
      "en": "FunctionName",
      "zh-cn": "函数名称"
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
      "en": "Description of the trigger."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "触发器描述"
    }
  }
  EOT
}

variable "trigger_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Name of the trigger."
    },
    "Label": {
      "en": "TriggerName",
      "zh-cn": "触发器的名称"
    }
  }
  EOT
}

variable "source_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source ARN of the trigger."
    },
    "Label": {
      "en": "SourceArn",
      "zh-cn": "触发器事件源的 Aliyun Resource Name"
    }
  }
  EOT
}

variable "trigger_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Trigger config."
    },
    "Label": {
      "en": "TriggerConfig",
      "zh-cn": "触发器配置"
    }
  }
  EOT
}

variable "invocation_role" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Invocation role."
    },
    "Label": {
      "en": "InvocationRole",
      "zh-cn": "事件源（如 OSS）调用函数所需的角色"
    }
  }
  EOT
}

variable "qualifier" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Qualifier of the trigger."
    },
    "Label": {
      "en": "Qualifier",
      "zh-cn": "函数的版本或别名"
    }
  }
  EOT
}

resource "alicloud_fcv3_trigger" "trigger" {
  trigger_type    = var.trigger_type
  function_name   = var.function_name
  description     = var.description
  trigger_name    = var.trigger_name
  source_arn      = var.source_arn
  invocation_role = var.invocation_role
  qualifier       = var.qualifier
}

output "function_name" {
  value       = alicloud_fcv3_trigger.trigger.function_name
  description = "Function name."
}

output "url_intranet" {
  // Could not transform ROS Attribute UrlIntranet to Terraform attribute.
  value       = null
  description = "The private endpoint. In a VPC, you can access HTTP triggers by using HTTP or HTTPS."
}

output "trigger_name" {
  value       = alicloud_fcv3_trigger.trigger.trigger_name
  description = "Trigger name."
}

output "trigger_id" {
  value       = alicloud_fcv3_trigger.trigger.id
  description = "The trigger ID."
}

output "url_internet" {
  // Could not transform ROS Attribute UrlInternet to Terraform attribute.
  value       = null
  description = "The public domain address. You can access HTTP triggers over the Internet by using HTTP or HTTPS."
}

