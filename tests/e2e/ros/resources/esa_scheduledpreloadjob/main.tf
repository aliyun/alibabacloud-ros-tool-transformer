variable "insert_way" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "oss",
      "textBox"
    ],
    "Description": {
      "en": "The method to submit the URLs to be prefetched."
    },
    "Label": {
      "en": "InsertWay",
      "zh-cn": "预热文件上传方式"
    }
  }
  EOT
}

variable "site_id" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The site ID."
    },
    "Label": {
      "en": "SiteId",
      "zh-cn": "站点 ID"
    }
  }
  EOT
}

variable "oss_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Preheat OSS files regularly and fill in the OSS file address. Note: The OSS file contains the URL that you need to warm up."
    },
    "Label": {
      "en": "OssUrl",
      "zh-cn": "定时预热 OSS 文件"
    }
  }
  EOT
}

variable "scheduled_preload_job_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the scheduled prefetch task."
    },
    "Label": {
      "en": "ScheduledPreloadJobName",
      "zh-cn": "定时预热任务名称"
    }
  }
  EOT
}

variable "url_list" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The URL."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "A list of URLs to be preheated, which is used when uploading a preheated file in the text box mode."
    },
    "Label": {
      "en": "UrlList",
      "zh-cn": "需要预热的 URL 列表"
    },
    "MinLength": 1,
    "MaxLength": 10000
  }
  EOT
}

resource "alicloud_esa_scheduled_preload_execution" "extension_resource" {}

output "scheduled_preload_job_id" {
  value       = alicloud_esa_scheduled_preload_execution.extension_resource.scheduled_preload_execution_id
  description = "The ID of the prefetch task."
}

