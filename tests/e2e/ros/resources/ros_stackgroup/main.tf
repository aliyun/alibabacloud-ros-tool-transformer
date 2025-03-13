variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Label": {
      "en": "Description",
      "zh-cn": "资源栈组描述"
    }
  }
  EOT
}

variable "parameters" {
  type        = any
  description = <<EOT
  {
    "Label": {
      "en": "Parameters",
      "zh-cn": "参数信息"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "dynamic_template_body" {
  type        = any
  description = <<EOT
  {
    "Label": {
      "en": "DynamicTemplateBody",
      "zh-cn": "模板主体的结构"
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

variable "template_version" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "TemplateVersion",
      "zh-cn": "模板版本"
    }
  }
  EOT
}

variable "administration_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "zh-cn": "创建自助管理权限模式的资源栈组时，ROS扮演的RAM管理员角色名称。"
    },
    "Label": {
      "en": "AdministrationRoleName",
      "zh-cn": "创建自助管理权限模式的资源栈组时"
    }
  }
  EOT
}

variable "template_body" {
  type        = any
  description = <<EOT
  {
    "Label": {
      "en": "TemplateBody",
      "zh-cn": "模板主体的结构"
    }
  }
  EOT
}

variable "templateurl" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "TemplateURL",
      "zh-cn": "模板主体的文件的位置"
    }
  }
  EOT
}

variable "auto_deployment" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Enabled": {
          "Type": "Boolean",
          "Required": true
        },
        "RetainStacksOnAccountRemoval": {
          "Type": "Boolean",
          "Required": false
        }
      }
    },
    "Label": {
      "en": "AutoDeployment",
      "zh-cn": "自动部署设置信息"
    }
  }
  EOT
}

variable "permission_model" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "PermissionModel",
      "zh-cn": "授权模式"
    }
  }
  EOT
}

variable "execution_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "zh-cn": "创建自助管理权限模式的资源栈组时，指定的管理员角色。"
    },
    "Label": {
      "en": "ExecutionRoleName",
      "zh-cn": "创建自助管理权限模式的资源栈组时"
    }
  }
  EOT
}

variable "template_id" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "TemplateId",
      "zh-cn": "模板ID"
    }
  }
  EOT
}

resource "alicloud_ros_stack_group" "extension_resource" {
  description              = var.description
  parameters               = var.parameters
  stack_group_name         = var.stack_group_name
  template_version         = var.template_version
  administration_role_name = var.administration_role_name
  template_body            = var.template_body
  template_url             = var.templateurl
  execution_role_name      = var.execution_role_name
}

output "stack_group_id" {
  value = alicloud_ros_stack_group.extension_resource.stack_group_id
}

