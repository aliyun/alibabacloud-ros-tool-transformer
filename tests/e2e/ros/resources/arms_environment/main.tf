variable "managed_type" {
  type        = string
  default     = "none"
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether agents or exporters are managed. Valid values:\nnone: No. By default, no managed agents or exporters are provided for ACK clusters.\nagent: Agents are managed. By default, managed agents are provided for ASK clusters, ACS clusters, and ACK One clusters.\nagent-exporter: Agents and exporters are managed. By default, managed agents and exporters are provided for cloud services."
    },
    "AllowedValues": [
      "none",
      "agent",
      "agent-exporter"
    ],
    "Label": {
      "en": "ManagedType",
      "zh-cn": "托管类型"
    }
  }
  EOT
}

variable "environment_sub_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "ACK",
      "ECS",
      "One",
      "Cloud"
    ],
    "Description": {
      "en": "The subtype of the environment. Valid values:\nOne: CS type environment\nACK: CS type environment\nECS: ECS type environment\nCloud: cloud service"
    },
    "Label": {
      "en": "EnvironmentSubType",
      "zh-cn": "环境的子类型"
    }
  }
  EOT
}

variable "environment_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "CS",
      "ECS",
      "Cloud"
    ],
    "Description": {
      "en": "The type of the environment. Valid values:\nCS: ACK\nECS: ECS\nCloud: cloud service"
    },
    "Label": {
      "en": "EnvironmentType",
      "zh-cn": "环境类型"
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
      "zh-cn": "资源组 Id"
    }
  }
  EOT
}

variable "environment_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the environment."
    },
    "Label": {
      "en": "EnvironmentName",
      "zh-cn": "环境名称"
    }
  }
  EOT
}

variable "bind_resource_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the resource bound to the environment, such as the container ID or VPC ID. For a Cloud environment, specify the region ID."
    },
    "Label": {
      "en": "BindResourceId",
      "zh-cn": "环境绑定的资源实例 ID"
    }
  }
  EOT
}

variable "grafana_workspace_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the grafana workspace bound to the environment. When passing space, the default share grafana is used."
    },
    "Label": {
      "en": "GrafanaWorkspaceId",
      "zh-cn": "环境绑定的 grafana 工作区 id"
    }
  }
  EOT
}

variable "delete_prom_instance" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Cascade delete Prometheus instance. Default value: true."
    },
    "Label": {
      "en": "DeletePromInstance",
      "zh-cn": "是否级联删除 prometheus 实例"
    }
  }
  EOT
}

variable "prometheus_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Prometheus instance. If no Prometheus instance is created, call the InitEnvironment operation to initialize a storage instance."
    },
    "Label": {
      "en": "PrometheusInstanceId",
      "zh-cn": "环境绑定的 prom 实例 id"
    }
  }
  EOT
}

variable "fee_package" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The payable resource plan. Valid values:\nIf the EnvironmentType parameter is set to CS, set the value to CS_Basic or CS_Pro. Default value: CS_Basic.\nOtherwise, leave the parameter empty."
    },
    "Label": {
      "en": "FeePackage",
      "zh-cn": "付费套餐"
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
      "en": "Tags of Environment."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_arms_environment" "extension_resource" {
  managed_type         = var.managed_type
  environment_sub_type = var.environment_sub_type
  environment_type     = var.environment_type
  resource_group_id    = var.resource_group_id
  environment_name     = var.environment_name
  bind_resource_id     = var.bind_resource_id
  tags                 = var.tags
}

output "managed_type" {
  value       = alicloud_arms_environment.extension_resource.managed_type
  description = "Specifies whether agents or exporters are managed."
}

output "environment_id" {
  value       = alicloud_arms_environment.extension_resource.id
  description = "The id of the environment."
}

output "environment_sub_type" {
  value       = alicloud_arms_environment.extension_resource.environment_sub_type
  description = "The subtype of the environment."
}

output "environment_type" {
  value       = alicloud_arms_environment.extension_resource.environment_type
  description = "The type of the environment."
}

output "resource_group_id" {
  value       = alicloud_arms_environment.extension_resource.resource_group_id
  description = "The ID of the resource group."
}

output "environment_name" {
  value       = alicloud_arms_environment.extension_resource.environment_name
  description = "The name of the environment."
}

output "grafana_workspace_id" {
  // Could not transform ROS Attribute GrafanaWorkspaceId to Terraform attribute.
  value       = null
  description = "The ID of the grafana workspace bound to the environment."
}

output "prometheus_instance_id" {
  // Could not transform ROS Attribute PrometheusInstanceId to Terraform attribute.
  value       = null
  description = "The ID of the Prometheus instance."
}

output "fee_package" {
  // Could not transform ROS Attribute FeePackage to Terraform attribute.
  value       = null
  description = "The payable resource plan."
}

