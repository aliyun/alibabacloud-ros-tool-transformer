variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "AutoChangeType": false,
      "LocaleKey": "Scheduler"
    },
    "AllowedValues": [
      "Wrr",
      "rr",
      "sch",
      "tch",
      "qch"
    ],
    "Label": {
      "en": "Scheduler",
      "zh-cn": "调度算法"
    }
  }
  EOT
}

variable "addressipversion" {
  type        = string
  default     = "ipv4"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "AddressIPVersion"
    },
    "Description": {
      "en": "IP version of address"
    },
    "AllowedValues": [
      "ipv4",
      "DualStack"
    ],
    "Label": {
      "en": "AddressIPVersion",
      "zh-cn": "协议版本"
    }
  }
  EOT
}

variable "servers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ServerType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "Servers_ServerType"
          },
          "Type": "String",
          "Description": {
            "en": "The type of the backend server. Valid values:\n- **Ecs**: an ECS instance.\n- **Eni**: an ENI.\n- **Eci**: an elastic container instance.\n- **Ip**: an IP address."
          },
          "AllowedValues": [
            "Ecs",
            "Eni",
            "Eci",
            "Ip"
          ],
          "Required": true,
          "Default": "Ecs"
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the servers. The description must be 2 to 256 characters in length, and can contain letters, digits, commas (,), periods (.), semicolons (;), forward slashes (/), at signs (@), underscores (_), and hyphens (-)."
          },
          "Required": false
        },
        "ServerId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the server. You can specify at most 40 server IDs in each call.\nIf the server group type is **Instance**, set the ServerId parameter to the ID of an Elastic Compute Service (ECS) instance, an elastic network interface (ENI), or an elastic container instance. These backend servers are specified by **Ecs**, **Eni**, or **Eci**.\nIf the server group type is **Ip**, set the ServerId parameter to an IP address."
          },
          "Required": true,
          "Label": {
            "zh-cn": "后端服务器的实例ID。"
          }
        },
        "ServerIp": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the server. If the server group type is **Ip**, ServerId is taken as the value of this parameter."
          },
          "Required": false
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port used by the backend server. Valid values: 0 to 65535. Default value is 0.\nWhen the server group enables full port forwarding, there is no need to specify a port when adding a backend server (0 is entered by default). NLB will forward traffic to the back-end server according to the frontend request port."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 65535
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of the backend server. Valid values: 0 to 100. Default value: 100.\nIf the weight of a backend server is set to 0, no requests are forwarded to the backend server."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 100,
          "Default": 100
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Servers",
      "zh-cn": "服务器列表"
    },
    "MaxLength": 1000
  }
  EOT
}

variable "preserve_client_ip_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable the client address retention function"
    },
    "Label": {
      "en": "PreserveClientIpEnabled",
      "zh-cn": "是否开启客户端地址保持功能"
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
      "LocaleKey": "ServerGroupType"
    },
    "Description": {
      "en": "Type of ServerGroup"
    },
    "AllowedValues": [
      "Instance",
      "Ip"
    ],
    "Label": {
      "en": "ServerGroupType",
      "zh-cn": "服务器组类型"
    }
  }
  EOT
}

variable "persistence_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable session persistence"
    },
    "Label": {
      "en": "PersistenceEnabled",
      "zh-cn": "是否开启会话保持"
    }
  }
  EOT
}

variable "connection_drain_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable graceful connection interruption"
    },
    "Label": {
      "en": "ConnectionDrainEnabled",
      "zh-cn": "是否开启连接优雅中断"
    }
  }
  EOT
}

variable "connection_drain_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Time of graceful connection interruption"
    },
    "MinValue": 0,
    "Label": {
      "en": "ConnectionDrainTimeout",
      "zh-cn": "设置连接优雅中断超时时间"
    },
    "MaxValue": 900
  }
  EOT
}

variable "persistence_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Time of session persistence"
    },
    "MinValue": 0,
    "Label": {
      "en": "PersistenceTimeout",
      "zh-cn": "会话保持超时时间"
    },
    "MaxValue": 3600
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "ID of VPC"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "服务器组所在VPC的ID"
    }
  }
  EOT
}

variable "any_port_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable all-port forwarding. Valid values:\ntrue\nfalse (default)"
    },
    "Label": {
      "zh-cn": "是否开启全端口转发。"
    }
  }
  EOT
}

variable "health_check_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "HealthCheckInterval": {
          "Type": "Number",
          "Description": {
            "en": "Health check interval"
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 50,
          "Default": 10
        },
        "HealthCheckUrl": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.HealthCheckType}",
                  "Http"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Url for health check"
          },
          "Required": false
        },
        "HealthCheckConnectPort": {
          "Type": "Number",
          "Description": {
            "en": "Port of health check"
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 65535,
          "Default": 0
        },
        "UnhealthyThreshold": {
          "Type": "Number",
          "Description": {
            "en": "Determine the health check status of the backend server from success to fail."
          },
          "Required": false,
          "MinValue": 2,
          "MaxValue": 10,
          "Default": 2
        },
        "HttpCheckMethod": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.HealthCheckType}",
                  "Http"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "When the health check protocol is http or https type, the selected health check detection method"
          },
          "AllowedValues": [
            "GET",
            "HEAD"
          ],
          "Required": true,
          "Default": "GET"
        },
        "HealthyThreshold": {
          "Type": "Number",
          "Description": {
            "en": "Determine the health check status of the backend server from fail to success."
          },
          "Required": false,
          "MinValue": 2,
          "MaxValue": 10,
          "Default": 2
        },
        "HealthCheckConnectTimeout": {
          "Type": "Number",
          "Description": {
            "en": "Maximum timeout for each health check response"
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 300,
          "Default": 5
        },
        "HealthCheckDomain": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.HealthCheckType}",
                  "Http"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Domain name for health check"
          },
          "Required": false
        },
        "HealthCheckEnabled": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Whether to open health check"
          },
          "Required": false
        },
        "HealthCheckHttpCode": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "AutoChangeType": false
              },
              "Type": "String",
              "AllowedValues": [
                "http_2xx",
                "http_3xx",
                "http_4xx",
                "http_5xx"
              ],
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Required": false
        },
        "HealthCheckType": {
          "Type": "String",
          "Description": {
            "en": "Type of health check"
          },
          "AllowedValues": [
            "Tcp",
            "Http"
          ],
          "Required": false,
          "Default": "Tcp"
        }
      }
    },
    "Description": {
      "en": "Health Check Config"
    },
    "Label": {
      "en": "HealthCheckConfig",
      "zh-cn": "健康检查相关配置"
    }
  }
  EOT
}

variable "protocol" {
  type        = string
  default     = "TCP"
  description = <<EOT
  {
    "Description": {
      "en": "Protocol of ServerGroup"
    },
    "AllowedValues": [
      "TCP",
      "UDP",
      "TCPSSL"
    ],
    "Label": {
      "en": "Protocol",
      "zh-cn": "后端转发协议"
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

variable "server_group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Name of ServerGroup"
    },
    "Label": {
      "en": "ServerGroupName",
      "zh-cn": "服务器组名称"
    }
  }
  EOT
}

resource "alicloud_nlb_server_group" "extension_resource" {
  resource_group_id          = var.resource_group_id
  scheduler                  = var.scheduler
  preserve_client_ip_enabled = var.preserve_client_ip_enabled
  server_group_type          = var.server_group_type
  connection_drain_enabled   = var.connection_drain_enabled
  connection_drain_timeout   = var.connection_drain_timeout
  vpc_id                     = var.vpc_id
  any_port_enabled           = var.any_port_enabled
  protocol                   = var.protocol
  tags                       = var.tags
  server_group_name          = var.server_group_name
}

output "server_group_id" {
  value       = alicloud_nlb_server_group.extension_resource.id
  description = "ID of ServerGroup"
}

