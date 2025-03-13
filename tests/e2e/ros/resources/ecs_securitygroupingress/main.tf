variable "source_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source Group Id"
    },
    "Label": {
      "zh-cn": "源端安全组ID"
    }
  }
  EOT
}

variable "policy" {
  type        = string
  default     = "accept"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SecurityGroupPolicy"
    },
    "Description": {
      "en": "Authorization policies, parameter values can be: accept (accepted access), drop (denied access). Default value is accept."
    },
    "AllowedValues": [
      "accept",
      "drop"
    ],
    "Label": {
      "en": "Policy",
      "zh-cn": "访问权限"
    }
  }
  EOT
}

variable "port_range" {
  type        = string
  default     = "80/80"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "IpProtocol": "$${.IpProtocol}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::PortRange",
    "Description": {
      "en": "Ip protocol relative port range. For tcp and udp, the port rang is [1,65535], using format '1/200'For icmp|gre|all protocel, the port range should be '-1/-1'"
    },
    "Label": {
      "zh-cn": "端口范围"
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
      "en": "Description of the security group rule, [1, 512] characters. The default is empty."
    },
    "Label": {
      "zh-cn": "描述"
    },
    "MinLength": 1,
    "MaxLength": 512
  }
  EOT
}

variable "source_port_range" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::PortRange",
    "Description": {
      "en": "The range of the ports enabled by the source security group for the transport layer protocol. Valid values: TCP/UDP: Value range: 1 to 65535. The start port and the end port are separated by a slash (/). Correct example: 1/200. Incorrect example: 200/1.ICMP: -1/-1.GRE: -1/-1.ALL: -1/-1."
    },
    "Label": {
      "zh-cn": "源端开放的端口范围"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Authorization policies priority range[1, 100]"
    },
    "MinValue": 1,
    "Label": {
      "zh-cn": "优先级"
    },
    "MaxValue": 100
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
      "en": "Id of the security group."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "需要创建入规则的安全组ID"
    }
  }
  EOT
}

variable "source_cidr_ip" {
  type        = string
  default     = "0.0.0.0/0"
  description = <<EOT
  {
    "Description": {
      "en": "The source IPv4 CIDR block to which you want to control access. CIDR blocks and IPv4 addresses are supported.",
      "zh-cn": "至少设置源端安全组ID或者授权对象网段其中一项。如果同时指定，则默认以授权对象网段的设置为准。"
    },
    "Label": {
      "zh-cn": "授权对象网段"
    }
  }
  EOT
}

variable "source_group_owner_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source Group Owner Account ID",
      "zh-cn": "如果源安全组ALI UID未设置，则默认设置您其他安全组的访问权限。如果已经设置授权对象网段，则该参数的设置无效。"
    },
    "Label": {
      "zh-cn": "源安全组ALI UID"
    }
  }
  EOT
}

variable "ip_protocol" {
  type        = string
  default     = "tcp"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "all": {
          "en": "All",
          "zh-cn": "全部"
        },
        "udp": {
          "en": "UDP",
          "zh-cn": "自定义 UDP"
        },
        "tcp": {
          "en": "TCP",
          "zh-cn": "自定义 TCP"
        },
        "gre": {
          "en": "GRE",
          "zh-cn": "全部 GRE"
        },
        "icmp": {
          "en": "ICMP",
          "zh-cn": "全部 ICMP(IPv4)"
        },
        "icmpv6": {
          "en": "ICMPv6",
          "zh-cn": "全部 ICMP(IPv6)"
        }
      },
      "AutoChangeType": false
    },
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
    "Label": {
      "zh-cn": "协议类型"
    }
  }
  EOT
}

variable "ipv6_source_cidr_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source IPv6 CIDR address segment. Supports IP address ranges in CIDR format and IPv6 format.\nNote Only VPC type IP addresses are supported.",
      "zh-cn": "支持CIDR格式和IPv6格式的IP地址范围。仅支持VPC类型的IP地址。"
    },
    "Label": {
      "en": "Ipv6SourceCidrIp",
      "zh-cn": "源端IPv6 CIDR地址段"
    }
  }
  EOT
}

variable "source_prefix_list_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the source prefix list to which you want to control access. You can call the DescribePrefixLists operation to query the IDs of available prefix lists. Take note of the following items:\n- If a security group is in the classic network, you cannot configure prefix lists in the security group rules.\n- If you specify the SourceCidrIp, Ipv6SourceCidrIp, or SourceGroupId parameter, this parameter is ignored.",
      "zh-cn": "当您指定了授权对象网段、源端IPv6 CIDR地址段与源端安全组参数中的任意一个时，将忽略该参数。"
    },
    "Label": {
      "zh-cn": "授权对象源端前缀列表"
    }
  }
  EOT
}

resource "alicloud_security_group_rule" "security_group_ingress" {
  policy            = var.policy
  port_range        = var.port_range
  description       = var.description
  priority          = var.priority
  security_group_id = var.security_group_id
  ip_protocol       = var.ip_protocol
}

