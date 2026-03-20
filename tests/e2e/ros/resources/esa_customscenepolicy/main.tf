variable "custom_scene_policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The policy name."
    },
    "Label": {
      "en": "CustomScenePolicyName",
      "zh-cn": "策略名称"
    }
  }
  EOT
}

variable "end_time" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The time when the policy expires.\nThe time follows the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time is displayed in UTC."
    },
    "Label": {
      "en": "EndTime",
      "zh-cn": "策略结束时间"
    }
  }
  EOT
}

variable "create_time" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The time when the policy takes effect.\nThe time follows the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time is displayed in UTC."
    },
    "Label": {
      "en": "CreateTime",
      "zh-cn": "策略起始时间"
    }
  }
  EOT
}

variable "objects" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IDs of the websites that you want to associate with the policy. Separate multiple IDs with commas (,)."
    },
    "Label": {
      "en": "Objects",
      "zh-cn": "要关联的站点 ID 信息"
    }
  }
  EOT
}

variable "template" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "promotion"
    ],
    "Description": {
      "en": "The name of the policy template. Valid value:\npromotion: major events."
    },
    "Label": {
      "en": "Template",
      "zh-cn": "模板名称"
    }
  }
  EOT
}

resource "alicloud_esa_custom_scene_policy" "extension_resource" {
  custom_scene_policy_name = var.custom_scene_policy_name
  end_time                 = var.end_time
  create_time              = var.create_time
  site_ids                 = var.objects
  template                 = var.template
}

output "policy_id" {
  value       = alicloud_esa_custom_scene_policy.extension_resource.id
  description = "The Id of the Policy."
}

