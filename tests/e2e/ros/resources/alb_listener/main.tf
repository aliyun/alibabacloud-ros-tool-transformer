variable "ca_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable mutual authentication. Default false."
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
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The frontend port that is used by the ALB instance.\nValid values: 1 to 65535."
    },
    "MinValue": 1,
    "Label": {
      "en": "ListenerPort",
      "zh-cn": "监听端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "request_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period of the request.\nValid values: 1 to 900. Unit: seconds.\nDefault value: 60.\nIf no response is received from the backend server during the request timeout period,\nALB sends an HTTP 504 error code to the client."
    },
    "MinValue": 1,
    "Label": {
      "en": "RequestTimeout",
      "zh-cn": "请求超时时间"
    },
    "MaxValue": 900
  }
  EOT
}

variable "http2_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ListenerProtocol}",
            "HTTPS"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable HTTP/2. Default value: on.\nValid values: true and false.\nDefault value: true.\nNote: Only HTTPS listeners support this parameter."
    },
    "Label": {
      "en": "Http2Enabled",
      "zh-cn": "是否开启HTTP/2特性"
    }
  }
  EOT
}

variable "default_actions" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Type": {
              "AssociationPropertyMetadata": {
                "ValueLabelMapping": {
                  "ForwardGroup": {
                    "en": "Forward to Multiple Virtual Server Groups",
                    "zh-cn": "转发至多个虚拟服务器组"
                  }
                }
              },
              "Type": "String",
              "Description": {
                "en": "The action type. The value is set to ForwardGroup. \nIt indicates that requests are forwarded to multiple vServer groups."
              },
              "AllowedValues": [
                "ForwardGroup"
              ],
              "Required": true,
              "Default": "ForwardGroup"
            },
            "ForwardGroupConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "ServerGroupTuples": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ServerGroupId": {
                          "Type": "String",
                          "Description": {
                            "en": "The ID of the destination server group to which requests are forwarded."
                          },
                          "Required": true,
                          "Label": {
                            "en": "Target Server Group ID",
                            "zh-cn": "目标服务器组ID"
                          }
                        }
                      }
                    },
                    "AssociationProperty": "List[Parameters]",
                    "Type": "Json",
                    "Description": {
                      "en": "The destination server group to which requests are forwarded."
                    },
                    "Required": true,
                    "Label": {
                      "en": "Forward Target Server Groups",
                      "zh-cn": "转发目标服务器组"
                    }
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The configurations of the actions. This parameter is required if Type is set to FowardGroup."
              },
              "Required": true,
              "Label": {
                "en": "Forward Configuration",
                "zh-cn": "转发配置"
              }
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The actions of the rule."
    },
    "Label": {
      "en": "DefaultActions",
      "zh-cn": "规则动作列表"
    }
  }
  EOT
}

variable "certificates" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CertificateId": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${ListenerProtocol}",
                      "HTTPS"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${ListenerProtocol}",
                      "QUIC"
                    ]
                  }
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The certificate ID."
          },
          "Required": false,
          "Label": {
            "en": "CertificateId",
            "zh-cn": "证书ID"
          }
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of SSL certificates for listener."
    },
    "Label": {
      "en": "Certificates",
      "zh-cn": "证书"
    }
  }
  EOT
}

variable "idle_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period of idle connections.\nValid values: 1 to 3600. Unit: seconds.\nDefault value: 15.\nIf no requests are received within the specified timeout period, ALB closes the current connection. When a new request is received, ALB establishes a new connection."
    },
    "MinValue": 1,
    "Label": {
      "en": "IdleTimeout",
      "zh-cn": "连接空闲超时时间"
    },
    "MaxValue": 3600
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ALB::LoadBalancer::LoadBalancerId",
    "Description": {
      "en": "The ID of the ALB instance."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "负载均衡实例ID"
    }
  }
  EOT
}

variable "listener_protocol" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "HTTP",
      "HTTPS",
      "QUIC"
    ],
    "Description": {
      "en": "The listener protocol.\nValid values: HTTP, HTTPS, and QUIC."
    },
    "Label": {
      "en": "ListenerProtocol",
      "zh-cn": "监听协议"
    }
  }
  EOT
}

variable "quic_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "QuicListenerId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the QUIC listener to be associated. Only HTTPS listeners support this parameter. If QuicUpgradeEnabled is set to true, this parameter is required.\nNote The original listener and the QUIC listener must belong to the same ALB instance.\nIn addition, make sure that the QUIC listener has not been associated before."
          },
          "Required": false
        },
        "QuicUpgradeEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable the QUIC update feature.\nValid values: true and false.\nDefault value: false.\nNote: Only HTTPS listeners support this parameter."
          },
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ListenerProtocol}",
            "HTTPS"
          ]
        }
      }
    },
    "Description": {
      "en": "Select a QUIC listener and associate it with the ALB instance."
    },
    "Label": {
      "en": "QuicConfig",
      "zh-cn": "配置关联的QUIC监听"
    }
  }
  EOT
}

variable "gzip_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable gzip compression to compress files of a specific type.\nValid values: true and false.\nDefault value: true.",
      "zh-cn": "是否开启Gzip压缩，压缩特定文件类型。"
    },
    "Label": {
      "en": "GzipEnabled",
      "zh-cn": "是否开启Gzip压缩"
    }
  }
  EOT
}

variable "security_policy_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ListenerProtocol}",
            "HTTPS"
          ]
        }
      }
    },
    "Description": {
      "en": "The ID of the security policy. System security policies and custom security policies\nare supported.\nDefault value: tls_cipher_policy_1_0. This value indicates a system security policy.\nNote: Only HTTPS listeners support this parameter."
    },
    "Label": {
      "en": "SecurityPolicyId",
      "zh-cn": "安全策略ID"
    }
  }
  EOT
}

variable "listener_status" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Stopped": {
          "zh-cn": "已停止"
        },
        "Running": {
          "zh-cn": "运行中"
        }
      }
    },
    "Description": {
      "en": "The status of the listener."
    },
    "AllowedValues": [
      "Running",
      "Stopped"
    ],
    "Label": {
      "en": "ListenerStatus",
      "zh-cn": "监听的状态"
    }
  }
  EOT
}

variable "listener_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the listener. \nThe description must be 2 to 256 characters in length."
    },
    "Label": {
      "en": "ListenerDescription",
      "zh-cn": "监听的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "xforwarded_for_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "XForwardedForClientSourceIpsEnabled": {
          "Type": "Boolean",
          "Required": false
        },
        "XForwardedForClientCertFingerprintAlias": {
          "Type": "String",
          "Description": {
            "en": "The name of the custom header. This parameter is valid only if XForwardedForClientCertFingerprintEnabled is set to true.\nThe name must be 1 to 40 characters in length, and can contain letters, hyphens (-),\nunderscores (_), and digits.\nNote: Only HTTPS listeners support this parameter."
          },
          "AllowedPattern": "[-a-z0-9_]{2,40}",
          "Required": false
        },
        "XForwardedForClientCertFingerprintEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Clientcert-fingerprint header field to obtain the fingerprint of the ALB client certificate.\nValid values: true and false.\nDefault value: false.\nNote: Only HTTPS listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForHostEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable obtaining the domain name of the client accessing the load balancer instance through the X-Forwarded-Host header field. Values:\ntrue: Yes.\nfalse (default): No.\nNote: HTTP, HTTPS, and QUIC listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForClientSourceIpsTrusted": {
          "Type": "String",
          "Required": false
        },
        "XForwardedForClientCertIssuerDNAlias": {
          "Type": "String",
          "Description": {
            "en": "The name of the custom header. This parameter is valid only if XForwardedForClientCertIssuerDNEnabled is set to On.\nThe name must be 1 to 40 characters in length, and can contain letters, hyphens (-),\nunderscores (_), and digits.\nNote: Only HTTPS listeners support this parameter."
          },
          "AllowedPattern": "[-a-z0-9_]{2,40}",
          "Required": false
        },
        "XForwardedForClientCertClientVerifyAlias": {
          "Type": "String",
          "Description": {
            "en": "The name of the custom header. This parameter is valid only if XForwardedForClientCertClientVerifyEnabled is set to true.\nThe name must be 1 to 40 characters in length, and can contain letters, hyphens (-),\nunderscores (_), and digits.\nNote: Only HTTPS listeners support this parameter."
          },
          "AllowedPattern": "[-a-z0-9_]{2,40}",
          "Required": false
        },
        "XForwardedForSLBIdEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the SLB-ID header field to obtain the ID of the ALB instance.\nValid values: true and false.\nDefault value: false.\nNote HTTP, HTTPS, and QUIC listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForClientCertSubjectDNEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Clientcert-subjectdn header field to obtain information about the owner of the ALB client certificate.\nValid values: true and false.\nDefault value: false.\nNote: Only HTTPS listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForClientCertSubjectDNAlias": {
          "Type": "String",
          "Description": {
            "en": "The name of the custom header. This parameter is valid only if XForwardedForClientCertSubjectDNEnabled\nis set to true.\nThe name must be 1 to 40 characters in length, and can contain letters, hyphens (-),\nunderscores (_), and digits.\nNote: Only HTTPS listeners support this parameter."
          },
          "AllowedPattern": "[-a-z0-9_]{2,40}",
          "Required": false
        },
        "XForwardedForProtoEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Proto header field to obtain the listener protocol of the ALB instance.\nValid values: true and false.\nDefault value: false.\nNote: HTTP, HTTPS, and QUIC listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForClientSrcPortEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Client-Port header field to obtain the port of the ALB client.\nValid values: true and false.\nDefault value: false.\nNote HTTP and HTTPS listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForSLBPortEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Port header field to obtain the listener port of the ALB instance.\nValid values: true and false.\nDefault value: false.\nNote HTTP, HTTPS, and QUIC listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-For header field to obtain the real IP address of the client.\nValid values: true and false.\nDefault value: true.\nNote HTTP and HTTPS listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForProcessingMode": {
          "Type": "String",
          "Description": {
            "en": "The mode for handling the X-Forwarded-For header field. This value takes effect only when XForwardedForEnabled is true. Possible values:\nappend (default): Append.\nremove: Remove.\nNote: When configured as append, the last hop IP is added to the X-Forwarded-For header field before the request is sent to the backend service.\nWhen configured as remove, the X-Forwarded-For header is deleted before the request is sent to the backend service, regardless of whether the request carries the X-Forwarded-For header field.This parameter is supported by both HTTP and HTTPS listeners."
          },
          "AllowedValues": [
            "append",
            "remove"
          ],
          "Required": false
        },
        "XForwardedForClientCertIssuerDNEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Clientcert-issuerdn header field to obtain information about the authority that issues the ALB client\ncertificate.\nValid values: true and false.\nDefault value: false.\nNote: Only HTTPS listeners support this parameter."
          },
          "Required": false
        },
        "XForwardedForClientCertClientVerifyEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the X-Forwarded-Clientcert-clientverify header field to obtain the verification result of the ALB client certificate.\nValid values: true and false.\nDefault value: false.\nNote: Only HTTPS listeners support this parameter."
          },
          "Required": false
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

variable "log_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AccessLogRecordCustomizedHeadersEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to record custom headers in the access log.\nValid values:\ntrue\nfalse (default)"
          },
          "Required": false
        },
        "AccessLogTracingConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "TracingType": {
                "Type": "String",
                "Description": {
                  "en": "The type of Xtrace. Set the value to Zipkin."
                },
                "AllowedValues": [
                  "Zipkin"
                ],
                "Required": false
              },
              "TracingSample": {
                "Type": "Number",
                "Description": {
                  "en": "The sampling rate of the Xtrace feature. Valid values: 1 to 10000."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 10000
              },
              "TracingEnabled": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to enable the Xtrace feature. Valid values:\ntrue\nfalse (default)"
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configuration information about the Xtrace feature."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration information about the access log."
    }
  }
  EOT
}

variable "ca_certificates" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CertificateId": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Fn::Equals": [
                "$${CaEnabled}",
                true
              ]
            }
          },
          "Type": "String",
          "Description": {
            "en": "The CA certificate ID."
          },
          "Required": false,
          "Label": {
            "en": "CertificateId",
            "zh-cn": "CA证书ID"
          }
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of configured CA certificates for listener."
    },
    "Label": {
      "en": "CaCertificates",
      "zh-cn": "CA证书信息"
    }
  }
  EOT
}

resource "alicloud_alb_listener" "listener" {
  listener_port        = var.listener_port
  request_timeout      = var.request_timeout
  http2_enabled        = var.http2_enabled
  default_actions      = var.default_actions
  certificates         = var.certificates
  idle_timeout         = var.idle_timeout
  load_balancer_id     = var.load_balancer_id
  listener_protocol    = var.listener_protocol
  gzip_enabled         = var.gzip_enabled
  security_policy_id   = var.security_policy_id
  listener_description = var.listener_description
}

output "load_balancer_id" {
  // Could not transform ROS Attribute LoadBalancerId to Terraform attribute.
  value       = null
  description = "The ID of the ALB instance."
}

output "listener_id" {
  value       = alicloud_alb_listener.listener.id
  description = "The ID of the listener."
}

