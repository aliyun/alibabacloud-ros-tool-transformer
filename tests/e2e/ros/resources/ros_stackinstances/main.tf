variable "operation_preferences" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MaxConcurrentPercentage": {
          "Type": "Number",
          "Required": false
        },
        "MaxConcurrentCount": {
          "Type": "Number",
          "Required": false
        },
        "FailureTolerancePercentage": {
          "Type": "Number",
          "Required": false
        },
        "FailureToleranceCount": {
          "Type": "Number",
          "Required": false
        }
      }
    },
    "Label": {
      "en": "OperationPreferences",
      "zh-cn": "创建资源栈实例的操作设置"
    }
  }
  EOT
}

variable "retain_stacks" {
  type        = bool
  description = <<EOT
  {
    "Label": {
      "en": "RetainStacks",
      "zh-cn": "是否保留资源栈"
    }
  }
  EOT
}

variable "region_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "RegionIds",
      "zh-cn": "目标执行地域列表"
    }
  }
  EOT
}

variable "account_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "AccountIds",
      "zh-cn": "使用自助管理权限模式部署资源栈的目标账号ID列表"
    }
  }
  EOT
}

variable "parameter_overrides" {
  type        = any
  description = <<EOT
  {
    "Label": {
      "en": "ParameterOverrides",
      "zh-cn": "覆盖参数的信息"
    }
  }
  EOT
}

variable "stack_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "StackGroupName",
      "zh-cn": "资源栈组名称"
    }
  }
  EOT
}

variable "deployment_targets" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RdFolderIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        }
      }
    },
    "Label": {
      "en": "DeploymentTargets",
      "zh-cn": "使用服务管理权限模式部署资源栈的部署目标"
    }
  }
  EOT
}

variable "operation_description" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "OperationDescription",
      "zh-cn": "创建资源栈实例的操作描述"
    }
  }
  EOT
}

variable "disable_rollback" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "zh-cn": "当创建资源栈实例失败时，是否禁用回滚策略。"
    },
    "Label": {
      "en": "DisableRollback",
      "zh-cn": "当创建资源栈实例失败时"
    }
  }
  EOT
}

variable "timeout_in_minutes" {
  type        = number
  description = <<EOT
  {
    "Label": {
      "en": "TimeoutInMinutes",
      "zh-cn": "创建资源栈实例的超时时间"
    }
  }
  EOT
}

resource "alicloud_ros_stack_instance" "extension_resource" {
  operation_preferences = var.operation_preferences
  retain_stacks         = var.retain_stacks
  parameter_overrides   = var.parameter_overrides
  stack_group_name      = var.stack_group_name
  operation_description = var.operation_description
  timeout_in_minutes    = var.timeout_in_minutes
}

output "last_operation_id" {
  // Could not transform ROS Attribute LastOperationId to Terraform attribute.
  value = null
}

output "stacks" {
  // Could not transform ROS Attribute Stacks to Terraform attribute.
  value = null
}

