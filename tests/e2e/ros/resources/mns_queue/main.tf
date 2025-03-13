variable "delay_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "It is measured in seconds. All messages sent to the queue can be consumed until the DelaySeconds expires.\nAn integer between 0 and 604800 (7 days). The default value is 0"
    },
    "MinValue": 0,
    "Label": {
      "en": "DelaySeconds",
      "zh-cn": "发送到该队列的所有消息默认以DelaySeconds参数指定的秒数延后"
    },
    "MaxValue": 604800
  }
  EOT
}

variable "polling_wait_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "It is the maximum time that a ReceiveMessage request could be waiting for any incoming messages, while there are no message in the queue. Measured in seconds.\nAn integer between 0 and 30 seconds. The default value is 0 (seconds)",
      "zh-cn": "当队列中没有消息时，针对该队列的ReceiveMessage请求最长的等待时间。"
    },
    "MinValue": 0,
    "Label": {
      "en": "PollingWaitSeconds",
      "zh-cn": "当队列中没有消息时"
    },
    "MaxValue": 30
  }
  EOT
}

variable "message_retention_period" {
  type        = number
  default     = 345600
  description = <<EOT
  {
    "Description": {
      "en": "Maximum lifetime of the message in the queue, measured in seconds. After the time specified by this parameter expires, the message will be deleted no matter whether it has been consumed or not.\nAn integer between 60 (1 minute) and 1296000 (15 days). The default value is 345600 (4 days)",
      "zh-cn": "消息在该队列中最长的存活时间，从发送到该队列开始经过此参数指定的时间后，不论消息是否被取出过都将被删除。"
    },
    "MinValue": 60,
    "Label": {
      "en": "MessageRetentionPeriod",
      "zh-cn": "消息在该队列中最长的存活时间"
    },
    "MaxValue": 604800
  }
  EOT
}

variable "maximum_message_size" {
  type        = number
  default     = 65536
  description = <<EOT
  {
    "Description": {
      "en": "Maximum body length of a message sent to the queue, measured in bytes.\nAn integer between 1024 (1K) and 65536 (64K). The default value is 65536 (64K)."
    },
    "MinValue": 1024,
    "Label": {
      "en": "MaximumMessageSize",
      "zh-cn": "发送到该队列消息体的最大长度"
    },
    "MaxValue": 65536
  }
  EOT
}

variable "visibility_timeout" {
  type        = number
  default     = 30
  description = <<EOT
  {
    "Description": {
      "en": "Duration in which a message stays in Inactive status after it is consumed from the queue. Measured in seconds.\nAn integer between 1 and 43200 (12 hours). The default value is 30 (seconds)"
    },
    "MinValue": 1,
    "Label": {
      "en": "VisibilityTimeout",
      "zh-cn": "消息从该队列中取出后从Active状态变成Inactive状态后的持续时间"
    },
    "MaxValue": 43200
  }
  EOT
}

variable "queue_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Queue name"
    },
    "Label": {
      "en": "QueueName",
      "zh-cn": "队列名称"
    },
    "MinLength": 1,
    "MaxLength": 256
  }
  EOT
}

variable "logging_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable log management. \"true\" indicates that log management is enabled, whereas \"false\" indicates that log management is disabled. \nThe default value is false"
    },
    "Label": {
      "en": "LoggingEnabled",
      "zh-cn": "是否启用日志管理功能"
    }
  }
  EOT
}

resource "alicloud_message_service_queue" "queue" {
  delay_seconds            = var.delay_seconds
  polling_wait_seconds     = var.polling_wait_seconds
  message_retention_period = var.message_retention_period
  maximum_message_size     = var.maximum_message_size
  visibility_timeout       = var.visibility_timeout
  queue_name               = var.queue_name
  logging_enabled          = var.logging_enabled
}

output "queue_name" {
  value       = alicloud_message_service_queue.queue.id
  description = "Queue name"
}

output "arn" {
  // Could not transform ROS Attribute ARN to Terraform attribute.
  value       = null
  description = "The ARN for ALIYUN::ROS::CustomResource"
}

output "arn._with_slash" {
  // Could not transform ROS Attribute ARN.WithSlash to Terraform attribute.
  value       = null
  description = "The ARN: acs:mns:$region:$accountid:/queues/$queueName"
}

output "queue_url" {
  // Could not transform ROS Attribute QueueUrl to Terraform attribute.
  value       = null
  description = "URL of created queue"
}

