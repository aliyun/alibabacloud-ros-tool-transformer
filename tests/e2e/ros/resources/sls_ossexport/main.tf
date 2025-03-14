variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the export job. It could be 0 to 256 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "导出任务的描述"
    },
    "MinLength": 0,
    "MaxLength": 256
  }
  EOT
}

variable "configuration" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ToTime": {
          "Type": "Number",
          "Description": {
            "en": "The end time of the time range."
          },
          "Required": false,
          "Default": 0
        },
        "Sink": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "BufferInterval": {
                "Type": "Number",
                "Description": {
                  "en": "The shipping time. The maximum interval at which data is shipped. Valid values: 300 to 900. Unit: seconds."
                },
                "Required": true,
                "MinValue": 300,
                "MaxValue": 900
              },
              "ContentType": {
                "Type": "String",
                "Description": {
                  "en": "The storage format. You can store data in the Parquet format for data analysis. Compared with data stored in the CSV or JSON format, data stored in the Parquet format can be scanned at a higher efficiency.You are charged more fees when you ship data in the Parquet format than in the CSV or JSON format. Select a storage format for data shipping based on your business requirements."
                },
                "AllowedValues": [
                  "json",
                  "parquet",
                  "csv",
                  "orc"
                ],
                "Required": true
              },
              "ContentDetail": {
                "Type": "Json",
                "Description": {
                  "en": "The content detail. If ContentType=json, the default value is {\"EnableTag\": false}."
                },
                "Required": false
              },
              "PathFormat": {
                "Type": "String",
                "Description": {
                  "en": "The partition format is used to generate subdirectories. A subdirectory is dynamically generated based on the shipping time. The default partition format is %Y/%m/%d/%H/%M. Example: 2017/01/23/12/00. Note that the partition format cannot start with a forward slash (/). For more information about how to integrate with the compute engines of E-MapReduce such as Hive and Impala to query and analyze data"
                },
                "Required": false,
                "Default": "%Y/%m/%d/%H/%M"
              },
              "Prefix": {
                "Type": "String",
                "Description": {
                  "en": "The prefix of the OSS object name."
                },
                "Required": false
              },
              "PathFormatType": {
                "Type": "String",
                "Description": {
                  "en": "The partition format type. Only support time."
                },
                "AllowedValues": [
                  "time"
                ],
                "Required": false,
                "Default": "time"
              },
              "RoleArn": {
                "Type": "String",
                "Description": {
                  "en": "Used to control permissions of writing data to OSS and reading data in Logstores. Example: acs:ram::13234:role/aliyunlogdefaultrole."
                },
                "Required": true
              },
              "BufferSize": {
                "Type": "Number",
                "Description": {
                  "en": "The shipping size. The value of this parameter determines the maximum size of raw log data that is shipped and stored in an object. Unit: MB. If the size of log data that you want to ship reaches the specified value, a shipping job is automatically created."
                },
                "Required": true,
                "MinValue": 5,
                "MaxValue": 256
              },
              "TimeZone": {
                "Type": "String",
                "Description": {
                  "en": "The time zone. Partition paths vary based on time zones. The value should be -1200 to +1400. For example, +0800."
                },
                "Required": false
              },
              "Suffix": {
                "Type": "String",
                "Description": {
                  "en": "The suffix of the OSS object name."
                },
                "Required": false
              },
              "Endpoint": {
                "Type": "String",
                "Description": {
                  "en": "The endpoint of the OSS bucket."
                },
                "Required": false
              },
              "DelaySeconds": {
                "Type": "Number",
                "Description": {
                  "en": "The shipping latency. The period of time after which data is shipped. Valid values: 900 to 63244800. Unit: seconds.\nNote: Do not specify a latency that exceeds the data retention period of the Logstore. We recommend that you reserve a buffer period of a few days for the latency. Otherwise, data loss may occur."
                },
                "Required": false,
                "MinValue": 900,
                "MaxValue": 63244800
              },
              "Bucket": {
                "Type": "String",
                "Description": {
                  "en": "The name of the OSS bucket."
                },
                "Required": true
              },
              "CompressionType": {
                "Type": "String",
                "Description": {
                  "en": "The compression method of OSS data. Valid values: none, snappy, gzip, and zstd. The value none indicates that raw data is not compressed. The value snappy, gzip, or zstd indicates that a specified algorithm is used to compress data, which can reduce the storage space usage of OSS buckets. The compression methods vary based on storage formats."
                },
                "AllowedValues": [
                  "none",
                  "snappy",
                  "gzip",
                  "zstd"
                ],
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The sink name."
          },
          "Required": true
        },
        "Logstore": {
          "Type": "String",
          "Description": {
            "en": "The logstore name of the project."
          },
          "Required": true
        },
        "FromTime": {
          "Type": "Number",
          "Description": {
            "en": "The start time of the time range."
          },
          "Required": false,
          "Default": 0
        },
        "RoleArn": {
          "Type": "String",
          "Description": {
            "en": "Used to control permissions of writing data to OSS and reading data in Logstores. Example: acs:ram::13234:role/aliyunlogdefaultrole."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The configuration of the export job."
    },
    "Label": {
      "en": "Configuration",
      "zh-cn": "导出任务的配置"
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
      "en": "The project name of SLS."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "日志项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "display_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The display name of the export job. It must be 4 to 100 characters in length."
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "OSS导出的显示名称"
    },
    "MinLength": 4,
    "MaxLength": 100
  }
  EOT
}

variable "export_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the export job. This value should be unique. It must be 2 to 64 characters in length and can contain lowercase letters, digits, hyphens (-), and underscores (_). It must start and end with a lowercase letter or a digit."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ExportName",
      "zh-cn": "投递配置名称"
    },
    "MinLength": 2,
    "MaxLength": 64
  }
  EOT
}

resource "alicloud_log_oss_export" "oss_export" {
  project_name = var.project_name
  display_name = var.display_name
  export_name  = var.export_name
}

output "project_name" {
  value       = alicloud_log_oss_export.oss_export.project_name
  description = "The project name of SLS."
}

output "export_name" {
  value       = alicloud_log_oss_export.oss_export.export_name
  description = "The name of the export job."
}

