variable "max_tps" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "If instance type is professional, the valid value is [1000, 1500, 2000, 2500, 3000, 4000, 5000].\nIf instance type is enterprise, the valid value is [3000, 5000, 8000, 10000, 15000, 20000, 3000040000, 50000, 80000, 10000].\nIf instance type is vip, the valid value is [8000, 15000, 25000, 40000, 50000, 100000, 200000, 300000, 500000, 800000, 1000000].\n"
    },
    "AllowedValues": [
      1000,
      1500,
      2000,
      2500,
      3000,
      4000,
      5000,
      8000,
      10000,
      15000,
      20000,
      25000,
      30000,
      40000,
      50000,
      100000,
      200000,
      300000,
      500000,
      800000,
      1000000
    ],
    "Label": {
      "en": "MaxTps",
      "zh-cn": "配置私网TPS流量峰值"
    }
  }
  EOT
}

variable "max_eip_tps" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SupportEip}",
            "True"
          ]
        }
      }
    },
    "Description": {
      "en": "The max eip tps. It is valid when support_eip is true. \nThe minimum value is 128, with the step size 128.\n"
    },
    "MinValue": 128,
    "Label": {
      "en": "MaxEipTps",
      "zh-cn": "配置公网TPS流量峰值"
    }
  }
  EOT
}

variable "support_eip" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to support EIP. Valid values: true, false."
    },
    "AllowedValues": [
      "True",
      "False"
    ],
    "Label": {
      "en": "SupportEip",
      "zh-cn": "配置实例是否支持公网"
    }
  }
  EOT
}

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The period. Valid values: 1, 2, 3, 6, 12, 24, 36."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费周期"
    }
  }
  EOT
}

variable "storage_size" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceType}",
            "vip"
          ]
        }
      }
    },
    "Description": {
      "en": "The storage size. It is valid when instance_type is vip.\nIf instance type is professional or enterprise, the valid value is 0.If instance type is vip, the valid value is [700, 2800] with the step size 100"
    },
    "MinValue": 0,
    "Label": {
      "en": "StorageSize",
      "zh-cn": "配置消息存储空间"
    },
    "MaxValue": 2800
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "PayAsYouGo"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Subscription": {
          "Month": [
            1,
            2,
            3,
            6
          ],
          "Year": [
            1,
            2
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the instance. The Message Queue RabbitMQ version does not support new pay-as-you-go instances. Valid values:\nPrePaid: subscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "queue_capacity" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The queue capacity. If instance type is professional, the valid value is [50, 1000] with the step size 5.\nIf instance type is enterprise, the valid value is [200, 6000] with the step size 100\nIf instance type is vip, the valid value is [200, 80000] with the step size 100"
    },
    "MinValue": 50,
    "Label": {
      "en": "QueueCapacity",
      "zh-cn": "配置Queue的数量上限"
    },
    "MaxValue": 80000
  }
  EOT
}

variable "tracing_storage_time" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SupportTracing}",
            "True"
          ]
        }
      }
    },
    "Description": {
      "en": "The retention period of message traces was set. Valid values: 3, 7, 15.\nIf instance_type=vip, the valid values is 15.\nIf instance_type!=vip, the valid values is 3, 7, 15.\nIf support_tracing == tracing_false, the valid values is 0."
    },
    "AllowedValues": [
      0,
      3,
      7,
      15
    ],
    "Label": {
      "en": "TracingStorageTime",
      "zh-cn": "配置消息轨迹的保存时长"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The instance name."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "order_num" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Set the number of instances to be created."
    },
    "MinValue": 1,
    "Label": {
      "en": "OrderNum",
      "zh-cn": "配置创建实例的数量"
    },
    "MaxValue": 9999
  }
  EOT
}

variable "support_tracing" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to support tracing. Valid values: true, false."
    },
    "AllowedValues": [
      "True",
      "False"
    ],
    "Label": {
      "en": "SupportTracing",
      "zh-cn": "配置是否开通消息轨迹功能"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Instance Type. Valid values: professional, enterprise, vip."
    },
    "AllowedValues": [
      "professional",
      "enterprise",
      "vip"
    ],
    "Label": {
      "en": "InstanceType",
      "zh-cn": "配置实例规格类型"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "month",
      "year",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "自动续费周期"
    }
  }
  EOT
}

resource "alicloud_amqp_instance" "instance" {
  max_tps              = var.max_tps
  max_eip_tps          = var.max_eip_tps
  period               = var.period
  storage_size         = var.storage_size
  payment_type         = var.pay_type
  queue_capacity       = var.queue_capacity
  tracing_storage_time = var.tracing_storage_time
  instance_name        = var.instance_name
  instance_type        = var.instance_type
}

output "classic_endpoint" {
  // Could not transform ROS Attribute ClassicEndpoint to Terraform attribute.
  value       = null
  description = "The classic endpoint of the instance."
}

output "instance_id" {
  value       = alicloud_amqp_instance.instance.id
  description = "The ID of the instance."
}

output "public_endpoint" {
  // Could not transform ROS Attribute PublicEndpoint to Terraform attribute.
  value       = null
  description = "The public endpoint of the instance."
}

output "private_endpoint" {
  // Could not transform ROS Attribute PrivateEndpoint to Terraform attribute.
  value       = null
  description = "The private endpoint of the instance."
}

