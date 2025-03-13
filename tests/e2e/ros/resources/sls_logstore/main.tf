variable "logstore_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logstore name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "LogstoreName",
      "zh-cn": "日志库的名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "preserve_storage" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to keep the log permanently.\nIf set to true, TTL will be ignored.\nDefault to false."
    },
    "Label": {
      "en": "PreserveStorage",
      "zh-cn": "是否永久保存日志"
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
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "要创建的日志库所属日志项目的名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "append_meta" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to add client external network IP and log arrival time after receiving the log.\nDefault to false.",
      "zh-cn": "接收日志后，是否自动添加客户端外网IP和日志到达时间。"
    },
    "Label": {
      "en": "AppendMeta",
      "zh-cn": "接收日志后"
    }
  }
  EOT
}

variable "max_split_shard" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of shards when splitting automatically. Must be specified if AutoSplit is set to true.\nAllowed Values: 1-64.",
      "zh-cn": "自动分裂时，分裂出最大的分区个数。"
    },
    "MinValue": 1,
    "Label": {
      "en": "MaxSplitShard",
      "zh-cn": "自动分裂时"
    },
    "MaxValue": 64
  }
  EOT
}

variable "auto_split" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to automatically split the shard.\nDefault to false."
    },
    "Label": {
      "en": "AutoSplit",
      "zh-cn": "是否自动分裂分区"
    }
  }
  EOT
}

variable "mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the Logstore. Simple Log Service provides two types of Logstores: Standard Logstores and Query Logstores. Valid values:\nstandard: Standard Logstore. This type of Logstore supports the log analysis feature and is suitable for scenarios such as real-time monitoring and interactive analysis. You can also use this type of Logstore to build a comprehensive observability system.\nquery: Query Logstore. This type of Logstore supports high-performance queries. The index traffic fee of a Query Logstore is approximately half that of a Standard Logstore. Query Logstores do not support SQL analysis. Query Logstores are suitable for scenarios in which the amount of data is large, the log retention period is long, or log analysis is not required. If logs are stored for weeks or months, the log retention period is considered long."
    },
    "AllowedValues": [
      "standard",
      "query"
    ],
    "Label": {
      "en": "Mode",
      "zh-cn": "Logstore的类型"
    }
  }
  EOT
}

variable "enable_tracking" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable WebTracking, which supports fast capture of various browsers and iOS/Android/APP access information.\nDefault to false."
    },
    "Label": {
      "en": "EnableTracking",
      "zh-cn": "是否开启WebTracking采集信息"
    }
  }
  EOT
}

variable "encrypt_conf" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "EncryptType": {
          "Type": "String",
          "Description": {
            "en": "The encryption algorithm. The encrypt_type \nparameter can be set to only default or m4."
          },
          "AllowedValues": [
            "default",
            "m4"
          ],
          "Required": true
        },
        "Enable": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether data encryption is enabled."
          },
          "Required": true,
          "Default": false
        },
        "UserCmkInfo": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "CmkKeyId": {
                "Type": "String",
                "Description": {
                  "en": "The ID of the CMK to which the BYOK key belongs, \nfor example, f5136b95-2420-ab31-xxxxxxxxx."
                },
                "Required": true,
                "Label": {
                  "zh-cn": "BYOK密钥所在CMK的ID"
                }
              },
              "RegionId": {
                "AssociationProperty": "ALIYUN::ECS::RegionId",
                "Type": "String",
                "Description": {
                  "en": "The ID of the region where the CMK resides."
                },
                "Required": true,
                "Label": {
                  "zh-cn": "CMK所在的区域ID"
                }
              },
              "Arn": {
                "Type": "String",
                "Description": {
                  "en": "The ARN of the RAM role. For more information \nabout how to obtain the ARN of a RAM role, \nsee Ship log data from Log Service to OSS."
                },
                "Required": true,
                "Label": {
                  "zh-cn": "RAM角色的ARN"
                }
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "If this parameter is specified, the BYOK key is used. \nOtherwise, the service key is used."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Data encryption config"
    },
    "Label": {
      "en": "EncryptConf",
      "zh-cn": "数据加密配置"
    }
  }
  EOT
}

variable "ttl" {
  type        = number
  default     = 30
  description = <<EOT
  {
    "Description": {
      "en": "The lifecycle of log in the logstore in days.\nAllowed Values: 1-3600, default to 30."
    },
    "MinValue": 1,
    "Label": {
      "en": "TTL",
      "zh-cn": "数据的保存时间"
    },
    "MaxValue": 3600
  }
  EOT
}

variable "shard_count" {
  type        = number
  default     = 2
  description = <<EOT
  {
    "Description": {
      "en": "The number of Shards.\nAllowed Values: 1-100, default to 2."
    },
    "MinValue": 1,
    "Label": {
      "en": "ShardCount",
      "zh-cn": "分区个数"
    },
    "MaxValue": 100
  }
  EOT
}

resource "alicloud_log_store" "logstore" {
  logstore_name         = var.logstore_name
  project               = var.project_name
  append_meta           = var.append_meta
  max_split_shard_count = var.max_split_shard
  auto_split            = var.auto_split
  mode                  = var.mode
  enable_web_tracking   = var.enable_tracking
  retention_period      = var.ttl
  shard_count           = var.shard_count
}

output "logstore_name" {
  value       = alicloud_log_store.logstore.logstore_name
  description = "Logstore name."
}

output "project_name" {
  value       = alicloud_log_store.logstore.project_name
  description = "Project name."
}

