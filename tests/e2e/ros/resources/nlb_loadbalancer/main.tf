variable "address_ip_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of IP address that the NLB instance uses to provide services."
    },
    "AllowedValues": [
      "Ipv4",
      "DualStack"
    ],
    "Label": {
      "en": "AddressIpVersion",
      "zh-cn": "负载均衡实例的IP版本"
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
            "en": "The billing method of the NLB instance."
          },
          "AllowedValues": [
            "PayAsYouGo"
          ],
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of the billing method."
    },
    "Label": {
      "en": "LoadBalancerBillingConfig",
      "zh-cn": "负载均衡实例的计费配置"
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
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "ZoneId": {
              "AssociationProperty": "ZoneId",
              "Type": "String",
              "Description": {
                "en": "The ID of the zone to which the NLB instance belongs."
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
              "AssociationProperty": "ALIYUN::VPC::Eip::AllocationId",
              "Type": "String",
              "Description": {
                "en": "The ID of the elastic IP address (EIP) that is associated with the Internet-facing NLB instance. "
              },
              "Required": false
            },
            "EipType": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ZoneMappings_EipType"
              },
              "Type": "String",
              "Description": {
                "en": "The type of the EIP. Valid values:\n- **Common**\n- **Anycast**\n**Note**: Only NLB instances in Hong Kong, China, support binding Anycast EIP."
              },
              "AllowedValues": [
                "Common",
                "Anycast"
              ],
              "Required": false
            },
            "LoadBalancerAddresses": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "AllocationId": {
                    "AssociationProperty": "ALIYUN::VPC::Eip::AllocationId",
                    "Type": "String",
                    "Description": {
                      "en": "The ID of the elastic IP address (EIP) that is associated with the Internet-facing NLB instance. "
                    },
                    "Required": true
                  },
                  "PrivateIPv4Address": {
                    "Type": "String",
                    "Description": {
                      "en": "The private IP address."
                    },
                    "Required": false,
                    "Label": {
                      "zh-cn": "IPv4地址。"
                    }
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Load balancer addresses. This property has higher priority than AllocationId and EipType in ZoneMappings."
              },
              "Required": false,
              "MaxLength": 1
            },
            "PrivateIPv4Address": {
              "Type": "String",
              "Description": {
                "en": "The private IP address."
              },
              "Required": false,
              "Label": {
                "zh-cn": "IPv4地址。"
              }
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
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
            "LocaleKey": "ModificationProtectionConfig_Status"
          },
          "Type": "String",
          "Description": {
            "en": "Specifies whether to enable the configuration read-only mode. Valid values:\nNonProtection: does not enable the configuration read-only mode. You cannot set the Reason parameter. If the Reason parameter is set, the value is cleared.\nConsoleProtection: enables the configuration read-only mode. You can set the Reason parameter."
          },
          "AllowedValues": [
            "NonProtection",
            "ConsoleProtection"
          ],
          "Required": true
        },
        "Reason": {
          "Type": "String",
          "Description": {
            "en": "The reason why the configuration read-only mode is enabled. The value must be 2 to 128 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). The value must start with a letter."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of the configuration read-only mode."
    },
    "Label": {
      "en": "ModificationProtectionConfig",
      "zh-cn": "修改保护配置"
    }
  }
  EOT
}

variable "cross_zone_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether enable cross zone. Default: true"
    },
    "Label": {
      "en": "CrossZoneEnabled",
      "zh-cn": "是否启用跨区域负载均衡"
    }
  }
  EOT
}

variable "load_balancer_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the NLB instance."
    },
    "AllowedValues": [
      "network"
    ],
    "Label": {
      "en": "LoadBalancerType",
      "zh-cn": "负载均衡实例类型"
    }
  }
  EOT
}

variable "load_balancer_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the NLB instance.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods(.), underscores (_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "LoadBalancerName",
      "zh-cn": "负载均衡实例的名称"
    }
  }
  EOT
}

variable "deletion_protection_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Enabled": {
          "Type": "String",
          "Description": {
            "en": "Specifies whether to enable deletion protection. Valid values:\ntrue: yes\nfalse (default): no"
          },
          "AllowedValues": [
            "true",
            "false"
          ],
          "Required": true,
          "Default": "false"
        },
        "Reason": {
          "Type": "String",
          "Description": {
            "en": "The reason why the deletion protection feature is enabled or disabled. The value must be 2 to 128 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-). The value must start with a letter."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of the deletion protection feature."
    },
    "Label": {
      "en": "DeletionProtectionConfig",
      "zh-cn": "删除保护配置"
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
      "en": "The ID of the virtual private cloud (VPC) where the NLB instance is deployed."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "负载均衡实例的所属VPC ID"
    }
  }
  EOT
}

variable "traffic_affinity_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether enable traffic affinity. Default: false"
    },
    "Label": {
      "en": "TrafficAffinityEnabled",
      "zh-cn": "是否启用流量相关性"
    }
  }
  EOT
}

variable "bandwidth_package_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Attach common bandwidth package to load balancer."
    },
    "Label": {
      "en": "BandwidthPackageId",
      "zh-cn": "公网类型实例关联的共享带宽包ID"
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
      "en": "The type of IP address that the NLB instance uses to provide services. Valid values:\nInternet: The NLB instance uses a public IP address. The domain name of the NLB instance is resolved to the public IP address. Therefore, the NLB instance can be accessed over the Internet.\nIntranet: The NLB instance uses a private IP address. The domain name of the NLB instance is resolved to the private IP address. Therefore, the NLB instance can be accessed over the VPC where the NLB instance is deployed."
    },
    "AllowedValues": [
      "Intranet",
      "Internet"
    ],
    "Label": {
      "en": "AddressType",
      "zh-cn": "负载均衡IPv4的网络地址类型"
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
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_nlb_load_balancer" "load_balancer" {
  address_ip_version   = var.address_ip_version
  resource_group_id    = var.resource_group_id
  zone_mappings        = var.zone_mappings
  cross_zone_enabled   = var.cross_zone_enabled
  load_balancer_type   = var.load_balancer_type
  load_balancer_name   = var.load_balancer_name
  vpc_id               = var.vpc_id
  bandwidth_package_id = var.bandwidth_package_id
  address_type         = var.address_type
  tags                 = var.tags
}

output "address_ip_version" {
  value       = alicloud_nlb_load_balancer.load_balancer.address_ip_version
  description = "The version of IP address that the NLB instance uses to provide services."
}

output "vpc_id" {
  value       = alicloud_nlb_load_balancer.load_balancer.vpc_id
  description = "The ID of the virtual private cloud (VPC) where the NLB instance is deployed."
}

output "load_balancer_id" {
  value       = alicloud_nlb_load_balancer.load_balancer.id
  description = "The ID of the NLB instance."
}

output "address_type" {
  value       = alicloud_nlb_load_balancer.load_balancer.address_type
  description = "The type of IP address that the NLB instance uses to provide services."
}

output "dnsname" {
  value       = alicloud_nlb_load_balancer.load_balancer.dns_name
  description = "The domain name of the NLB instance."
}

output "zone_mappings" {
  value       = alicloud_nlb_load_balancer.load_balancer.zone_mappings
  description = "The zones, vSwitches and addresses which are mapped to the zones."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "load_balancer_type" {
  value       = alicloud_nlb_load_balancer.load_balancer.load_balancer_type
  description = "The type of the NLB instance."
}

