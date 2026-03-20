variable "default_target" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The number of target resources to reserve."
    },
    "Label": {
      "en": "DefaultTarget",
      "zh-cn": "预留的默认目标资源个数"
    },
    "MaxValue": 299
  }
  EOT
}

variable "always_allocatecpu" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether CPU should always be allocated; defaults to true."
    },
    "Label": {
      "en": "AlwaysAllocateCPU",
      "zh-cn": "是否始终分配 CPU"
    }
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

variable "target_tracking_policies" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MetricTarget": {
          "Type": "Number",
          "Description": {
            "en": "Tracking values for metrics."
          },
          "Required": true,
          "MaxValue": 100
        },
        "TimeZone": {
          "Type": "String",
          "Description": {
            "en": "Time zones. startTime, endTime, and scheduleExpression times need to be in UTC when the timezone argument is empty."
          },
          "Required": false
        },
        "EndTime": {
          "Type": "String",
          "Description": {
            "en": "Policy end time (UTC)."
          },
          "Required": false
        },
        "MetricType": {
          "Type": "String",
          "Description": {
            "en": "Tracking target type. Valid values:\n- ProvisionedConcurrencyUtilization: reserve a pattern instance concurrent degree of utilization. \n- CPUUtilization: CPU utilization. \n- GPUMemUtilization: GPU utilization."
          },
          "AllowedValues": [
            "ProvisionedConcurrencyUtilization",
            "CPUUtilization",
            "GPUMemUtilization"
          ],
          "Required": true
        },
        "StartTime": {
          "Type": "String",
          "Description": {
            "en": "Policy start time (UTC)."
          },
          "Required": false
        },
        "MinCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The minimum of the shrinkage."
          },
          "Required": true,
          "MaxValue": 299
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Policy name."
          },
          "Required": true
        },
        "MaxCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The maximum of the expansion."
          },
          "Required": true,
          "MaxValue": 299
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Target tracking policy configuration."
    },
    "Label": {
      "en": "TargetTrackingPolicies",
      "zh-cn": "指标追踪伸缩策略配置"
    },
    "MaxLength": 100
  }
  EOT
}

variable "scheduled_actions" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ScheduleExpression": {
          "Type": "String",
          "Description": {
            "en": "Cron expression."
          },
          "Required": false
        },
        "TimeZone": {
          "Type": "String",
          "Description": {
            "en": "Time zones. startTime, endTime, and scheduleExpression times need to be in UTC when the timezone argument is empty."
          },
          "Required": false
        },
        "Target": {
          "Type": "Number",
          "Description": {
            "en": "The number of target resources to reserve."
          },
          "Required": true,
          "MaxValue": 299
        },
        "EndTime": {
          "Type": "String",
          "Description": {
            "en": "Policy expiration time."
          },
          "Required": false
        },
        "StartTime": {
          "Type": "String",
          "Description": {
            "en": "Policy start time."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Policy name."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Timing policy configuration."
    },
    "Label": {
      "en": "ScheduledActions",
      "zh-cn": "定时策略配置"
    },
    "MaxLength": 100
  }
  EOT
}

variable "qualifier" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Function alias or LATEST."
    },
    "Label": {
      "en": "Qualifier",
      "zh-cn": "函数别名"
    }
  }
  EOT
}

variable "always_allocategpu" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether GPU should always be allocated; defaults to true."
    },
    "Label": {
      "en": "AlwaysAllocateGPU",
      "zh-cn": "是否始终分配 GPU"
    }
  }
  EOT
}

resource "alicloud_fcv3_provision_config" "provision_config" {
  // The value var.target_tracking_policies of arguments target_tracking_policies is not block and will be ignore.
  // The value var.scheduled_actions of arguments scheduled_actions is not block and will be ignore.
  target              = var.default_target
  always_allocate_cpu = var.always_allocatecpu
  function_name       = var.function_name
  qualifier           = var.qualifier
  always_allocate_gpu = var.always_allocategpu
}

