variable "environment_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The id of the environment."
    },
    "Label": {
      "en": "EnvironmentId",
      "zh-cn": "环境 ID"
    }
  }
  EOT
}

variable "addon_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of the add-on."
    },
    "Label": {
      "en": "AddonVersion",
      "zh-cn": "Addon 版本"
    }
  }
  EOT
}

variable "values" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The metadata."
    },
    "Label": {
      "en": "Values",
      "zh-cn": "输入的元数据"
    }
  }
  EOT
}

variable "release_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the add-on after it is installed. If you do not specify this parameter, a default rule name is generated."
    },
    "Label": {
      "en": "ReleaseName",
      "zh-cn": "安装后的插件名称"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the add-on."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "Addon 名称"
    }
  }
  EOT
}

resource "alicloud_arms_addon_release" "extension_resource" {
  environment_id = var.environment_id
  addon_version  = var.addon_version
}

output "environment_id" {
  value       = alicloud_arms_addon_release.extension_resource.environment_id
  description = "The environment ID."
}

output "config" {
  // Could not transform ROS Attribute Config to Terraform attribute.
  value       = null
  description = "AddonRelease configuration information."
}

output "release_name" {
  // Could not transform ROS Attribute ReleaseName to Terraform attribute.
  value       = null
  description = "The name of the add-on."
}

output "release" {
  // Could not transform ROS Attribute Release to Terraform attribute.
  value       = null
  description = "Release information."
}

