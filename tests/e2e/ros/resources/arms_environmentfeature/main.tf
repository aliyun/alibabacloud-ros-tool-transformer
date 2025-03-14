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

variable "config" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The metadata of the feature."
    },
    "Label": {
      "en": "Config",
      "zh-cn": "Feature 的元数据信息"
    }
  }
  EOT
}

variable "feature_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of the feature."
    },
    "Label": {
      "en": "FeatureVersion",
      "zh-cn": "Feature 的版本信息"
    }
  }
  EOT
}

variable "feature_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the feature. Valid values:\napp-agent-pilot\nmetric-agent"
    },
    "Label": {
      "en": "FeatureName",
      "zh-cn": "Feature 的名称"
    }
  }
  EOT
}

resource "alicloud_arms_env_feature" "extension_resource" {
  environment_id  = var.environment_id
  feature_version = var.feature_version
}

output "environment_id" {
  value       = alicloud_arms_env_feature.extension_resource.environment_id
  description = "The environment ID."
}

output "feature_status" {
  // Could not transform ROS Attribute FeatureStatus to Terraform attribute.
  value       = null
  description = "The status of the feature."
}

output "feature" {
  // Could not transform ROS Attribute Feature to Terraform attribute.
  value       = null
  description = "The installation information of the feature."
}

output "feature_name" {
  // Could not transform ROS Attribute FeatureName to Terraform attribute.
  value       = null
  description = "The name of the feature."
}

