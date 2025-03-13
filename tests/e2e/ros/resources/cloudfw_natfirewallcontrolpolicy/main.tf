variable "destination" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The destination address in the access control policy.\nValid values:\nIf DestinationType is set to net, the value of this parameter is a CIDR block.\nExample: 1.2.XX.XX/24\nIf DestinationType is set to group, the value of this parameter is an address book.\nExample: db_group\nIf DestinationType is set to domain, the value of this parameter is a domain name.\nExample: *.aliyuncs.com\nDestinationType is set to location, the value of this parameter is a location.\nExample: [\"BJ11\", \"ZB\"]"
    },
    "Label": {
      "en": "Destination",
      "zh-cn": "访问控制策略中的目的地址段"
    }
  }
  EOT
}

variable "description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the access control policy."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "访问控制策略的描述信息"
    }
  }
  EOT
}

variable "end_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the access control policy stops taking effect. The value is a UNIX timestamp. Unit: seconds. The value must be on the hour or on the half hour, and at least 30 minutes later than the value of StartTime."
    },
    "Label": {
      "en": "EndTime",
      "zh-cn": "访问控制策略的策略有效期的结束时间"
    }
  }
  EOT
}

variable "ip_version" {
  type        = number
  default     = 4
  description = <<EOT
  {
    "Description": {
      "en": "The IP version supported by the access control policy. Valid values:\n4: IPv4 (default)"
    },
    "Label": {
      "en": "IpVersion",
      "zh-cn": "支持的 IP 地址版本"
    }
  }
  EOT
}

variable "source_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "net",
      "group"
    ],
    "Description": {
      "en": "The type of the source address in the access control policy.Valid values:\nnet: source CIDR block\ngroup: source address book"
    },
    "Label": {
      "en": "SourceType",
      "zh-cn": "访问控制策略中的源地址类型"
    }
  }
  EOT
}

variable "dest_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The destination port in the access control policy. Valid values:\nIf Proto is set to ICMP, DestPort is automatically left empty.\nIf Proto is set to TCP, UDP, or ANY and DestPortType is set to group, DestPort is empty.\nIf Proto is set to TCP, UDP, or ANY and DestPortType is set to port, the value of DestPort is the destination port number."
    },
    "Label": {
      "en": "DestPort",
      "zh-cn": "访问控制策略中流量访问的目的端口"
    }
  }
  EOT
}

variable "application_name_list" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Application types supported by access control policies."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The application types supported by the access control policy."
    },
    "Label": {
      "en": "ApplicationNameList",
      "zh-cn": "访问控制策略支持的应用类型列表"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "start_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the access control policy starts to take effect. The value is a UNIX timestamp. Unit: seconds. The value must be on the hour or on the half hour, and at least 30 minutes earlier than the value of EndTime."
    },
    "Label": {
      "en": "StartTime",
      "zh-cn": "访问控制策略的策略有效期的开始时间"
    }
  }
  EOT
}

variable "acl_action" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "accept",
      "drop",
      "log"
    ],
    "Description": {
      "en": "The action that Cloud Firewall performs on the traffic.Valid values:\naccept: allows the traffic.\ndrop: denies the traffic.\nlog: monitors the traffic."
    },
    "Label": {
      "en": "AclAction",
      "zh-cn": "安全访问控制策略中访问流量通过云防火墙的方式（动作）"
    }
  }
  EOT
}

variable "destination_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "net",
      "group",
      "domain"
    ],
    "Description": {
      "en": "The type of the destination address in the access control policy. Valid values:\nnet: CIDR block\ngroup: address book\ndomain: domain name"
    },
    "Label": {
      "en": "DestinationType",
      "zh-cn": "访问控制策略中的目的地址类型"
    }
  }
  EOT
}

variable "direction" {
  type        = string
  default     = "out"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The direction of the traffic to which the access control policy applies. Valid values:\nout: outbound traffic"
    },
    "AllowedValues": [
      "out"
    ],
    "Label": {
      "en": "Direction",
      "zh-cn": "访问控制策略的流量方向"
    }
  }
  EOT
}

variable "source_fe6276b0" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source address in the access control policy.Valid values:\nIf SourceType is set to net, the value of Source is a CIDR block.Example: 10.2.4.0/24\nIf SourceType is set to group, the value of this parameter must be an address book name.Example: db_group"
    },
    "Label": {
      "en": "Source",
      "zh-cn": "访问控制策略中的源地址"
    }
  }
  EOT
}

variable "dest_port_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the destination port in the access control policy. Valid values:\nnet: source CIDR block\ngroup: source address book"
    },
    "AllowedValues": [
      "net",
      "group"
    ],
    "Label": {
      "en": "DestPortType",
      "zh-cn": "安全访问控制策略中访问流量的目的端口类型"
    }
  }
  EOT
}

variable "proto" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "ANY",
      "TCP",
      "UDP",
      "ICMP"
    ],
    "Description": {
      "en": "The protocol type in the access control policy.Valid values:\nANY: all types of protocols\nTCP\nUDP\nICMP"
    },
    "Label": {
      "en": "Proto",
      "zh-cn": "访问控制策略中流量访问的安全协议类型"
    }
  }
  EOT
}

variable "repeat_end_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The point in time when the recurrence ends. Example: 23:30. The value must be on the hour or on the half hour, and at least 30 minutes later than the value of RepeatStartTime."
    },
    "Label": {
      "en": "RepeatEndTime",
      "zh-cn": "访问控制策略的策略有效期的重复结束时间"
    }
  }
  EOT
}

variable "domain_resolve_type" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The domain name resolution method of the access control policy. Valid values:\n0: fully qualified domain name (FQDN)-based resolution\n1: Domain Name System (DNS)-based dynamic resolution\n2: FQDN and DNS-based dynamic resolution"
    },
    "AllowedValues": [
      0,
      1,
      2
    ],
    "Label": {
      "en": "DomainResolveType",
      "zh-cn": "访问控制策略的域名解析方式"
    }
  }
  EOT
}

variable "repeat_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The recurrence type for the access control policy to take effect. Valid values:\nPermanent (default): The policy always takes effect.\nNone: The policy takes effect for only once.\nDaily: The policy takes effect on a daily basis.\nWeekly: The policy takes effect on a weekly basis.\nMonthly: The policy takes effect on a monthly basis."
    },
    "AllowedValues": [
      "Permanent",
      "None",
      "Daily",
      "Weekly",
      "Monthly"
    ],
    "Label": {
      "en": "RepeatType",
      "zh-cn": "访问控制策略的策略有效期的重复类型"
    }
  }
  EOT
}

variable "repeat_days" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The days of a week or of a month on which the access control policy takes effect.\nIf RepeatType is set to Permanent, None, or Daily, RepeatDays is left empty. Example: [].\nIf RepeatType is set to Weekly, RepeatDays must be specified. Example: [0, 6].\nIf RepeatType is set to Monthly, RepeatDays must be specified. Example: [1, 31]."
    },
    "Label": {
      "en": "RepeatDays",
      "zh-cn": "访问控制策略的策略有效期的重复日期集合"
    }
  }
  EOT
}

variable "repeat_start_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The point in time when the recurrence starts. Example: 08:00. The value must be on the hour or on the half hour, and at least 30 minutes earlier than the value of RepeatEndTime."
    },
    "Label": {
      "en": "RepeatStartTime",
      "zh-cn": "访问控制策略的策略有效期的重复开始时间"
    }
  }
  EOT
}

variable "nat_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the NAT gateway."
    },
    "Label": {
      "en": "NatGatewayId",
      "zh-cn": "NAT 网关的实例 ID"
    }
  }
  EOT
}

variable "release" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the access control policy. By default, an access control policy is enabled after it is created. Valid values:\ntrue\nfalse"
    },
    "Label": {
      "en": "Release",
      "zh-cn": "访问控制策略的启用状态"
    }
  }
  EOT
}

variable "new_order" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the access control policy. The priority value starts from 1. A small priority value indicates a high priority."
    },
    "Label": {
      "en": "NewOrder",
      "zh-cn": "访问控制策略生效的优先级"
    }
  }
  EOT
}

variable "dest_port_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the destination port address book in the access control policy."
    },
    "Label": {
      "en": "DestPortGroup",
      "zh-cn": "访问控制策略中访问流量的目的端口地址簿名称"
    }
  }
  EOT
}

resource "alicloud_cloud_firewall_nat_firewall_control_policy" "extension_resource" {
  destination           = var.destination
  description           = var.description
  end_time              = var.end_time
  ip_version            = var.ip_version
  source_type           = var.source_type
  dest_port             = var.dest_port
  application_name_list = var.application_name_list
  start_time            = var.start_time
  acl_action            = var.acl_action
  destination_type      = var.destination_type
  direction             = var.direction
  source                = var.source_fe6276b0
  dest_port_type        = var.dest_port_type
  proto                 = var.proto
  repeat_end_time       = var.repeat_end_time
  domain_resolve_type   = var.domain_resolve_type
  repeat_type           = var.repeat_type
  repeat_days           = var.repeat_days
  repeat_start_time     = var.repeat_start_time
  nat_gateway_id        = var.nat_gateway_id
  new_order             = var.new_order
  dest_port_group       = var.dest_port_group
}

output "acl_uuid" {
  value       = alicloud_cloud_firewall_nat_firewall_control_policy.extension_resource.acl_uuid
  description = "The unique ID of the access control policy."
}

output "direction" {
  value       = alicloud_cloud_firewall_nat_firewall_control_policy.extension_resource.direction
  description = "The direction of the traffic to which the access control policy applies."
}

output "nat_gateway_id" {
  value       = alicloud_cloud_firewall_nat_firewall_control_policy.extension_resource.nat_gateway_id
  description = "The ID of the NAT gateway."
}

