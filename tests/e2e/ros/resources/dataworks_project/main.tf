variable "project_identifier" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the workspace. The name can contain letters, digits, and underscores (_) and must start with a letter or digit."
    },
    "AllowedPattern": "^[a-zA-Z][a-zA-Z0-9_]{2,27}$",
    "Label": {
      "en": "ProjectIdentifier",
      "zh-cn": "工作空间的名称"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "project_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The display name of the workspace. If not provided, it is the same as ProjectIdentifier."
    },
    "Label": {
      "en": "ProjectName",
      "zh-cn": "工作空间的显示名称"
    },
    "MaxLength": 23
  }
  EOT
}

variable "is_allow_download" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether query result download from DataStudio is allowed. Valid values:\ntrue: allowed\nfalse: not allowed\nDefault value: true."
    },
    "Label": {
      "en": "IsAllowDownload",
      "zh-cn": "是否允许下载ide上查询的结果"
    }
  }
  EOT
}

variable "project_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the workspace. If not provided, it is the same as ProjectIdentifier."
    },
    "Label": {
      "en": "ProjectDescription",
      "zh-cn": "工作空间的详细描述信息"
    },
    "MaxLength": 80
  }
  EOT
}

variable "project_mode" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The mode of the workspace. For more information about the differences between the modes of workspaces, see Differences between workspaces in basic mode and workspaces in standard mode. Valid values:\n2: basic mode\n3: standard mode\nDefault value: 2."
    },
    "AllowedValues": [
      2,
      3
    ],
    "Label": {
      "en": "ProjectMode",
      "zh-cn": "工作空间的模式"
    }
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
      "en": "Tags to attach to workspace. Max support 20 tags to add during create workspace. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "工作空间绑定的标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "disable_development" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to disable the Development role. Valid values:\nfalse: enables the Development role.\ntrue: disables the Development role.\nDefault value: false."
    },
    "Label": {
      "en": "DisableDevelopment",
      "zh-cn": "是否禁用开发角色"
    }
  }
  EOT
}

output "project_identifier" {
  // Could not transform ROS Attribute ProjectIdentifier to Terraform attribute.
  value       = null
  description = "The name of the workspace. The name can contain letters, digits, and underscores (_) and must start with a letter or digit."
}

output "is_default" {
  // Could not transform ROS Attribute IsDefault to Terraform attribute.
  value       = null
  description = <<EOT
  "Indicates whether the workspace is the default workspace. Valid values:\n1: The workspace is the default workspace.\n0: The workspace is not the default workspace."
  EOT
}

output "scheduler_max_retry_times" {
  // Could not transform ROS Attribute SchedulerMaxRetryTimes to Terraform attribute.
  value       = null
  description = "The default maximum number of automatic reruns that are allowed after an error occurs."
}

output "protected_mode" {
  // Could not transform ROS Attribute ProtectedMode to Terraform attribute.
  value       = null
  description = <<EOT
  "Indicates whether the workspace protection feature is enabled. Valid values:\n1: The workspace protection feature is enabled.\n0: The workspace protection feature is disabled."
  EOT
}

output "project_id" {
  // Could not transform ROS Attribute ProjectId to Terraform attribute.
  value       = null
  description = "The ID of the workspace."
}

output "table_privacy_mode" {
  // Could not transform ROS Attribute TablePrivacyMode to Terraform attribute.
  value       = null
  description = <<EOT
  "Indicates whether the MaxCompute tables in the workspace are visible to the users within the tenant. Valid values:\n0: The MaxCompute tables are invisible to the users within a tenant.\n1: The MaxCompute tables are visible to the users within a tenant."
  EOT
}

output "env_types" {
  // Could not transform ROS Attribute EnvTypes to Terraform attribute.
  value       = null
  description = <<EOT
  "The environment of the workspace. Valid values: PROD and DEV.\nThe value PROD indicates the production environment. Workspaces in basic mode provide only the production environment.\nThe value DEV indicates the development environment. Workspaces in standard mode provide both the development environment and the production environment."
  EOT
}

output "resident_area" {
  // Could not transform ROS Attribute ResidentArea to Terraform attribute.
  value       = null
  description = "The type of the workspace. Valid values: private and swap."
}

output "scheduler_retry_interval" {
  // Could not transform ROS Attribute SchedulerRetryInterval to Terraform attribute.
  value       = null
  description = "The interval between automatic reruns after an error occurs. Unit: milliseconds. The maximum interval is 30 minutes. You must pay attention to the conversion between units."
}

