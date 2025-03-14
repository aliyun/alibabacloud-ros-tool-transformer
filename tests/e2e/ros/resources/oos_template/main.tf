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

variable "content" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The content of the template. The template must be in the JSON or YAML format. Maximum size: 64 KB."
    },
    "Label": {
      "en": "Content",
      "zh-cn": "模板内容"
    },
    "MaxLength": 65536
  }
  EOT
}

variable "template_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the template. The template name can be up to 200 characters in length. The name can contain letters, digits, hyphens (-), and underscores (_). It cannot start with ALIYUN, ACS, ALIBABA, or ALICLOUD."
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
      "zh-cn": "标签，由键值对组成。例如：{“k1”:”v1”,”k2”:”v2”}。"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    }
  }
  EOT
}

resource "alicloud_oos_template" "template" {
  resource_group_id = var.resource_group_id
  content           = var.content
  template_name     = var.template_name
  tags              = var.tags
}

output "execution_policy" {
  // Could not transform ROS Attribute ExecutionPolicy to Terraform attribute.
  value       = null
  description = "Execution Policy"
}

output "template_name" {
  value       = alicloud_oos_template.template.id
  description = "Template Name"
}

output "template_id" {
  value       = alicloud_oos_template.template.template_id
  description = "Template ID"
}

