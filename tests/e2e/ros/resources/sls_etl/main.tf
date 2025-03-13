variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "ETL description message."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "数据加工任务的描述"
    }
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
        "Script": {
          "Type": "String",
          "Description": {
            "en": "Processing operation grammar."
          },
          "Required": true
        },
        "Sinks": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Project": {
                "Type": "String",
                "Description": {
                  "en": "The project where the target logstore is delivered."
                },
                "Required": true
              },
              "Type": {
                "Type": "String",
                "Description": {
                  "en": "ETL sinks type, the default value is AliyunLOG."
                },
                "Required": false
              },
              "Endpoint": {
                "Type": "String",
                "Description": {
                  "en": "Delivery target logstore region."
                },
                "Required": false
              },
              "Logstore": {
                "Type": "String",
                "Description": {
                  "en": "Delivery target logstore."
                },
                "Required": true
              },
              "AccessKeyId": {
                "Type": "String",
                "Description": {
                  "en": "Delivery target logstore access key id. \nRoleArn and (AccessKeyId, AccessKeySecret) fill in at most one"
                },
                "Required": false,
                "Default": ""
              },
              "AccessKeySecret": {
                "Type": "String",
                "Description": {
                  "en": "Delivery target logstore access key secret. \nRoleArn and (AccessKeyId, AccessKeySecret) fill in at most one"
                },
                "Required": false,
                "Default": ""
              },
              "RoleArn": {
                "Type": "String",
                "Description": {
                  "en": "Sts role info under delivery target logstore. \n"
                },
                "Required": false,
                "Default": ""
              },
              "Name": {
                "Type": "String",
                "Description": {
                  "en": "Delivery target name."
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "target logstore configuration for delivery after data processing."
          },
          "Required": true
        },
        "Parameters": {
          "Type": "Json",
          "Description": {
            "en": "Advanced parameter configuration of processing operations."
          },
          "Required": false
        },
        "ToTime": {
          "Type": "Number",
          "Description": {
            "en": "Deadline of processing job, the default value is None"
          },
          "Required": false
        },
        "Version": {
          "Type": "Number",
          "Description": {
            "en": "The script version."
          },
          "Required": false
        },
        "Logstore": {
          "Type": "String",
          "Description": {
            "en": "The source logstore of the processing job."
          },
          "Required": true
        },
        "AccessKeyId": {
          "Type": "String",
          "Description": {
            "en": "Delivery target logstore access key id. \n RoleArn and (AccessKeyId, AccessKeySecret) fill in at most one"
          },
          "Required": false,
          "Default": ""
        },
        "AccessKeySecret": {
          "Type": "String",
          "Description": {
            "en": "Delivery target logstore access key secret. \nRoleArn and (AccessKeyId, AccessKeySecret) fill in at most one"
          },
          "Required": false,
          "Default": ""
        },
        "FromTime": {
          "Type": "Number",
          "Description": {
            "en": "The start time of the processing job, the default starts from the current time."
          },
          "Required": false
        },
        "RoleArn": {
          "Type": "String",
          "Description": {
            "en": "Sts role info under delivery target logstore. \n"
          },
          "Required": false,
          "Default": ""
        }
      }
    },
    "Description": {
      "en": "The configuration of ETL task"
    },
    "Label": {
      "en": "Configuration",
      "zh-cn": "数据加工任务的配置"
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
      "en": "Project name"
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "数据加工任务的目标日志项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "schedule" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of task scheduling strategies, value: Resident"
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Task scheduling strategy"
    },
    "Label": {
      "en": "Schedule",
      "zh-cn": "数据加工任务的调度策略"
    }
  }
  EOT
}

variable "display_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ETL display name"
    },
    "Label": {
      "en": "DisplayName",
      "zh-cn": "数据加工任务的显示名称"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ETL name"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "数据加工任务的名称"
    }
  }
  EOT
}

resource "alicloud_log_etl" "etl" {
  description  = var.description
  project      = var.project_name
  display_name = var.display_name
  etl_name     = var.name
}

output "name" {
  value       = alicloud_log_etl.etl.etl_name
  description = "ETL name."
}

