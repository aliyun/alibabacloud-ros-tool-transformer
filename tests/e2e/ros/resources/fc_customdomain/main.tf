variable "api_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "api version"
    },
    "Label": {
      "en": "ApiVersion",
      "zh-cn": "API版本"
    }
  }
  EOT
}

variable "cert_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "PrivateKey": {
          "Type": "String",
          "Description": {
            "en": "private key"
          },
          "Required": true
        },
        "CertName": {
          "Type": "String",
          "Description": {
            "en": "custom certificate name"
          },
          "Required": true
        },
        "Certificate": {
          "Type": "String",
          "Description": {
            "en": "certificate"
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "certificate info"
    },
    "Label": {
      "en": "CertConfig",
      "zh-cn": "证书信息"
    }
  }
  EOT
}

variable "domain_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "domain name"
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "域名"
    }
  }
  EOT
}

variable "route_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Routes": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Path": {
                "Type": "String",
                "Description": {
                  "en": "HTTP request path when a function is called with a custom domain name, for example: \"/login/*\""
                },
                "Required": true,
                "Label": {
                  "zh-cn": "请求路径"
                }
              },
              "FunctionName": {
                "Type": "String",
                "Description": {
                  "en": "Path to the function, for example: \"login\""
                },
                "Required": true,
                "Label": {
                  "zh-cn": "函数名称"
                }
              },
              "ServiceName": {
                "Type": "String",
                "Description": {
                  "en": "Path to the service, for example: \"blogService\""
                },
                "Required": true,
                "Label": {
                  "zh-cn": "服务名称"
                }
              },
              "Qualifier": {
                "Type": "String",
                "Description": {
                  "en": "Service version or alias"
                },
                "Required": false,
                "Label": {
                  "zh-cn": "服务版本（或别名）"
                }
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "PathConfig Array"
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "Routing table: path to function mappingwhen a function is called with a custom domain name"
    },
    "Label": {
      "en": "RouteConfig",
      "zh-cn": "路由表配置"
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
      "HTTP",
      "HTTPS"
    ],
    "Description": {
      "en": "HTTP or HTTP,HTTPS"
    },
    "Label": {
      "en": "Protocol",
      "zh-cn": "协议类型"
    }
  }
  EOT
}

resource "alicloud_fc_custom_domain" "custom_domain" {
  api_version = var.api_version
  domain_name = var.domain_name
  protocol    = var.protocol
}

output "domain_name" {
  value       = alicloud_fc_custom_domain.custom_domain.id
  description = "The domain name"
}

output "domain" {
  // Could not transform ROS Attribute Domain to Terraform attribute.
  value       = null
  description = "The domain with protocol."
}

