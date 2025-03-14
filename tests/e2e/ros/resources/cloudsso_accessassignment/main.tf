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

variable "principal_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the CloudSSO identity.\n- If you set PrincipalType to User, set PrincipalId to the ID of the CloudSSO user.\n- If you set PrincipalType to Group, set PrincipalId to the ID of the CloudSSO group."
    },
    "Label": {
      "en": "PrincipalId",
      "zh-cn": "云SSO身份 ID"
    }
  }
  EOT
}

variable "target_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "RD-Account"
    ],
    "Description": {
      "en": "The type of the task object. Set the value to RD-Account, which specifies the accounts in the resource directory."
    },
    "Label": {
      "en": "TargetType",
      "zh-cn": "任务目标类型"
    }
  }
  EOT
}

variable "principal_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "User",
      "Group"
    ],
    "Description": {
      "en": "The type of the CloudSSO identity. Valid values: User, Group"
    },
    "Label": {
      "en": "PrincipalType",
      "zh-cn": "云SSO身份类型"
    }
  }
  EOT
}

variable "access_configuration_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the access configuration."
    },
    "Label": {
      "en": "AccessConfigurationId",
      "zh-cn": "访问配置ID"
    }
  }
  EOT
}

variable "target_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the task object."
    },
    "Label": {
      "en": "TargetId",
      "zh-cn": "部署目标ID"
    }
  }
  EOT
}

resource "alicloud_cloud_sso_access_assignment" "access_assignment" {
  directory_id            = var.directory_id
  principal_id            = var.principal_id
  target_type             = var.target_type
  principal_type          = var.principal_type
  access_configuration_id = var.access_configuration_id
  target_id               = var.target_id
}

