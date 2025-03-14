variable "address_ip_version" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "IPv4": {
          "en": "IPv4",
          "zh-cn": "IPv4"
        },
        "DualStack": {
          "en": "DualStack",
          "zh-cn": "双栈类型"
        }
      }
    },
    "Description": {
      "en": "The protocol version. Valid values:\nIPv4: IPv4\nDualStack: dual stack"
    },
    "AllowedValues": [
      "IPv4",
      "DualStack"
    ],
    "Label": {
      "en": "IP Version",
      "zh-cn": "IP版本"
    }
  }
  EOT
}

variable "load_balancer_edition" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Basic": {
          "en": "Basic",
          "zh-cn": "基础版"
        },
        "Standard": {
          "en": "Standard",
          "zh-cn": "标准版"
        },
        "StandardWithWaf": {
          "en": "StandardWithWaf",
          "zh-cn": "WAF增强版"
        }
      }
    },
    "Description": {
      "en": "The edition of the ALB instance. Different editions have different limits and billing methods. Valid values:\nBasic: Basic Edition\nStandard: Standard Edition\nStandardWithWaf: Standard Edition with WAF"
    },
    "AllowedValues": [
      "Basic",
      "Standard",
      "StandardWithWaf"
    ],
    "Label": {
      "en": "Version",
      "zh-cn": "版本"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "load_balancer_billing_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PayType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "InstanceChargeType"
          },
          "Type": "String",
          "Description": {
            "en": "The billing method of the ALB instance. Set the value to PostPay, which indicates the pay-as-you-go billing method."
          },
          "AllowedValues": [
            "PostPay"
          ],
          "Required": true,
          "Label": {
            "en": "Billing Type",
            "zh-cn": "计费方式"
          },
          "Default": "PostPay"
        }
      }
    },
    "Description": {
      "en": "The configuration of the billing method."
    },
    "Label": {
      "en": "LoadBalancerBillingConfig",
      "zh-cn": "计费配置"
    }
  }
  EOT
}

variable "zone_mappings" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "IntranetAddress": {
          "Type": "String",
          "Description": {
            "en": "The private IP address of the ALB instance."
          },
          "Required": false
        },
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "The ID of the zone to which the ALB instance belongs."
          },
          "Required": true
        },
        "VSwitchId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}",
            "ZoneId": "$${.ZoneId}"
          },
          "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
          "Type": "String",
          "Description": {
            "en": "The ID of the vSwitch in the zone. Each zone can contain only one vSwitch and one subnet."
          },
          "Required": true
        },
        "AllocationId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the elastic IP address (EIP) that is associated with the ALB instance."
          },
          "Required": false,
          "Label": {
            "en": "AllocationId",
            "zh-cn": "与ALB实例关联的EIP (elastic IP address) ID"
          }
        }
      },
      "ListMetadata": {
        "Order": [
          "ZoneId",
          "VSwitchId",
          "AllocationId"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The zones and the vSwitches in the zones. You must specify at least two zones."
    },
    "Label": {
      "en": "ZoneMappings",
      "zh-cn": "可用区及交换机映射列表"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "modification_protection_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Status": {
          "AssociationPropertyMetadata": {
            "ValueLabelMapping": {
              "NonProtection": {
                "en": "NonProtection",
                "zh-cn": "未启用修改保护"
              },
              "ConsoleProtection": {
                "en": "ConsoleProtection",
                "zh-cn": "已启用控制台修改保护"
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Specifies whether to enable the configuration read-only mode for the ALB instance. Valid values:\nNonProtection: disables the configuration read-only mode. In this case, you cannot set the Reason parameter. If the Reason parameter is set, the value is cleared.\nConsoleProtection: enables the configuration read-only mode. In this case, you can set the Reason parameter."
          },
          "AllowedValues": [
            "NonProtection",
            "ConsoleProtection"
          ],
          "Required": true,
          "Label": {
            "en": "Modification Protection Status",
            "zh-cn": "修改保护状态"
          }
        },
        "Reason": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Status}",
                  "ConsoleProtection"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The reason for modification protection. The reason must be 2 to 128 characters in\nlength, and can contain letters, digits, periods (.), underscores (_), and hyphens\n(-). The reason must start with a letter.\nThis parameter is valid only if the ModificationProtectionStatus parameter is set to ConsoleProtection."
          },
          "Required": false,
          "Label": {
            "en": "Modification Protection Reason",
            "zh-cn": "修改保护原因"
          }
        }
      }
    },
    "Description": {
      "en": "The configuration of modification protection."
    },
    "Label": {
      "en": "Modification Protection Configuration",
      "zh-cn": "修改保护配置"
    }
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the security group to which the ALB instance join."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "应用型负载均衡实例需要绑定的安全组 ID 集合"
    },
    "MinLength": 0,
    "MaxLength": 9
  }
  EOT
}

variable "load_balancer_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the ALB instance.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods(.), underscores (_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "LoadBalancerName",
      "zh-cn": "ALB实例的名称"
    }
  }
  EOT
}

variable "access_log_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "LogStore": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Enable}",
                  true
                ]
              }
            }
          },
          "Type": "String",
          "Required": true,
          "Label": {
            "en": "Log Store",
            "zh-cn": "日志库"
          },
          "Default": " "
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether enable access log config. If LogProject and LogStore are configured, default True."
          },
          "Required": false,
          "Label": {
            "en": "Enable Access Log Configuration",
            "zh-cn": "是否启用访问日志配置"
          },
          "Default": false
        },
        "LogProject": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Enable}",
                  true
                ]
              }
            }
          },
          "Type": "String",
          "Required": true,
          "Label": {
            "en": "Log Project",
            "zh-cn": "日志项目"
          },
          "Default": " "
        }
      },
      "ListMetadata": {
        "Order": [
          "Enable",
          "LogProject",
          "LogStore"
        ]
      }
    },
    "Label": {
      "en": "AccessLogConfig",
      "zh-cn": "访问日志配置"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The ID of the virtual private cloud (VPC) where the ALB instance is deployed."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "bandwidth_package_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AddressType}",
            "Internet"
          ]
        }
      }
    },
    "Description": {
      "en": "Attach common bandwidth package to load balancer. It only takes effect when AddressType=Internet."
    },
    "Label": {
      "en": "Bandwidth Package ID",
      "zh-cn": "带宽包ID"
    }
  }
  EOT
}

variable "address_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetType"
    },
    "Description": {
      "en": "The type of IP address that the ALB instance uses to provide services. Valid values:\nInternet: The ALB instance uses a public IP address. The domain name of the ALB instance is resolved to the public IP address. Therefore, the ALB instance can be accessed over the Internet.\nIntranet: The ALB instance uses a private IP address. The domain name of the ALB instance is resolved to the private IP address. Therefore, the ALB instance can be accessed over the VPC where the ALB instance is deployed."
    },
    "AllowedValues": [
      "Internet",
      "Intranet"
    ],
    "Label": {
      "en": "Address Type",
      "zh-cn": "地址类型"
    }
  }
  EOT
}

variable "address_allocated_mode" {
  type        = string
  default     = "Dynamic"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Dynamic": {
          "en": "Dynamic",
          "zh-cn": "动态IP模式"
        },
        "Fixed": {
          "en": "Fixed",
          "zh-cn": "固定IP模式"
        }
      }
    },
    "Description": {
      "en": "The mode in which IP addresses are assigned. Valid values:\nFixed: The ALB instance uses a static IP address.\nDynamic: An IP address is dynamically assigned to the ALB instance in each zone. This is the default value."
    },
    "AllowedValues": [
      "Fixed",
      "Dynamic"
    ],
    "Label": {
      "en": "Address Allocation Mode",
      "zh-cn": "地址分配方式"
    }
  }
  EOT
}

variable "deletion_protection_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable deletion protection. Default value: false."
    },
    "Label": {
      "en": "DeletionProtectionEnabled",
      "zh-cn": "是否启用删除保护"
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
      "zh-cn": "ALB实例的标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_alb_load_balancer" "load_balancer" {
  address_ip_version             = var.address_ip_version
  load_balancer_edition          = var.load_balancer_edition
  resource_group_id              = var.resource_group_id
  load_balancer_billing_config   = var.load_balancer_billing_config
  zone_mappings                  = var.zone_mappings
  modification_protection_config = var.modification_protection_config
  load_balancer_name             = var.load_balancer_name
  access_log_config              = var.access_log_config
  vpc_id                         = var.vpc_id
  bandwidth_package_id           = var.bandwidth_package_id
  address_type                   = var.address_type
  address_allocated_mode         = var.address_allocated_mode
  deletion_protection_enabled    = var.deletion_protection_enabled
  tags                           = var.tags
}

output "load_balancer_edition" {
  value       = alicloud_alb_load_balancer.load_balancer.load_balancer_edition
  description = "The edition of the ALB instance."
}

output "vpc_id" {
  value       = alicloud_alb_load_balancer.load_balancer.vpc_id
  description = "The ID of the virtual private cloud (VPC) where the ALB instance is deployed."
}

output "load_balancer_id" {
  value       = alicloud_alb_load_balancer.load_balancer.id
  description = "The ID of the ALB instance."
}

output "address_type" {
  value       = alicloud_alb_load_balancer.load_balancer.address_type
  description = "The type of IP address that the ALB instance uses to provide services."
}

output "dnsname" {
  value       = alicloud_alb_load_balancer.load_balancer.dns_name
  description = "The domain name of the ALB instance."
}

output "zone_mappings" {
  value       = alicloud_alb_load_balancer.load_balancer.zone_mappings
  description = "The zones, vSwitches and addresses which are mapped to the zones."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

