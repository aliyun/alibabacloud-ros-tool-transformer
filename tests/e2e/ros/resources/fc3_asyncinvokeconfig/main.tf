variable "max_async_event_age_in_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum message survival time (optional), value range [1,604800], default is 86400, unit is seconds."
    },
    "MinValue": 1,
    "Label": {
      "en": "MaxAsyncEventAgeInSeconds",
      "zh-cn": "事件最大存活时间"
    },
    "MaxValue": 604800
  }
  EOT
}

variable "function_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Function name."
    },
    "Label": {
      "en": "FunctionName",
      "zh-cn": "函数名称"
    }
  }
  EOT
}

variable "destination_config" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "OnSuccess": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Destination": {
                "Type": "String",
                "Description": {
                  "en": "Asynchronous invocation target resource descriptor."
                },
                "Required": true,
                "MaxLength": 512
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Successful callback target structure."
          },
          "Required": false
        },
        "OnFailure": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Destination": {
                "Type": "String",
                "Description": {
                  "en": "Asynchronous invocation target resource descriptor."
                },
                "Required": true,
                "MaxLength": 512
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Failed callback target structure."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Configuration structure of asynchronous invocation target (optional)."
    },
    "Label": {
      "en": "DestinationConfig",
      "zh-cn": "目标配置"
    }
  }
  EOT
}

variable "async_task" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable asynchronous tasks (optional)."
    },
    "Label": {
      "en": "AsyncTask",
      "zh-cn": "是否开启异步任务"
    }
  }
  EOT
}

variable "max_async_retry_attempts" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum number of retries after asynchronous invocation fails, optional. Value range [0,8]. When not configured, the default number of retries is 3."
    },
    "MinValue": 0,
    "Label": {
      "en": "MaxAsyncRetryAttempts",
      "zh-cn": "异步调用重试次数"
    },
    "MaxValue": 8
  }
  EOT
}

resource "alicloud_fcv3_async_invoke_config" "async_invoke_config" {
  function_name = var.function_name
}

