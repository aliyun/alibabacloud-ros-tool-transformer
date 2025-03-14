variable "argument" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "X-match Attributes. Valid Values:\n\"x-match:all\": Default Value, All the Message Header of Key-Value Pairs Stored in the Must Match.\n\"x-match:any\": at Least One Pair of the Message Header of Key-Value Pairs Stored in the Must Match."
    },
    "Label": {
      "en": "Argument",
      "zh-cn": "设置消息头属性键值对信息"
    }
  }
  EOT
}

variable "source_exchange" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Source Exchange Name."
    },
    "Label": {
      "en": "SourceExchange",
      "zh-cn": "源Exchange名称"
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

variable "binding_key" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Binding Key."
    },
    "Label": {
      "en": "BindingKey",
      "zh-cn": "绑定键"
    }
  }
  EOT
}

variable "binding_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      0,
      "0",
      "QUEUE",
      1,
      "1",
      "EXCHANGE"
    ],
    "Description": {
      "en": "The Target Binding Types. Valid values: EXCHANGE, QUEUE."
    },
    "Label": {
      "en": "BindingType",
      "zh-cn": "绑定目标对象的类型"
    }
  }
  EOT
}

variable "destination_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Target Queue Or Exchange of the Name."
    },
    "Label": {
      "en": "DestinationName",
      "zh-cn": "绑定目标名称"
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

resource "alicloud_amqp_binding" "binding" {
  argument          = var.argument
  source_exchange   = var.source_exchange
  instance_id       = var.instance_id
  binding_key       = var.binding_key
  binding_type      = var.binding_type
  destination_name  = var.destination_name
  virtual_host_name = var.virtual_host
}

