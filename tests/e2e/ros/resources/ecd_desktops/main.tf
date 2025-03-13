variable "user_assign_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The assignment mode of the cloud desktop. Default value: ALL.\nALL: If you specify the EndUserId parameter, the cloud desktops that you create are\nassigned to each regular user that you specify.\nPER_USER: If you specify the EndUserId parameter, the cloud desktops that you create\nare evenly assigned to all regular users that you specify. In this case, you must\nmake sure that the value of the Amount parameter can be divided by the N value of\nthe EndUserId.N parameter that you specify.\nNote If you do not specify the EndUserId parameter, the cloud desktop that you create is\nnot assigned to regular users."
    },
    "AllowedValues": [
      "ALL",
      "PER_USER"
    ],
    "Label": {
      "en": "UserAssignMode",
      "zh-cn": "云桌面分配模式"
    }
  }
  EOT
}

variable "user_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "This parameter is not open for use."
    },
    "Label": {
      "en": "UserName",
      "zh-cn": "此参数暂不开放使用"
    }
  }
  EOT
}

variable "promotion_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "promotion id."
    },
    "Label": {
      "en": "PromotionId",
      "zh-cn": "优惠活动ID"
    }
  }
  EOT
}

variable "policy_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the policy."
    },
    "Label": {
      "en": "PolicyGroupId",
      "zh-cn": "策略ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto-renewal for the cloud desktop. This parameter takes\neffect only when the ChargeType parameter is set to PrePaid.\nValid values:\ntrue: enables auto-renewal. The renewal duration is the same as the subscription duration\nthat you specified for the Period parameter when you purchased the cloud desktop.\nfalse: does not enable auto-renewal.\nDefault value: false."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
    }
  }
  EOT
}

variable "desktop_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the cloud desktop."
    },
    "Label": {
      "en": "DesktopName",
      "zh-cn": "云桌面名称"
    }
  }
  EOT
}

variable "amount" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of cloud desktops that you want to create. Valid values: 1 to 300. Default\nvalue: 1."
    },
    "MinValue": 1,
    "Label": {
      "en": "Amount",
      "zh-cn": "创建的云桌面数量"
    },
    "MaxValue": 300
  }
  EOT
}

variable "hostname" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The custom hostname that you specify for the cloud desktop. You can only specify the\nhostname of a Windows cloud desktop in the workspace of the enterprise AD account\ntype.\nThe hostname must meet the following requirements:\nThe hostname must be 2 to 15 characters in length.\nThe hostname can contain letters, digits, and hyphens (-). It cannot start or end\nwith a hyphen (-), contain consecutive hyphens (-), or contain only digits.\nIf you create multiple cloud desktops, you can specify the names of the cloud desktops\nin the name_prefix[begin_number,bits]name_suffix format. For example, if you set Hostname to ecd--1,4-test, the hostname of the first cloud desktop is ecd-0001-test and the hostname of\nthe second cloud desktop is ecd-0002-test. The rest may be deduced by analogy.\nname_prefix: the prefix of the hostname.\n[begin_number,bits]: the ordered numbers in the hostname. begin_number: the start number. Valid values:\n0 to 999999. Default value: 0. bits: the digit. Valid values: 1 to 6. Default value:\n6.\nname_suffix: the suffix of the hostname."
    },
    "Label": {
      "en": "Hostname",
      "zh-cn": "自定义设置云桌面的主机名称"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription duration. The unit of the value is specified by the PeriodUnit parameter. This parameter takes effect and is required only when the ChargeType parameter is set to PrePaid.\nIf PeriodUnit is month, the valid range is 1, 2, 3, 6, 12, 24, 36, 48,60\nIf periodUnit is year, the valid range is 1 to 5"
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "volume_encryption_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable disk encryption."
    },
    "Label": {
      "en": "VolumeEncryptionEnabled",
      "zh-cn": "是否开启磁盘加密"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable automatic payment. Valid values:\ntrue: enables automatic payment. You must make sure that your Alibaba Cloud account\nhas sufficient balance. If your Alibaba Cloud account does not have sufficient balance,\nabnormal orders are generated.\nfalse: disables automatic payment. In this case, an order is generated, and no payment\nis automatically made. You can log on to the EDS console and complete the payment\nbased on the order ID on the Orders page.\nDefault value: true."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "desktop group ID。\nNote that the desktop group function is currently in the invitation test.\nIf you want to experience it, please submit a work order application."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "桌面组ID"
    }
  }
  EOT
}

variable "office_site_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the workspace."
    },
    "Label": {
      "en": "OfficeSiteId",
      "zh-cn": "工作区ID"
    }
  }
  EOT
}

variable "desktop_name_suffix" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically add a suffix to the cloud desktop name when you\ncreate multiple cloud desktops at a time.\nTrue: automatically adds a suffix.\nFalse: does not add a suffix."
    },
    "Label": {
      "en": "DesktopNameSuffix",
      "zh-cn": "桌面名称是否自动增加后缀"
    }
  }
  EOT
}

variable "bundle_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cloud desktop template."
    },
    "Label": {
      "en": "BundleId",
      "zh-cn": "桌面模板ID"
    }
  }
  EOT
}

variable "directory_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "This parameter is not open for use."
    },
    "Label": {
      "en": "DirectoryId",
      "zh-cn": "此参数暂不开放使用"
    }
  }
  EOT
}

variable "end_user_id" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The user ID that authorizes the use of the cloud desktop, 1~100 can be set.\nDuring the same period, only one user can use the desktop.\nIf EndUserId is not set, the created cloud desktop will not be assigned to any user."
    },
    "Label": {
      "en": "EndUserId",
      "zh-cn": "授权使用云桌面的用户ID"
    },
    "MaxLength": 100
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "This parameter is not open for use."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "此参数暂不开放使用"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method of the cloud desktop. Valid values:\nPostPaid: pay-as-you-go\nPrePaid: subscription\nDefault value: PostPaid."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "云桌面的计费方式"
    }
  }
  EOT
}

variable "volume_encryption_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The key ID of the KMS used when disk encryption is enabled. It can be obtained through the ListKeys interface."
    },
    "Label": {
      "en": "VolumeEncryptionKey",
      "zh-cn": "开启磁盘加密的情况下使用的KMS的密钥ID"
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
          "Description": {
            "en": "The value of the tag."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The keyword of the tag."
          },
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
      "en": "The list of desktops tags in the form of key/value pairs.\nYou can define a maximum of 20 tags for each desktops."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
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
      "month",
      "year",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "包年包月计费方式的时长单位"
    }
  }
  EOT
}

resource "alicloud_ecd_desktop" "desktops" {
  user_assign_mode = var.user_assign_mode
  policy_group_id  = var.policy_group_id
  auto_renew       = var.auto_renew
  desktop_name     = var.desktop_name
  amount           = var.amount
  period           = var.period
  auto_pay         = var.auto_pay
  office_site_id   = var.office_site_id
  bundle_id        = var.bundle_id
  payment_type     = var.charge_type
  tags             = var.tags
  period_unit      = var.period_unit
}

output "desktop_id" {
  value       = alicloud_ecd_desktop.desktops.id
  description = <<EOT
  "The ID of the cloud desktop. If multiple cloud desktops are created in a call, the\nIDs of the cloud desktops are returned."
  EOT
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = <<EOT
  "The ID of the order.\nNote This parameter is returned only when the ChargeType parameter is set to PrePaid."
  EOT
}

