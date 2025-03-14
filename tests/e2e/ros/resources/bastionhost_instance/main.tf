variable "extra_bandwidth" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Additional bandwidth is added to the default settings to ensure efficient O&M.Unit: Mbps"
    },
    "MinValue": 0,
    "Label": {
      "en": "ExtraBandwidth",
      "zh-cn": "带宽扩展包"
    },
    "MaxValue": 200
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
      "zh-cn": "堡垒机所在资源组"
    }
  }
  EOT
}

variable "version_037f81c2" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Enterprise",
      "Basic"
    ],
    "Description": {
      "en": "Enterprise version:- Deployment instructions: dual-engine architecture, supports multiple availability zones, and ensures high stability\n- Operation and maintenance scenarios: unified operation and maintenance of assets on Alibaba Cloud, offline IDC servers, and third-party clouds\n- Asset type: Linux/Windows, database assets\n- User management: RAM, AD/LDAP and local users\n- Control strategy: fine-grained strategic control such as operation and maintenance approval, high-risk command blocking, etc.\n- Operation and maintenance audit: full traceability of operation and maintenance log audit and video audit\nValue-added capabilities: automatic password change of Linux assets, database operation and maintenance management and control, convenient operation and maintenance of Web and client, network domain agent hybrid cloud scenario operation and maintenance mode, etc.Basic version:- Deployment instructions: The basic version is deployed on a single machine and does not support multiple availability zones.\n- Operation and maintenance scenarios: unified operation and maintenance of assets on Alibaba Cloud, offline IDC servers, and third-party clouds\n- Asset type: Linux/Windows assets\n- User management: RAM, AD/LDAP and local users\n- Control strategy: Operation and maintenance approval, high-risk command blocking and other strategic management and control\n- Operation and maintenance audit: full traceability of operation and maintenance log audit and video audit"
    },
    "Label": {
      "en": "Version",
      "zh-cn": "垒机实例的版本"
    }
  }
  EOT
}

variable "extended_storage_plans" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "If the default storage capacity is insufficient, you can purchase extended storage plans.Unit: TB"
    },
    "MinValue": 0,
    "Label": {
      "en": "ExtendedStoragePlans",
      "zh-cn": "选择需购买的存储扩展包"
    },
    "MaxValue": 500
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to auto renew the prepay instance. The auto-renewal period is Monthly.After you enable auto-renewal, the system deducts the renewal fee nine days before the resource expires.If the payment fails, the system does not stop deducting the fee until the deduction is successful or one day before the resource expires."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "到期是否自动续费"
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
      "en": "The subscription period of the bastionhost instanceIf PeriodUnit is month, the valid range is 1, 3, 6\nIf periodUnit is year, the valid range is 1, 2, 3"
    },
    "AllowedValues": [
      1,
      2,
      3,
      6
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "实例的订阅周期"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to auto pay the bill."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动付款"
    }
  }
  EOT
}

variable "plan" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      50,
      100,
      200,
      500,
      1000,
      2000,
      5000,
      10000
    ],
    "Description": {
      "en": "The number of asset authorization and concurrency limit.Unit: Asset number"
    },
    "Label": {
      "en": "Plan",
      "zh-cn": "资产数"
    }
  }
  EOT
}

variable "start_instance_param" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VswitchId": {
          "Type": "String",
          "Description": {
            "en": "The VSwitch ID bound to the bastion host instance."
          },
          "Required": true
        },
        "SecurityGroupIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}"
              },
              "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
              "Type": "String",
              "Description": {
                "en": "Security group id."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "List of security group IDs bound to the bastion host instance"
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 20
        }
      }
    },
    "Description": {
      "en": "Parameters required to start a bastion host instance."
    },
    "Label": {
      "en": "StartInstanceParam",
      "zh-cn": "启动主机实例所需的参数"
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
      "zh-cn": "订阅持续时间的单位"
    }
  }
  EOT
}

resource "alicloud_bastionhost_instance" "instance" {
  resource_group_id = var.resource_group_id
  period            = var.period
}

output "instance_id" {
  value       = alicloud_bastionhost_instance.instance.id
  description = "Instance Id."
}

