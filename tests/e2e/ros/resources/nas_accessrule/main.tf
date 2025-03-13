variable "user_access_type" {
  type        = string
  default     = "no_squash"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "User permission type: no_squash (default), root_squash, all_squash"
    },
    "AllowedValues": [
      "no_squash",
      "root_squash",
      "all_squash"
    ],
    "Label": {
      "en": "UserAccessType",
      "zh-cn": "用户权限类型"
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
      "en": "Priority level. Range: 1-100. Default value: 1"
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "优先级"
    },
    "MaxValue": 100
  }
  EOT
}

variable "file_system_type" {
  type        = string
  default     = "standard"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NasFileSystemType"
    },
    "Description": {
      "en": "The type of file system. Values:\nstandard: the general NAS\nextreme: the extreme NAS"
    },
    "AllowedValues": [
      "standard",
      "extreme"
    ],
    "Label": {
      "en": "FileSystemType",
      "zh-cn": "文件系统类型"
    }
  }
  EOT
}

variable "source_cidr_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Address or address segment"
    },
    "Label": {
      "en": "SourceCidrIp",
      "zh-cn": "地址或地址段"
    }
  }
  EOT
}

variable "access_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Permission group name"
    },
    "Label": {
      "en": "AccessGroupName",
      "zh-cn": "权限组名称"
    }
  }
  EOT
}

variable "ipv6_source_cidr_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Source IPv6 CIDR address segment. IP addresses in CIDR format and IPv6 format are supported.\nCurrently, only the ultra-fast NAS in mainland China supports the IPv6 function, and the file system needs to enable the IPv6 function.\nOnly VPC private network is supported.\nIPv4 and IPv6 are mutually exclusive, and the types cannot be converted."
    },
    "Label": {
      "en": "Ipv6SourceCidrIp",
      "zh-cn": "源端IPv6 CIDR地址段"
    }
  }
  EOT
}

variable "rwaccess_type" {
  type        = string
  default     = "RDWR"
  description = <<EOT
  {
    "Description": {
      "en": "Read-write permission type: RDWR (default), RDONLY"
    },
    "AllowedValues": [
      "RDWR",
      "RDONLY"
    ],
    "Label": {
      "en": "RWAccessType",
      "zh-cn": "读写权限类型"
    }
  }
  EOT
}

resource "alicloud_nas_access_rule" "access_rule" {
  user_access_type    = var.user_access_type
  priority            = var.priority
  file_system_type    = var.file_system_type
  source_cidr_ip      = var.source_cidr_ip
  access_group_name   = var.access_group_name
  ipv6_source_cidr_ip = var.ipv6_source_cidr_ip
  rw_access_type      = var.rwaccess_type
}

output "access_rule_id" {
  value       = alicloud_nas_access_rule.access_rule.access_rule_id
  description = "Rule serial number"
}

