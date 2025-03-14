variable "maximum_message_size" {
  type        = number
  default     = 65536
  description = <<EOT
  {
    "Description": {
      "en": "Maximum body length of a message sent to the topic, in the unit of bytes.\nAn integer in the range of 1,024 (1 KB) to 65, 536 (64 KB); default value: 65,536 (64 KB)."
    },
    "MinValue": 1024,
    "Label": {
      "en": "MaximumMessageSize",
      "zh-cn": "发送到该主题的消息体最大长度"
    },
    "MaxValue": 65536
  }
  EOT
}

variable "logging_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable log management. \"true\" indicates that log management is enabled, whereas \"false\" indicates that log management is disabled. \nThe default value is false"
    },
    "Label": {
      "en": "LoggingEnabled",
      "zh-cn": "是否开启日志管理功能"
    }
  }
  EOT
}

variable "topic_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Topic name"
    },
    "Label": {
      "en": "TopicName",
      "zh-cn": "主题名称"
    },
    "MinLength": 1,
    "MaxLength": 256
  }
  EOT
}

resource "alicloud_message_service_topic" "topic" {
  logging_enabled = var.logging_enabled
  topic_name      = var.topic_name
}

output "topic_url" {
  // Could not transform ROS Attribute TopicUrl to Terraform attribute.
  value       = null
  description = "URL of created topic"
}

output "arn" {
  // Could not transform ROS Attribute ARN to Terraform attribute.
  value       = null
  description = "The ARN for ALIYUN::ROS::CustomResource"
}

output "arn._with_slash" {
  // Could not transform ROS Attribute ARN.WithSlash to Terraform attribute.
  value       = null
  description = "The ARN: acs:mns:$region:$accountid:/topics/$topicName"
}

output "topic_name" {
  value       = alicloud_message_service_topic.topic.id
  description = "Topic name"
}

