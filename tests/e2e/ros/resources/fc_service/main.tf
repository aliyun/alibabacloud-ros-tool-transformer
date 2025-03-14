variable "role" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The role grants Function Compute the permission to access user’s cloud resources, such as pushing logs to user’s log store. The temporary STS token generated from this role can be retrieved from function context and used to access cloud resources. "
    },
    "Label": {
      "en": "Role",
      "zh-cn": "授予函数计算所需权限的RAM角色ARN"
    }
  }
  EOT
}

variable "internet_access" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Set it to true to enable Internet access."
    },
    "Label": {
      "en": "InternetAccess",
      "zh-cn": "函数是否可以访问公网"
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
      "en": "Service description"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "服务的描述"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete the service without waiting for network interfaces to be cleaned up if VpcConfig is specified. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除"
    }
  }
  EOT
}

variable "tracing_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of the tracing analysis system."
          },
          "Required": false
        },
        "Params": {
          "Type": "Json",
          "Description": {
            "en": "The tracing analysis parameters."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The Tracing Analysis configuration. After Function Compute integrates with Tracing Analysis, you can record the stay time of a request in Function Compute, view the cold start time for a function, and record the execution time of a function."
    },
    "Label": {
      "en": "TracingConfig",
      "zh-cn": "链路追踪配置"
    }
  }
  EOT
}

variable "vpc_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "VPC ID"
          },
          "Required": true
        },
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "Zone Id"
          },
          "Required": false
        },
        "VSwitchIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "List of VSwitch IDs\t"
          },
          "Required": true
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "Security group ID"
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "VPC configuration. Function Compute uses the config to setup ENI in the specific VPC.",
      "zh-cn": "专有网络配置，配置后函数可以访问指定专有网络。"
    },
    "Label": {
      "en": "VpcConfig",
      "zh-cn": "专有网络配置"
    }
  }
  EOT
}

variable "service_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Service name"
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "服务的名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "oss_mount_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPoints": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ReadOnly": {
                "Type": "Boolean",
                "Description": {
                  "en": "Whether the oss bucket is read-only"
                },
                "Required": true
              },
              "BucketName": {
                "Type": "String",
                "Description": {
                  "en": "mount OSS bucket name."
                },
                "Required": true
              },
              "BucketPath": {
                "Type": "String",
                "Description": {
                  "en": "Path of the mounted OSS Bucket."
                },
                "Required": true
              },
              "EndPoint": {
                "Type": "String",
                "Description": {
                  "en": "OSS access address,"
                },
                "Required": true
              },
              "MountDir": {
                "Type": "String",
                "Description": {
                  "en": "A local mount point."
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The OSS mount point configurations."
          },
          "Required": true,
          "MaxLength": 5
        }
      }
    },
    "Description": {
      "en": "The OSS mount configurations."
    },
    "Label": {
      "en": "OssMountConfig",
      "zh-cn": "OSS挂载配置"
    }
  }
  EOT
}

variable "vpc_bindings" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
        "Type": "String",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Function Invocation only by Specified VPCs. \nBy default, you can invoke the function by using the Internet endpoint and internal endpoint after a function is created. If you want the function to be invoked only by using specified VPCs, but not the Internet endpoint or internal endpoint, you must bind the specified VPCs to the service."
    },
    "Label": {
      "en": "VpcBindings",
      "zh-cn": "函数计算中绑定的VPC ID列表"
    },
    "MaxLength": 20
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
      "en": "Tags to attach to service. Max support 20 tags to add during create service. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "nas_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MountPoints": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ServerAddr": {
                "Type": "String",
                "Description": {
                  "en": "The address of NAS instance."
                },
                "Required": true
              },
              "MountDir": {
                "Type": "String",
                "Description": {
                  "en": "A local mount point."
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "Mount points"
          },
          "Required": true,
          "MaxLength": 5
        },
        "UserId": {
          "Type": "Number",
          "Description": {
            "en": "User ID"
          },
          "Required": true,
          "MinValue": -1,
          "MaxValue": 65534
        },
        "GroupId": {
          "Type": "Number",
          "Description": {
            "en": "Group ID"
          },
          "Required": true,
          "MinValue": -1,
          "MaxValue": 65534
        }
      }
    },
    "Description": {
      "en": "NAS configuration. Function Compute uses a specified NAS configured on the service.",
      "zh-cn": "NAS配置，配置后函数可以访问指定NAS资源。"
    },
    "Label": {
      "en": "NasConfig",
      "zh-cn": "NAS配置"
    }
  }
  EOT
}

variable "log_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Project": {
          "Type": "String",
          "Description": {
            "en": "The project name of Logs service"
          },
          "Required": false
        },
        "LogBeginRule": {
          "Type": "String",
          "Description": {
            "en": "The log rotation rule. Log are split based on the rule. The log blocks obtained after the splitting are written to Log Service. Valid values:\nNone: disables the log splitting rule. This is the default value.\nDefaultRegex: sets the log splitting rule to the default regular expression. If you set this parameter to DefaultRegex, logs are split based on the data in a log. For example, the line that contains 2021-10-10 in the log is considered as the first line of a log block. The first line and the following consecutive lines that do not contain dates in the log are written to Log Service as a whole."
          },
          "Required": false
        },
        "Logstore": {
          "Type": "String",
          "Description": {
            "en": "The log store name of Logs service"
          },
          "Required": false
        },
        "EnableRequestMetrics": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable the request-level metrics. If you enable this feature, you can view the time and memory that are consumed for a specific invocation of each function in the service. Valid values:\nfalse: disables request-level metrics.\ntrue: enables request-level metrics. Default value: true."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Log configuration. Function Compute pushes function execution logs to the configured log store.",
      "zh-cn": "日志配置，函数产生的日志会写入此处配置的日志库中。"
    },
    "Label": {
      "en": "LogConfig",
      "zh-cn": "日志配置"
    }
  }
  EOT
}

resource "alicloud_fc_service" "service" {
  role            = var.role
  internet_access = var.internet_access
  description     = var.description
  vpc_config      = var.vpc_config
  name            = var.service_name
  tags            = var.tags
  log_config      = var.log_config
}

output "role" {
  value       = alicloud_fc_service.service.role
  description = "Role of service"
}

output "internet_access" {
  value       = alicloud_fc_service.service.internet_access
  description = "Whether enable Internet access"
}

output "vpc_id" {
  // Could not transform ROS Attribute VpcId to Terraform attribute.
  value       = null
  description = "VPC ID"
}

output "service_name" {
  // Could not transform ROS Attribute ServiceName to Terraform attribute.
  value       = null
  description = "The service name"
}

output "logstore" {
  // Could not transform ROS Attribute Logstore to Terraform attribute.
  value       = null
  description = "Log store of service"
}

output "tags" {
  value       = alicloud_fc_service.service.tags
  description = "Tags of service"
}

output "log_project" {
  // Could not transform ROS Attribute LogProject to Terraform attribute.
  value       = null
  description = "Log project of service"
}

output "service_id" {
  value       = alicloud_fc_service.service.id
  description = "The service ID"
}

