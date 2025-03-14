variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "待创建主题所属的实例的ID"
    }
  }
  EOT
}

variable "message_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "NORMAL",
      "FIFO",
      "DELAY",
      "TRANSACTION"
    ],
    "Description": {
      "en": "The message type of the topic to be created. Valid values:\nNORMAL\nFIFO\nDELAY\nTRANSACTION"
    },
    "Label": {
      "en": "MessageType",
      "zh-cn": "待创建主题的消息类型"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remark of the topic to be created."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "待创建主题的备注信息"
    },
    "MaxLength": 128
  }
  EOT
}

variable "topic_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the topic to be created is used to identify the topic and is globally unique.\nValid values:\nCharacter limitation: supports letters a~z or A-Z, numbers 0-9, underscore (_), dash (-) and percent sign (%).\nLength limit: 1-60 characters."
    },
    "Label": {
      "en": "TopicName",
      "zh-cn": "待创建主题的名称"
    },
    "MinLength": 1,
    "MaxLength": 60
  }
  EOT
}

resource "alicloud_rocketmq_topic" "topic" {
  instance_id  = var.instance_id
  message_type = var.message_type
  remark       = var.remark
  topic_name   = var.topic_name
}

output "instance_id" {
  value       = alicloud_rocketmq_topic.topic.instance_id
  description = "The ID of the instance."
}

output "message_type" {
  value       = alicloud_rocketmq_topic.topic.message_type
  description = "The type of the message."
}

output "topic_name" {
  value       = alicloud_rocketmq_topic.topic.topic_name
  description = "The name of the topic."
}

