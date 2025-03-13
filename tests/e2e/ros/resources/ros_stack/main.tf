variable "templateurl" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Location of file containing the template body. The URL must point to a template (max size: 524288 bytes) that is located in a http web server(http, https), or an Aliyun OSS bucket(Such as oss://ros-template/demo?RegionId=cn-hangzhou, oss://ros-template/demo. RegionId is default to the value of RegionId Parameter of the request.).\nYou must specify either the TemplateBody or the TemplateURL property. If both are specified, TemplateBody will be used."
    },
    "Label": {
      "en": "TemplateURL",
      "zh-cn": "模板主体的文件的位置"
    },
    "MaxLength": 1024
  }
  EOT
}

variable "parameters" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The set of parameters passed to this nested stack.",
      "zh-cn": "一组键值对，表示在创建此嵌套资源栈时传递给ROS的参数。"
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "一组键值对"
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
      "en": "Resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "timeout_mins" {
  type        = number
  default     = 60
  description = <<EOT
  {
    "Description": {
      "en": "The length of time, in minutes, to wait for the nested stack creation or update. Default to 60 minutes."
    },
    "Label": {
      "en": "TimeoutMins",
      "zh-cn": "创建或更新资源栈的超时时间"
    }
  }
  EOT
}

variable "template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Template version of template containing the template body."
    },
    "AllowedPattern": "^v(([1-9])|([1-9][0-9])|([1-9][0-9][0-9]))$",
    "Label": {
      "en": "TemplateVersion",
      "zh-cn": "模板版本名"
    }
  }
  EOT
}

variable "template_body" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Structure containing the template body.\nIt is just to facilitate the passing of template. It is raw content.Functions in TemplateBody will not be resolved in parent stack.\nYou must specify either the TemplateBody or the TemplateURL property. If both are specified, TemplateBody will be used.",
      "zh-cn": "模板内容，用于简化模板的传递。"
    },
    "Label": {
      "en": "TemplateBody",
      "zh-cn": "模板内容"
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
          "Description": {
            "en": "Tag value."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Tag key."
          },
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
      "en": "The tags of nested stack. If it is specified, it will be passed to all tag-supported resources in the nested stack."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    }
  }
  EOT
}

variable "template_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Template ID of template containing the template body."
    },
    "AllowedPattern": "^([0-9a-f]{8}[-][0-9a-f]{4}[-a-z0-9][0-9a-f]{4}[-][0-9a-f]{4}[-][0-9a-f]{12})|(acs[:]ros[:][*][:]\\d+[:]template/[0-9a-f]{8}[-][0-9a-f]{4}[-a-z0-9][0-9a-f]{4}[-][0-9a-f]{4}[-][0-9a-f]{12})|(acs[:]ros[:]template[/][-_a-zA-Z0-9]+[/][-_a-zA-Z0-9]+)$|(acs[:]ros[:]public_template[/][-_a-zA-Z0-9]+)$",
    "Label": {
      "en": "TemplateId",
      "zh-cn": "模板ID"
    }
  }
  EOT
}

resource "alicloud_ros_stack" "nested_stack" {
  template_url       = var.templateurl
  parameters         = var.parameters
  timeout_in_minutes = var.timeout_mins
  template_version   = var.template_version
  template_body      = var.template_body
  tags               = var.tags
}

