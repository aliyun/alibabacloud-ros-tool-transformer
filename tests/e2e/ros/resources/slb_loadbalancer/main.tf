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
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  default     = "PayBySpec"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SLBInstanceChargeType"
    },
    "Description": {
      "en": "Instance billing method. Valid value:\n- **PayBySpec** (default): Pay by spec.\n- **PayByCLCU**: billed by usage."
    },
    "AllowedValues": [
      "PayBySpec",
      "PayByCLCU"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例计费方式"
    }
  }
  EOT
}

variable "addressipversion" {
  type        = string
  default     = "ipv4"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${AddressType}",
              "intranet"
            ]
          },
          "Value": [
            "ipv4"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${AddressType}",
              "internet"
            ]
          },
          "Value": [
            "ipv4",
            "ipv6"
          ]
        }
      ]
    },
    "Description": {
      "en": "IP version, support 'ipv4' or 'ipv6'. If 'ipv6' is selected, please note that the zone and the specification are supported."
    },
    "AllowedValues": [
      "ipv4",
      "ipv6"
    ],
    "Label": {
      "en": "AddressIPVersion",
      "zh-cn": "IP版本"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${MasterZoneId}",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AddressType}",
            "intranet"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The VSwitch id to create load balancer instance. For VPC network only."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable deletion protection."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否开启删除保护"
    }
  }
  EOT
}

variable "slave_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "MasterZoneId": "$${MasterZoneId}",
      "ZoneType": "Slave"
    },
    "AssociationProperty": "ALIYUN::SLB::LoadBalancer::ZoneId",
    "Description": {
      "en": "The slave zone id to create load balancer instance."
    },
    "Label": {
      "zh-cn": "实例的备可用区ID"
    }
  }
  EOT
}

variable "modification_protection_status" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "NonProtection or empty: means no restriction on modification protection\nConsoleProtection: Modify instance protection status by console\nDefault value is empty."
    },
    "AllowedValues": [
      "NonProtection",
      "ConsoleProtection"
    ],
    "Label": {
      "en": "ModificationProtectionStatus",
      "zh-cn": "修改保护状态"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${InstanceChargeType}",
              "PayByCLCU"
            ]
          },
          "Value": [
            "paybytraffic"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${InstanceChargeType}",
              "PayBySpec"
            ]
          },
          "Value": [
            "paybytraffic",
            "paybybandwidth"
          ]
        }
      ],
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "The metering method of the Internet-facing CLB instance. Valid values:\n- **paybytraffic** (default): If you set the value to paybytraffic, you do not need to specify Bandwidth. Even if you specify Bandwidth, the value does not take effect.\n- **paybybandwidth**: pay-by-bandwidth.\n**Note** If you set PayType to PayOnDemand and set InstanceChargeType to PayByCLCU, you must set InternetChargeType to paybytraffic."
    },
    "AllowedValues": [
      "paybytraffic",
      "paybybandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "公网类型实例付费方式"
    }
  }
  EOT
}

variable "load_balancer_spec" {
  type        = string
  default     = "slb.s1.small"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${MasterZoneId}",
      "InstanceChargeType": "$${InstanceChargeType}",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "PayBySpec"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::SLB::Instance::InstanceType",
    "Description": {
      "en": "The specification of the CLB instance. Valid values:\n- **slb.s1.small**\n- **slb.s2.small**\n- **slb.s2.medium**\n- **slb.s3.small**\n- **slb.s3.medium**\n- **slb.s3.large**\n**Note** If you do not specify this parameter, a shared-resource CLB instance is created. Shared-resource CLB instances are no longer available for purchase. Therefore, you must specify this parameter.\nIf InstanceChargeType is set to PayByCLCU, this parameter is invalid and you do not need to specify this parameter."
    },
    "Label": {
      "en": "LoadBalancerSpec",
      "zh-cn": "负载均衡实例的规格"
    }
  }
  EOT
}

variable "load_balancer_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of created load balancer. Length is limited to 1-80 characters, allowed to contain letters, numbers, '-, /, _,.' When not specified, a default name will be assigned."
    },
    "Label": {
      "en": "LoadBalancerName",
      "zh-cn": "负载均衡实例的名称"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AddressType}",
            "intranet"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC id to create load balancer instance. For VPC network only."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InternetChargeType}",
            "paybybandwidth"
          ]
        }
      }
    },
    "Description": {
      "en": "The bandwidth for network, unit in Mbps(Mega bit per second). Default is 1. If InternetChargeType is specified as \"paybytraffic\", this property will be ignore and please specify the \"Bandwidth\" in ALIYUN::SLB::Listener."
    },
    "MinValue": 1,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "按固定带宽计费方式的公网类型实例的带宽峰值"
    }
  }
  EOT
}

variable "modification_protection_reason" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Set the reason for modifying the protection status. The length is 1-80 English or Chinese characters, must start with upper and lower letters or Chinese, and can include numbers, periods (.), underscores (_) and dashes (-).\nOnly valid when ModificationProtectionStatus is ConsoleProtection."
    },
    "Label": {
      "en": "ModificationProtectionReason",
      "zh-cn": "修改保护状态的原因"
    },
    "MaxLength": 80
  }
  EOT
}

variable "address_type" {
  type        = string
  default     = "internet"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetType"
    },
    "Description": {
      "en": "The network type of the CLB instance. Valid values:\n- **internet** (default): After an internet-facing CLB instance is created, the system assigns a public IP address to the CLB instance. Then, the CLB instance can forward requests over the Internet.\n- **intranet**: After an internal-facing CLB instance is created, the system assigns a private IP address to the CLB instance. Then, the CLB instance can forward requests only over the internal networks."
    },
    "AllowedValues": [
      "internet",
      "intranet"
    ],
    "Label": {
      "en": "AddressType",
      "zh-cn": "负载均衡实例的地址类型"
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
      "en": "Tags to attach to slb. Max support 5 tags to add during create slb. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "负载均衡实例的标签"
    },
    "MaxLength": 5
  }
  EOT
}

variable "master_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::SLB::LoadBalancer::ZoneId",
    "Description": {
      "en": "The master zone id to create load balancer instance."
    },
    "Label": {
      "en": "MasterZoneId",
      "zh-cn": "实例的主可用区ID"
    }
  }
  EOT
}

resource "alicloud_slb_load_balancer" "load_balance" {
  resource_group_id              = var.resource_group_id
  instance_charge_type           = var.instance_charge_type
  vswitch_id                     = var.vswitch_id
  slave_zone_id                  = var.slave_zone_id
  modification_protection_status = var.modification_protection_status
  internet_charge_type           = var.internet_charge_type
  load_balancer_spec             = var.load_balancer_spec
  load_balancer_name             = var.load_balancer_name
  bandwidth                      = var.bandwidth
  modification_protection_reason = var.modification_protection_reason
  address_type                   = var.address_type
  tags                           = var.tags
  master_zone_id                 = var.master_zone_id
}

output "resource_group_id" {
  value       = alicloud_slb_load_balancer.load_balance.resource_group_id
  description = "Resource group id."
}

output "addressipversion" {
  // Could not transform ROS Attribute AddressIPVersion to Terraform attribute.
  value       = null
  description = "IP version"
}

output "vswitch_id" {
  value       = alicloud_slb_load_balancer.load_balance.vswitch_id
  description = "VSwitch id"
}

output "load_balancer_id" {
  value       = alicloud_slb_load_balancer.load_balance.id
  description = "The id of load balance created."
}

output "pay_type" {
  // Could not transform ROS Attribute PayType to Terraform attribute.
  value       = null
  description = "The billing method of the instance to be created."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order ID."
}

output "slave_zone_id" {
  value       = alicloud_slb_load_balancer.load_balance.slave_zone_id
  description = "The slave zone id to create load balancer instance."
}

output "load_balancer_spec" {
  value       = alicloud_slb_load_balancer.load_balance.load_balancer_spec
  description = "The specification of the Server Load Balancer instance"
}

output "load_balancer_name" {
  value       = alicloud_slb_load_balancer.load_balance.load_balancer_name
  description = "Name of created load balancer."
}

output "vpc_id" {
  // Could not transform ROS Attribute VpcId to Terraform attribute.
  value       = null
  description = "Vpc id"
}

output "network_type" {
  // Could not transform ROS Attribute NetworkType to Terraform attribute.
  value       = null
  description = "The network type of the load balancer. \"vpc\" or \"classic\" network."
}

output "bandwidth" {
  value       = alicloud_slb_load_balancer.load_balance.bandwidth
  description = "The bandwidth for network"
}

output "ip_address" {
  // Could not transform ROS Attribute IpAddress to Terraform attribute.
  value       = null
  description = "The ip address of the load balancer."
}

output "address_type" {
  value       = alicloud_slb_load_balancer.load_balance.address_type
  description = "The address type of the load balancer. \"intranet\" or \"internet\"."
}

output "master_zone_id" {
  value       = alicloud_slb_load_balancer.load_balance.master_zone_id
  description = "The master zone id to create load balancer instance."
}

