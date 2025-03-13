variable "comment" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the entry."
    },
    "Label": {
      "en": "Comment",
      "zh-cn": "说明"
    }
  }
  EOT
}

variable "entry" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IP address range that is allowed to access the instance.",
      "zh-cn": "允许访问的IP网段，例如192.168.1.1/32。"
    },
    "Label": {
      "en": "Entry",
      "zh-cn": "允许访问的IP网段"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "module_name" {
  type        = string
  default     = "Registry"
  description = <<EOT
  {
    "Description": {
      "en": "The name of the module in the instance for which a whitelist is configured. Valid\nvalues: Registry and Chart."
    },
    "Label": {
      "en": "ModuleName",
      "zh-cn": "需要设置访问策略的模块"
    }
  }
  EOT
}

variable "endpoint_type" {
  type        = string
  default     = "internet"
  description = <<EOT
  {
    "Description": {
      "en": "The type of the endpoint."
    },
    "Label": {
      "en": "EndpointType",
      "zh-cn": "访问入口类型"
    }
  }
  EOT
}

variable "region_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Region ID of instance. Default is current region."
    },
    "Label": {
      "en": "RegionId",
      "zh-cn": "地域ID"
    }
  }
  EOT
}

resource "alicloud_cr_endpoint_acl_policy" "instance_endpoint_acl_policy" {
  description   = var.comment
  entry         = var.entry
  instance_id   = var.instance_id
  module_name   = var.module_name
  endpoint_type = var.endpoint_type
}

output "entry" {
  value       = alicloud_cr_endpoint_acl_policy.instance_endpoint_acl_policy.entry
  description = "The IP address range that is allowed to access the instance."
}

output "instance_id" {
  value       = alicloud_cr_endpoint_acl_policy.instance_endpoint_acl_policy.instance_id
  description = "The ID of the instance."
}

