variable "parent_execution_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Parent execution ID."
    },
    "Label": {
      "en": "ParentExecutionId",
      "zh-cn": "父执行ID"
    }
  }
  EOT
}

variable "resource_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CancelOnDelete": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to cancel execution for resource deletion, if the execution is not completed. Default to false."
          },
          "Required": false,
          "Default": false
        },
        "Timeout": {
          "Type": "Number",
          "Description": {
            "en": "Timeout seconds before the completion of execution. Default to 1800."
          },
          "Required": false,
          "MinValue": 10,
          "MaxValue": 43200,
          "Default": 1800
        },
        "SuccessStatuses": {
          "Type": "Json",
          "Description": {
            "en": "It is used for ROS to judge if resource creation is successful.\nDefault to [Success].\nROS will wait util some status in SuccessStatuses or FailureStatuses.\nFailureStatuses has higher priority.\nSpecified all statuses(Started,Queued,Running,Waiting,Success,Failed,Cancelled) if you do not want to wait for the completion of execution."
          },
          "Required": false
        },
        "FailureStatuses": {
          "Type": "Json",
          "Description": {
            "en": "It is used for ROS to judge if resource creation fails.\nDefault to [Failed, Cancelled].\nROS will wait util some status in SuccessStatuses or FailureStatuses.\nFailureStatuses has higher priority."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Resource options user by ROS."
    },
    "Label": {
      "en": "ResourceOptions",
      "zh-cn": "ROS使用的资源选项"
    }
  }
  EOT
}

variable "loop_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The loop mode of OOS Execution. Valid values:\n- Automatic(Default): does not pause.\n- FirstBatchPause: The first batch of pauses.\n- EveryBatchPause: pause each batch."
    },
    "AllowedValues": [
      "Automatic",
      "FirstBatchPause",
      "EveryBatchPause"
    ],
    "Label": {
      "en": "LoopMode",
      "zh-cn": "循环模式"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of OOS Execution."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "要给执行添加的描述信息"
    }
  }
  EOT
}

variable "parameters" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Parameters for the execution of template."
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "由参数集合组成的JSON字符串"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "template_content" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The content of the template in the JSON or YAML format. This parameter is the same as the Content parameter that you can specify when you call the CreateTemplate operation. You can use this parameter to specify the tasks that you want to run. This way, you do not need to create a template before you start an execution. If you select an existing template, you do not need to specify this parameter."
    },
    "Label": {
      "en": "TemplateContent",
      "zh-cn": "模板内容"
    },
    "MaxLength": 65536
  }
  EOT
}

variable "mode" {
  type        = string
  default     = "Automatic"
  description = <<EOT
  {
    "Description": {
      "en": "Execution mode."
    },
    "AllowedValues": [
      "Automatic",
      "Debug"
    ],
    "Label": {
      "en": "Mode",
      "zh-cn": "执行模式"
    }
  }
  EOT
}

variable "template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Version number of template. Default to the latest version."
    },
    "Label": {
      "en": "TemplateVersion",
      "zh-cn": "版本号"
    }
  }
  EOT
}

variable "templateurl" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Object Storage Service (OSS) URL of the object that stores the content of the Operation Orchestration Service (OOS) template. The access control list (ACL) of the object must be public-read. You can use this parameter to specify the tasks that you want to run. This way, you do not need to create a template before you start an execution. If you select an existing template, you do not need to specify this parameter."
    },
    "Label": {
      "en": "TemplateURL",
      "zh-cn": "阿里云对象存储 OSS 中存放 OOS 模板内容的 URL（只支持公共读的 URL）"
    }
  }
  EOT
}

variable "safety_check" {
  type        = string
  default     = "Skip"
  description = <<EOT
  {
    "Description": {
      "en": "Security check mode. Allowed values:\n- Skip (default): This option means that customers understand the risks, you can do anything without confirmation Action, no matter what the level of risk. It takes effect only if Mode is Automatic.\n- ConfirmEveryHighRiskAction: This option would require customers to confirm each Action a high risk. NotifyExecution by calling customer interface to confirm or cancel."
    },
    "AllowedValues": [
      "ConfirmEveryHighRiskAction",
      "Skip"
    ],
    "Label": {
      "en": "SafetyCheck",
      "zh-cn": "安全检查模式"
    }
  }
  EOT
}

variable "template_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Template name. Content is limited to letters, numbers, underlined, underline, the length of 200 characters."
    },
    "Label": {
      "en": "TemplateName",
      "zh-cn": "模板名称"
    },
    "MaxLength": 200
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Tag value and the key mapping, the label of the key number can be up to 20.",
      "zh-cn": "标签，由键值对组成。例如：{“k1”:”v1”, ”k2”:”v2”}。"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    }
  }
  EOT
}

resource "alicloud_oos_execution" "execution" {
  parent_execution_id = var.parent_execution_id
  loop_mode           = var.loop_mode
  description         = var.description
  parameters          = var.parameters
  template_content    = var.template_content
  mode                = var.mode
  template_version    = var.template_version
  safety_check        = var.safety_check
  template_name       = var.template_name
}

output "status" {
  value       = alicloud_oos_execution.execution.status
  description = "Execution status."
}

output "curl_cli" {
  // Could not transform ROS Attribute CurlCli to Terraform attribute.
  value       = null
  description = <<EOT
  "Convenience attribute, provides curl CLI command prefix, which can be used to notify oos execution instead of OOS API NotifyExecution.\nYou can notify approve to oos execution by adding --data-binary '{\"data\": {\"NotifyType\": \"Approve\"}}' \nFor more parameters in data, refer to https://help.aliyun.com/document_detail/120777.html.\nYou can also notify execution via ROS API SignalResource. API parameters Status and UniqueId are ignored. Use API parameter Data to pass data."
  EOT
}

output "windows_curl_cli" {
  // Could not transform ROS Attribute WindowsCurlCli to Terraform attribute.
  value       = null
  description = <<EOT
  "Convenience attribute, provides curl CLI command prefix for Windows, which can be used to notify oos execution instead of OOS API NotifyExecution.\nYou can notify approve to oos execution by adding --data-binary \"{\\\"data\\\": {\\\"NotifyType\\\": \\\"Approve\\\"}}\" \nFor more parameters in data, refer to https://help.aliyun.com/document_detail/120777.html.You can also notify execution via ROS API SignalResource. API parameters Status and UniqueId are ignored. Use API parameter Data to pass data."
  EOT
}

output "outputs" {
  value       = alicloud_oos_execution.execution.outputs
  description = "Execution output."
}

output "counters" {
  value       = alicloud_oos_execution.execution.counters
  description = "Task statistics: FailedTasks, SuccessTasks, TotalTasks."
}

output "power_shell_curl_cli" {
  // Could not transform ROS Attribute PowerShellCurlCli to Terraform attribute.
  value       = null
  description = <<EOT
  "Convenience attribute, provides curl CLI command prefix for PowerShell, which can be used to notify oos execution instead of OOS API NotifyExecution.\nYou can notify approve to oos execution by adding -Body '{\"data\": {\"NotifyType\": \"Approve\"}}' \nFor more parameters in data, refer to https://help.aliyun.com/document_detail/120777.html.You can also notify execution via ROS API SignalResource. API parameters Status and UniqueId are ignored. Use API parameter Data to pass data."
  EOT
}

output "execution_id" {
  value       = alicloud_oos_execution.execution.id
  description = "Execution ID."
}

output "status_message" {
  value       = alicloud_oos_execution.execution.status_message
  description = "Execution status information."
}

