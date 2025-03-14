variable "connection_drain_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ConnectionDrainEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable graceful connection interruption."
          },
          "Required": true,
          "Default": false
        },
        "ConnectionDrainTimeout": {
          "Type": "Number",
          "Description": {
            "en": "The graceful connection interruption timeout period. Unit: seconds."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 900,
          "Default": 300
        }
      }
    },
    "Description": {
      "en": "Configuration related to graceful connection interruption.Enable graceful connection interruption. After the backend server is removed or the health check fails, the load balancing allows the existing connection to be transmitted normally within a certain period of time.Note: \nBasic Edition instances do not support enabling graceful connection interruption. Only Standard Edition and WAF Enhanced Edition instances support it.Server type and IP type server group support graceful connection interruption. Function Compute type does not support it."
    },
    "Label": {
      "en": "ConnectionDrainConfig",
      "zh-cn": "连接优雅中断相关配置"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "uch_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "Parameter type. Only supports: QueryString."
          },
          "AllowedValues": [
            "QueryString"
          ],
          "Required": true,
          "Default": "QueryString"
        },
        "Value": {
          "Type": "String",
          "Description": {
            "en": "Consistent hash parameter value."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "URL consistency hash parameter configuration."
    },
    "Label": {
      "en": "UchConfig",
      "zh-cn": "URL一致性 hash 参数配置"
    }
  }
  EOT
}

variable "upstream_keepalive_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable upstream keepalive."
    },
    "Label": {
      "en": "UpstreamKeepaliveEnabled",
      "zh-cn": "是否开启后端长链接"
    }
  }
  EOT
}

variable "scheduler" {
  type        = string
  default     = "Wrr"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Wrr": {
          "en": "Weighted Round Robin",
          "zh-cn": "加权轮询"
        },
        "Sch": {
          "en": "Consistent Hash",
          "zh-cn": "一致性哈希"
        },
        "Wlc": {
          "en": "Weighted Least Connections",
          "zh-cn": "加权最小连接数"
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ServerGroupType}",
                "Instance"
              ]
            },
            {
              "Fn::Equals": [
                "$${ServerGroupType}",
                "Ip"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The scheduling algorithm. Valid values:\nWrr (default): The weighted round-robin algorithm is used. Backend servers that have higher weights receive more requests than those that have lower weights.\nWlc: The weighted least connections algorithm is used. Requests are distributed based on the weights and the number of connections to backend servers. If two backend servers have the same weight, the backend server that has fewer connections is expected to receive more requests.\nSch: The consistent hashing algorithm is used. Requests from the same source IP address are distributed to the same backend server.\nNote: This parameter takes effect when the ServerGroupType parameter is set to Instance or Ip."
    },
    "AllowedValues": [
      "Wrr",
      "Wlc",
      "Sch"
    ],
    "Label": {
      "en": "Scheduler",
      "zh-cn": "调度算法"
    }
  }
  EOT
}

variable "sticky_session_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Cookie": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::And": [
                  {
                    "Fn::Equals": [
                      "$${.StickySessionType}",
                      "Server"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${.StickySessionEnabled}",
                      true
                    ]
                  }
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The cookie to be configured on the backend server.\nThe cookie must be 1 to 200 characters in length, and can contain ASCII characters\nand digits. It cannot contain commas (,), semicolons (;), or spaces. It cannot start\nwith a dollar sign ($).\nNote: This parameter is required if the StickySessionEnabled parameter is set to true and the StickySessionType parameter is set to Server."
          },
          "Required": false
        },
        "CookieTimeout": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::And": [
                  {
                    "Fn::Equals": [
                      "$${.StickySessionType}",
                      "Insert"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${.StickySessionEnabled}",
                      true
                    ]
                  }
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "The timeout period of the cookie. Unit: seconds.\nValid values: 1 to 86400.\nDefault value: 1000.\nNote: This parameter is required if the StickySessionEnabled parameter is set to true and the StickySessionType parameter is set to Insert."
          },
          "Required": false
        },
        "StickySessionType": {
          "AssociationPropertyMetadata": {
            "ValueLabelMapping": {
              "Server": {
                "en": "Server",
                "zh-cn": "重写 Cookie"
              },
              "Insert": {
                "en": "Insert",
                "zh-cn": "植入 Cookie"
              }
            },
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.StickySessionEnabled}",
                  true
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The method that is used to handle a cookie. Valid values:\nInsert : inserts a cookie. This is the default value.\nApplication Load Balancer (ALB) inserts the server ID as a cookie into the first HTTP\nor HTTPS response that is sent to a client. The next request from the client will\ncontain this cookie, and the listener will distribute this request to the recorded\nbackend server.\nServer: rewrites a cookie.\nWhen ALB detects a user-defined cookie, it uses the user-defined cookie to rewrite\nthe original cookie. The next request from the client will contain the user-defined\ncookie, and the listener will distribute this request to the recorded backend server.\nNote: This parameter is required if the StickySessionEnabled parameter is set to true."
          },
          "AllowedValues": [
            "Insert",
            "Server"
          ],
          "Required": false,
          "Default": "Insert"
        },
        "StickySessionEnabled": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${ServerGroupType}",
                      "Instance"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${ServerGroupType}",
                      "Ip"
                    ]
                  }
                ]
              }
            }
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable session persistence. Valid values: true and false.\nNote: This parameter is required if the ServerGroupType parameter is set to Instance or Ip."
          },
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ServerGroupType}",
                "Instance"
              ]
            },
            {
              "Fn::Equals": [
                "$${ServerGroupType}",
                "Ip"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The configuration of session persistence.\nNote: This parameter is required if the ServerGroupType parameter is set to Instance or Ip."
    },
    "Label": {
      "en": "StickySessionConfig",
      "zh-cn": "会话保持配置结构体"
    }
  }
  EOT
}

variable "server_group_type" {
  type        = string
  default     = "Instance"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Instance": {
          "en": "SERVER",
          "zh-cn": "服务器类型"
        },
        "Ip": {
          "en": "IP",
          "zh-cn": "IP地址类型"
        },
        "Fc": {
          "en": "FC",
          "zh-cn": "函数计算类型"
        }
      },
      "AutoChangeType": false
    },
    "Description": {
      "en": "The type of the server group. Valid values:\nInstance (default): allows you add servers by specifying Ecs, Ens, or Eci.\nIp: allows you to add servers by specifying IP addresses.\nFc: allows you to add servers by specifying functions of Function Compute."
    },
    "AllowedValues": [
      "Instance",
      "Ip",
      "Fc"
    ],
    "Label": {
      "en": "ServerGroupType",
      "zh-cn": "服务器组类型"
    }
  }
  EOT
}

variable "cross_zone_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable cross-zone load balancing. Valid values:\ntrue (default)\nfalse\nNote:\nBasic ALB instances do not support server groups that have cross-zone load balancing disabled. Only Standard and WAF-enabled ALB instances support server groups that have cross-zone load balancing.\nCross-zone load balancing can be disabled for server groups of the server and IP type, but not for server groups of the Function Compute type.\nWhen cross-zone load balancing is disabled, session persistence cannot be enabled."
    }
  }
  EOT
}

variable "ipv6_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable IPv6."
    }
  }
  EOT
}

variable "slow_start_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SlowStartEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable slow start."
          },
          "Required": true,
          "Default": false
        },
        "SlowStartDuration": {
          "Type": "Number",
          "Description": {
            "en": "The duration of slow start. Unit: seconds."
          },
          "Required": true,
          "MinValue": 30,
          "MaxValue": 900,
          "Default": 30
        }
      }
    },
    "Description": {
      "en": "Slow start related configuration.After slow start is enabled, the backend server newly added to the backend server group will be preheated within the set time period, and the number of requests forwarded to the server will increase linearly.Note:\nBasic Edition instances do not support slow start, only Standard Edition and WAF Enhanced Edition instances support it.Server type and IP type server groups support slow start configuration, but Function Compute type does not.Slow start can only be enabled when the backend scheduling algorithm is the weighted polling algorithm."
    },
    "Label": {
      "en": "SlowStartConfig",
      "zh-cn": "慢启动相关配置"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The ID of the virtual private cloud (VPC). You can add only servers that are deployed\nin the specified VPC to the server group.\nNote: This parameter is required if the ServerGroupType parameter is set to Instance or Ip.\nNote: This parameter takes effect when the ServerGroupType parameter is set to Instance or Ip."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "service_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "This parameter is available only if the ALB Ingress controller is used. In this case, set the parameter to the name of the Kubernetes Service that is associated with the server group."
    },
    "Label": {
      "en": "ServiceName",
      "zh-cn": "服务器组对应的Kubernetes服务名称"
    }
  }
  EOT
}

variable "health_check_config" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "HealthCheckInterval": {
          "Type": "Number",
          "Description": {
            "en": "The time interval between two consecutive health checks. Unit: seconds.\nValid values: 1 to 50.\nDefault value: 2."
          },
          "Required": false
        },
        "HealthCheckConnectPort": {
          "Type": "Number",
          "Description": {
            "en": "The backend port that is used for health checks.\nValid values: 0 to 65535.\nDefault value: 0. This value indicates that the port on a backend server is used for health checks."
          },
          "Required": false
        },
        "HealthCheckCodes": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "AllowedPattern": "^(http_[2345]xx|([0-9]{1,2})|([0-9]{1,2}-[0-9]{1,2}))$",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The HTTP status codes that are used to determine whether the backend server passes the health check.\nIf HealthCheckProtocol is set to HTTP, HealthCheckCodes can be set to http_2xx (default), http_3xx, http_4xx, and http_5xx. Separate multiple HTTP status codes with a comma (,).\nIf HealthCheckProtocol is set to gRPC, HealthCheckCodes can be set to 0 to 99. Default value: 0. Value ranges are supported. You can enter at most 20 value ranges. Separate multiple value ranges with commas (,).)\nNote: This parameter takes effect only when the HealthCheckProtocol parameter is set to HTTP or gRPC."
          },
          "Required": false
        },
        "UnhealthyThreshold": {
          "Type": "Number",
          "Description": {
            "en": "The number of health checks that a healthy backend server must consecutively fail\nbefore it is declared unhealthy. In this case, the health status is changed from success to fail.\nValid values: 2 to 10.\nDefault value: 3."
          },
          "Required": false
        },
        "HealthCheckMethod": {
          "Type": "String",
          "Description": {
            "en": "The HTTP method that is used for health checks. Valid values:\nGET: If the length of a response exceeds 8 KB, the response is truncated. However, the health check result is not affected.\nPOST: By default, gRPC health checks use the POST method.\nHEAD: By default, HTTP health checks use the HEAD method.\nNote: This parameter takes effect only when the HealthCheckProtocol parameter is set to HTTP or gRPC."
          },
          "Required": false
        },
        "HealthCheckPath": {
          "Type": "String",
          "Description": {
            "en": "The URL that is used for health checks.\nThe URL must be 1 to 80 characters in length, and can contain letters, digits, and\nthe following special characters:\n- / .% ?# & =.\nIt can also contain the following extended characters:\n_ ; ~ ! ( )* [ ] @ $ ^ : ' , +.\nThe URL must start with a forward slash (/).\nNote: This parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
          },
          "Required": false
        },
        "HealthyThreshold": {
          "Type": "Number",
          "Description": {
            "en": "The number of health checks that an unhealthy backend server must consecutively pass\nbefore it is declared healthy. In this case, the health status is changed from fail to success.\nValid values: 2 to 10.\nDefault value: 3."
          },
          "Required": false
        },
        "HealthCheckHost": {
          "Type": "String",
          "Description": {
            "en": "The domain name that is used for health checks. The domain name must meet the following\nrequirements:\nThe domain name must be 1 to 80 characters in length.\nThe domain name can contain lowercase letters, digits, hyphens (-), and periods (.).\nThe domain name must contain at least one period (.),and cannot start or end with\na period (.).\nThe rightmost field can contain only letters, and cannot contain digits or hyphens\n(-).\nOther fields cannot start or end with a hyphen (-).\nNote: This parameter is required only if the HealthCheckProtocol parameter is set to HTTP.\nNote: This parameter takes effect only when the HealthCheckProtocol parameter is set to HTTP."
          },
          "Required": false
        },
        "HealthCheckProtocol": {
          "AssociationPropertyMetadata": {
            "ValueLabelMapping": {
              "HTTPS": {
                "en": "Supports Associating HTTPS Listeners",
                "zh-cn": "支持关联 HTTPS 监听"
              },
              "HTTP": {
                "en": "Supports Associating HTTPS, HTTP, and QUIC Listeners",
                "zh-cn": "支持关联 HTTPS、HTTP 和 QUIC 监听"
              },
              "gRPC": {
                "en": "Supports Associating HTTPS and QUIC Listeners",
                "zh-cn": "支持关联 HTTPS 和 QUIC 监听"
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The protocol that is used for health checks."
          },
          "AllowedValues": [
            "HTTPS",
            "HTTP",
            "gRPC",
            "GRPC"
          ],
          "Required": false,
          "Default": "HTTP"
        },
        "HealthCheckHttpVersion": {
          "Type": "String",
          "Description": {
            "en": "The version of the HTTP protocol. Valid values: HTTP1.0 and HTTP1.1. Default value: HTTP1.1.\nNote: This parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
          },
          "AllowedValues": [
            "HTTP1.0",
            "HTTP1.1"
          ],
          "Required": false
        },
        "HealthCheckEnabled": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable the health check feature. Valid values:\ntrue: enables the feature.\nfalse: disables the feature.\nNote: If the ServerGroupType parameter is set to Instance or Ip, the health check feature is enabled by default. If the ServerGroupType parameter is set to Fc, the health check feature is disabled by default."
          },
          "Required": true,
          "Default": false
        },
        "HealthCheckTimeout": {
          "Type": "Number",
          "Description": {
            "en": "The timeout period of a health check. If a backend server does not respond within\nthe specified timeout period, the backend server fails the health check. Unit: seconds.\nValid values: 1 to 300.\nDefault value: 5.\nNote If the value of the HealthCheckTimeout parameter is smaller than that of the HealthCheckInterval parameter, the timeout period specified by the HealthCheckTimeout parameter is ignored and the period of time specified by the HealthCheckInterval parameter is used as the timeout period."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configuration of health checks."
    },
    "Label": {
      "en": "HealthCheckConfig",
      "zh-cn": "健康检查相关配置结构"
    }
  }
  EOT
}

variable "protocol" {
  type        = string
  default     = "HTTP"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "HTTPS": {
          "en": "Supports Associating HTTPS Listeners",
          "zh-cn": "支持关联 HTTPS 监听"
        },
        "HTTP": {
          "en": "Supports Associating HTTPS, HTTP, and QUIC Listeners",
          "zh-cn": "支持关联 HTTPS、HTTP 和 QUIC 监听"
        },
        "gRPC": {
          "en": "Supports Associating HTTPS and QUIC Listeners",
          "zh-cn": "支持关联 HTTPS 和 QUIC 监听"
        }
      },
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${ServerGroupType}",
              "Fc"
            ]
          },
          "Value": [
            "HTTP"
          ]
        },
        {
          "Condition": {
            "Fn::Not": {
              "Fn::Equals": [
                "$${ServerGroupType}",
                "Fc"
              ]
            }
          },
          "Value": [
            "HTTP",
            "HTTPS",
            "gRPC"
          ]
        }
      ]
    },
    "Description": {
      "en": "The backend protocol. Valid values:\nHTTP (default): The server group can be associated with HTTPS, HTTP, and QUIC listeners.\nHTTPS: The server group can be associated with HTTPS listeners.\ngRPC: The server group can be associated with HTTPS and QUIC listeners.\nNote: If the ServerGroupType parameter is set to Fc, you can set Protocol only to HTTP."
    },
    "AllowedValues": [
      "HTTPS",
      "HTTP",
      "gRPC",
      "GRPC"
    ],
    "Label": {
      "en": "Protocol",
      "zh-cn": "后端协议"
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "server_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the server group. The name must be 2 to 128 characters in length, and\ncan contain letters, digits, periods (.), underscores (_), and hyphens (-). The name\nmust start with a letter."
    },
    "Label": {
      "en": "ServerGroupName",
      "zh-cn": "服务器组名称"
    }
  }
  EOT
}

resource "alicloud_alb_server_group" "server_group" {
  resource_group_id = var.resource_group_id
  scheduler         = var.scheduler
  server_group_type = var.server_group_type
  vpc_id            = var.vpc_id
  protocol          = var.protocol
  tags              = var.tags
  server_group_name = var.server_group_name
}

output "server_group_id" {
  value       = alicloud_alb_server_group.server_group.id
  description = "The ID of the server group."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

