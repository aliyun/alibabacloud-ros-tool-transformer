variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the authorization, less than 180 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "授权说明 "
    }
  }
  EOT
}

variable "auth_valid_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time (UTC) when the authorization expires. If this parameter is empty, the authorization does not expire.\nPattern: YYYY-MM-DDThh:mm:ssZ"
    },
    "AllowedPattern": "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}Z$",
    "Label": {
      "en": "AuthValidTime",
      "zh-cn": "授权有效时间的截止时间"
    }
  }
  EOT
}

variable "stage_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "Authorize in this stage."
    },
    "AllowedValues": [
      "TEST",
      "RELEASE",
      "PRE"
    ],
    "Label": {
      "zh-cn": "运行环境名称"
    }
  }
  EOT
}

variable "api_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "APIs to authorize."
    },
    "Label": {
      "en": "ApiIds",
      "zh-cn": "指定操作的API编号"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "app_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "APPs are authorized to APIs."
    },
    "Label": {
      "en": "AppIds",
      "zh-cn": "应用编号列表"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The id of the group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "API分组ID"
    }
  }
  EOT
}

resource "alicloud_api_gateway_app_attachment" "authorization" {
  stage_name = var.stage_name
  group_id   = var.group_id
}

