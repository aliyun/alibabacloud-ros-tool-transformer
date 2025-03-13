variable "destination" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Security Access Control destination address policy.\nWhen DestinationType is net, Destination purpose CIDR. For example: 1.2.3.4/24\nWhen DestinationType as a group, Destination for the purpose of the address book name. For example: db_group\nWhen DestinationType for the domain, Destination for the purpose of a domain name. For example:. * Aliyuncs.com\nWhen DestinationType as location, Destination area for the purpose (see below position encoding specific regions). For example: [ \"BJ11\", \"ZB\"]"
    },
    "Label": {
      "en": "Destination",
      "zh-cn": "安全访问控制策略中的目的地址"
    },
    "MinLength": 1
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
      "en": "Security access control policy description information."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "安全访问控制策略的描述信息"
    },
    "MinLength": 1
  }
  EOT
}

variable "application_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Application types supported by the security policy.\nThe following types of applications are supported: ANY, HTTP, HTTPS, MySQL, SMTP, SMTPS, RDP, VNC, SSH, Redis, MQTT, MongoDB, Memcache, SSL\nNOTE ANY indicates that the policy is applied to all types of applications.\nEither ApplicationNameList or ApplicationName must be passed, not both."
    },
    "AllowedValues": [
      "ANY",
      "HTTP",
      "HTTPS",
      "MQTT",
      "Memcache",
      "MongoDB",
      "MySQL",
      "RDP",
      "Redis",
      "SMTP",
      "SMTPS",
      "SSH",
      "SSL",
      "VNC"
    ],
    "Label": {
      "en": "ApplicationName",
      "zh-cn": "安全策略支持的应用类型"
    }
  }
  EOT
}

variable "end_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The end time of the policy validity period for an access control policy. It is represented in a second-level timestamp format. It must be the whole hour or half hour, and at least half an hour greater than the start time.\nNotes: When RepeatType is Permanent, EndTime is empty. When RepeatType is None, Daily, Weekly, Monthly, EndTime must havea value, and you need to set the end time."
    },
    "Label": {
      "en": "EndTime",
      "zh-cn": "访问控制策略的策略有效期的结束时间"
    }
  }
  EOT
}

variable "ip_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "IP version. Valid values:\n- 4: IPv4\n- 6: IPv6"
    },
    "AllowedValues": [
      "4",
      "6"
    ],
    "Label": {
      "en": "IpVersion",
      "zh-cn": "云防火墙防护的资产的 IP 版本"
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
      "group",
      "location",
      "net"
    ],
    "Description": {
      "en": "Security access control source address type of policy.\nnet: Source segment (CIDR)\ngroup: source address book\nlocation: the source area"
    },
    "Label": {
      "en": "SourceType",
      "zh-cn": "安全访问控制策略中的源地址类型"
    }
  }
  EOT
}

variable "dest_port" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security access control policy access traffic destination port.\nNote When DestPortType to port, set the item."
    },
    "Label": {
      "en": "DestPort",
      "zh-cn": "安全访问控制策略中流量访问的目的端口"
    }
  }
  EOT
}

variable "application_name_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "Application types supported by the security policy.\nThe following types of applications are supported: ANY, HTTP, HTTPS, MySQL, SMTP, SMTPS, RDP, VNC, SSH, Redis, MQTT, MongoDB, Memcache, SSL\nNOTE ANY indicates that the policy is applied to all types of applications.\nEither ApplicationNameList or ApplicationName must be passed, not both."
        },
        "AllowedValues": [
          "ANY",
          "HTTP",
          "HTTPS",
          "MQTT",
          "Memcache",
          "MongoDB",
          "MySQL",
          "RDP",
          "Redis",
          "SMTP",
          "SMTPS",
          "SSH",
          "SSL",
          "VNC"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "List of application types supported by the access control policy."
    },
    "Label": {
      "en": "ApplicationNameList",
      "zh-cn": "应用名称"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "start_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The start time of the policy validity period for an access control policy. It is represented in a second-level timestamp format. It must be the whole hour or half hour, and at least half an hour less than the end time.\nNotes: When RepeatType is Permanent, StartTime is empty. When RepeatType is None, Daily, Weekly, Monthly, StartTime must have a value, and you need to set the start time."
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
      "en": "Traffic access control policy set by the cloud of a firewall.\naccept: Release\ndrop: rejected\nlog: Observation"
    },
    "Label": {
      "en": "AclAction",
      "zh-cn": "访问控制策略中设置的流量通过云防火墙的方式"
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
      "domain",
      "group",
      "location",
      "net"
    ],
    "Description": {
      "en": "Security Access Control destination address type of policy.\nnet: Destination network segment (CIDR)\ngroup: destination address book\ndomain: The purpose domain\nlocation: The purpose area"
    },
    "Label": {
      "en": "DestinationType",
      "zh-cn": "安全访问控制策略中的目的地址类型"
    }
  }
  EOT
}

variable "direction" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "in",
      "out"
    ],
    "Description": {
      "en": "Security access control traffic direction policies.\nin: internal and external traffic access control\nout: within the flow of external access control"
    },
    "Label": {
      "en": "Direction",
      "zh-cn": "安全访问控制策略的流量方向"
    }
  }
  EOT
}

variable "source_4df508f0" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Security access control source address policy.\nWhen SourceType for the net, Source is the source CIDR. For example: 1.2.3.0/24\nWhen SourceType as a group, Source name for the source address book. For example: db_group\nWhen SourceType as location, Source source region (specific region position encoder see below). For example, [ \"BJ11\", \"ZB\"]"
    },
    "Label": {
      "en": "Source",
      "zh-cn": "安全访问控制策略中的源地址"
    },
    "MinLength": 1
  }
  EOT
}

variable "dest_port_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security access control policy access destination port traffic type.\nport: Port\ngroup: port address book"
    },
    "AllowedValues": [
      "group",
      "port"
    ],
    "Label": {
      "en": "DestPortType",
      "zh-cn": "安全访问控制策略中流量访问的目的端口类型"
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
      "ICMP",
      "TCP",
      "UDP"
    ],
    "Description": {
      "en": "The type of security protocol for traffic access in the security access control policy. Can be set to ANY when you are not sure of the specific protocol type.\nAllowed values: ANY, TCP, UDP, ICMP"
    },
    "Label": {
      "en": "Proto",
      "zh-cn": "安全访问控制策略中流量访问的安全协议类型"
    }
  }
  EOT
}

variable "repeat_end_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The repeated end time of the policy validity period for an access control policy. For example: 08:00, must be the hour or half time, and less than the repeat start time at least half an hour.\nNotes: When RepeatType is Permanent and None, RepeatEndTime is empty. When RepeatType is Daily, Weekly, or Monthly, RepeatEndTime musthave a value, and you need to set the repeat end time."
    },
    "Label": {
      "en": "RepeatEndTime",
      "zh-cn": "访问控制策略的策略有效期的重复结束时间"
    }
  }
  EOT
}

variable "domain_resolve_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The domain name resolution method of the access control policy. Value:\n- FQDN: Based on FQDN\n- DNS: Based on DNS dynamic resolution\n- FQDN_AND_DNS: Based on FQDN and DNS dynamic resolution"
    },
    "AllowedValues": [
      "FQDN",
      "DNS",
      "FQDN_AND_DNS"
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
      "en": "The repetition type of the policy validity period for an access control policy. Valid values:\n- Permanent (default)\n- None\n- Daily\n- Weekly\n- Monthly."
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
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "Number",
        "Description": {
          "en": "The repeated date of policy validity for an access control policy.\nNotes: When RepeatType is set to Weekly, it ranges from 0 to 6, with each week starting on Sunday. Range from 1 to 31 when RepeatType is set to Monthly."
        },
        "Required": false,
        "MinValue": 0,
        "MaxValue": 31
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "A collection of repeated dates of policy validity for an access control policy.\nWhen RepeatType is Permanent, None, and Daily, RepeatDays is an empty set. For example: []\nWhen RepeatType is Weekly, RepeatDays cannot be empty. Example: [0, 6]\nNotes: When RepeatType is set to Weekly, RepeatDays is not allowed.\nWhen RepeatType is Monthly, RepeatDays cannot be empty. Examples: [1, 31]\nNotes: When RepeatType is set to Monthly, RepeatDays is not allowed to repeat."
    },
    "Label": {
      "en": "RepeatDays",
      "zh-cn": "访问控制策略的策略有效期的重复日期集合"
    },
    "MinLength": 1,
    "MaxLength": 31
  }
  EOT
}

variable "region_id" {
  type        = string
  default     = "cn-hangzhou"
  description = <<EOT
  {
    "Description": {
      "en": "Region ID. Default to cn-hangzhou."
    },
    "AllowedValues": [
      "cn-hangzhou",
      "ap-southeast-1"
    ],
    "Label": {
      "en": "RegionId",
      "zh-cn": "地域"
    }
  }
  EOT
}

variable "repeat_start_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The repeated start time of the policy validity period for an access control policy. For example: 08:00, must be the hour or half time, and less than the repeat end time at least half an hour.\nNotes: When RepeatType is Permanent and None, RepeatStartTime is empty. When RepeatType is Daily, Weekly, or Monthly, RepeatStartTime must have a value, and you need to set the repeat start time."
    },
    "Label": {
      "en": "RepeatStartTime",
      "zh-cn": "访问控制策略的策略有效期的重复开始时间"
    }
  }
  EOT
}

variable "release" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The enabled state of the access control policy. This policy is enabled by default when it is created. Valid values:\n- true: Access control policy is enabled\n- false: Access control policy is not enabled"
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
      "en": "Security access control priority policy in force. Priority number increments sequentially from 1, lower the priority number, the higher the priority.\nDescription -1 indicates the lowest priority."
    },
    "MinValue": -1,
    "Label": {
      "en": "NewOrder",
      "zh-cn": "安全访问控制策略生效的优先级"
    }
  }
  EOT
}

variable "dest_port_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Security access control policy access traffic destination port address book name.\nDescription DestPortType is group, set the item."
    },
    "Label": {
      "en": "DestPortGroup",
      "zh-cn": "安全访问控制策略中流量访问的目的端口地址簿名称"
    }
  }
  EOT
}

resource "alicloud_cloud_firewall_control_policy" "control_policy" {
  destination      = var.destination
  description      = var.description
  application_name = var.application_name
  ip_version       = var.ip_version
  source_type      = var.source_type
  dest_port        = var.dest_port
  acl_action       = var.acl_action
  destination_type = var.destination_type
  direction        = var.direction
  source           = var.source_4df508f0
  dest_port_type   = var.dest_port_type
  proto            = var.proto
  dest_port_group  = var.dest_port_group
}

output "acl_uuid" {
  value       = alicloud_cloud_firewall_control_policy.control_policy.acl_uuid
  description = "Security access control ID that uniquely identifies the policy."
}

