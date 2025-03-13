variable "big_screen" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "BigScreen",
      "zh-cn": "可视化大屏服务"
    }
  }
  EOT
}

variable "prefessional_service" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "zh-cn": "是否使用产品专家服务。说明 专家服务：提供钉钉群交流，负责产品配置、策略优化、日常监控。"
    },
    "Label": {
      "en": "PrefessionalService",
      "zh-cn": "是否使用产品专家服务"
    }
  }
  EOT
}

variable "ext_domain_package" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "ExtDomainPackage",
      "zh-cn": "域名扩展包数量"
    }
  }
  EOT
}

variable "log_time" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "LogTime",
      "zh-cn": "日志存储时长"
    }
  }
  EOT
}

variable "renewal_status" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "RenewalStatus",
      "zh-cn": "自动续费状态"
    }
  }
  EOT
}

variable "renew_period" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "RenewPeriod",
      "zh-cn": "自动续费周期 "
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Label": {
      "en": "Period",
      "zh-cn": "预付费周期"
    }
  }
  EOT
}

variable "exclusive_ip_package" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "ExclusiveIpPackage",
      "zh-cn": "域名独享资源包数量"
    }
  }
  EOT
}

variable "log_storage" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "LogStorage",
      "zh-cn": "日志存储容量"
    }
  }
  EOT
}

variable "subscription_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Subscription type of the instance"
    },
    "Label": {
      "en": "SubscriptionType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "ext_bandwidth" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "ExtBandwidth",
      "zh-cn": "带宽扩展包"
    }
  }
  EOT
}

variable "waf_log" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "WafLog",
      "zh-cn": "是否启用日志服务"
    }
  }
  EOT
}

variable "package_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Label": {
      "en": "PackageCode",
      "zh-cn": "套餐"
    }
  }
  EOT
}

resource "alicloud_waf_instance" "wafinstance" {
  big_screen           = var.big_screen
  prefessional_service = var.prefessional_service
  ext_domain_package   = var.ext_domain_package
  log_time             = var.log_time
  renewal_status       = var.renewal_status
  renew_period         = var.renew_period
  period               = var.period
  exclusive_ip_package = var.exclusive_ip_package
  log_storage          = var.log_storage
  subscription_type    = var.subscription_type
  ext_bandwidth        = var.ext_bandwidth
  waf_log              = var.waf_log
  package_code         = var.package_code
}

output "subscription_type" {
  value       = alicloud_waf_instance.wafinstance.subscription_type
  description = "Subscription type of the instance"
}

output "trial" {
  // Could not transform ROS Attribute Trial to Terraform attribute.
  value       = null
  description = "Trial version"
}

output "instance_id" {
  value       = alicloud_waf_instance.wafinstance.id
  description = "Instance ID"
}

output "in_debt" {
  // Could not transform ROS Attribute InDebt to Terraform attribute.
  value       = null
  description = "Instance is overdue"
}

output "remain_day" {
  // Could not transform ROS Attribute RemainDay to Terraform attribute.
  value       = null
  description = "Number of available days for WAF Trial version"
}

output "end_date" {
  // Could not transform ROS Attribute EndDate to Terraform attribute.
  value       = null
  description = "Due date of the instance"
}

