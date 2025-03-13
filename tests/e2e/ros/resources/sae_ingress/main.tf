variable "default_rule" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "BackendProtocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol of the application."
          },
          "AllowedValues": [
            "http",
            "https",
            "grpc"
          ],
          "Required": false
        },
        "AppId": {
          "Type": "String",
          "Description": {
            "en": "The application ID"
          },
          "Required": true
        },
        "ContainerPort": {
          "Type": "Number",
          "Description": {
            "en": "The container port of the application."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 65535
        }
      }
    },
    "Description": {
      "en": "The default forwarding rule. You can specify a port and an application in the default forwarding rule to forward traffic based on the IP address of the application. "
    },
    "Label": {
      "en": "DefaultRule",
      "zh-cn": "默认转发规则"
    }
  }
  EOT
}

variable "slb_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Server Load Balancer (SLB) instance that is used by the routing rule."
    },
    "Label": {
      "en": "SlbId",
      "zh-cn": "路由规则所使用的SLB"
    }
  }
  EOT
}

variable "listener_port" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The listener port of the SLB instance. You must specify a vacant port."
    },
    "MinValue": 0,
    "Label": {
      "en": "ListenerPort",
      "zh-cn": "SLB监听端口"
    },
    "MaxValue": 65535
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
      "en": "The name of the routing rule."
    },
    "AllowedPattern": "^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9])?$",
    "Label": {
      "en": "Description",
      "zh-cn": "路由规则名称"
    }
  }
  EOT
}

variable "cert_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of the certificates that are associated with the Application Load Balancer (ALB) instance."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the certificates that are associated with the Application Load Balancer (ALB) instance."
    },
    "Label": {
      "en": "CertIds",
      "zh-cn": "ALB多证书ID"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "cert_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the certificate that is associated with the Classic Load Balancer (CLB) instance.\nIf LoadBalanceType is set to clb, specify this parameter to configure a certificate for the HTTP listener."
    },
    "Label": {
      "en": "CertId",
      "zh-cn": "CLB证书ID"
    }
  }
  EOT
}

variable "load_balance_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the SLB instance based on the processing capabilities. The instance type can be specified only when you create a routing rule. You cannot change the instance type when you update the routing rule."
    },
    "Label": {
      "en": "LoadBalanceType",
      "zh-cn": "负载均衡SLB的类型"
    }
  }
  EOT
}

variable "namespace_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the namespace to which the application belongs. You can specify only one namespace ID each time you call this operation."
    },
    "Label": {
      "en": "NamespaceId",
      "zh-cn": "应用所在命名空间ID"
    }
  }
  EOT
}

variable "listener_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol that is used to forward requests."
    },
    "AllowedValues": [
      "HTTP",
      "HTTPS"
    ],
    "Label": {
      "en": "ListenerProtocol",
      "zh-cn": "请求转发协议"
    }
  }
  EOT
}

variable "rules" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Path": {
          "Type": "String",
          "Description": {
            "en": "The request path."
          },
          "Required": true
        },
        "BackendProtocol": {
          "Type": "String",
          "Description": {
            "en": "The protocol of the application."
          },
          "AllowedValues": [
            "http",
            "https",
            "grpc"
          ],
          "Required": false
        },
        "AppId": {
          "Type": "String",
          "Description": {
            "en": "The application ID"
          },
          "Required": true
        },
        "RewritePath": {
          "Type": "String",
          "Description": {
            "en": "The rewrite path."
          },
          "Required": false
        },
        "ContainerPort": {
          "Type": "Number",
          "Description": {
            "en": "The container port of the application."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 65535
        },
        "Domain": {
          "Type": "String",
          "Description": {
            "en": "The domain name."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The forwarding rules. You can specify a port and an application in a forwarding rule to forward traffic based on the specified domain name and request path."
    },
    "Label": {
      "en": "Rules",
      "zh-cn": "转发规则"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

resource "alicloud_sae_ingress" "ingress" {
  slb_id            = var.slb_id
  listener_port     = var.listener_port
  description       = var.description
  cert_id           = var.cert_id
  load_balance_type = var.load_balance_type
  namespace_id      = var.namespace_id
  listener_protocol = var.listener_protocol
  rules             = var.rules
}

output "ingress_id" {
  value       = alicloud_sae_ingress.ingress.id
  description = "The ID of the routing rule."
}

