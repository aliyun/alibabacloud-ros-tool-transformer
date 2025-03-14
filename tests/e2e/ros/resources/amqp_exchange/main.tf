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

variable "alternate_exchange" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The alternate exchange. An alternate exchange is configured for an existing exchange. It is used to receive messages that fail to be routed to queues from the existing exchange."
    },
    "Label": {
      "en": "AlternateExchange",
      "zh-cn": "备份Exchange"
    }
  }
  EOT
}

variable "internal" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether an exchange is an internal exchange. Valid values:\nfalse: The exchange is not an internal exchange.\ntrue: The exchange is an internal exchange."
    },
    "Label": {
      "en": "Internal",
      "zh-cn": "是否为内部Exchange"
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
      "zh-cn": "Exchange所在的Vhost名称"
    }
  }
  EOT
}

variable "xdelayed_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Exchanges of the x-delay-Message type allow you to customize the Header property of the message, and the x-delay specifies the amount of time in milliseconds for the message to be delivered. The routing rules for this class of exchanges depend on the Exchange type specified in the x-delay-type parameter, which specifies the actual Exchange type to which the delayed message will eventually be delivered. Valid values:\n- DIRECT: Delivers deferred messages to a specified queue bound to an Exchange of type DIRECT.\n- TOPIC: Delivers deferred messages to the queue bound to the Exchange type TOPIC.\n - FANOUT: Delivers deferred messages to a queue bound to an Exchange of type FANOUT.\n- HEADERS: Deferred messages are delivered to the queue bound to the Exchange HEADERS type.\n - X-JMS-TOPIC: Delivers deferred messages to the queue bound to X-JMS-TOPIC."
    },
    "AllowedValues": [
      "DIRECT",
      "TOPIC",
      "FANOUT",
      "HEADERS",
      "X-JMS-TOPIC"
    ],
    "Label": {
      "en": "XDelayedType",
      "zh-cn": "指定延迟消息最终将被投递到的实际 Exchange 类型"
    }
  }
  EOT
}

variable "auto_delete_state" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the Auto Delete attribute is configured. Valid values:\ntrue: The Auto Delete attribute is configured. If the last queue that is bound to an exchange is unbound, the exchange is automatically deleted.\nfalse: The Auto Delete attribute is not configured. If the last queue that is bound to an exchange is unbound, the exchange is not automatically deleted."
    },
    "Label": {
      "en": "AutoDeleteState",
      "zh-cn": "是否自动删除"
    }
  }
  EOT
}

variable "exchange_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the exchange."
    },
    "Label": {
      "en": "ExchangeName",
      "zh-cn": "Exchange名称"
    },
    "MaxLength": 255
  }
  EOT
}

variable "exchange_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "DIRECT",
      "TOPIC",
      "FANOUT",
      "HEADERS"
    ],
    "Description": {
      "en": "The type of the exchange. Valid values:\nFANOUT: An exchange of this type routes all the received messages to all the queues bound to this exchange. You can use a fanout exchange to broadcast messages.\nDIRECT: An exchange of this type routes a message to the queue whose binding key is exactly the same as the routing key of the message.\nTOPIC: This type is similar to the direct exchange type. An exchange of this type routes a message to one or more queues based on the fuzzy match or multi-condition match result between the routing key of the message and the binding keys of the current exchange.\nHEADERS: Headers Exchange uses the Headers property instead of Routing Key for routing matching. When binding Headers Exchange and Queue, set the key-value pair of the binding property; when sending a message to the Headers Exchange, set the message's Headers property key-value pair and use the message Headers The message is routed to the bound Queue by comparing the attribute key-value pair and the bound attribute key-value pair."
    },
    "Label": {
      "en": "ExchangeType",
      "zh-cn": "Exchange类型"
    }
  }
  EOT
}

resource "alicloud_amqp_exchange" "exchange" {
  instance_id        = var.instance_id
  alternate_exchange = var.alternate_exchange
  internal           = var.internal
  auto_delete_state  = var.auto_delete_state
  exchange_name      = var.exchange_name
  exchange_type      = var.exchange_type
}

output "exchange_name" {
  value       = alicloud_amqp_exchange.exchange.exchange_name
  description = "The name of the exchange."
}

