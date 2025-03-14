variable "network_interface_traffic_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetworkInterfaceTrafficMode"
    },
    "Description": {
      "en": "The communication mode of the ENI. Valid values:\nStandard: uses the TCP communication mode.\nHighPerformance: enables the Elastic RDMA Interface (ERI) and uses the remote direct memory access (RDMA) communication mode."
    },
    "AllowedValues": [
      "Standard",
      "HighPerformance"
    ],
    "Label": {
      "en": "NetworkInterfaceTrafficMode",
      "zh-cn": "弹性网卡的通讯模式"
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
      "en": "Description of your ENI. It is a string of [2, 256] English or Chinese characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "弹性网卡的描述信息"
    }
  }
  EOT
}

variable "delete_on_release" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to delete the ENI when the instance is released."
    },
    "Label": {
      "en": "DeleteOnRelease",
      "zh-cn": "释放实例时是否保留网卡"
    }
  }
  EOT
}

variable "private_ip_addresses" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Specifies secondary private IP addresses of the ENI. This IP address must be an available IP address in the CIDR block of the VSwitch to which the ENI belongs."
    },
    "Label": {
      "en": "PrivateIpAddresses",
      "zh-cn": "从弹性网卡所属交换机的空闲IP地址中选择一个或多个辅助私有IP地址"
    },
    "MaxLength": 10
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
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "secondary_private_ip_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of private IP addresses that can be created automatically by ECS."
    },
    "MinValue": 1,
    "Label": {
      "en": "SecondaryPrivateIpAddressCount",
      "zh-cn": "辅助私有IP地址数量"
    },
    "MaxValue": 49
  }
  EOT
}

variable "ipv6_prefix_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies one or more IPv6 prefixes for the elastic network interface. Range: 1-10\n**Note**: If you need to set an IPv6 prefix for an elastic network interface, you must set either Ipv6Prefixes or Ipv6PrefixCount, but not both."
    },
    "MinValue": 1,
    "Label": {
      "en": "Ipv6PrefixCount",
      "zh-cn": "为弹性网卡指定一个或多个 IPv6 前缀"
    },
    "MaxValue": 10
  }
  EOT
}

variable "ipv4_prefixes" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Specifies one or more IPv4 prefixes for the elastic network interface."
    },
    "Label": {
      "en": "Ipv4Prefixes",
      "zh-cn": "IPv4 IP地址前缀"
    },
    "MaxLength": 10
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
      "en": "VSwitch ID of the specified VPC. Specifies the switch ID for the VPC."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "The ID of the security group that the ENI joins. The security group and the ENI must be in a same VPC."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "ipv4_prefix_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies one or more IPv4 prefixes for the elastic network interface. Range: 1-10\n**Note**: If you need to set an IPv4 prefix for an elastic network interface, you must set either Ipv4Prefixes or Ipv4PrefixCount, but not both."
    },
    "MinValue": 1,
    "Label": {
      "en": "Ipv4PrefixCount",
      "zh-cn": "为弹性网卡指定一个或多个IPv4前缀"
    },
    "MaxValue": 10
  }
  EOT
}

variable "network_interface_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of your ENI. It is a string of [2, 128]  Chinese or English characters. It must begin with a letter and can contain numbers, underscores (_), colons (:), or hyphens (-)."
    },
    "Label": {
      "en": "NetworkInterfaceName",
      "zh-cn": "弹性网卡的名称"
    }
  }
  EOT
}

variable "primary_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The primary private IP address of the ENI.  The specified IP address must have the same Host ID as the VSwitch. If no IP addresses are specified, a random network ID is assigned for the ENI."
    },
    "Label": {
      "en": "PrimaryIpAddress",
      "zh-cn": "弹性网卡的主私有IP地址"
    }
  }
  EOT
}

variable "ipv6_prefixes" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Specifies one or more IPv6 prefixes for the elastic network interface."
    },
    "Label": {
      "en": "Ipv6Prefixes",
      "zh-cn": "IPv6地址前缀"
    },
    "MaxLength": 10
  }
  EOT
}

variable "ipv6_addresses" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IPv6 address N to assign to the ENI."
    },
    "Label": {
      "en": "Ipv6Addresses",
      "zh-cn": "为弹性网卡指定一个或多个IPv6地址"
    },
    "MaxLength": 10
  }
  EOT
}

variable "queue_number" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of queues that are supported by the ENI. Valid values: 1 to 2048.\nWhen you attach the ENI to an instance, make sure that the value of this parameter is less than the maximum number of queues per ENI that is allowed for the instance type. To view the maximum number of queues per ENI allowed for an instance type, you can call DescribeInstanceTypes and then check the return value of MaximumQueueNumberPerEni.\nBy default, this parameter is empty. If you do not specify this parameter, the default number of queues per ENI for the instance type of an instance is used when you attach the ENI to the instance. To learn about the default number of queues per ENI for an instance type, you can call DescribeInstanceTypes and then check the return value of SecondaryEniQueueNumber."
    },
    "MinValue": 1,
    "Label": {
      "en": "QueueNumber",
      "zh-cn": "弹性网卡队列数"
    },
    "MaxValue": 2048
  }
  EOT
}

variable "tx_queue_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Elastic network card outbound queue depth.\n**Note**: The outbound queue depth of the network card must be equal to the inbound queue depth, ranging from 8192 to 16384, and must be a power of two.\nLarger outbound queue depth can improve outbound throughput, but it consumes more memory."
    },
    "MinValue": 8192,
    "Label": {
      "en": "TxQueueSize",
      "zh-cn": "弹性网卡出方向队列深度"
    },
    "MaxValue": 16384
  }
  EOT
}

variable "rx_queue_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Elastic network card inbound queue depth.\n**Note**: The inbound queue depth of the network card must be equal to the outbound queue depth, ranging from 8192 to 16384, and must be a power of two.\nLarger inbound queue depth can improve inbound throughput, but it consumes more memory."
    },
    "MinValue": 8192,
    "Label": {
      "en": "RxQueueSize",
      "zh-cn": "弹性网卡入方向队列深度"
    },
    "MaxValue": 16384
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_network_interface" "eni_instance" {
  network_interface_traffic_mode = var.network_interface_traffic_mode
  description                    = var.description
  private_ip_addresses           = var.private_ip_addresses
  resource_group_id              = var.resource_group_id
  private_ips_count              = var.secondary_private_ip_address_count
  ipv4_prefixes                  = var.ipv4_prefixes
  vswitch_id                     = var.vswitch_id
  ipv4_prefix_count              = var.ipv4_prefix_count
  name                           = var.network_interface_name
  primary_ip_address             = var.primary_ip_address
  ipv6_addresses                 = var.ipv6_addresses
  queue_number                   = var.queue_number
  tags                           = var.tags
}

output "private_ip_address" {
  value       = alicloud_ecs_network_interface.eni_instance.private_ip
  description = "The primary private ip address of your Network Interface."
}

output "secondary_private_ip_addresses" {
  // Could not transform ROS Attribute SecondaryPrivateIpAddresses to Terraform attribute.
  value       = null
  description = "The secondary private IP addresses of your Network Interface."
}

output "mac_address" {
  value       = alicloud_ecs_network_interface.eni_instance.mac
  description = "The MAC address of your Network Interface."
}

output "network_interface_id" {
  value       = alicloud_ecs_network_interface.eni_instance.id
  description = "ID of your Network Interface."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

