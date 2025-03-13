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
      "zh-cn": "Topic所在的实例ID"
    }
  }
  EOT
}

variable "topic" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the topic you want to create.\nNote:\n\"CID\" and \"GID\" are the reserved fields of a group ID, and they cannot be the start of a topic name.\nIf namespaces are available in the instance for which the topic is created, the topic name must be unique in the instance and can be duplicated across instances.\nIf no namespaces are available in the instance, the topic name must be unique both in the instance and across instances."
    },
    "Label": {
      "en": "Topic",
      "zh-cn": "Topic的名称"
    }
  }
  EOT
}

variable "message_type" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      0,
      1,
      2,
      4,
      5
    ],
    "Description": {
      "en": "The type of the message. Valid values:\n0: normal message\n1: partitionally ordered message\n2: globally ordered message\n4: transactional message\n5: scheduled/delayed message"
    },
    "Label": {
      "en": "MessageType",
      "zh-cn": "Topic的消息类型"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remarks on the request. This parameter can be left blank."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "Topic的描述信息"
    }
  }
  EOT
}

resource "alicloud_ons_topic" "rocketmqtopic" {
  instance_id  = var.instance_id
  topic        = var.topic
  message_type = var.message_type
  remark       = var.remark
}

output "instance_id" {
  value       = alicloud_ons_topic.rocketmqtopic.instance_id
  description = "The ID of the instance."
}

output "topic" {
  value       = alicloud_ons_topic.rocketmqtopic.topic
  description = "The name of the topic."
}

output "message_type" {
  value       = alicloud_ons_topic.rocketmqtopic.message_type
  description = "The type of the message."
}

