variable "ingress_acl_entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Policy": {
          "Type": "String",
          "Description": {
            "en": "The authorization policy. Valid values:\naccept: access permissions granted.\ndrop: access permissions denied."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": true
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the ingress entry."
          },
          "Required": false
        },
        "EntryType": {
          "Type": "String",
          "Description": {
            "en": "The type of the rule. Valid values:\ncustom : custom rules.\nsystem : system rules."
          },
          "AllowedValues": [
            "custom",
            "system"
          ],
          "Required": false
        },
        "SourceCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Source address network segment."
          },
          "Required": false
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The source ports. The value range is from 1 to 65535; setting formats such as \"1/200\" and \"80/80\", where \"-1/-1\" cannot be set individually, which means that the port is not restricted."
          },
          "Required": true
        },
        "Protocol": {
          "Type": "String",
          "Description": {
            "en": "The transport layer protocols. Valid values:\nicmp\ngre\ntcp\nudp\nall: All protocols are supported."
          },
          "AllowedValues": [
            "icmp",
            "gre",
            "tcp",
            "udp",
            "all"
          ],
          "Required": true
        },
        "NetworkAclEntryName": {
          "Type": "String",
          "Description": {
            "en": "The name of the ingress entry."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of ingress network ACL entries."
    },
    "Label": {
      "en": "IngressAclEntries",
      "zh-cn": "入方向网络ACL规则"
    },
    "MaxLength": 20
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the network ACL.\nThe description must be 2 to 256 characters in length. The description must start\nwith a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "网络ACL的描述信息"
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
      "en": "The ID of the virtual private cloud (VPC) to which the network ACL belongs."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "网络ACL所属的VPC的ID"
    }
  }
  EOT
}

variable "egress_acl_entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Policy": {
          "Type": "String",
          "Description": {
            "en": "The authorization policy. Valid values:\naccept: access permissions granted.\ndrop: access permissions denied."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": true
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the egress entry."
          },
          "Required": false
        },
        "EntryType": {
          "Type": "String",
          "Description": {
            "en": "The type of the rule. Valid values:\ncustom : custom rules.\nsystem : system rules."
          },
          "AllowedValues": [
            "custom",
            "system"
          ],
          "Required": false
        },
        "DestinationCidrIp": {
          "Type": "String",
          "Description": {
            "en": "Destination address network segment."
          },
          "Required": false
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The source ports. The value range is from 1 to 65535; setting formats such as \"1/200\" and \"80/80\", where \"-1/-1\" cannot be set individually, which means that the port is not restricted."
          },
          "Required": true
        },
        "Protocol": {
          "Type": "String",
          "Description": {
            "en": "The transport layer protocols. Valid values:\nicmp\ngre\ntcp\nudp\nall: All protocols are supported."
          },
          "AllowedValues": [
            "icmp",
            "gre",
            "tcp",
            "udp",
            "all"
          ],
          "Required": true
        },
        "NetworkAclEntryName": {
          "Type": "String",
          "Description": {
            "en": "The name of the egress entry."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of egress network ACL entries."
    },
    "Label": {
      "en": "EgressAclEntries",
      "zh-cn": "出方向网络ACL规则"
    },
    "MaxLength": 20
  }
  EOT
}

variable "network_acl_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the network ACL.\nThe name must be 2 to 128 characters in length and can contain letters, digits, periods\n(.), underscores (_), and hyphens (-). The name must start with a letter and cannot\nstart with http:// or https://."
    },
    "Label": {
      "en": "NetworkAclName",
      "zh-cn": "网络ACL的名称"
    }
  }
  EOT
}

resource "alicloud_network_acl" "network_acl" {
  ingress_acl_entries = var.ingress_acl_entries
  description         = var.description
  vpc_id              = var.vpc_id
  egress_acl_entries  = var.egress_acl_entries
  name                = var.network_acl_name
}

output "network_acl_id" {
  value       = alicloud_network_acl.network_acl.id
  description = "The ID of the network ACL."
}

output "network_acl_entry_name" {
  value       = alicloud_network_acl.network_acl.name
  description = "The name of the inbound rule."
}

