variable "vserver_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The id of the VServerGroup which use in listener."
    },
    "Label": {
      "en": "VServerGroupId",
      "zh-cn": "服务器组ID"
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
      "en": "The description of the listener.It must be 1 to 80 characters in length and can contain letters, digits, hyphens (-), forward slashes (/), periods (.), and underscores (_). Chinese characters are supported."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "监听的描述信息"
    },
    "MaxLength": 80
  }
  EOT
}

variable "proxy_protocol_v2_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to support carrying the client source address to the backend server through the Proxy Protocol. Value:\ntrue: Yes\nfalse (default): No\nNote: Only effective TCP or UDP listener."
    },
    "Label": {
      "en": "Whether to use the Proxy protocol to pass client IP addresses",
      "zh-cn": "是否支持通过 Proxy Protocol 协议携带客户端源地址"
    }
  }
  EOT
}

variable "scheduler" {
  type        = string
  default     = "wrr"
  description = <<EOT
  {
    "Description": {
      "en": "The scheduling algorithm. Valid values:\nwrr: Backend servers that have higher weights receive more requests than those that have lower weights.\nwlc: Requests are distributed based on the combination of the weights and connections to backend servers. If two backend servers have the same weight, the backend server that has fewer connections receives more requests.\nrr: Requests are distributed to backend servers in sequence.\nsch: specifies consistent hashing that is based on source IP addresses. Requests from the same source IP address are distributed to the same backend server.\ntch: specifies consistent hashing that is based on four factors: source IP address, destination IP address, source port number, and destination port number. Requests that contain the same preceding information are distributed to the same backend server.\nDefault: wrr"
    },
    "AllowedValues": [
      "wrr",
      "wlc",
      "rr",
      "sch",
      "tch"
    ],
    "Label": {
      "en": "Scheduler",
      "zh-cn": "调度算法"
    }
  }
  EOT
}

variable "health_check" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UnhealthyThreshold": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The number of consecutive health checks failures required,before identified the backend server in Unhealthy status.",
            "zh-cn": "判定健康检查结果为fail的阈值。即，健康检查连续失败多少次后，将后端服务器的健康检查状态由success改为fail。"
          },
          "Required": false,
          "MinValue": 1,
          "Label": {
            "en": "UnhealthyThreshold",
            "zh-cn": "判定健康检查结果为fail的阈值"
          },
          "MaxValue": 10
        },
        "Timeout": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The amount of time, in seconds, during which no response means a failed health check."
          },
          "Required": false,
          "MinValue": 0,
          "Label": {
            "en": "Timeout",
            "zh-cn": "每次健康检查响应的最大超时时间"
          }
        },
        "Port": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The port being checked. The range of valid ports is 0 through 65535."
          },
          "Required": false,
          "MinValue": 0,
          "Label": {
            "en": "Port",
            "zh-cn": "用于健康检查的端口"
          },
          "MaxValue": 65535
        },
        "URI": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The url of health check target."
          },
          "Required": false,
          "Label": {
            "en": "URI",
            "zh-cn": "用于健康检查的URI"
          }
        },
        "HttpCode": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The expect status of health check result. Any answer other than referred status within the timeout period is considered unhealthy.",
            "zh-cn": "取值：http_2xx（默认值）,http_3xx,http_4xx,http_5xx,多个HTTP状态码之间用半角逗号（,）分隔。"
          },
          "Required": false,
          "Label": {
            "en": "HttpCode",
            "zh-cn": "HTTP状态码"
          }
        },
        "Switch": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "String",
          "Description": {
            "en": "Whether to enable health check. Valid value: on, off.\nIf value is on, turn on the health check. If value is off, turn off the health checkIf value is not set, the health check is disabled by default, unless any health check items are configured."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false,
          "Label": {
            "en": "Switch",
            "zh-cn": "是否启用健康检查"
          },
          "Default": "off"
        },
        "HealthCheckMethod": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The health check method used in HTTP or HTTPS health checks. Valid values: head and get."
          },
          "AllowedValues": [
            "head",
            "get"
          ],
          "Required": false,
          "Label": {
            "en": "HealthCheckMethod",
            "zh-cn": "健康检查方法"
          }
        },
        "HealthyThreshold": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The number of consecutive health checks successes required,before identified the backend server in Healthy status.",
            "zh-cn": "判定健康检查结果为success的阈值。即，健康检查连续成功多少次后，将后端服务器的健康检查状态由fail改为success。"
          },
          "Required": false,
          "MinValue": 1,
          "Label": {
            "en": "HealthyThreshold",
            "zh-cn": "判定健康检查结果为success的阈值"
          },
          "MaxValue": 10
        },
        "Domain": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The domain of health check target."
          },
          "Required": false,
          "Label": {
            "en": "Domain",
            "zh-cn": "用于健康检查的域名"
          }
        },
        "Exp": {
          "Type": "String",
          "Description": {
            "en": "The response string for UDP listening health check is limited to letters and numbers, and the maximum length is 64 characters."
          },
          "Required": false,
          "Label": {
            "en": "Exp",
            "zh-cn": "UDP监听健康检查的响应字符串仅限于字母和数字"
          }
        },
        "HealthCheckType": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The type of health check.Valid values: tcp, udp, https and http. Default value: tcp."
          },
          "AllowedValues": [
            "tcp",
            "http",
            "udp",
            "https"
          ],
          "Required": false,
          "Label": {
            "en": "HealthCheckType",
            "zh-cn": "健康检查类型"
          }
        },
        "Interval": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Switch}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The approximate interval, unit in seconds, between health checks of an backend server."
          },
          "Required": false,
          "MinValue": 1,
          "Label": {
            "en": "Interval",
            "zh-cn": "健康检查的时间间隔"
          },
          "MaxValue": 50
        },
        "Req": {
          "Type": "String",
          "Description": {
            "en": "The request string for UDP listening health check is limited to letters and numbers, and the maximum length is 64 characters."
          },
          "Required": false,
          "Label": {
            "en": "Req",
            "zh-cn": "UDP监听健康检查的请求字符串仅限于字母和数字"
          }
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${Protocol}",
                "http"
              ]
            },
            {
              "Fn::Equals": [
                "$${Protocol}",
                "https"
              ]
            }
          ]
        }
      },
      "ListMetadata": {
        "Order": [
          "Switch",
          "HealthCheckMethod",
          "HealthCheckType",
          "HttpCode"
        ]
      }
    },
    "Description": {
      "en": "The properties of health checking setting."
    },
    "Label": {
      "en": "HealthCheck",
      "zh-cn": "健康检查设置"
    }
  }
  EOT
}

variable "idle_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specify the idle connection timeout in seconds. Valid value: 1-60 If no request is received during the specified timeout period, Server Load Balancer will temporarily terminate the connection and restart the connection when the next request comes."
    },
    "MinValue": 1,
    "Label": {
      "en": "IdleTimeout",
      "zh-cn": "连接空闲超时时间"
    },
    "MaxValue": 60
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::SLB::LoadBalancer::LoadBalancerId",
    "Description": {
      "en": "The id of load balancer to create listener."
    },
    "Label": {
      "en": "LoadBalancerId",
      "zh-cn": "负载均衡实例的ID"
    }
  }
  EOT
}

variable "backend_server_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Backend server can listen on ports from 0 to 65535."
    },
    "MinValue": 0,
    "Label": {
      "en": "BackendServerPort",
      "zh-cn": "负载均衡实例后端使用的端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "connection_drain_timeout" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ConnectionDrain}",
            "on"
          ]
        }
      }
    },
    "Description": {
      "en": "Set the connection graceful interruption timeout. Unit: seconds. Value range: 10-900.\nNote: Only effective for TCP listener. When ConnectionDrain is on, this option is required."
    },
    "MinValue": 10,
    "Label": {
      "en": "The timeout period of connection draining",
      "zh-cn": "优雅中断超时时间"
    },
    "MaxValue": 900
  }
  EOT
}

variable "bandwidth" {
  type        = number
  default     = -1
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The bandwidth of network, unit in Mbps(Million bits per second). If the specified load balancer with \"LOAD_BALANCE_ID\" is charged by \"paybybandwidth\" and is created in classic network, each Listener's bandwidth must be greater than 0 and the sum of all of its Listeners' bandwidth can't be greater than the bandwidth of the load balancer.",
      "zh-cn": "针对按固定带宽计费方式的公网类型实例，不同Listener上的Bandwidth的峰值总和不能超出在创建负载均衡实例时设定的Bandwidth值。针对按流量计费的实例类型，该值置为-1。"
    },
    "MinValue": -1,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "监听的带宽峰值"
    },
    "MaxValue": 5120
  }
  EOT
}

variable "gzip" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable Gzip compression to compress specific types of files. Valid values:\non (default): yes\noff: no",
      "zh-cn": "指定是否启用Gzip压缩，以压缩特定类型的文件。"
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Gzip",
      "zh-cn": "指定是否启用Gzip压缩"
    }
  }
  EOT
}

variable "server_certificate_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Required": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "https"
          ]
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "https"
          ]
        }
      }
    },
    "Description": {
      "en": "Server certificate id, for https listener only, this properties is required."
    },
    "Label": {
      "en": "ServerCertificateId",
      "zh-cn": "服务器证书的ID"
    }
  }
  EOT
}

variable "http_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ListenerForward": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "String",
          "Description": {
            "en": "Whether to enable HTTP to HTTPS forwarding.\nValid values: on | off. Default value: off."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false,
          "Default": "off"
        },
        "ForwardPort": {
          "Type": "Number",
          "Description": {
            "en": "HTTP to HTTPS listening forwarding port.\nDefault value: 443."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 65535,
          "Default": 443
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "http"
          ]
        }
      }
    },
    "Description": {
      "en": "Config for http protocol."
    },
    "Label": {
      "en": "HttpConfig",
      "zh-cn": "用于配置HTTP协议"
    }
  }
  EOT
}

variable "protocol" {
  type        = string
  default     = "http"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The load balancer transport protocol to use for routing: http, https, tcp, or udp."
    },
    "AllowedValues": [
      "http",
      "https",
      "tcp",
      "udp"
    ],
    "Label": {
      "en": "Protocol",
      "zh-cn": "网络协议"
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
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "request_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specify the request timeout in seconds. Valid value: 1-180 If no response is received from the backend server during the specified timeout period, Server Load Balancer will stop waiting and send an HTTP 504 error to the client."
    },
    "MinValue": 1,
    "Label": {
      "en": "RequestTimeout",
      "zh-cn": "请求超时时间"
    },
    "MaxValue": 180
  }
  EOT
}

variable "listener_port" {
  type        = number
  default     = 80
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Port for front listener. Range from 0 to 65535."
    },
    "MinValue": 0,
    "Label": "监听端口",
    "MaxValue": 65535
  }
  EOT
}

variable "tlscipher_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "https"
          ]
        }
      }
    },
    "Description": {
      "en": "The Transport Layer Security (TLS) security policy. Each security policy contains TLS protocol versions and cipher suites available for HTTPS. It takes effect when Protocol=https."
    },
    "Label": {
      "en": "TLSCipherPolicy",
      "zh-cn": "TLS安全策略"
    }
  }
  EOT
}

variable "cacertificate_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "https"
          ]
        }
      }
    },
    "Description": {
      "en": "CA server certificate id, for https listener only."
    },
    "Label": {
      "en": "CACertificateId",
      "zh-cn": "CA证书ID"
    }
  }
  EOT
}

variable "connection_drain" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable graceful connection interruption. Value:on: turn on\noff: Not turned on\nNote: Only effective TCP listener."
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "Whether to enable connection draining",
      "zh-cn": "是否开启连接优雅中断"
    }
  }
  EOT
}

variable "persistence" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "XForwardedFor_SLBID": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Optional. Indicates whether to use the SLB-ID header field to obtain the SLB instance ID. Valid values: on | off. Default value: off If you do not set this parameter, the default value is used."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        },
        "CookieTimeout": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The timeout for cookie setting, in seconds. It only take effect while StickySession is setting to 'on' and StickySessionType is setting to 'insert'."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 86400
        },
        "Cookie": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The type of session persistence."
          },
          "Required": false
        },
        "StickySession": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The switch of session persistence. Support 'on' and 'off'. "
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false,
          "Default": "off"
        },
        "PersistenceTimeout": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The timeout number of persistence, in seconds."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 1000
        },
        "XForwardedFor_SLBPORT": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Optional. Indicates whether to use the X-Forwarded-Port header field to retrieve the listening ports of the SLB instance. Valid values: on | off. Default value: offIf you do not set this parameter, the default value is used."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        },
        "XForwardedFor": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Use 'X-Forwarded-For' to get real ip of accessor. On for open, off for close."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        },
        "XForwardedFor_ClientSrcPort": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Optional. Indicates whether to use the X-Forwarded-Client-srcport header field to retrieve the port used by a client to connect to the SLB instance. Valid values: on | off. Default value: offIf you do not set this parameter, the default value is used."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        },
        "XForwardedFor_proto": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Optional. Indicates whether to use the X-Forwarded-Proto header field to obtainthe listening protocol used by the SLB instance. Valid values: on | off. Default value: offIf you do not set this parameter, the default value is used."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        },
        "StickySessionType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "StickySessionType",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The type of session persistence. Depends on parameter StickySession, if it is set to off, this parameter will be ignored."
          },
          "AllowedValues": [
            "insert",
            "server"
          ],
          "Required": false
        },
        "XForwardedFor_SLBIP": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean",
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySession}",
                  "on"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Optional. Indicates whether to use the SLB-IP header field to obtainthe real IP address of a client request.Valid values: on | off. Default value: offIf you do not set this parameter, the default value is used."
          },
          "AllowedValues": [
            "on",
            "off"
          ],
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${Protocol}",
                "http"
              ]
            },
            {
              "Fn::Equals": [
                "$${Protocol}",
                "https"
              ]
            }
          ]
        }
      },
      "ListMetadata": {
        "Order": [
          "StickySession"
        ]
      }
    },
    "Description": {
      "en": "The properties of persistence."
    },
    "Label": {
      "en": "Persistence",
      "zh-cn": "相关参数的持久化"
    }
  }
  EOT
}

variable "port_range" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "StartPort": {
          "Type": "Number",
          "Description": {
            "en": "Start port, from 1 to 65535."
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 65535
        },
        "EndPort": {
          "Type": "Number",
          "Description": {
            "en": "End port, from 1 to 65535."
          },
          "Required": true,
          "MinValue": 1,
          "MaxValue": 65535
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Port range, only supports TCP or UDP listener. ListenerPort should be 0 when PortRange is specified."
    },
    "Label": {
      "en": "PortRange",
      "zh-cn": "监听的端口范围"
    },
    "MinLength": 1,
    "MaxLength": 1
  }
  EOT
}

variable "acl_status" {
  type        = string
  default     = "off"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Indicates whether to enable access control.\nValid values: on | off. Default value: off"
    },
    "AllowedValues": [
      "on",
      "off"
    ],
    "Label": {
      "en": "AclStatus",
      "zh-cn": "是否开启访问控制功能"
    }
  }
  EOT
}

variable "master_slave_server_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The id of the MasterSlaveServerGroup which use in listener."
    },
    "Label": {
      "en": "MasterSlaveServerGroupId",
      "zh-cn": "主备服务器组ID"
    }
  }
  EOT
}

variable "start_listener" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether start listener after listener created. Default True."
    },
    "Label": {
      "en": "StartListener",
      "zh-cn": "是否启动监听器"
    }
  }
  EOT
}

variable "acl_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AclStatus}",
            "on"
          ]
        }
      }
    },
    "Description": {
      "en": "The access control type:\n* white: Indicates a whitelist. Only requests from IP addresses or CIDR blocks in the selected access control lists are forwarded. This applies to scenarios in which an application only allows access from specific IP addresses.\nEnabling a whitelist poses some risks to your services.\nAfter a whitelist is enabled, only the IP addresses in the list can access the listener.\nIf you enable a whitelist without adding any IP addresses in the list, no requests are forwarded.\n* black: Indicates a blacklist. Requests from IP addresses or CIDR blocks in the selected access control lists are not forwarded (that is, they are blocked). This applies to scenarios in which an application only denies access from specific IP addresses.\nIf you enable a blacklist without adding any IP addresses in the list, all requests are forwarded.\n\nIf the value of the AclStatus parameter is on, this parameter is required."
    },
    "AllowedValues": [
      "white",
      "black"
    ],
    "Label": {
      "en": "AclType",
      "zh-cn": "访问控制类型"
    }
  }
  EOT
}

variable "full_nat_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "When Full NAT mode is enabled, it can support the backend servers as clients for access. Default value is false.\nNote: Only effective for TCP or UDP listener."
    }
  }
  EOT
}

variable "enable_http2" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${Protocol}",
            "http"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to use HTTP/2. It takes effect when Protocol=https. Valid values:\non: yes\noff: no"
    },
    "Label": {
      "en": "EnableHttp2",
      "zh-cn": "是否开启HTTP2特性"
    }
  }
  EOT
}

variable "acl_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Required": {
        "Condition": {
          "Fn::Equals": [
            "$${AclStatus}",
            "on"
          ]
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AclStatus}",
            "on"
          ]
        }
      },
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The ID list of the access controls associated with the listener to be created.\nIf the value of the AclStatus parameter is on, this parameter is required.AclIds have higher priority than AclId."
    },
    "Label": {
      "en": "AclIds",
      "zh-cn": "与要创建的侦听器关联的访问控制的ID列表"
    }
  }
  EOT
}

resource "alicloud_slb_listener" "listener" {
  server_group_id              = var.vserver_group_id
  description                  = var.description
  proxy_protocol_v2_enabled    = var.proxy_protocol_v2_enabled
  scheduler                    = var.scheduler
  idle_timeout                 = var.idle_timeout
  load_balancer_id             = var.load_balancer_id
  backend_port                 = var.backend_server_port
  bandwidth                    = var.bandwidth
  gzip                         = var.gzip
  server_certificate_id        = var.server_certificate_id
  protocol                     = var.protocol
  request_timeout              = var.request_timeout
  frontend_port                = var.listener_port
  tls_cipher_policy            = var.tlscipher_policy
  ca_certificate_id            = var.cacertificate_id
  acl_status                   = var.acl_status
  master_slave_server_group_id = var.master_slave_server_group_id
  acl_type                     = var.acl_type
  enable_http2                 = var.enable_http2
}

output "listener_ports_and_protocol" {
  // Could not transform ROS Attribute ListenerPortsAndProtocol to Terraform attribute.
  value       = null
  description = "The collection of listener."
}

output "load_balancer_id" {
  value       = alicloud_slb_listener.listener.load_balancer_id
  description = "The id of load balancer"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

