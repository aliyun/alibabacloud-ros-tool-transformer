variable "consumer_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the consumer group to be created. Used to identify consumer groups, globally unique.\nThe value description is as follows:\nCharacter limitation: supports letters a~z or A-Z, numbers 0-9, underscore (_), dash (-) and percent sign (%).\nLength limit: 1-60 characters."
    },
    "Label": {
      "en": "ConsumerGroupId",
      "zh-cn": "待创建的消费者分组的ID"
    },
    "MinLength": 1,
    "MaxLength": 60
  }
  EOT
}

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
      "zh-cn": "待创建的消费者分组所属的实例ID"
    }
  }
  EOT
}

variable "consume_retry_policy" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DeadLetterTargetTopic": {
          "Type": "String",
          "Description": {
            "en": "The dead letter topic of the consumer group."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 60
        },
        "RetryPolicy": {
          "Type": "String",
          "Description": {
            "en": "Retry policy type."
          },
          "AllowedValues": [
            "DefaultRetryPolicy",
            "FixedRetryPolicy"
          ],
          "Required": true
        },
        "MaxRetryTimes": {
          "Type": "Number",
          "Description": {
            "en": "Maximum number of retries."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 1000
        }
      }
    },
    "Description": {
      "en": "The consumption retry policy of the consumer group to be created."
    },
    "Label": {
      "en": "ConsumeRetryPolicy",
      "zh-cn": "待创建消费者分组的消费重试策略"
    }
  }
  EOT
}

variable "delivery_order_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Orderly",
      "Concurrently"
    ],
    "Description": {
      "en": "Delivery sequence of the consumer group to be created."
    },
    "Label": {
      "en": "DeliveryOrderType",
      "zh-cn": "待创建消费者分组的投递顺序性"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remark of the consumer group to be created."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "待创建消费者分组的备注信息"
    },
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_rocketmq_consumer_group" "consumer_group" {
  consumer_group_id   = var.consumer_group_id
  instance_id         = var.instance_id
  delivery_order_type = var.delivery_order_type
  remark              = var.remark
}

output "consumer_group_id" {
  value       = alicloud_rocketmq_consumer_group.consumer_group.consumer_group_id
  description = "The ID of the consumer group."
}

output "instance_id" {
  value       = alicloud_rocketmq_consumer_group.consumer_group.instance_id
  description = "The ID of the instance."
}

output "delivery_order_type" {
  value       = alicloud_rocketmq_consumer_group.consumer_group.delivery_order_type
  description = "Delivery sequence of consumer group."
}

