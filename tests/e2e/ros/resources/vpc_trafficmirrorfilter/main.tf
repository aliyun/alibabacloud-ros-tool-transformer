variable "traffic_mirror_filter_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the filter. The description must be 1 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "TrafficMirrorFilterDescription",
      "zh-cn": "流量镜像筛选条件的描述信息"
    }
  }
  EOT
}

variable "egress_rules" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DestinationPortRange": {
          "Type": "String",
          "Description": {
            "en": "The destination port range of the outbound traffic. Valid values for a port: 1 to 65535. Separate the first port and the last port with a forward slash (/). Examples: 1/200 and 80/80. You cannot set this parameter to only -1/-1. The value -1/-1 specifies all ports."
          },
          "Required": false
        },
        "Action": {
          "Type": "String",
          "Description": {
            "en": "The action of the outbound rule. Valid values:\naccept: collects network traffic.\ndrop: does not collect network traffic."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": true
        },
        "SourcePortRange": {
          "Type": "String",
          "Description": {
            "en": "The source port range of the outbound traffic. Valid values for a port: 1 to 65535. Separate the first port and the last port with a forward slash (/). Examples: 1/200 and 80/80. You cannot set this parameter to only -1/-1. The value -1/-1 specifies all ports."
          },
          "Required": false
        },
        "Priority": {
          "Type": "Number",
          "Description": {
            "en": "The priority of the outbound rule. A smaller value specifies a higher priority.."
          },
          "Required": false
        },
        "SourceCidrBlock": {
          "Type": "String",
          "Description": {
            "en": "The source CIDR block of the outbound traffic.."
          },
          "Required": false
        },
        "DestinationCidrBlock": {
          "Type": "String",
          "Description": {
            "en": "The destination CIDR block of the outbound traffic."
          },
          "Required": false
        },
        "Protocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol that is used by the outbound traffic to be mirrored. Valid values:\nALL: all protocols\nICMP: ICMP\nTCP: TCP\nUDP: User Datagram Protocol (UDP)"
          },
          "AllowedValues": [
            "ALL",
            "ICMP",
            "TCP",
            "UDP"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Egress rules."
    },
    "Label": {
      "en": "EgressRules",
      "zh-cn": "出方向规则详情"
    },
    "MaxLength": 10
  }
  EOT
}

variable "traffic_mirror_filter_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the filter.The name must be 1 to 128 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "TrafficMirrorFilterName",
      "zh-cn": "流量镜像筛选条件的名称"
    }
  }
  EOT
}

variable "ingress_rules" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DestinationPortRange": {
          "Type": "String",
          "Description": {
            "en": "The destination port range of the inbound traffic. Valid values for a port: 1 to 65535. Separate the first port and the last port with a forward slash (/). Examples: 1/200 and 80/80."
          },
          "Required": false
        },
        "Action": {
          "Type": "String",
          "Description": {
            "en": "The action of the inbound rule. Valid values:\naccept: collects network traffic.\ndrop: does not collect network traffic."
          },
          "AllowedValues": [
            "accept",
            "drop"
          ],
          "Required": true
        },
        "SourcePortRange": {
          "Type": "String",
          "Description": {
            "en": "The source port range of the inbound traffic. Valid values for a port: 1 to 65535. Separate the first port and the last port with a forward slash (/). Examples: 1/200 and 80/80."
          },
          "Required": false
        },
        "Priority": {
          "Type": "Number",
          "Description": {
            "en": "The priority of the inbound rule. A smaller value specifies a higher priority.."
          },
          "Required": false
        },
        "SourceCidrBlock": {
          "Type": "String",
          "Description": {
            "en": "The source CIDR block of the inbound traffic.."
          },
          "Required": false
        },
        "DestinationCidrBlock": {
          "Type": "String",
          "Description": {
            "en": "The destination CIDR block of the inbound traffic."
          },
          "Required": false
        },
        "Protocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol that is used by the inbound traffic to be mirrored. Valid values:\nALL: all protocols\nICMP: ICMP\nTCP: TCP\nUDP: User Datagram Protocol (UDP)"
          },
          "AllowedValues": [
            "ALL",
            "ICMP",
            "TCP",
            "UDP"
          ],
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Ingress rules."
    },
    "Label": {
      "en": "IngressRules",
      "zh-cn": "入方向规则详情"
    },
    "MaxLength": 10
  }
  EOT
}

resource "alicloud_vpc_traffic_mirror_filter" "extension_resource" {
  traffic_mirror_filter_description = var.traffic_mirror_filter_description
  egress_rules                      = var.egress_rules
  traffic_mirror_filter_name        = var.traffic_mirror_filter_name
  ingress_rules                     = var.ingress_rules
}

output "traffic_mirror_filter_description" {
  value       = alicloud_vpc_traffic_mirror_filter.extension_resource.traffic_mirror_filter_description
  description = "The description of the filter."
}

output "egress_rules" {
  value       = alicloud_vpc_traffic_mirror_filter.extension_resource.egress_rules
  description = "Egress rules."
}

output "traffic_mirror_filter_id" {
  value       = alicloud_vpc_traffic_mirror_filter.extension_resource.id
  description = "The ID of the filter."
}

output "traffic_mirror_filter_name" {
  value       = alicloud_vpc_traffic_mirror_filter.extension_resource.traffic_mirror_filter_name
  description = "The name of the filter."
}

output "ingress_rules" {
  value       = alicloud_vpc_traffic_mirror_filter.extension_resource.ingress_rules
  description = "Ingress rules."
}

