variable "compress" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether it is compressed."
    },
    "Label": {
      "en": "Compress",
      "zh-cn": "是否压缩"
    }
  }
  EOT
}

variable "local_subnet" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Is the address segment that the client wants to access through an SSL-VPN connection.\nThe local network segment can be the network segment of the VPC, the network segment of the switch, the network segment of the IDC interconnected by the leased line and the VPC, and the network segment of the cloud service such as RDS/OSS."
    },
    "Label": {
      "en": "LocalSubnet",
      "zh-cn": "客户端通过SSL-VPN连接要访问的地址段"
    }
  }
  EOT
}

variable "client_ip_pool" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "It is the address segment that assigns the access address to the client virtual NIC. It does not refer to the existing intranet segment of the client.\nWhen the client accesses the local end through an SSL-VPN connection, the VPN gateway allocates an IP address to the client from the specified client network segment.\nThe network segment cannot conflict with the LocalSubnet address segment."
    },
    "Label": {
      "en": "ClientIpPool",
      "zh-cn": "给客户端虚拟网卡分配访问地址的地址段（不是指客户端已有的内网网段）"
    }
  }
  EOT
}

variable "idaasinstance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the IDaaS instance. "
    },
    "Label": {
      "en": "IDaaSInstanceId",
      "zh-cn": "IDaaS EIAM 实例 ID"
    }
  }
  EOT
}

variable "idaasapplication_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the IDaaS application. "
    },
    "Label": {
      "en": "IDaaSApplicationId",
      "zh-cn": "IDaaS 应用 ID"
    }
  }
  EOT
}

variable "proto" {
  type        = string
  default     = "UDP"
  description = <<EOT
  {
    "Description": {
      "en": "The protocol used by the SSL-VPN server. Allowed values: UDP (default) | TCP."
    },
    "AllowedValues": [
      "UDP",
      "TCP"
    ],
    "Label": {
      "en": "Proto",
      "zh-cn": "SSL-VPN服务端所使用的协议"
    }
  }
  EOT
}

variable "vpn_gateway_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ID of the VPN gateway."
    },
    "Label": {
      "en": "VpnGatewayId",
      "zh-cn": "VPN网关的ID"
    }
  }
  EOT
}

variable "enable_multi_factor_auth" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable multi-factor authentication. The default value is false. "
    },
    "Label": {
      "en": "EnableMultiFactorAuth",
      "zh-cn": "是否开启了双因子认证"
    }
  }
  EOT
}

variable "port" {
  type        = number
  default     = 1194
  description = <<EOT
  {
    "Description": {
      "en": "The port used by the SSL-VPN server. The default value is 1194. Cannot use the following ports:\n22, 2222, 22222, 9000, 9001, 9002, 7505, 80, 443, 53, 68, 123, 4510, 4560, 500, 4500"
    },
    "Label": {
      "en": "Port",
      "zh-cn": "SSL-VPN服务端所使用的端口"
    }
  }
  EOT
}

variable "idaasregion_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The region ID of the IDaaS instance. "
    },
    "Label": {
      "en": "IDaaSRegionId",
      "zh-cn": "IDaaS EIAM 实例所属地域 ID"
    }
  }
  EOT
}

variable "cipher" {
  type        = string
  default     = "AES-128-CBC"
  description = <<EOT
  {
    "Description": {
      "en": "The encryption algorithm used by SSL-VPN. Value:\nAES-128-CBC (default) | AES-192-CBC | AES-256-CBC | none"
    },
    "AllowedValues": [
      "AES-128-CBC",
      "AES-192-CBC",
      "AES-256-CBC",
      "none"
    ],
    "Label": {
      "en": "Cipher",
      "zh-cn": "SSL-VPN使用的加密算法"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the SSL-VPN server. The length is 2-128 characters and must start with a letter or Chinese. It can contain numbers, periods (.), underscores (_), and dashes (-).\nBut it can't start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "SSL-VPN服务端的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_ssl_vpn_server" "ssl_vpn_server" {
  compress       = var.compress
  local_subnet   = var.local_subnet
  client_ip_pool = var.client_ip_pool
  protocol       = var.proto
  vpn_gateway_id = var.vpn_gateway_id
  port           = var.port
  cipher         = var.cipher
  name           = var.name
}

output "ssl_vpn_server_id" {
  value       = alicloud_ssl_vpn_server.ssl_vpn_server.id
  description = "ID of the SSL-VPN server."
}

