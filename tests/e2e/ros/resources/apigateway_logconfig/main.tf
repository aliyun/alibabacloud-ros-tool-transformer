variable "sls_log_store" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logstore name of SLS"
    },
    "Label": {
      "en": "SlsLogStore",
      "zh-cn": "日志项目下的日志库"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "sls_project" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Project name of SLS"
    },
    "Label": {
      "en": "SlsProject",
      "zh-cn": "日志项目"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

resource "alicloud_api_gateway_log_config" "log_config" {
  sls_log_store = var.sls_log_store
  sls_project   = var.sls_project
}

output "sls_log_store" {
  value       = alicloud_api_gateway_log_config.log_config.sls_log_store
  description = "Logstore name of SLS"
}

output "sls_project" {
  value       = alicloud_api_gateway_log_config.log_config.sls_project
  description = "Project name of SLS"
}

