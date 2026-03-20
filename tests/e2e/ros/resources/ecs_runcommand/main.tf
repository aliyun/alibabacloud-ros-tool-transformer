variable "description" {
  type = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the script, which supports all character sets. It can be up to 512 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "脚本描述"
    }
  }
  EOT
}

variable "parameters" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${EnableParameter}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "The key-value pairs of custom parameters passed in when the script contains custom parameters.\nNumber of custom parameters: 0 to 10.\nThe key cannot be an empty string. It can be up to 64 characters in length.\nThe value can be an empty string.\nAfter the custom parameters and the original script content are Base64 encoded, the total size cannot exceed 16 KB.\nThe set of custom parameter names must be a subset of the parameter set that is defined when you created the script. You can use an empty string to represent the parameters that are not passed in.\nDefault value: null, indicating that this parameter is canceled and customer parameters are disabled.",
      "zh-cn": "脚本中包含自定义参数时，执行脚本时指定的自定义参数的键值对。例如：脚本内容为echo {{name}}，则可以通过Parameters参数指定键值对{\"name\":\"Jack\"}。自定义参数将自动替换变量值name，得到一条新的脚本，实际执行的是echo Jack。"
    },
    "Label": {
      "en": "Custom parameters",
      "zh-cn": "自定义参数"
    }
  }
  EOT
}

variable "resource_group_id" {
  type = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which to assign the command executions. The instances specified by InstanceIds must belong to the specified resource group."
    },
    "Label": {
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "timeout" {
  type = number
  default = 60
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period for script execution. Unit: seconds. A timeout error occurs when a script cannot be run because the process slows down, a specific module or the Cloud Assistant client does not exist. When the script times out, the script process is forcibly terminated.\nDefault value: 60."
    },
    "Label": {
      "en": "Timeout of execution(Unit: second)",
      "zh-cn": "执行脚本的超时时间(单位：秒)"
    }
  }
  EOT
}

variable "content_encoding" {
  type = string
  default = "PlainText"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "CommandContentEncoding"
    },
    "Description": {
      "en": "The encoding mode of script content (CommandContent). Valid values (case insensitive):\nPlainText: The script content is not encoded, and transmitted in plaintext.\nBase64: base64-encoded.\nDefault value: PlainText. If the specified value of this parameter is invalid, PlainText is used by default."
    },
    "AllowedValues": [
      "Base64",
      "PlainText"
    ],
    "Label": {
      "zh-cn": "编码方式"
    }
  }
  EOT
}

variable "name" {
  type = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the script, which supports all character sets. It can be up to 128 characters in length."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "脚本名称"
    }
  }
  EOT
}

variable "working_dir" {
  type = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Value": [
        {
          "Condition": {
            "Fn::Or": [
              {
                "Fn::Equals": [
                  "$${Type}",
                  "RunShellScript"
                ]
              }
            ]
          },
          "Value": "/root"
        },
        {
          "Condition": {
            "Fn::Or": [
              {
                "Fn::Equals": [
                  "$${Type}",
                  "RunBatScript"
                ]
              },
              {
                "Fn::Equals": [
                  "$${Type}",
                  "RunPowerShellScript"
                ]
              }
            ]
          },
          "Value": "C:\\\\Windows\\\\System32"
        }
      ]
    },
    "Description": {
      "en": "The running directory of the script in the ECS instance.\nDefault value:\nLinux instances: under the home directory of the administrator (root user): /root.\nWindows instances: under the directory where the process of the Cloud Assistant client is located, such as C:\\ProgramData\\aliyun\\assist\\$(version).",
      "zh-cn": "命令在 ECS 实例中的运行目录。长度不得超过 200 个字符。\n默认值：Linux 系统实例默认在管理员（root 用户）的 home 目录下，即/root。\nWindows 系统实例默认在云助手 Agent 进程所在目录，例如C:\\Windows\\System32。"
    },
    "Label": {
      "en": "WorkingDir",
      "zh-cn": "脚本在ECS实例中的运行目录"
    }
  }
  EOT
}

variable "command_content" {
  type = string
  nullable = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "CommandType": "$${Type}"
    },
    "AssociationProperty": "ALIYUN::OOS::Command::CommandContent",
    "Description": {
      "en": "The plaintext content or the Base64-encoded content of the script. The Base64-encoded script content cannot exceed 16 KB.\nYou can enable the custom parameter function by setting EnableParameter=true in the script content:\nDefine custom parameters in the {{}} format. Within {{}}, the spaces and line breaks before and after the name of the parameter are ignored.\nThe number of custom parameters cannot exceed 20.\nA custom parameter name can contain only letters, digits, underscores (_), and hyphens (-). It is case insensitive.\nEach custom parameter key cannot exceed 64 bytes."
    },
    "Label": {
      "zh-cn": "命令内容"
    }
  }
  EOT
}

variable "repeat_mode" {
  type = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "CommandRepeatMode"
    },
    "Description": {
      "en": "Specifies how to run the command. Valid values:\n- **Once**: immediately runs the command.\n- **Period**: runs the command on a schedule. If you set this parameter to Period, you must specify **Frequency**.\n- **NextRebootOnly**: runs the command the next time the instance is started.\n- **EveryReboot*: runs the command every time the instance is started.\nDefault value:\n- If you do not specify Frequency, the default value is Once.\n- If you specify **Frequency**, **Period** is used as the value of RepeatMode regardless of whether RepeatMode is set to Period."
    },
    "AllowedValues": [
      "Once",
      "Period",
      "NextRebootOnly",
      "EveryReboot"
    ],
    "Label": {
      "zh-cn": "命令执行的方式"
    }
  }
  EOT
}

variable "type" {
  type = string
  default = "RunShellScript"
  nullable = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "ECSCommandType"
    },
    "Description": {
      "en": "The language type of the O&M script. Valid values:\nRunBatScript: batch scripts for Windows instances\nRunPowerShellScript: PowerShell scripts for Windows instances\nRunShellScript: shell scripts for Linux instances"
    },
    "AllowedValues": [
      "RunBatScript",
      "RunPowerShellScript",
      "RunShellScript"
    ],
    "Label": {
      "en": "Type",
      "zh-cn": "运维脚本的语言类型"
    }
  }
  EOT
}

variable "launcher" {
  type = string
  description = <<EOT
  {
    "Description": {
      "en": "A bootloader for script execution. The length cannot exceed 1 KB."
    },
    "Label": {
      "en": "Launcher",
      "zh-cn": "脚本执行的引导程序"
    }
  }
  EOT
}

variable "frequency" {
  type = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${RepeatMode}",
            "Period"
          ]
        }
      }
    },
    "AssociationProperty": "Cron",
    "Description": {
      "en": "The execution period of recurring tasks. If the Timed parameter is set to True, you must specify the Frequency parameter. The interval between two recurring tasks cannot be less than 10 seconds.\nThe parameter value follows the cron expression. For more information, see Configure scheduled commands."
    },
    "Label": {
      "en": "Frequency",
      "zh-cn": "周期任务的执行周期"
    }
  }
  EOT
}

variable "run_again_on" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "LocaleKey": "CommandRunAgainOn"
        },
        "Type": "String",
        "AllowedValues": [
          "Delete"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The stage of executing the command again."
    },
    "Label": {
      "en": "RunAgainOn",
      "zh-cn": "再次执行命令的阶段"
    },
    "MinLength": 1,
    "MaxLength": 1
  }
  EOT
}

variable "enable_parameter" {
  type = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the script contains custom parameters.\nDefault value: false"
    },
    "Label": {
      "en": "EnableParameter",
      "zh-cn": "脚本中是否包含自定义参数"
    }
  }
  EOT
}

variable "sync" {
  type = bool
  default = true
  description = <<EOT
  {
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
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type = any
  nullable = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The instance id list. Instances status must be running."
    },
    "Label": {
      "zh-cn": "执行脚本的ECS实例ID列表"
    },
    "MinLength": 1,
    "MaxLength": 50
  }
  EOT
}

variable "keep_command" {
  type = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to retain the script after it is run. Valid values:\ntrue: The script is retained. You can call the InvokeCommand operation to run the script again, call the DescribeCommands operation to query the script, and call the DeleteCommands operation to delete the script. The retained script takes up the quota of Cloud Assistant scripts.\nfalse: The script is not retained. It is automatically deleted after running, without taking up the quota of Cloud Assistant scripts.\nDefault value: false"
    },
    "Label": {
      "en": "KeepCommand",
      "zh-cn": "执行完该脚本后是否保留"
    }
  }
  EOT
}

variable "tags" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type = any
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
      "en": "Tags to attach to run_command. Max support 20 tags to add during create run_command. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_command" "run_command_alicloud_ecs_command" {
  description = var.description
  timeout = var.timeout
  name = "auto-13b27f3f"
  working_dir = var.working_dir
  command_content = var.command_content
  type = var.type
  enable_parameter = var.enable_parameter
}

resource "alicloud_ecs_invocation" "run_command_alicloud_ecs_invocation" {
  parameters = var.parameters
  repeat_mode = var.repeat_mode
  frequency = var.frequency
  command_id = alicloud_ecs_command.run_command_alicloud_ecs_command.id
  instance_id = [
    var.instance_ids
  ]
}

output "command_id" {
  value = alicloud_ecs_command,alicloud_ecs_invocation.run_command.alicloud_ecs_command.id
  description = "The id of command created."
}

output "invoke_id" {
  value = alicloud_ecs_command,alicloud_ecs_invocation.run_command.alicloud_ecs_invocation.id
  description = "The invoke id of command."
}

