variable "ca_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to open CA"
    },
    "Label": {
      "en": "CaEnabled",
      "zh-cn": "是否开启双向认证"
    }
  }
  EOT
}

variable "listener_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Port of the listener,[0, 65535] the portRange setting need 0"
    },
    "MinValue": 0,
    "Label": {
      "en": "ListenerPort",
      "zh-cn": "负载均衡实例前端使用的端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "start_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "StartPort of the portRange"
    },
    "MinValue": 0,
    "Label": {
      "en": "StartPort",
      "zh-cn": "监听的起始端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "cps" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "New connection rate limit of Instance"
    },
    "MinValue": 0,
    "Label": {
      "en": "Cps",
      "zh-cn": "每秒新建连接数"
    },
    "MaxValue": 1000000
  }
  EOT
}

variable "server_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NLB::ServerGroup::ServerGroupId",
    "Description": {
      "en": "ID of the ServerGroup"
    },
    "Label": {
      "en": "ServerGroupId",
      "zh-cn": "转发到的目的服务器组ID"
    }
  }
  EOT
}

variable "idle_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the connection idle timeout"
    },
    "MinValue": 1,
    "Label": {
      "en": "IdleTimeout",
      "zh-cn": "指定连接空闲超时时间"
    },
    "MaxValue": 900
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NLB::LoadBalancer::LoadBalancerId",
    "Description": {
      "en": "ID of the LoadBalancer"
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "负载均衡实例ID"
    }
  }
  EOT
}

variable "proxy_protocol_v2_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Ppv2VpcIdEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable Proxy Protocol to carry VpcId to the back-end server. Default False."
          },
          "Required": false
        },
        "Ppv2PrivateLinkEpsIdEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable Proxy Protocol to carry PrivateLinkEpsId to the back-end server. Default: False."
          },
          "Required": false
        },
        "Ppv2PrivateLinkEpIdEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable Proxy Protocol to carry Ppv2PrivateLinkEpId to the back-end server. Default False."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "ProxyProtocolV2Config of the listener"
    },
    "Label": {
      "en": "ProxyProtocolV2Config",
      "zh-cn": "通过 Proxy Protocol 协议携带 VpcId、PrivateLinkEpId、PrivateLinkEpsId 信息到后端服务器配置"
    }
  }
  EOT
}

variable "mss" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Max length of the TCP packet"
    },
    "MinValue": 0,
    "Label": {
      "en": "Mss",
      "zh-cn": "MSS自动协商"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "listener_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "TCP",
      "UDP",
      "TCPSSL"
    ],
    "Label": {
      "en": "ListenerProtocol",
      "zh-cn": "负载均衡实例前端使用的协议"
    }
  }
  EOT
}

variable "security_policy_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NLB::SecurityPolicy::SecurityPolicyId",
    "Description": {
      "en": "Only valid for TcpSSL protocol monitoring"
    },
    "Label": {
      "en": "SecurityPolicyId",
      "zh-cn": "安全策略ID"
    }
  }
  EOT
}

variable "listener_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of the listener, [2, 256] characters."
    },
    "Label": {
      "en": "ListenerDescription",
      "zh-cn": "设置监听的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "alpn_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Proxy of alpn"
    },
    "Label": {
      "en": "AlpnPolicy",
      "zh-cn": "Alpn代理"
    }
  }
  EOT
}

variable "ca_certificate_ids" {
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
      "en": "List of the ca certificate ids"
    },
    "Label": {
      "en": "CaCertificateIds",
      "zh-cn": "CA签名证书ID"
    },
    "MinLength": 0,
    "MaxLength": 1
  }
  EOT
}

variable "end_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "EndPort of the portRange"
    },
    "MinValue": 0,
    "Label": {
      "en": "EndPort",
      "zh-cn": "监听的终止端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "proxy_protocol_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable ppv2 function"
    },
    "Label": {
      "en": "ProxyProtocolEnabled",
      "zh-cn": "是否启用ppv2代理"
    }
  }
  EOT
}

variable "certificate_ids" {
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
      "en": "List of the certificate ids"
    },
    "Label": {
      "en": "CertificateIds",
      "zh-cn": "签名证书ID"
    },
    "MinLength": 0,
    "MaxLength": 1
  }
  EOT
}

variable "sec_sensor_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable the second-level monitoring function"
    },
    "Label": {
      "en": "SecSensorEnabled",
      "zh-cn": "是否启用二级监控"
    }
  }
  EOT
}

variable "enable" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to start listener or not. Default True."
    },
    "Label": {
      "en": "Enable",
      "zh-cn": "是否启用监听"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "alpn_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Label": {
      "en": "AlpnEnabled",
      "zh-cn": "是否启用Alpn代理"
    }
  }
  EOT
}

resource "alicloud_nlb_listener" "extension_resource" {
  ca_enabled             = var.ca_enabled
  listener_port          = var.listener_port
  start_port             = var.start_port
  cps                    = var.cps
  server_group_id        = var.server_group_id
  idle_timeout           = var.idle_timeout
  load_balancer_id       = var.load_balancer_id
  mss                    = var.mss
  listener_protocol      = var.listener_protocol
  security_policy_id     = var.security_policy_id
  listener_description   = var.listener_description
  alpn_policy            = var.alpn_policy
  ca_certificate_ids     = var.ca_certificate_ids
  end_port               = var.end_port
  proxy_protocol_enabled = var.proxy_protocol_enabled
  certificate_ids        = var.certificate_ids
  sec_sensor_enabled     = var.sec_sensor_enabled
  tags                   = var.tags
  alpn_enabled           = var.alpn_enabled
}

output "listener_port" {
  value       = alicloud_nlb_listener.extension_resource.listener_port
  description = "ListenerPort of created Listener"
}

output "listener_id" {
  value       = alicloud_nlb_listener.extension_resource.id
  description = "Id of created Listener"
}

