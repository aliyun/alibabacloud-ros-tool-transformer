variable "zone_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Zone name"
    },
    "Label": {
      "en": "ZoneName",
      "zh-cn": "可用区名称"
    }
  }
  EOT
}

variable "ignored_stack_tag_keys" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "stack tag key"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Stack tag keys to ignore"
    },
    "Label": {
      "en": "IgnoredStackTagKeys",
      "zh-cn": "忽略资源栈引入的自定义标签"
    },
    "MinLength": 0,
    "MaxLength": 20
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "PrivateZone所属的资源组ID"
    }
  }
  EOT
}

variable "proxy_pattern" {
  type        = string
  default     = "ZONE"
  description = <<EOT
  {
    "Description": {
      "en": "ZONE: completely hijack the entire zone.\nRECORD: Incomplete hijacking, recursive resolution agent.\nDefault to ZONE."
    },
    "AllowedValues": [
      "RECORD",
      "ZONE"
    ],
    "Label": {
      "en": "ProxyPattern",
      "zh-cn": "代理模式"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "dns_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Built-in authority location area. Valid values:\n- NORMAL_ZONE: Default. normal zone (The parsing response result will be cached, and only back to the built-in authority normal zone if the cache is missed, the effect of parsing changes is affected by TTL time; Cannot use custom line analysis, weight analysis function.\n- FAST_ZONE: Fast zone (Recommended: directly reply to the parsing request, the parsing delay is the lowest, and the record changes take effect in real time; Support custom line analysis, weight analysis."
    },
    "AllowedValues": [
      "NORMAL_ZONE",
      "FAST_ZONE"
    ],
    "Label": {
      "en": "DnsGroup",
      "zh-cn": "内置权威位置区"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "50 characters at most. It can only contain numbers, Chinese, English and special characters: \"_-,.，。\"."
    },
    "AllowedPattern": "^[-_,.\\uff0c\\u3002a-zA-Z0-9\\u4e00-\\u9fa5]{0,50}$",
    "Label": {
      "en": "Remark",
      "zh-cn": "备注信息"
    },
    "MaxLength": 50
  }
  EOT
}

resource "alicloud_pvtz_zone" "zone" {
  name              = var.zone_name
  resource_group_id = var.resource_group_id
  proxy_pattern     = var.proxy_pattern
  tags              = var.tags
  remark            = var.remark
}

output "zone_name" {
  value       = alicloud_pvtz_zone.zone.zone_name
  description = "Zone name."
}

output "zone_id" {
  value       = alicloud_pvtz_zone.zone.id
  description = "Zone ID."
}

output "zone_tag" {
  // Could not transform ROS Attribute ZoneTag to Terraform attribute.
  value       = null
  description = "Zone label."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "zone_type" {
  // Could not transform ROS Attribute ZoneType to Terraform attribute.
  value       = null
  description = "Zone type."
}

