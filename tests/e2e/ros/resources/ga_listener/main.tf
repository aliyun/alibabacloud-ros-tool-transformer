variable "security_policy_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the security policy. Valid values:\ntls_cipher_policy_1_0\ntls_cipher_policy_1_1\ntls_cipher_policy_1_2\ntls_cipher_policy_1_2_strict\ntls_cipher_policy_1_2_strict_with_1_3\nNote Only HTTPS listeners support this parameter."
    },
    "Label": {
      "en": "SecurityPolicyId",
      "zh-cn": "安全策略实例ID"
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
      "en": "The description of the listener."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "监听的描述信息"
    }
  }
  EOT
}

variable "proxy_protocol" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to preserve client IP addresses. Valid values:\ntrue: preserves client IP addresses. After this feature is enabled, backend servers can retrieve client IP addresses.\nfalse (default): does not preserve client IP addresses."
    },
    "Label": {
      "en": "ProxyProtocol",
      "zh-cn": "是否开启保持客户端源IP功能"
    }
  }
  EOT
}

variable "port_ranges" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "FromPort": {
          "Type": "Number",
          "Description": {
            "en": "The first listening port of the port range specified for receiving and forwarding\nrequests to endpoints."
          },
          "Required": true
        },
        "ToPort": {
          "Type": "Number",
          "Description": {
            "en": "The last listening port of the port range specified for receiving and forwarding requests\nto endpoints."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "PortRanges",
      "zh-cn": "监听端口"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "certificates" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Id": {
          "Type": "String",
          "Description": {
            "en": "The ID of the SSL certificate."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Certificates",
      "zh-cn": "SSL证书"
    },
    "MaxLength": 1
  }
  EOT
}

variable "xforwarded_for_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "XForwardedForGaApEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the GA-AP header to retrieve the information about the acceleration area. Valid values:\ntrue: yes\nfalse (default): no\nNote Only HTTP and HTTPS listeners support this parameter."
          },
          "Required": false,
          "Default": "false"
        },
        "XForwardedForProtoEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the GA-X-Forward-Proto header to retrieve the listener protocol of the GA instance. Valid values:\ntrue: yes\nfalse (default): no\nNote Only HTTP and HTTPS listeners support this parameter."
          },
          "Required": false,
          "Default": "false"
        },
        "XRealIpEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Real-IP header to retrieve client IP addresses. Valid values:\ntrue: yes\nfalse (default): no\nNote Only HTTP and HTTPS listeners support this parameter."
          },
          "Required": false,
          "Default": "false"
        },
        "XForwardedForPortEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the GA-X-Forward-Port header to retrieve the listener ports of the GA instance. Valid values:\ntrue: yes\nfalse (default): no\nNote Only HTTP and HTTPS listeners support this parameter."
          },
          "Required": false,
          "Default": "false"
        },
        "XForwardedForGaIdEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the GA-ID header to retrieve the ID of the GA instance. Valid values:\ntrue: yes\nfalse (default): no\nNote Only HTTP and HTTPS listeners support this parameter."
          },
          "Required": false,
          "Default": "false"
        }
      }
    },
    "Description": {
      "en": "The configuration of the XForward field."
    },
    "Label": {
      "en": "XForwardedForConfig",
      "zh-cn": "XForward字段配置信息"
    }
  }
  EOT
}

variable "protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "tcp",
      "udp",
      "http",
      "https"
    ],
    "Description": {
      "en": "The network transmission protocol of the listener. Valid values:\ntcp: TCP protocol\nudp: UDP protocol\nhttp: HTTP protocolhttps: HTTPS protocol."
    },
    "Label": {
      "en": "Protocol",
      "zh-cn": "监听的网络传输协议类型"
    }
  }
  EOT
}

variable "accelerator_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Global Accelerator instance to which the listener will be added."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "全球加速实例ID"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the listener.\nThe name must be 2 to 128 characters in length and can contain letters, digits, underscores\n(_), and hyphens (-). It must start with a letter or Chinese character."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "监听的名称"
    }
  }
  EOT
}

variable "client_affinity" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable client affinity for the listener.\nIf you do not specify the default value in the parameter, client affinity is disabled.\nWhen client affinity is disabled, the connections from a specific source (client)\nIP address are not always routed to the same endpoint.\nIf you set the value to SOURCE_IP, client affinity is enabled. When client affinity is enabled, the connections from\na specific source (client) IP address are always routed to the same endpoint."
    },
    "AllowedValues": [
      "NONE",
      "SOURCE_IP"
    ],
    "Label": {
      "en": "ClientAffinity",
      "zh-cn": "客户端亲和性"
    }
  }
  EOT
}

resource "alicloud_ga_listener" "listener" {
  security_policy_id = var.security_policy_id
  description        = var.description
  proxy_protocol     = var.proxy_protocol
  port_ranges        = var.port_ranges
  certificates       = var.certificates
  protocol           = var.protocol
  accelerator_id     = var.accelerator_id
  name               = var.name
  client_affinity    = var.client_affinity
}

output "listener_id" {
  value       = alicloud_ga_listener.listener.id
  description = "The ID of the listener."
}

