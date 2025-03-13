variable "configure_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The configuration mode. Valid values: ApplyOnce: The configuration is applied only once. After a configuration is updated, the new configuration is applied. ApplyAndMonitor: The configuration is applied only once. After the configuration is applied, the system only checks whether the configuration is migrated in the future. ApplyAndAutoCorrect: The configuration is always applied."
    },
    "Label": {
      "en": "ConfigureMode",
      "zh-cn": "配置模式"
    }
  }
  EOT
}

variable "schedule_expression" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The schedule expression. The interval between two schedules must be a minimum of 30 minutes."
    },
    "Label": {
      "en": "ScheduleExpression",
      "zh-cn": "调度表达式"
    }
  }
  EOT
}

variable "schedule_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The schedule type. Set the value to rate."
    },
    "Label": {
      "en": "ScheduleType",
      "zh-cn": "调度类型"
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
      "en": "The description of the desired-state configuration."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "终态配置的描述信息"
    }
  }
  EOT
}

variable "parameters" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The parameters."
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "参数"
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
      "en": "The resource group ID."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "template_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the template. The name must be 1 to 200 characters in length and can contain letters, digits, hyphens (-), and underscores (_)."
    },
    "Label": {
      "en": "TemplateName",
      "zh-cn": "模板名称"
    }
  }
  EOT
}

variable "template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version number of the template. If you do not specify this parameter, the latest version of the template is used."
    },
    "Label": {
      "en": "TemplateVersion",
      "zh-cn": "版本号"
    }
  }
  EOT
}

variable "targets" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resources to be queried."
    },
    "Label": {
      "en": "Targets",
      "zh-cn": "目标资源"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Tag value and the key mapping, the label of the key number can be up to 20."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    }
  }
  EOT
}

resource "alicloud_oos_state_configuration" "state_configuration" {
  configure_mode      = var.configure_mode
  schedule_expression = var.schedule_expression
  schedule_type       = var.schedule_type
  description         = var.description
  parameters          = var.parameters
  resource_group_id   = var.resource_group_id
  template_name       = var.template_name
  template_version    = var.template_version
  targets             = var.targets
  tags                = var.tags
}

output "state_configuration_id" {
  value       = alicloud_oos_state_configuration.state_configuration.id
  description = "The ID of the desired-state configuration."
}

