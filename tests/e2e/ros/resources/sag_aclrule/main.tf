variable "policy" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "accept",
      "drop"
    ],
    "Description": {
      "en": "Access: accept|drop"
    },
    "Label": {
      "en": "Policy",
      "zh-cn": "访问控制规则授权策略"
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
      "en": "Rule description information, ranging from 1 to 512 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "访问控制规则描述信息"
    },
    "MinLength": 1,
    "MaxLength": 512
  }
  EOT
}

variable "source_port_range" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source port range, 80/80."
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
      "en": "Source address, CIDR format and IP address range in IPv4 format."
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
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Priority, ranging from 1 to 100.\nDefault: 1"
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "访问控制规则优先级"
    },
    "MaxValue": 100
  }
  EOT
}

variable "acl_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Access control ID."
    },
    "Label": {
      "en": "AclId",
      "zh-cn": "访问控制实例ID"
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
      "en": "Destination port range, 80/80."
    },
    "Label": {
      "en": "DestPortRange",
      "zh-cn": "目的端口范围"
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
      "en": "Regular direction.\nValue: in|out"
    },
    "Label": {
      "en": "Direction",
      "zh-cn": "访问控制规则应用方向"
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
      "en": "The name of the ACL rule.\nThe name must be 2 to 100 characters in length, and can contain digits, underscores\n(_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "访问控制规则的名称"
    }
  }
  EOT
}

variable "type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the ACL rule: Valid values:\nLAN: The ACL rule controls traffic of private IP addresses. This is the default value.\nWAN: The ACL rule controls traffic of public IP addresses."
    },
    "AllowedValues": [
      "LAN",
      "WAN"
    ],
    "Label": {
      "en": "Type",
      "zh-cn": "访问控制规则类型"
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
      "en": "Destination address, CIDR format and IP address range in IPv4 format."
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
      "zh-cn": "应用ID列表"
    },
    "MaxLength": 100
  }
  EOT
}

variable "ip_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Protocol, not case sensitive."
    },
    "Label": {
      "en": "IpProtocol",
      "zh-cn": "访问控制规则应用的协议"
    }
  }
  EOT
}

resource "alicloud_sag_acl_rule" "aclrule" {
  policy            = var.policy
  description       = var.description
  source_port_range = var.source_port_range
  source_cidr       = var.source_cidr
  priority          = var.priority
  acl_id            = var.acl_id
  dest_port_range   = var.dest_port_range
  direction         = var.direction
  dest_cidr         = var.dest_cidr
  ip_protocol       = var.ip_protocol
}

output "acr_id" {
  value       = alicloud_sag_acl_rule.aclrule.id
  description = "Access control rule ID."
}

