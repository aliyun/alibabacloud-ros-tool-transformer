variable "sls_project_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The unique ARN of the Log Service project."
    },
    "Label": {
      "en": "SlsProjectArn",
      "zh-cn": "跟踪投递的日志服务项目的ARN"
    }
  }
  EOT
}

variable "role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The RAM role in ActionTrail permitted by the user."
    },
    "Label": {
      "en": "RoleName",
      "zh-cn": "操作审计服务关联角色名称"
    }
  }
  EOT
}

variable "eventrw" {
  type        = string
  default     = "Write"
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the event is a read or a write event. Valid values: Read, Write, and All. Default value: Write."
    },
    "AllowedValues": [
      "All",
      "Read",
      "Write"
    ],
    "Label": {
      "en": "EventRW",
      "zh-cn": "投递事件的读写类型"
    }
  }
  EOT
}

variable "oss_key_prefix" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the specified OSS bucket name. This parameter can be left empty."
    },
    "Label": {
      "en": "OssKeyPrefix",
      "zh-cn": "跟踪投递的OSS存储空间文件名的前缀"
    }
  }
  EOT
}

variable "oss_bucket_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The OSS bucket to which the trail delivers logs. Ensure that this is an existing OSS bucket."
    },
    "Label": {
      "en": "OssBucketName",
      "zh-cn": "跟踪投递的OSS存储空间名称"
    }
  }
  EOT
}

variable "sls_write_role_arn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The unique ARN of the Log Service role.",
      "zh-cn": "操作审计向日志服务项目投递操作事件时，扮演的角色ARN。"
    },
    "Label": {
      "en": "SlsWriteRoleArn",
      "zh-cn": "操作审计向日志服务项目投递操作事件时"
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
      "en": "The name of the trail to be created, which must be unique for an account."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "跟踪名称"
    }
  }
  EOT
}

resource "alicloud_actiontrail_trail" "trail" {
  sls_project_arn    = var.sls_project_arn
  role_name          = var.role_name
  event_rw           = var.eventrw
  oss_key_prefix     = var.oss_key_prefix
  oss_bucket_name    = var.oss_bucket_name
  sls_write_role_arn = var.sls_write_role_arn
  name               = var.name
}

output "name" {
  value       = alicloud_actiontrail_trail.trail.id
  description = "The name of the trail to be created, which must be unique for an account."
}

