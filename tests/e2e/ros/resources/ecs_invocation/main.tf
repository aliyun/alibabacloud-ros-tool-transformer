variable "parameters" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The key-value pairs of custom parameters passed in when the script contains custom parameters.\nNumber of custom parameters: 0 to 10.\nThe key cannot be an empty string. It can be up to 64 characters in length.\nThe value can be an empty string.\nAfter the custom parameters and the original script content are Base64 encoded, the total size cannot exceed 16 KB.\nThe set of custom parameter names must be a subset of the parameter set that is defined when you created the script. You can use an empty string to represent the parameters that are not passed in.\nDefault value: null, indicating that this parameter is canceled and customer parameters are disabled.",
      "zh-cn": "启用自定义参数功能时，执行命令时传入的自定义参数的键值对。示例值：{\"name\": \"Jack\", \"accessKey\": \"LTAIdyv******aRY\"}。"
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "启用自定义参数功能时"
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
      "en": "The ID of the resource group to which to assign the command executions. The instances specified by InstanceIds must belong to the specified resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "命令执行的资源组ID"
    }
  }
  EOT
}

variable "timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period for the command execution. Unit: seconds.\n- The timeout period cannot be less than 10 seconds.\n- A timeout error occurs if the command cannot be run because the process slows down or because a specific module or Cloud Assistant Agent does not exist. When the specified timeout period ends, the command process is forcefully terminated.\n- If you do not specify this parameter, the timeout period that is specified when the command is created is used.\n- This timeout period is applicable only to this execution. The timeout period of the command is not modified."
    },
    "MinValue": 10,
    "Label": {
      "en": "Timeout",
      "zh-cn": "执行命令的超时时间"
    }
  }
  EOT
}

variable "windows_password_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the password to use to run the command on Windows instances. The name can be up to 255 characters in length.\nIf you do not want to use the default System user to run the command on Windows instances, specify both **WindowsPasswordName** and **Username**. To mitigate the risk of password leaks, the password is stored in plaintext in Operation Orchestration Service (OOS) Parameter Store, and only the name of the password is passed in by using WindowsPasswordName."
    },
    "Label": {
      "en": "WindowsPasswordName",
      "zh-cn": "在Windows实例中执行命令的用户的密码名称"
    },
    "MaxLength": 255
  }
  EOT
}

variable "repeat_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies how to run the command. Valid values:\n- **Once**: immediately runs the command.\n- **Period**: runs the command on a schedule. If you set this parameter to Period, you must specify **Frequency**.\n- **NextRebootOnly**: runs the command the next time the instance is started.\n- **EveryReboot*: runs the command every time the instance is started.\nDefault value:\n- If you do not specify Frequency, the default value is Once.\n- If you specify **Frequency**, **Period** is used as the value of RepeatMode regardless of whether RepeatMode is set to Period."
    },
    "Label": {
      "en": "RepeatMode",
      "zh-cn": "设置命令执行的方式"
    }
  }
  EOT
}

variable "username" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The username to use to run the command on instances. The username can be up to 255 characters in length.\n- For Linux instances, the root username is used by default.\n- For Windows instances, the System username is used by default.\nYou can also specify other usernames that already exist in the instances to run the command. For security purposes, we recommend that you run Cloud Assistant commands as a regular user. "
    },
    "Label": {
      "en": "Username",
      "zh-cn": "在ECS实例中执行命令的用户名称"
    },
    "MaxLength": 255
  }
  EOT
}

variable "container_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the container.\nTake note of the following items:\n- If you specify this parameter, Cloud Assistant runs scripts in the specified container of the instance.\n- If you specify this parameter, make sure that the version of Cloud Assistant Agent installed on Linux instances is 2.2.3.344 or later.\n- If you specify this parameter, Username that is specified in a request to call this operation and WorkingDir that is specified in a request to call the CreateCommand operation do not take effect. You can run the command only in the default working directory of the container by using the default user of the container. \n- If you specify this parameter, only shell scripts can be run in Linux containers. You cannot add a command in the format similar to #!/usr/bin/python at the beginning of a script to specify a script interpreter. "
    },
    "Label": {
      "en": "ContainerName",
      "zh-cn": "容器名称"
    }
  }
  EOT
}

variable "container_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the container. Only 64-bit hexadecimal strings are supported. You can use container IDs that are prefixed with docker://, containerd://, or cri-o:// to specify container runtimes.\nTake note of the following items:\n- If you specify this parameter, Cloud Assistant runs scripts in the specified container of the instance.\n- If you specify this parameter, make sure that the version of Cloud Assistant Agent installed on Linux instances is 2.2.3.344 or later.- If you specify this parameter, Username that is specified in a request to call this operation and WorkingDir that is specified in a request to call the CreateCommand operation do not take effect. You can run the command only in the default working directory of the container by using the default user of the container. \n- If you specify this parameter, only shell scripts can be run in Linux containers. You cannot add a command in the format similar to #!/usr/bin/python at the beginning of a script to specify a script interpreter."
    },
    "Label": {
      "en": "ContainerId",
      "zh-cn": "容器ID"
    }
  }
  EOT
}

variable "frequency" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Timed}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "The frequency of timing execution (the shortest frequency is performed every 1 minute). It iss mandatory when Timing is True.The value rule follows the rules of the cron expression. ",
      "zh-cn": "周期任务的执行周期。该参数值结构以Cron 表达式为准。"
    },
    "Label": {
      "en": "Frequency",
      "zh-cn": "周期任务的执行周期"
    }
  }
  EOT
}

variable "command_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of command. Only system commands whose provide is AlibabaCloud are supported"
    },
    "Label": {
      "en": "CommandName",
      "zh-cn": "命令名称"
    }
  }
  EOT
}

variable "command_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Command::CommandId",
    "Description": {
      "en": "The id of command."
    },
    "Label": {
      "en": "CommandId",
      "zh-cn": "命令ID"
    }
  }
  EOT
}

variable "sync" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to invoke synchronously."
    },
    "Label": {
      "en": "Sync",
      "zh-cn": "是否同步调用"
    }
  }
  EOT
}

variable "instance_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
        "Type": "String"
      }
    },
    "Description": {
      "en": "The instance id list. Instances status must be running."
    },
    "Label": {
      "en": "InstanceIds",
      "zh-cn": "执行命令的实例列表"
    },
    "MaxLength": 50
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
      "en": "Tags to attach to invocation. Max support 20 tags to add during create invocation. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_invocation" "invocation" {
  parameters            = var.parameters
  windows_password_name = var.windows_password_name
  repeat_mode           = var.repeat_mode
  username              = var.username
  frequency             = var.frequency
  command_id            = var.command_id
  instance_id           = var.instance_ids
}

output "invoke_results" {
  // Could not transform ROS Attribute InvokeResults to Terraform attribute.
  value       = null
  description = "The results of invoke command."
}

output "invoke_instances" {
  // Could not transform ROS Attribute InvokeInstances to Terraform attribute.
  value       = null
  description = "The InvokeInstances of command."
}

output "invoke_id" {
  value       = alicloud_ecs_invocation.invocation.id
  description = "The id of command execution."
}

