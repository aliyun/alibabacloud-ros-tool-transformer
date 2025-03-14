variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Kafka instance id."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "Kafka 实例ID"
    }
  }
  EOT
}

variable "consumer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Group name. Value:\nCan only contain letters, numbers, dashes (-), underscores (_), and at least one English or number.\nThe length is limited to 3 to 128 characters, and more than 128 characters will be automatically intercepted.\nOnce the group name is created, it cannot be modified."
    },
    "Label": {
      "en": "ConsumerId",
      "zh-cn": "Group名称"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Remark description."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "备注"
    }
  }
  EOT
}

resource "alicloud_alikafka_consumer_group" "consumer_group" {
  instance_id = var.instance_id
  consumer_id = var.consumer_id
  tags        = var.tags
}

output "consumer_id" {
  value       = alicloud_alikafka_consumer_group.consumer_group.consumer_id
  description = "Consumer group ID"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

