variable "backend_port" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The port of the origin server. Valid values: 0 to 65535."
    },
    "Label": {
      "en": "BackendPort",
      "zh-cn": "源站端口"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Anti-DDoS Pro or Anti-DDoS Premium instance to which the port forwarding rule belongs."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "端口转发规则所属的DDoS高防实例的ID"
    }
  }
  EOT
}

variable "real_servers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The IP address of the origin server."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "An array that consists of the IP addresses of origin servers."
    },
    "Label": {
      "en": "RealServers",
      "zh-cn": "源站IP地址列表"
    },
    "MinLength": 0,
    "MaxLength": 20
  }
  EOT
}

variable "frontend_port" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The forwarding port. Valid values: 0 to 65535."
    },
    "Label": {
      "en": "FrontendPort",
      "zh-cn": "转发端口"
    }
  }
  EOT
}

variable "frontend_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "tcp",
      "udp"
    ],
    "Description": {
      "en": "The type of the protocol. Valid values: \ntcp\nudp"
    },
    "Label": {
      "en": "FrontendProtocol",
      "zh-cn": "转发协议类型"
    }
  }
  EOT
}

resource "alicloud_ddoscoo_port" "extension_resource" {
  backend_port      = var.backend_port
  instance_id       = var.instance_id
  real_servers      = var.real_servers
  frontend_port     = var.frontend_port
  frontend_protocol = var.frontend_protocol
}

output "frontend_port" {
  value       = alicloud_ddoscoo_port.extension_resource.frontend_port
  description = "The forwarding port."
}

