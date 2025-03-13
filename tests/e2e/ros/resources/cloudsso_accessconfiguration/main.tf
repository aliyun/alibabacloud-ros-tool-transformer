variable "session_duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The duration of a session in which a CloudSSO user accesses an account in your resource directory by using the access configuration.\nUnit: seconds.\nValid values: 900 to 43200. The value 900 indicates 15 minutes. The value 43200 indicates 12 hours.\nDefault value: 3600. The value indicates 1 hour."
    },
    "MinValue": 900,
    "Label": {
      "en": "SessionDuration",
      "zh-cn": "会话持续时间"
    },
    "MaxValue": 43200
  }
  EOT
}

variable "access_configuration_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the access configuration.\nThe name can contain letters, digits, and hyphens (-).\nThe name can be up to 32 characters in length."
    },
    "AllowedPattern": "^[a-zA-Z0-9-]{1,32}$",
    "Label": {
      "en": "AccessConfigurationName",
      "zh-cn": "访问配置名称"
    }
  }
  EOT
}

variable "directory_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the directory."
    },
    "Label": {
      "en": "DirectoryId",
      "zh-cn": "目录ID"
    }
  }
  EOT
}

variable "relay_state" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The initial web page that is displayed after a CloudSSO user accesses an account in your resource directory by using the access configuration.\nThe web page must be a page of the Alibaba Cloud Management Console. By default, this parameter is empty, which indicates that the initial web page is the homepage of the Alibaba Cloud Management Console."
    },
    "Label": {
      "en": "RelayState",
      "zh-cn": "初始访问页面"
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
      "en": "The description of the access configuration.\nThe description can be up to 1,024 characters in length."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "访问配置的描述"
    },
    "MaxLength": 1024
  }
  EOT
}

resource "alicloud_cloud_sso_access_configuration" "access_configuration" {
  session_duration          = var.session_duration
  access_configuration_name = var.access_configuration_name
  directory_id              = var.directory_id
  relay_state               = var.relay_state
  description               = var.description
}

output "access_configuration_id" {
  value       = alicloud_cloud_sso_access_configuration.access_configuration.access_configuration_id
  description = "The ID of the access configuration."
}

