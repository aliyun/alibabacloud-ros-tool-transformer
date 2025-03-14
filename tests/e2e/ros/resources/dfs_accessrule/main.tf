variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The Description of the Access Rule."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "权限组规则的描述信息"
    }
  }
  EOT
}

variable "priority" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The Priority of the Access Rule. Valid values: 1 to 100. \nNOTE: When multiple rules are matched by the same authorized object, \nthe high-priority rule takes effect. 1 is the highest priority."
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "权限组规则优先级"
    },
    "MaxValue": 100
  }
  EOT
}

variable "network_segment" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The NetworkSegment of the Access Rule."
    },
    "Label": {
      "en": "NetworkSegment",
      "zh-cn": "授权对象的IP地址或网段"
    },
    "MaxLength": 100
  }
  EOT
}

variable "access_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The resource ID of Access Group."
    },
    "Label": {
      "en": "AccessGroupId",
      "zh-cn": "权限组ID"
    }
  }
  EOT
}

variable "rwaccess_type" {
  type        = string
  default     = "RDWR"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The read/write permission of the authorized object on the file system.\nValues:\nRDWR (default) : read and write.\nRDONLY: read-only"
    },
    "AllowedValues": [
      "RDWR",
      "RDONLY"
    ],
    "Label": {
      "en": "RWAccessType",
      "zh-cn": "授权对象对文件系统的读写权限"
    }
  }
  EOT
}

resource "alicloud_dfs_access_rule" "access_rule" {
  description     = var.description
  priority        = var.priority
  network_segment = var.network_segment
  access_group_id = var.access_group_id
}

output "access_rule_id" {
  value       = alicloud_dfs_access_rule.access_rule.id
  description = "The ID of the access_rule."
}

