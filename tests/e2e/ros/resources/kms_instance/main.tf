variable "vpc_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of managed accesses. The maximum number of VPCs that can access this KMS instance. It is required when the InstanceCharge is Subscription."
    },
    "MinValue": 1,
    "Label": {
      "en": "VpcNum",
      "zh-cn": "实例的访问管理总量"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "log" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable log."
    },
    "Label": {
      "en": "Log",
      "zh-cn": "是否启用日志分析"
    }
  }
  EOT
}

variable "key_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum number of stored keys. It is required when the InstanceCharge is Subscription."
    },
    "MinValue": 100,
    "Label": {
      "en": "KeyNum",
      "zh-cn": "实例支持创建的密钥数量"
    },
    "MaxValue": 100000
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "Billing method of the KMS instance, default to Subscription."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "connection" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "Set the private network VPC ID for the KMS instance."
          },
          "Required": true
        },
        "VSwitchIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Set up a switch under dual availability zones, and the switch has at least 1 available IP."
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 1
        },
        "ZoneIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationProperty": "ZoneId",
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Set up two Availability Zones for the KMS instance. Improve service availability and disaster recovery capabilities through dual availability zone load balancing."
          },
          "Required": true,
          "MinLength": 2,
          "MaxLength": 2
        }
      }
    },
    "Label": {
      "en": "Connection",
      "zh-cn": "密钥实例的网络连接配置"
    }
  }
  EOT
}

variable "renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal period, in months."
    },
    "MinValue": 1,
    "Label": {
      "en": "RenewPeriod",
      "zh-cn": "自动续费周期"
    },
    "MaxValue": 36
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription duration of the KMS instance.\nIf PeriodUnit is Month, the valid range is 1, 2, 3, 6, 12, 24, 36\nIf PeriodUnit is Year, the valid range is 1, 2, 3"
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "付费周期"
    }
  }
  EOT
}

variable "secret_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum number of secrets. It is required when the InstanceCharge is Subscription."
    },
    "MinValue": 0,
    "Label": {
      "en": "SecretNum",
      "zh-cn": "实例支持创建的凭据数量"
    },
    "MaxValue": 100000
  }
  EOT
}

variable "product_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "software",
      "software-small",
      "hardware",
      "hardware-small"
    ],
    "Description": {
      "en": "KMS Instance commodity type (software/software-small/hardware/hardware-small)."
    },
    "Label": {
      "en": "ProductVersion",
      "zh-cn": "实例类型"
    }
  }
  EOT
}

variable "log_storage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Log storage."
    },
    "MinValue": 1000,
    "Label": {
      "en": "LogStorage",
      "zh-cn": "绑定的日志库的数量"
    },
    "MaxValue": 500000
  }
  EOT
}

variable "renew_status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Renewal options (manual renewal, automatic renewal, no renewal)."
    },
    "AllowedValues": [
      "AutoRenewal",
      "ManualRenewal"
    ],
    "Label": {
      "en": "RenewStatus",
      "zh-cn": "自动续费状态"
    }
  }
  EOT
}

variable "spec" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The computation performance level of the KMS instance."
    },
    "AllowedValues": [
      200,
      1000,
      2000,
      4000
    ],
    "Label": {
      "en": "Spec",
      "zh-cn": "实例的计算性能"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "付费时长单位"
    }
  }
  EOT
}

resource "alicloud_kms_instance" "instance" {
  vpc_num         = var.vpc_num
  key_num         = var.key_num
  renew_period    = var.renew_period
  period          = var.period
  secret_num      = var.secret_num
  product_version = var.product_version
  log_storage     = var.log_storage
  renew_status    = var.renew_status
  spec            = var.spec
}

output "instance_id" {
  value       = alicloud_kms_instance.instance.id
  description = "The ID of the instance."
}

