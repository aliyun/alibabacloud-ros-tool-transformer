variable "partition_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of partitions in the topic. Valid values:\n1 to 48\nWe recommend that you set the number of partitions to a multiple of 6 to reduce the\nrisk of data skew.Note:For special requirements,submit a ticket."
    },
    "Label": {
      "en": "PartitionNum",
      "zh-cn": "Topic的分区数"
    }
  }
  EOT
}

variable "compact_topic" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The log cleanup policy for the topic. This parameter is available when the Local Storage mode is specified for the topic. Valid values:\nfalse: uses the default log cleanup policy.\ntrue: uses the Apache Kafka log compaction policy."
    },
    "Label": {
      "en": "CompactTopic",
      "zh-cn": "日志清理策略"
    }
  }
  EOT
}

variable "replication_factor" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of copies of the topic.\nThis parameter can only be specified if the LocalTopic value is true.\nThe number of copies is limited to 1~3.\nNote When the number of replicas is 1, there is a risk of data loss. Please set it carefully."
    },
    "MinValue": 1,
    "Label": {
      "en": "ReplicationFactor",
      "zh-cn": "Topic的副本数"
    },
    "MaxValue": 3
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Message Queue for Apache Kafka instance where the topic is located.\nYou can call the GetInstanceList operation to query instances."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "config" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Supplementary configuration.\nCurrently supports Key as replications. Indicates the number of Topic copies, the value type is Integer, and the value limit is 1~3.\nThis parameter can only be specified if the LocalTopic value is true.\nNOTE If replications is specified in this parameter, the specified ReplicationFactor parameter no longer takes effect."
    },
    "Label": {
      "en": "Config",
      "zh-cn": "补充配置"
    }
  }
  EOT
}

variable "min_insync_replicas" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The minimum number of ISR sync replicas.\nThis parameter can only be specified if the LocalTopic value is true.\nThe value must be less than the number of Topic copies.\nThe number of synchronous replicas is limited to 1~3."
    },
    "MinValue": 1,
    "Label": {
      "en": "MinInsyncReplicas",
      "zh-cn": "最小ISR同步副本数"
    },
    "MaxValue": 3
  }
  EOT
}

variable "topic" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the topic. The value of this parameter must meet the following requirements:\nThe name can only contain letters, digits, hyphens (-), and underscores (_).\nThe name must be 3 to 64 characters in length, and will be automatically truncated\nif it contains more characters.\nThe name cannot be modified after being created."
    },
    "Label": {
      "en": "Topic",
      "zh-cn": "Topic的名称"
    }
  }
  EOT
}

variable "local_topic" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The storage engine of the topic. Valid values:\nfalse: the Cloud Storage mode.\ntrue: the Local Storage mode."
    },
    "Label": {
      "en": "LocalTopic",
      "zh-cn": "Topic的存储引擎"
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "remark" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The description of the topic. The value of this parameter must meet the following\nrequirements:\nThe value can only contain letters, digits, hyphens (-), and underscores (_).\nThe value must be 3 to 64 characters in length."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "Topic的备注信息"
    }
  }
  EOT
}

resource "alicloud_alikafka_topic" "kafkatopic" {
  partition_num = var.partition_num
  compact_topic = var.compact_topic
  instance_id   = var.instance_id
  topic         = var.topic
  local_topic   = var.local_topic
  tags          = var.tags
  remark        = var.remark
}

output "instance_id" {
  value       = alicloud_alikafka_topic.kafkatopic.instance_id
  description = <<EOT
  "The ID of the Message Queue for Apache Kafka instance where the topic is located.\nYou can call the GetInstanceList operation to query instances."
  EOT
}

output "topic" {
  value       = alicloud_alikafka_topic.kafkatopic.topic
  description = "Topic name."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

