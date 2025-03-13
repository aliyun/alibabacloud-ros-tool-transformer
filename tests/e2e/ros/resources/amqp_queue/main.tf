variable "dead_letter_exchange" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The dead-letter exchange. A dead-letter exchange is used to receive rejected messages. \nIf a consumer rejects a message that cannot be retried, this message is routed to a specified dead-letter exchange. \nThen, the dead-letter exchange routes the message to the queue that is bound to the dead-letter exchange."
    },
    "Label": {
      "en": "DeadLetterExchange",
      "zh-cn": "死信Exchange"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "InstanceId"
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "exclusive_state" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the queue is an exclusive queue. Valid values:\ntrue: The queue is an exclusive queue. It can be used only for the connection that declares the exclusive queue. After the connection is closed, the exclusive queue is automatically deleted.\nfalse: The Auto Delete attribute is not configured."
    },
    "Label": {
      "en": "ExclusiveState",
      "zh-cn": "是否为排他性Exchange"
    }
  }
  EOT
}

variable "dead_letter_routing_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The dead letter routing key."
    },
    "Label": {
      "en": "DeadLetterRoutingKey",
      "zh-cn": "死信Routing Key"
    }
  }
  EOT
}

variable "virtual_host" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the virtual host."
    },
    "Label": {
      "en": "VirtualHost",
      "zh-cn": "Vhost名称"
    }
  }
  EOT
}

variable "auto_delete_state" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the Auto Delete attribute is configured. Valid values:\ntrue: The Auto Delete attribute is configured. The queue is automatically deleted after the last subscription from consumers to this queue is canceled.\nfalse: The Auto Delete attribute is not configured."
    },
    "Label": {
      "en": "AutoDeleteState",
      "zh-cn": "是否自动删除"
    }
  }
  EOT
}

variable "queue_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the queue."
    },
    "Label": {
      "en": "QueueName",
      "zh-cn": "队列名称"
    },
    "MaxLength": 255
  }
  EOT
}

variable "messagettl" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The message TTL of the queue\nIf a message is retained in the Queue longer than the configured message lifetime, the message expires.\nThe value of message lifetime must be a non-negative integer, up to 1 day.\nThe unit is milliseconds"
    },
    "Label": {
      "en": "MessageTTL",
      "zh-cn": "消息在队列中的有效期"
    }
  }
  EOT
}

resource "alicloud_amqp_queue" "queue" {
  dead_letter_exchange    = var.dead_letter_exchange
  instance_id             = var.instance_id
  exclusive_state         = var.exclusive_state
  dead_letter_routing_key = var.dead_letter_routing_key
  auto_delete_state       = var.auto_delete_state
  queue_name              = var.queue_name
}

output "queue_name" {
  value       = alicloud_amqp_queue.queue.queue_name
  description = "The name of the queue."
}

