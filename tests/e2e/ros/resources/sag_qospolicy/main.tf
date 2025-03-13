variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the traffic classification rule.\nThe description must be 1 to 512 characters in length and can contain letters, digits,\nunderscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "规则的描述信息"
    }
  }
  EOT
}

variable "end_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the traffic classification rule becomes invalid.\nSpecify the time in the ISO 8601 standard in the YYYY-MM-DDThh:mm:ss+0800 format.\nThe time must be in UTC+8."
    },
    "Label": {
      "en": "EndTime",
      "zh-cn": "规则生效的结束时间"
    }
  }
  EOT
}

variable "source_port_range" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The range of source ports.\nValid values: 1 to 65535 and -1.\nSet this parameter in one of the following formats:\n1/200: a port range from 1 to 200\n80/80: port 80\n-1/-1: all ports"
    },
    "Label": {
      "en": "SourcePortRange",
      "zh-cn": "源端口范围"
    }
  }
  EOT
}

variable "source_cidr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The range of the source IP addresses.\nSpecify the value of this parameter in CIDR notation. Example: 192.168.1.0/24."
    },
    "Label": {
      "en": "SourceCidr",
      "zh-cn": "源网段"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the traffic throttling policy to which the traffic classification\nrule belongs."
    },
    "Label": {
      "en": "Priority",
      "zh-cn": "规则所属的限速规则优先级"
    }
  }
  EOT
}

variable "start_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the traffic classification rule takes effect.\nSpecify the time in the ISO 8601 standard in the YYYY-MM-DDThh:mm:ss+0800 format.\nThe time must be in UTC+8."
    },
    "Label": {
      "en": "StartTime",
      "zh-cn": "规则生效的开始时间"
    }
  }
  EOT
}

variable "dest_port_range" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The range of destination ports.\nValid values: 1 to 65535 and -1.\nSet this parameter in one of the following formats:\n1/200: a port range from 1 to 200\n80/80: port 80\n-1/-1: all ports"
    },
    "Label": {
      "en": "DestPortRange",
      "zh-cn": "目的端口范围"
    }
  }
  EOT
}

variable "dpi_group_ids" {
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
      "en": "The ID of the application group.\nYou can enter at most 100 application group IDs at a time.\nYou can call the ListDpiGroups operation to query application group IDs and information about the applications."
    },
    "Label": {
      "en": "DpiGroupIds",
      "zh-cn": "应用组ID"
    },
    "MaxLength": 100
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the traffic classification rule.\nThe name must be 2 to 100 characters in length, and can contain digits, underscores\n(_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "规则的名称"
    }
  }
  EOT
}

variable "dest_cidr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The range of the destination IP addresses.\nSpecify the value of this parameter in CIDR notation. Example: 192.168.10.0/24."
    },
    "Label": {
      "en": "DestCidr",
      "zh-cn": "目的网段"
    }
  }
  EOT
}

variable "dpi_signature_ids" {
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
      "en": "The ID of the application.\nYou can enter at most 100 application IDs at a time.\nYou can call the ListDpiSignatures operation to query application IDs and information about the applications."
    },
    "Label": {
      "en": "DpiSignatureIds",
      "zh-cn": "应用ID"
    },
    "MaxLength": 100
  }
  EOT
}

variable "qos_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the QoS policy."
    },
    "Label": {
      "en": "QosId",
      "zh-cn": "QoS策略的实例ID"
    }
  }
  EOT
}

variable "ip_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the protocol that applies to the traffic classification rule.\nThe supported protocols provided in this topic are for reference only. The actual\nprotocols in the console shall prevail."
    },
    "Label": {
      "en": "IpProtocol",
      "zh-cn": "规则应用的协议类型"
    }
  }
  EOT
}

resource "alicloud_sag_qos_policy" "qos_policy" {
  description       = var.description
  end_time          = var.end_time
  source_port_range = var.source_port_range
  source_cidr       = var.source_cidr
  priority          = var.priority
  start_time        = var.start_time
  dest_port_range   = var.dest_port_range
  name              = var.name
  dest_cidr         = var.dest_cidr
  qos_id            = var.qos_id
  ip_protocol       = var.ip_protocol
}

output "qos_policy_id" {
  value       = alicloud_sag_qos_policy.qos_policy.id
  description = "The ID of the traffic classification rule."
}

