variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cloud phone instance key pair name. \nThe cloud phone key can be imported through the ImportKeyPair interface."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "云手机实例密钥对的名称"
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
      "en": "Description of instance. \nThe length is 2~256 English or Chinese characters and cannot start with http:// and https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "实例的描述"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security group to create ecs instance. For classic instance need the security group not belong to VPC, for VPC instance, please make sure the security group belong to specified VPC."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether renew the fee automatically. \nWhen the parameter InstanceChargeType is PrePaid, it will take effect. \nRange of value:True: automatic renewal. \nFalse: no automatic renewal. Default value is False."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否要自动续费"
    }
  }
  EOT
}

variable "amount" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the number of ECS instances to create.Value range: 1~100\nDefault：1"
    },
    "MinValue": 1,
    "Label": {
      "en": "Amount",
      "zh-cn": "指定创建ECS实例的数量"
    },
    "MaxValue": 100
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "vswitch id"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "虚拟交换机ID"
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
      "en": "Prepaid time period. While PeriodUnit is month, it could be 1, 2, 3, 6.\nWhile PeriodUnit is year, it could be from 1 to 5Default value is 1.\n"
    },
    "Label": {
      "en": "Period",
      "zh-cn": "周期时长"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to pay automatically, the default is true"
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "\"Display name of the instance, [2, 128] English or Chinese characters, must \nstart with a letter or Chinese in size, can contain numbers, \"_\" or \".\", \"-\""
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "eip_bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "EIP bandwidth value, the value range is 1-200. \nSetting this parameter will automatically create an EIP instance \ncorresponding to the bandwidth and bind the EIP instance to the \ncloud phone instance. When the instance is released, this EIP \ninstance will be released and recycled together."
    },
    "Label": {
      "en": "EipBandwidth",
      "zh-cn": "EIP带宽值"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance internet access charge type. "
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "实例的付费方式"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The image id"
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "vnc_password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cloud phone VNC password.\nThe password must be six characters long, and must contain only uppercase, \nlowercase English letters and Arabic numerals."
    },
    "AllowedPattern": "[a-zA-Z0-9]{6}",
    "Label": {
      "en": "VncPassword",
      "zh-cn": "云手机实例管理终端连接密码"
    }
  }
  EOT
}

variable "tag" {
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
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tag",
      "zh-cn": "实例的标签集合"
    },
    "MaxLength": 20
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "instance type"
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of prepaid time period, it could be Month/Year. Default value is Month."
    },
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "包年包月计费方式的时长单位"
    }
  }
  EOT
}

variable "resolution" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "You can use the DescribeInstanceTypes interface to query the list of \nresolutions supported by the current specification and select an appropriate resolution."
    },
    "Label": {
      "en": "Resolution",
      "zh-cn": "云手机实例选用的分辨率"
    }
  }
  EOT
}

resource "alicloud_ecp_instance" "instance_group" {
  key_pair_name     = var.key_pair_name
  description       = var.description
  security_group_id = var.security_group_id
  auto_renew        = var.auto_renew
  vswitch_id        = var.vswitch_id
  period            = var.period
  auto_pay          = var.auto_pay
  instance_name     = var.instance_name
  eip_bandwidth     = var.eip_bandwidth
  payment_type      = var.charge_type
  image_id          = var.image_id
  vnc_password      = var.vnc_password
  instance_type     = var.instance_type
  period_unit       = var.period_unit
  resolution        = var.resolution
}

output "private_ips" {
  // Could not transform ROS Attribute PrivateIps to Terraform attribute.
  value       = null
  description = "Private IP address list of created cloud phone instances. Only for VPC instance."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "oder id"
}

output "instance_ids" {
  // Could not transform ROS Attribute InstanceIds to Terraform attribute.
  value       = null
  description = "instance ids"
}

output "trade_price" {
  // Could not transform ROS Attribute TradePrice to Terraform attribute.
  value       = null
  description = "price"
}

