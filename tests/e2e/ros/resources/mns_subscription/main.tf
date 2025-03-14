variable "endpoint" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Terminal address of the message recipient for the created subscription.\nCurrently, four types of endpoints are supported: \n1. HttpEndpoint, which must be prefixed with \"http://\"; \n2. QueueEndpoint, in the format of acs:mns:{REGION}:{AccountID}:queues/{QueueName}; \n3. MailEndpoint, in the format of mail:directmail:{MailAddress}; \n4. SmsEndpoint, in the format of sms:directsms:anonymous or sms:directsms:{Phone}."
    },
    "Label": {
      "en": "Endpoint",
      "zh-cn": "此次订阅中接收消息的终端地址"
    }
  }
  EOT
}

variable "notify_strategy" {
  type        = string
  default     = "BACKOFF_RETRY"
  description = <<EOT
  {
    "Description": {
      "en": "Retry policy that will be applied when an error occurs during message push to the endpoint.\nBACKOFF_RETRY or EXPONENTIAL_DECAY_RETRY; default value: BACKOFF_RETRY. For details about retry policies, refer to Basic Concepts/NotifyStrategy."
    },
    "AllowedValues": [
      "BACKOFF_RETRY",
      "EXPONENTIAL_DECAY_RETRY"
    ],
    "Label": {
      "en": "NotifyStrategy",
      "zh-cn": "向Endpoint推送消息出现错误时的重试策略"
    }
  }
  EOT
}

variable "notify_content_format" {
  type        = string
  default     = "XML"
  description = <<EOT
  {
    "Description": {
      "en": "Format of the message content pushed to the endpoint.\nXML, JSON, or SIMPLIFIED; default value: XML. For details about message formats, refer to Basic Concepts/NotifyContentFormat."
    },
    "AllowedValues": [
      "XML",
      "JSON",
      "SIMPLIFIED"
    ],
    "Label": {
      "en": "NotifyContentFormat",
      "zh-cn": "向Endpoint推送的消息格式"
    }
  }
  EOT
}

variable "filter_tag" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Message filter tag in the created subscription (Only messages with consistent tags are pushed.)\nThe value is a string of no more than 16 characters. The default value is no message filter."
    },
    "Label": {
      "en": "FilterTag",
      "zh-cn": "此次订阅中消息过滤的标签"
    },
    "MaxLength": 16
  }
  EOT
}

variable "subscription_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Subscription name"
    },
    "Label": {
      "en": "SubscriptionName",
      "zh-cn": "订阅名称"
    },
    "MinLength": 1,
    "MaxLength": 256
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

resource "alicloud_message_service_subscription" "subscription" {
  endpoint              = var.endpoint
  notify_strategy       = var.notify_strategy
  notify_content_format = var.notify_content_format
  filter_tag            = var.filter_tag
  subscription_name     = var.subscription_name
  topic_name            = var.topic_name
}

output "subscription_url" {
  // Could not transform ROS Attribute SubscriptionUrl to Terraform attribute.
  value       = null
  description = "URL of created subscription"
}

output "subscription_name" {
  value       = alicloud_message_service_subscription.subscription.id
  description = "Subscription name"
}

output "topic_name" {
  value       = alicloud_message_service_subscription.subscription.topic_name
  description = "Topic name"
}

