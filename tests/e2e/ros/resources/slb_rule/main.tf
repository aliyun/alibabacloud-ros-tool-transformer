variable "listener_port" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The front-end HTTPS listener port of the Server Load Balancer instance. Valid value:\n1-65535"
    },
    "MinValue": 1,
    "Label": {
      "en": "ListenerPort",
      "zh-cn": "负载均衡实例前端使用的监听端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "rule_list" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "VServerGroupId": {
              "Type": "String",
              "Description": {
                "en": "The ID of the VServer group associated with the forwarding rule."
              },
              "Required": true
            },
            "AdvancedSettings": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "CookieTimeout": {
                    "Type": "Number",
                    "Description": {
                      "en": "The timeout period of a cookie. Unit: seconds."
                    },
                    "Required": false
                  },
                  "Cookie": {
                    "Type": "String",
                    "Description": {
                      "en": "The cookie that is configured on the server.\nThe cookie must be 1 to 200 characters in length and can contain only ASCII characters and digits. It cannot contain commas (,), semicolons (;), or space characters. It cannot start with a dollar sign ($)."
                    },
                    "Required": false
                  },
                  "HealthCheckInterval": {
                    "Type": "Number",
                    "Description": {
                      "en": "The interval between two consecutive health checks. Unit: seconds. Valid values: 1 to 50."
                    },
                    "Required": false
                  },
                  "UnhealthyThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of times that a healthy backend server must consecutively fail health checks before it is declared unhealthy. In this case, the health status is changed from success to fail."
                    },
                    "Required": false
                  },
                  "HealthCheckURI": {
                    "Type": "String",
                    "Description": {
                      "en": "The URI that is used for health checks."
                    },
                    "Required": false
                  },
                  "Scheduler": {
                    "Type": "String",
                    "Description": {
                      "en": "The scheduling algorithm. Valid values:\nwrr: Backend servers with higher weights receive more requests than those with lower weights.\nrr: Requests are distributed to backend servers in sequence."
                    },
                    "AllowedValues": [
                      "wrr",
                      "rr"
                    ],
                    "Required": false
                  },
                  "HealthCheck": {
                    "Type": "String",
                    "Description": {
                      "en": "Specifies whether to enable the health check feature. Valid values:\non: yes\noff: no"
                    },
                    "AllowedValues": [
                      "on",
                      "off"
                    ],
                    "Required": false
                  },
                  "HealthCheckTimeout": {
                    "Type": "Number",
                    "Description": {
                      "en": "The timeout period of a health check response. If a backend server, such as an Elastic Compute Service (ECS) instance, does not return a health check response within the specified timeout period, the server fails the health check. Unit: seconds. Valid values: 1 to 300."
                    },
                    "Required": false
                  },
                  "StickySession": {
                    "Type": "String",
                    "Description": {
                      "en": "Specifies whether to enable session persistence. Valid values:\non: yes\noff: no"
                    },
                    "AllowedValues": [
                      "on",
                      "off"
                    ],
                    "Required": false
                  },
                  "HealthCheckConnectPort": {
                    "Type": "Number",
                    "Description": {
                      "en": "The port that is used for health checks. Valid values: 1 to 65535."
                    },
                    "Required": false
                  },
                  "HealthyThreshold": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of times that an unhealthy backend server must consecutively pass health checks before it is declared healthy. In this case, the health status is changed from fail to success."
                    },
                    "Required": false
                  },
                  "ListenerSync": {
                    "Type": "String",
                    "Description": {
                      "en": "Specifies whether to use the scheduling algorithm, session persistence, and health check configurations of the listener. Valid values:\non: uses the configurations of the listener.\noff: does not use the configurations of the listener. You can customize the health check and session persistence configurations for the forwarding rule."
                    },
                    "AllowedValues": [
                      "on",
                      "off"
                    ],
                    "Required": false
                  },
                  "HealthCheckDomain": {
                    "Type": "String",
                    "Description": {
                      "en": "The domain name that is used for health checks. Valid values:\n$_ip: the private IP address of a backend server. If you do not set this parameter or set the parameter to $_ip, the SLB instance uses the private IP address of each backend server for health checks.\ndomain: The domain name must be 1 to 80 characters in length, and can contain letters, digits, periods (.), and hyphens (-)."
                    },
                    "Required": false
                  },
                  "StickySessionType": {
                    "Type": "String",
                    "Description": {
                      "en": "The method that is used to handle a cookie. Valid values:\ninsert: inserts a cookie.\nserver: rewrites a cookie."
                    },
                    "Required": false
                  },
                  "HealthCheckHttpCode": {
                    "Type": "String",
                    "Description": {
                      "en": "The HTTP status code for a successful health check. Multiple HTTP status codes are separated by commas (,).\nValid values: http_2xx, http_3xx, http_4xx, and http_5xx."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "The advanced settings of the rule."
              },
              "Required": false
            },
            "Domain": {
              "Type": "String",
              "Description": {
                "en": "The domain name."
              },
              "Required": false
            },
            "Url": {
              "Type": "String",
              "Description": {
                "en": "The URL."
              },
              "Required": false
            },
            "RuleName": {
              "Type": "String",
              "Description": {
                "en": "The name of the forwarding rule."
              },
              "Required": true
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The forwarding rules to add."
    },
    "Label": {
      "en": "RuleList",
      "zh-cn": "要添加的转发规则"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "load_balancer_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of Server Load Balancer instance."
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
  description = <<EOT
  {
    "Description": {
      "en": "The frontend protocol that is used by the SLB instance."
    },
    "Label": {
      "en": "ListenerProtocol",
      "zh-cn": "实例前端使用的协议"
    }
  }
  EOT
}

resource "alicloud_slb_rule" "rule" {
  frontend_port    = var.listener_port
  load_balancer_id = var.load_balancer_id
}

output "rules" {
  // Could not transform ROS Attribute Rules to Terraform attribute.
  value       = null
  description = "A list of forwarding rules. Each element of rules contains \"RuleId\"."
}

