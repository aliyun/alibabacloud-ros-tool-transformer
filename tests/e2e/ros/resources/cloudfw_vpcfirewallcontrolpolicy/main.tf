variable "destination" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The destination address in the access control policy.\nSet this parameter in the following way:\nIf the DestinationType parameter is set to net, set the value to a Classless Inter-Domain Routing (CIDR) block.\nExample: 10.2.3.0/24.\nIf the DestinationType parameter is set to group, set the value to the name of an address book.\nExample: db_group.\nIf the DestinationType parameter is set to domain, set the value to a domain name.\nExample: *.aliyuncs.com."
    },
    "Label": {
      "en": "Destination",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的目的地址"
    }
  }
  EOT
}

variable "application_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The application type that the access control policy supports.\nValid values: \nANY (indicates that all application types are supported) \nFTP \nHTTP \nHTTPS \nMySQL \nSMTP \nSMTPS \nRDP \nVNC \nSSH \nRedis \nMQTT \nMongoDB \nMemcache \nSSL"
    },
    "AllowedValues": [
      "ANY",
      "FTP",
      "HTTP",
      "HTTPS",
      "MySQL",
      "SMTP",
      "SMTPS",
      "RDP",
      "VNC",
      "SSH",
      "Redis",
      "MQTT",
      "MongoDB",
      "Memcache",
      "SSL"
    ],
    "Label": {
      "en": "ApplicationName",
      "zh-cn": "VPC边界防火墙访问控制策略支持的应用类型"
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
      "zh-cn": "VPC边界防火墙访问控制策略的描述信息"
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

variable "member_uid" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Member account UID of current Alibaba Cloud account."
    },
    "Label": {
      "en": "MemberUid",
      "zh-cn": "云防火墙成员账号的 UID"
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
      "net"
    ],
    "Description": {
      "en": "The type of the source address in the access control policy. Valid values:\nnet: CIDR block\ngroup: address book"
    },
    "Label": {
      "en": "SourceType",
      "zh-cn": "VPC边界防火墙访问控制策略中的源地址类型"
    }
  }
  EOT
}

variable "dest_port" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The destination port in the access control policy.\nNote This parameter must be specified if the DestPortType parameter is set to port."
    },
    "Label": {
      "en": "DestPort",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的目的端口"
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
          "en": "The application type that the access control policy supports.\nValid values: \nANY (indicates that all application types are supported) \nFTP \nHTTP \nHTTPS \nMySQL \nSMTP \nSMTPS \nRDP \nVNC \nSSH \nRedis \nMQTT \nMongoDB \nMemcache \nSSL.\nNote: There is a dependency between the supported application type and the Proto value. Proto with TCP, ApplicationNameList supports selecting all of the above application types using [\"HTTP\",\"HTTPS\",...] Format representation; When Proto is UDP, ICMP, or ANY protocol type, ApplicationNameList only supports selecting ANY. Either ApplicationNameList or ApplicationName must be passed, not both. When both ApplicationNameList and ApplicationName are passed, ApplicationNameList takes precedence."
        },
        "AllowedValues": [
          "ANY",
          "FTP",
          "HTTP",
          "HTTPS",
          "MySQL",
          "SMTP",
          "SMTPS",
          "RDP",
          "VNC",
          "SSH",
          "Redis",
          "MQTT",
          "MongoDB",
          "Memcache",
          "SSL"
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
      "en": "The action that Cloud Firewall performs on the traffic. Valid values:\naccept: allows the traffic.\ndrop: denies the traffic.\nlog: monitors the traffic."
    },
    "Label": {
      "en": "AclAction",
      "zh-cn": "VPC边界防火墙访问控制策略中设置的流量通过云防火墙的方式（动作）"
    }
  }
  EOT
}

variable "lang" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The natural language of the request and response. Valid values:\nzh: Chinese\nen: English"
    },
    "AllowedValues": [
      "en",
      "zh"
    ],
    "Label": {
      "en": "Lang",
      "zh-cn": "请求和接收消息的语言类型"
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
      "net"
    ],
    "Description": {
      "en": "The type of the destination address in the access control policy. Valid values:\nnet: CIDR block\ngroup: address book\ndomain: domain name"
    },
    "Label": {
      "en": "DestinationType",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的目的地址类型"
    }
  }
  EOT
}

variable "vpc_firewall_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the policy group to which you want to add the access control policy.\nIf the VPC firewall is used to protect CEN, set the value to the ID of the CEN instance\nthat the VPC firewall protects. Example: cen-ervw5jbw1234*****.\nIf the VPC firewall is used to protect Express Connect, set the value to the ID of\nthe VPC firewall instance. Example: vfw-a42bbb748c91234*****.\nNote You can call the DescribeVpcFirewallAclGroupList operation to query the ID of the policy group."
    },
    "Label": {
      "en": "VpcFirewallId",
      "zh-cn": "VPC边界防火墙访问控制策略组ID"
    }
  }
  EOT
}

variable "source_6a5721c9" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source address in the access control policy.\nIf the SourceType parameter is set to net, set the value to a CIDR block. Example: 10.2.3.0/24.\nIf the SourceType parameter is set to group, set the value to the name of an address book. Example: db_group."
    },
    "Label": {
      "en": "Source",
      "zh-cn": "VPC边界防火墙访问控制策略中的源地址"
    }
  }
  EOT
}

variable "dest_port_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the destination port in the access control policy. Valid values:\nport: port\ngroup: address book"
    },
    "AllowedValues": [
      "group",
      "port"
    ],
    "Label": {
      "en": "DestPortType",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的目的端口类型"
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
      "en": "The type of the security protocol in the access control policy."
    },
    "Label": {
      "en": "Proto",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的安全协议类型"
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
      "zh-cn": "地域ID"
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
      "en": "The enabled state of the access control policy. This policy is enabled by default when it is created. Value:\n- true: Access control policy is enabled\n- false: Access control policy is not enabled"
    },
    "Label": {
      "en": "Release",
      "zh-cn": "访问控制策略的启用状态"
    }
  }
  EOT
}

variable "new_order" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the access control policy.\nThe priority value starts from 1. A smaller priority value indicates a higher priority.\nNote The value of -1 indicates the lowest priority."
    },
    "Label": {
      "en": "NewOrder",
      "zh-cn": "VPC边界防火墙访问控制策略生效的优先级"
    }
  }
  EOT
}

variable "dest_port_group" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The address book of destination ports in the access control policy.\nNote This parameter must be specified if the DestPortType parameter is set to group."
    },
    "Label": {
      "en": "DestPortGroup",
      "zh-cn": "VPC边界防火墙访问控制策略中流量访问的目的端口地址簿名称"
    }
  }
  EOT
}

resource "alicloud_cloud_firewall_vpc_firewall_control_policy" "vpc_firewall_control_policy" {
  destination      = var.destination
  application_name = var.application_name
  description      = var.description
  member_uid       = var.member_uid
  source_type      = var.source_type
  dest_port        = var.dest_port
  acl_action       = var.acl_action
  lang             = var.lang
  destination_type = var.destination_type
  vpc_firewall_id  = var.vpc_firewall_id
  source           = var.source_6a5721c9
  dest_port_type   = var.dest_port_type
  proto            = var.proto
  release          = var.release
  dest_port_group  = var.dest_port_group
}

output "acl_uuid" {
  value       = alicloud_cloud_firewall_vpc_firewall_control_policy.vpc_firewall_control_policy.acl_uuid
  description = "The unique ID of the access control policy."
}

