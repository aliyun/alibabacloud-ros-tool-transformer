variable "auto_renew_period" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${PaymentType}",
                "Subscription"
              ]
            },
            {
              "Fn::Equals": [
                "$${AutoRenew}",
                true
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Automatic renewal period. This parameter is valid only when automatic renewal is enabled. Unit: Month."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12
    ],
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "自动续费周期"
    }
  }
  EOT
}

variable "product_info" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SendReceiveRatio": {
          "Type": "Number",
          "Description": {
            "en": "The ratio of messages sent and received."
          },
          "Required": false,
          "MinValue": 0.2,
          "MaxValue": 0.5
        },
        "MessageRetentionTime": {
          "Type": "Number",
          "Description": {
            "en": "The message storage time. Unit: Hour."
          },
          "Required": false
        },
        "AutoScaling": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable out-of-spec burst resiliency.\nAfter the elastic burst capability is enabled, the message queue RocketMQ allows the instance to exceed the TPS limited by the basic specification within a certain range, and the part exceeding the basic specification requires additional elastic specification fees."
          },
          "Required": false
        },
        "MsgProcessSpec": {
          "Type": "String",
          "Description": {
            "en": "Message processing specification."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Instance specification information."
    },
    "Label": {
      "en": "ProductInfo",
      "zh-cn": "实例规格信息"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group ID."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PaymentType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether to auto-renew. This parameter takes effect only when the PaymentType=Subscription."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
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
      "en": "The subscription duration. Valid values:\nWhen Period is Month, it could be from 1 to 6, 12, 24, 36.\n When Period is Year, it could be from 1 to 3."
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
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "internet_info" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "FlowOutType": {
          "Type": "String",
          "Description": {
            "en": "The billing method of Internet usage. Valid values: payByBandwidth: pay-by-bandwidth. If Internet access is enabled for an instance, specify this value for the parameter. payByTraffic: pay-by-traffic. If Internet access is enabled for an instance, specify this value for the parameter. uninvolved: No billing method is involved. If Internet access is disabled for an instance, specify this value for the parameter."
          },
          "Required": false
        },
        "IpWhitelist": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Public network access whitelist address segment."
          },
          "Required": false
        },
        "InternetSpec": {
          "Type": "String",
          "Description": {
            "en": "Whether to enable public network access."
          },
          "AllowedValues": [
            "enable",
            "disable"
          ],
          "Required": true
        },
        "FlowOutBandwidth": {
          "Type": "Number",
          "Description": {
            "en": "Public network bandwidth specification. Unit: Mb/s.\nIt needs to be filled in only when the billing type of the public network is billed by fixed bandwidth."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 1000
        }
      }
    },
    "Description": {
      "en": "Public network configuration information."
    },
    "Label": {
      "en": "InternetInfo",
      "zh-cn": "公网配置信息"
    }
  }
  EOT
}

variable "sub_series_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SubSeriesCode"
    },
    "Description": {
      "en": "The sub series code of the instance."
    },
    "AllowedValues": [
      "single_node",
      "cluster_ha",
      "serverless"
    ],
    "Label": {
      "en": "SubSeriesCode",
      "zh-cn": "实例的子系列编码"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remark of instance."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "实例的备注信息"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the instance to be created."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "待创建的实例名称"
    },
    "MinLength": 3,
    "MaxLength": 64
  }
  EOT
}

variable "series_code" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SeriesCode"
    },
    "Description": {
      "en": "The primary series code of the instance."
    },
    "AllowedValues": [
      "standard",
      "professional",
      "ultimate"
    ],
    "Label": {
      "en": "SeriesCode",
      "zh-cn": "实例的主系列编码"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Subscription": {
          "Month": [
            1,
            2,
            3,
            4,
            5,
            6
          ],
          "Year": [
            1,
            2,
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The sub series code of the instance."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PaymentType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "vpc_info" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "ID of the VPC associated with the instance to be created."
          },
          "Required": true
        },
        "VSwitchIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcInfo.VpcId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Required": false,
              "Label": {
                "zh-cn": "虚拟交换机列表"
              }
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "IDs of the vSwitchs associated with the instance to be created.\n**Note**: Only one is required for VSwitchIds and VSwitchId. When both are filled in, VSwitchIds overwrites VSwitchId."
          },
          "Required": false,
          "MaxLength": 10
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcInfo.VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "ID of the security group associated with the instance to be created. Required when creating serverless."
          },
          "Required": false,
          "Label": {
            "zh-cn": "安全组ID"
          }
        }
      }
    },
    "Description": {
      "en": "Private network configuration information."
    },
    "Label": {
      "en": "VpcInfo",
      "zh-cn": "专有网络配置信息"
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
      "en": "The period unit for the duration of the instance."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "购买时长的最小周期单位"
    }
  }
  EOT
}

resource "alicloud_rocketmq_instance" "instance" {
  auto_renew_period = var.auto_renew_period
  resource_group_id = var.resource_group_id
  auto_renew        = var.auto_renew
  period            = var.period
  sub_series_code   = var.sub_series_code
  remark            = var.remark
  instance_name     = var.instance_name
  series_code       = var.series_code
  payment_type      = var.payment_type
  period_unit       = var.period_unit
}

output "instance_name" {
  value       = alicloud_rocketmq_instance.instance.instance_name
  description = "Instance name."
}

output "user_name" {
  // Could not transform ROS Attribute UserName to Terraform attribute.
  value       = null
  description = "The user name of instance."
}

output "vpc_endpoint" {
  // Could not transform ROS Attribute VpcEndpoint to Terraform attribute.
  value       = null
  description = "VPC endpoint."
}

output "instance_id" {
  value       = alicloud_rocketmq_instance.instance.id
  description = "Instance ID created."
}

output "internet_endpoint" {
  // Could not transform ROS Attribute InternetEndpoint to Terraform attribute.
  value       = null
  description = "Internet endpoint."
}

output "password" {
  // Could not transform ROS Attribute Password to Terraform attribute.
  value       = null
  description = "The password of instance."
}

