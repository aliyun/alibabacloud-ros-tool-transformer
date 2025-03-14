variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the security group, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "安全组描述信息"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "Physical ID of the VPC."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "security_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the security group, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "SecurityGroupName",
      "zh-cn": "安全组名称"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "安全组所在的资源组ID"
    }
  }
  EOT
}

variable "security_group_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SecurityGroupType"
    },
    "Description": {
      "en": "The type of the security group. Valid values:\nnormal: basic security group\nenterprise: advanced security group"
    },
    "AllowedValues": [
      "normal",
      "enterprise"
    ],
    "Label": {
      "en": "SecurityGroupType",
      "zh-cn": "安全组的类型"
    }
  }
  EOT
}

variable "security_group_ingress" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Policy": {
          "Type": "String",
          "Description": {
            "en": "Authorization policies, parameter values can be: accept (accepted access), drop (denied access). Default value is accept."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": false
        },
        "SourceGroupId": {
          "Type": "String",
          "Description": {
            "en": "Source Group Id"
          },
          "Required": false
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the security group rule, [1, 512] characters. The default is empty."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 512
        },
        "SourcePortRange": {
          "Type": "String",
          "Description": {
            "en": "The range of the ports enabled by the source security group for the transport layer protocol. Valid values: TCP/UDP: Value range: 1 to 65535. The start port and the end port are separated by a slash (/). Correct example: 1/200. Incorrect example: 200/1.ICMP: -1/-1.GRE: -1/-1.ALL: -1/-1."
          },
          "Required": false
        },
        "Priority": {
          "Type": "Number",
          "Description": {
            "en": "Authorization policies priority range[1, 100]"
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 100,
          "Default": 1
        },
        "SourceGroupOwnerId": {
          "Type": "String",
          "Description": {
            "en": "Source Group Owner Account ID"
          },
          "Required": false
        },
        "Ipv6SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Source IPv6 CIDR address segment. Supports IP address ranges in CIDR format and IPv6 format.\nNote Only VPC type IP addresses are supported."
          },
          "Required": false
        },
        "NicType": {
          "Type": "String",
          "Description": {
            "en": "Network type, could be 'internet' or 'intranet'. Default value is internet."
          },
          "AllowedValues": [
            "internet",
            "intranet"
          ],
          "Required": false
        },
        "PortRange": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol relative port range. For tcp and udp, the port rang is [1,65535], using format '1/200'For icmp|gre|all protocel, the port range should be '-1/-1'"
          },
          "Required": true
        },
        "SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "The source IPv4 CIDR block to which you want to control access. CIDR blocks and IPv4 addresses are supported."
          },
          "Required": false
        },
        "IpProtocol": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol for in rule."
          },
          "AllowedValues": [
            "tcp",
            "udp",
            "icmp",
            "gre",
            "all",
            "icmpv6"
          ],
          "Required": true
        },
        "DestCidrIp": {
          "Type": "String",
          "Description": {
            "en": "The destination IPv4 CIDR block to which you want to control access. CIDR blocks and IPv4 addresses are supported."
          },
          "Required": false
        },
        "Ipv6DestCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Destination IPv6 CIDR address block for which access rights need to be set. CIDR format and IPv6 format IP address range are supported."
          },
          "Required": false
        },
        "SourcePrefixListId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the source prefix list to which you want to control access. You can call the DescribePrefixLists operation to query the IDs of available prefix lists. Take note of the following items:\n- If a security group is in the classic network, you cannot configure prefix lists in the security group rules.\n- If you specify the SourceCidrIp, Ipv6SourceCidrIp, or SourceGroupId parameter, this parameter is ignored."
          },
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Policy",
          "Priority",
          "IpProtocol",
          "PortRange",
          "SourceCidrIp",
          "SourcePrefixListId",
          "SourceGroupOwnerId",
          "Ipv6SourceCidrIp",
          "SourcePortRange",
          "NicType",
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Ingress rules for the security group."
    },
    "Label": {
      "en": "SecurityGroupIngress",
      "zh-cn": "安全组入方向的访问规则"
    }
  }
  EOT
  default = [
    {
      Policy       = "accept"
      PortRange    = "80/80"
      Priority     = 1
      SourceCidrIp = "0.0.0.0/0"
      IpProtocol   = "tcp"
    },
    {
      Policy       = "accept"
      PortRange    = "443/443"
      Priority     = 1
      SourceCidrIp = "0.0.0.0/0"
      IpProtocol   = "tcp"
    },
    {
      Policy       = "accept"
      PortRange    = "22/22"
      Priority     = 1
      SourceCidrIp = "0.0.0.0/0"
      IpProtocol   = "tcp"
    },
    {
      Policy       = "accept"
      PortRange    = "3389/3389"
      Priority     = 1
      SourceCidrIp = "0.0.0.0/0"
      IpProtocol   = "tcp"
    },
    {
      Policy       = "accept"
      PortRange    = "-1/-1"
      Priority     = 1
      SourceCidrIp = "0.0.0.0/0"
      IpProtocol   = "icmp"
    }
  ]
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
      "en": "Tags to attach to security group. Max support 20 tags to add during create security group. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "安全组的标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "security_group_egress" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Policy": {
          "Type": "String",
          "Description": {
            "en": "Authorization policies, parameter values can be: accept (accepted access), drop (denied access). Default value is accept."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": false
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the security group rule, [1, 512] characters. The default is empty."
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 512
        },
        "SourcePortRange": {
          "Type": "String",
          "Description": {
            "en": "The range of the ports enabled by the source security group for the transport layer protocol. Valid values: TCP/UDP: Value range: 1 to 65535. The start port and the end port are separated by a slash (/). Correct example: 1/200. Incorrect example: 200/1.ICMP: -1/-1.GRE: -1/-1.ALL: -1/-1."
          },
          "Required": false
        },
        "Priority": {
          "Type": "Number",
          "Description": {
            "en": "Authorization policies priority range[1, 100]"
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 100,
          "Default": 1
        },
        "Ipv6SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Source IPv6 CIDR address segment. Supports IP address ranges in CIDR format and IPv6 format.\nNote Only VPC type IP addresses are supported."
          },
          "Required": false
        },
        "NicType": {
          "Type": "String",
          "Description": {
            "en": "Network type, could be 'internet' or 'intranet'. Default value is internet."
          },
          "AllowedValues": [
            "internet",
            "intranet"
          ],
          "Required": false
        },
        "DestGroupId": {
          "Type": "String",
          "Description": {
            "en": "The destination security group ID to which access permissions need to be set.\nSet at least one of the DestGroupId, DestCidrIp, Ipv6DestCidrIp, or DestPrefixListId parameters.\n- If DestGroupId is specified without the DestCidrIp parameter, the NicType parameter can only take the value intranet.\n- If both DestGroupId and DestCidrIp are specified, DestCidrIp is assumed to prevail.\nYou should pay attention to:\n- Enterprise Security groups do not support authorized security group access.\n- The maximum number of authorized security groups supported by ordinary security groups is 20."
          },
          "Required": false
        },
        "PortRange": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol relative port range. For tcp and udp, the port rang is [1,65535], using format '1/200'For icmp|gre|all protocel, the port range should be '-1/-1'"
          },
          "Required": true
        },
        "DestPrefixListId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the destination prefix list to which you want to control access. You can call the DescribePrefixLists operation to query the IDs of available prefix lists.Take note of the following items:\nIf a security group is in the classic network, you cannot configure prefix lists in the security group rules. For information about the limits on security groups and prefix lists, see the \"Security group limits\" in Limits.\nIf you specify DestCidrIp, Ipv6DestCidrIp, or DestGroupId, DestPrefixListId is ignored."
          },
          "Required": false
        },
        "SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "The source IPv4 CIDR block to which you want to control access. CIDR blocks and IPv4 addresses are supported."
          },
          "Required": false
        },
        "DestGroupOwnerId": {
          "Type": "String",
          "Description": {
            "en": "When setting security group rules across accounts, the Ali Cloud account ID of the destination security group.\n- If neither DestGroupOwnerId nor DestGroupOwnerAccount is set, it is considered to set the access rights of your other security group.\n- If you have set the parameter DestCidrIp, the parameter DestGroupOwnerId is invalid."
          },
          "Required": false
        },
        "IpProtocol": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol for in rule."
          },
          "AllowedValues": [
            "tcp",
            "udp",
            "icmp",
            "gre",
            "all",
            "icmpv6"
          ],
          "Required": true
        },
        "DestCidrIp": {
          "Type": "String",
          "Description": {
            "en": "The destination IPv4 CIDR block to which you want to control access. CIDR blocks and IPv4 addresses are supported."
          },
          "Required": false
        },
        "Ipv6DestCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Destination IPv6 CIDR address block for which access rights need to be set. CIDR format and IPv6 format IP address range are supported."
          },
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Policy",
          "Priority",
          "IpProtocol",
          "PortRange",
          "DestCidrIp",
          "DestPrefixListId",
          "DestGroupOwnerId",
          "Ipv6DestCidrIp",
          "NicType",
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "egress rules for the security group."
    },
    "Label": {
      "en": "SecurityGroupEgress",
      "zh-cn": "安全组出方向的访问规则"
    }
  }
  EOT
}

resource "alicloud_security_group" "security_group" {
  description         = var.description
  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  resource_group_id   = var.resource_group_id
  security_group_type = var.security_group_type
  tags                = var.tags
}

output "security_group_name" {
  // Could not transform ROS Attribute SecurityGroupName to Terraform attribute.
  value       = null
  description = "The name of security group."
}

output "security_group_id" {
  value       = alicloud_security_group.security_group.id
  description = "generated security group id for security group."
}

