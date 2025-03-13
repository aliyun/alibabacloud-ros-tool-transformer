variable "comment" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The comment of topic."
    },
    "Label": {
      "en": "Comment",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "record_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "TUPLE",
      "BLOB"
    ],
    "Description": {
      "en": "Record type. TUPLE: structured data, BLOB: unstructured data."
    },
    "Label": {
      "en": "RecordType",
      "zh-cn": "类型"
    }
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the project. Length [3, 32]. Beginning with characters, only characters, numbers and _ are allowed."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "项目名称"
    },
    "MinLength": 3,
    "MaxLength": 32
  }
  EOT
}

variable "lifecycle_f356b5b4" {
  type        = number
  default     = 3
  description = <<EOT
  {
    "Description": {
      "en": "Data storage life cycle."
    },
    "MinValue": 1,
    "Label": {
      "en": "Lifecycle",
      "zh-cn": "数据存储生命周期"
    }
  }
  EOT
}

variable "record_schema" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "When creating a TUPLE type topic, you need to specify the schema, but the BLOB type does not pass this parameter."
    },
    "Label": {
      "en": "RecordSchema",
      "zh-cn": "Schema详情"
    }
  }
  EOT
}

variable "shard_count" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Initial shard number."
    },
    "MinValue": 1,
    "Label": {
      "en": "ShardCount",
      "zh-cn": "初始Shard数目"
    }
  }
  EOT
}

variable "topic_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the topic. Length [3, 64]. Beginning with characters, only characters, numbers and _ are allowed."
    },
    "Label": {
      "en": "TopicName",
      "zh-cn": "Topic名称"
    },
    "MinLength": 3,
    "MaxLength": 64
  }
  EOT
}

resource "alicloud_datahub_topic" "topic" {
  comment       = var.comment
  record_type   = var.record_type
  project_name  = var.project_name
  life_cycle    = var.lifecycle_f356b5b4
  record_schema = var.record_schema
  shard_count   = var.shard_count
  name          = var.topic_name
}

output "project_name" {
  value       = alicloud_datahub_topic.topic.project_name
  description = "Project name"
}

output "topic_name" {
  value       = alicloud_datahub_topic.topic.name
  description = "Topic name"
}

