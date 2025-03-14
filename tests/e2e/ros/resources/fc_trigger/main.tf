variable "function_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Function name."
    },
    "Label": {
      "en": "FunctionName",
      "zh-cn": "要创建触发器的函数名称"
    }
  }
  EOT
}

variable "trigger_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "cdn_events": {
          "en": "CDN Events Trigger",
          "zh-cn": "CDN事件触发器"
        },
        "timer": {
          "en": "Timer Trigger",
          "zh-cn": "定时触发器"
        },
        "log": {
          "en": "Log Service Trigger",
          "zh-cn": "日志服务触发器"
        },
        "mns_topic": {
          "en": "MNS Topic Trigger",
          "zh-cn": "MNS主题触发器"
        },
        "http": {
          "en": "HTTP Trigger",
          "zh-cn": "HTTP触发器"
        },
        "oss": {
          "en": "OSS Trigger",
          "zh-cn": "OSS触发器"
        },
        "tablestore": {
          "en": "Tablestore Trigger",
          "zh-cn": "Tablestore触发器"
        }
      },
      "AutoChangeType": false
    },
    "Description": {
      "en": "Trigger type, e.g. oss, timer, logs. This determines how the trigger config is interpreted.\nExample : \"oss\""
    },
    "AllowedValues": [
      "oss",
      "log",
      "tablestore",
      "mns_topic",
      "http",
      "timer",
      "cdn_events"
    ],
    "Label": {
      "en": "TriggerType",
      "zh-cn": "触发器类型"
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
      "en": "Trigger name.\nExample : \"image_resize\""
    },
    "Label": {
      "en": "TriggerName",
      "zh-cn": "触发器名称"
    }
  }
  EOT
}

variable "source_arn" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Or": [
              {
                "Fn::Equals": [
                  "$${TriggerType}",
                  "timer"
                ]
              },
              {
                "Fn::Equals": [
                  "$${TriggerType}",
                  "http"
                ]
              }
            ]
          }
        }
      }
    },
    "Description": {
      "en": "The Aliyun Resource Name (ARN) of event source. This is optional for some triggers.\nExample : \"acs:oss:cn-shanghai:12345:mybucket\""
    },
    "Label": {
      "en": "SourceArn",
      "zh-cn": "事件源ARN"
    }
  }
  EOT
}

variable "service_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Service name."
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "函数服务名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "trigger_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Event source specific trigger configuration. The value is different according to trigger type."
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
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Or": [
              {
                "Fn::Equals": [
                  "$${TriggerType}",
                  "timer"
                ]
              },
              {
                "Fn::Equals": [
                  "$${TriggerType}",
                  "http"
                ]
              }
            ]
          }
        }
      }
    },
    "Description": {
      "en": "The role grants event source the permission to run function on behalf of user. This is optional for some triggers.\nExample : \"acs:ram::1234567890:role/fc-test\"",
      "zh-cn": "触发器角色，该角色授予事件源代表用户运行函数的权限。例如：acs:ram::164696547407****:role/fc-test。"
    },
    "Label": {
      "en": "InvocationRole",
      "zh-cn": "触发器角色"
    }
  }
  EOT
}

variable "qualifier" {
  type        = string
  default     = "LATEST"
  description = <<EOT
  {
    "Description": {
      "en": "service version or alias.\nExample : \"LATEST\""
    },
    "Label": {
      "en": "Qualifier",
      "zh-cn": "触发版本"
    }
  }
  EOT
}

resource "alicloud_fc_trigger" "trigger" {
  function   = var.function_name
  type       = var.trigger_type
  name       = var.trigger_name
  source_arn = var.source_arn
  service    = var.service_name
  config     = var.trigger_config
  role       = var.invocation_role
}

output "function_name" {
  // Could not transform ROS Attribute FunctionName to Terraform attribute.
  value       = null
  description = "Function name."
}

output "url_intranet" {
  // Could not transform ROS Attribute UrlIntranet to Terraform attribute.
  value       = null
  description = "The private endpoint. In a VPC, you can access HTTP triggers by using HTTP or HTTPS."
}

output "trigger_name" {
  // Could not transform ROS Attribute TriggerName to Terraform attribute.
  value       = null
  description = "Trigger name."
}

output "trigger_id" {
  value       = alicloud_fc_trigger.trigger.trigger_id
  description = "The trigger ID."
}

output "service_name" {
  // Could not transform ROS Attribute ServiceName to Terraform attribute.
  value       = null
  description = "Service name."
}

output "url_internet" {
  // Could not transform ROS Attribute UrlInternet to Terraform attribute.
  value       = null
  description = "The public domain address. You can access HTTP triggers over the Internet by using HTTP or HTTPS."
}

