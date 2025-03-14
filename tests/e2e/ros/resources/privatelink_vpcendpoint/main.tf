variable "protected_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable user authentication. This parameter is available in Security Token Service (STS) mode. Valid values:\ntrue: yes After user authentication is enabled, only the user who creates the endpoint can modify or delete the endpoint in STS mode.\nfalse (default): no"
    },
    "Label": {
      "en": "ProtectedEnabled",
      "zh-cn": "是否开启托管保护"
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
      "en": "The VPC to which the endpoint belongs."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "终端节点所属的专有网络ID"
    }
  }
  EOT
}

variable "endpoint_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the endpoint.\nThe name must be 2 to 128 characters in length and can contain digits, underscores\n(_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "EndpointName",
      "zh-cn": "终端节点名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

variable "service_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the endpoint service that is associated with the endpoint. One of ServiceId and ServiceName is required."
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "终端节点关联的终端节点服务名称"
    }
  }
  EOT
}

variable "zone" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "The zone of the associated endpoint service."
          },
          "Required": false
        },
        "Ip": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the zone in which the endpoint is deployed."
          },
          "Required": false
        },
        "VSwitchId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}",
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
          "Type": "String",
          "Description": {
            "en": "The switch of the endpoint network interface in the given zone."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Zone",
      "zh-cn": "可用区"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "security_group_id" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The security group associated with the endpoint network interface. The security group can control the data communication from the VPC to the endpoint network interface.",
      "zh-cn": "终端节点网卡关联的安全组ID，安全组可以管控专有网络到终端节点网卡的数据通信。"
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "终端节点网卡关联的安全组ID"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "endpoint_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Endpoint type."
    },
    "Label": {
      "en": "EndpointType",
      "zh-cn": "终端节点类型"
    }
  }
  EOT
}

variable "zone_private_ip_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of private IP addresses that can be used by an elastic network interface (ENI) in each zone. Set the value to 1."
    },
    "Label": {
      "en": "ZonePrivateIpAddressCount",
      "zh-cn": "每个可用区ENI私网IP的数量"
    }
  }
  EOT
}

variable "endpoint_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the endpoint.\nThe description must be 2 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "EndpointDescription",
      "zh-cn": "终端节点描述"
    },
    "MinLength": 2,
    "MaxLength": 256
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

variable "service_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The endpoint service that is associated with the endpoint. One of ServiceId and ServiceName is required."
    },
    "Label": {
      "en": "ServiceId",
      "zh-cn": "终端节点关联的终端节点服务ID"
    }
  }
  EOT
}

resource "alicloud_privatelink_vpc_endpoint" "vpc_endpoint" {
  protected_enabled             = var.protected_enabled
  vpc_id                        = var.vpc_id
  vpc_endpoint_name             = var.endpoint_name
  service_name                  = var.service_name
  endpoint_type                 = var.endpoint_type
  zone_private_ip_address_count = var.zone_private_ip_address_count
  endpoint_description          = var.endpoint_description
  tags                          = var.tags
  service_id                    = var.service_id
}

output "vpc_id" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.vpc_id
  description = "The vpc ID of endpoint."
}

output "endpoint_domain" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.endpoint_domain
  description = "The domain name of the endpoint."
}

output "endpoint_name" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.vpc_endpoint_name
  description = "The name of the endpoint."
}

output "service_name" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.service_name
  description = "The name of endpoint service that is associated with the endpoint."
}

output "bandwidth" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.bandwidth
  description = "The bandwidth of the endpoint."
}

output "endpoint_id" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.id
  description = "The ID of the endpoint."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "service_id" {
  value       = alicloud_privatelink_vpc_endpoint.vpc_endpoint.service_id
  description = "The ID of endpoint service that is associated with the endpoint."
}

output "zone_domains" {
  // Could not transform ROS Attribute ZoneDomains to Terraform attribute.
  value       = null
  description = "The zone domains."
}

