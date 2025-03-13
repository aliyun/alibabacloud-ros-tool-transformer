variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the security group. The description must be 2 to 256 characters in length. It must start with a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "security_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the security group. The name must be 2 to 128 characters in length. The name must start with a letter and cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), and hyphens (-). By default, this parameter is empty."
    },
    "Label": {
      "en": "SecurityGroupName",
      "zh-cn": "安全组名称"
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
        "PortRange": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol relative port range. For tcp and udp, the port rang is [1,65535], using format '1/200'For icmp|gre|all protocel, the port range should be '-1/-1'"
          },
          "Required": true
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
        "SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Source CIDR Ip Address range."
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
            "all"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Ingress rules for the security group."
    },
    "Label": {
      "en": "SecurityGroupIngress",
      "zh-cn": "安全组入方向的规则属性列表"
    }
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
        "PortRange": {
          "Type": "String",
          "Description": {
            "en": "Ip protocol relative port range. For tcp and udp, the port rang is [1,65535], using format '1/200'For icmp|gre|all protocel, the port range should be '-1/-1'"
          },
          "Required": true
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
            "all"
          ],
          "Required": true
        },
        "DestCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Dest CIDR Ip Address range."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "egress rules for the security group."
    },
    "Label": {
      "en": "SecurityGroupEgress",
      "zh-cn": "安全组出方向的规则属性列表"
    }
  }
  EOT
}

resource "alicloud_ens_security_group" "security_group" {
  description         = var.description
  security_group_name = var.security_group_name
}

output "security_group_id" {
  value       = alicloud_ens_security_group.security_group.id
  description = "The ID of the security group."
}

