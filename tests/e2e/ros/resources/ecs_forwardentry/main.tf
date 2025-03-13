variable "external_port" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source port, now support [1-65535]|Any|x/y"
    },
    "Label": {
      "zh-cn": "公网端口"
    }
  }
  EOT
}

variable "external_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Source IP, must belongs to bandwidth package internet IP"
    },
    "Label": {
      "zh-cn": "公网IP地址"
    }
  }
  EOT
}

variable "ip_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "TCP",
      "UDP",
      "Any"
    ],
    "Description": {
      "en": "Supported protocol, Now support 'TCP|UDP|Any'"
    },
    "Label": {
      "zh-cn": "协议类型"
    }
  }
  EOT
}

variable "port_break" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to remove limits on the port range."
    },
    "Label": {
      "zh-cn": "是否开启端口突破"
    }
  }
  EOT
}

variable "internal_port" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Destination port, now support [1-65535]|Any|x/y"
    },
    "Label": {
      "zh-cn": "私网端口"
    }
  }
  EOT
}

variable "forward_entry_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "the name of the DNAT rule is 2-128 characters long and must start with a letter or Chinese, but cannot begin with HTTP:// or https://."
    },
    "Label": {
      "zh-cn": "DNAT规则的名称"
    }
  }
  EOT
}

variable "internal_ip" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Destination IP, must belong to VPC private IP"
    },
    "Label": {
      "zh-cn": "私网IP地址"
    }
  }
  EOT
}

variable "forward_table_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Create forward entry in specified forward table."
    },
    "Label": {
      "zh-cn": "DNAT表的ID"
    }
  }
  EOT
}

resource "alicloud_forward_entry" "forward_table_entry" {
  external_port      = var.external_port
  external_ip        = var.external_ip
  ip_protocol        = var.ip_protocol
  port_break         = var.port_break
  internal_port      = var.internal_port
  forward_entry_name = var.forward_entry_name
  internal_ip        = var.internal_ip
  forward_table_id   = var.forward_table_id
}

output "forward_entry_id" {
  value       = alicloud_forward_entry.forward_table_entry.id
  description = "The id of created forward entry."
}

