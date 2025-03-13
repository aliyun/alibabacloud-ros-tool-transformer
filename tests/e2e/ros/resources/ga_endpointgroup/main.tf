variable "health_check_interval_seconds" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The interval between two consecutive health checks. Unit: seconds."
    },
    "Label": {
      "en": "HealthCheckIntervalSeconds",
      "zh-cn": "健康检查的时间间隔"
    }
  }
  EOT
}

variable "traffic_percentage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The weight of the endpoint group when the corresponding listener is associated with\nmultiple endpoint groups."
    },
    "Label": {
      "en": "TrafficPercentage",
      "zh-cn": "监听有多个终端节点组时的权重"
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
      "en": "The description of the endpoint group."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "终端节点组描述信息"
    }
  }
  EOT
}

variable "health_check_path" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The path set as the destination on the targets for health checks."
    },
    "Label": {
      "en": "HealthCheckPath",
      "zh-cn": "健康检查路径"
    }
  }
  EOT
}

variable "threshold_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of consecutive health check failures that must occur before a healthy endpoint is considered unhealthy, or the number of consecutive health check successes that must occur before an unhealthy endpoint is considered healthy.\nValid values: 2 to 10. Default value: 3."
    },
    "Label": {
      "en": "ThresholdCount",
      "zh-cn": "健康检查判定终端节点为不健康的次数"
    }
  }
  EOT
}

variable "health_check_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the health check feature."
    },
    "Label": {
      "en": "HealthCheckEnabled",
      "zh-cn": "是否开启健康检查"
    }
  }
  EOT
}

variable "endpoint_request_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol used by the backend service. Valid values:\nhttp: This is the default value.\nhttps\nNote: You can set this parameter only when the listener that is associated with the endpoint group uses HTTP or HTTPS.\nFor an HTTP listener, the backend service protocol must be HTTP."
    },
    "Label": {
      "en": "EndpointRequestProtocol",
      "zh-cn": "后端服务协议"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the endpoint group."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "终端节点组的名称"
    }
  }
  EOT
}

variable "endpoint_group_region" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The region ID of the endpoint group."
    },
    "Label": {
      "en": "EndpointGroupRegion",
      "zh-cn": "终端节点组所属的地域"
    }
  }
  EOT
}

variable "health_check_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol that is used to connect with the targets for health checks.\ntcp: TCP protocol\nhttp: HTTP protocol\nhttps: HTTPS protocol"
    },
    "AllowedValues": [
      "tcp",
      "http",
      "https"
    ],
    "Label": {
      "en": "HealthCheckProtocol",
      "zh-cn": "健康检查的协议"
    }
  }
  EOT
}

variable "health_check_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The port that is used to connect with the targets for health checks."
    },
    "Label": {
      "en": "HealthCheckPort",
      "zh-cn": "健康检查的端口"
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
      "en": "The ID of the Global Accelerator instance with which the endpoint group will be associated."
    },
    "Label": {
      "en": "AcceleratorId",
      "zh-cn": "全球加速实例ID"
    }
  }
  EOT
}

variable "endpoint_configurations" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "EnableProxyProtocol": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to obtain and preserve the IP addresses of clients that access the endpoint by using the TCP Option Address (TOA) module. Valid values:\ntrue: yes\nfalse (default): no"
          },
          "Required": false,
          "Default": "false"
        },
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of endpoint in the endpoint group. Valid values:\nDomain: a custom domain name\nEIP: eip address\nIp: a custom IP address\nPublicIp: a public IP address provided by Alibaba Cloud\nECS: an Elastic Compute Service (ECS) instance\nSLB: a Server Load Balancer (SLB) instance\nALB: an Application Load Balancer (ALB) instance\nOSS: an Object Storage Service (OSS) bucket"
          },
          "Required": true
        },
        "Endpoint": {
          "Type": "String",
          "Description": {
            "en": "The IP address or domain name of endpoint in the endpoint group."
          },
          "Required": true
        },
        "EnableClientIPPreservation": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to obtain and preserve the IP addresses of clients that access the endpoint by using the TCP Option Address (TOA) module. Valid values:\ntrue: yes\nfalse (default): no"
          },
          "Required": false,
          "Default": "false"
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of endpoint N in the endpoint group."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "EndpointConfigurations",
      "zh-cn": "终端节点"
    },
    "MinLength": 1,
    "MaxLength": 4
  }
  EOT
}

variable "endpoint_group_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the endpoint group. Valid values:\ndefault: The endpoint group is a default endpoint group. This is the default value.\nvirtual: The endpoint group is a virtual endpoint group.\nNote Only HTTP and HTTPS listeners support virtual endpoint groups."
    },
    "Label": {
      "en": "EndpointGroupType",
      "zh-cn": "终端节点组类型"
    }
  }
  EOT
}

variable "listener_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the listener to be associated with the endpoint group."
    },
    "Label": {
      "en": "ListenerId",
      "zh-cn": "监听ID"
    }
  }
  EOT
}

resource "alicloud_ga_endpoint_group" "endpoint_group" {
  health_check_interval_seconds = var.health_check_interval_seconds
  traffic_percentage            = var.traffic_percentage
  description                   = var.description
  health_check_path             = var.health_check_path
  threshold_count               = var.threshold_count
  health_check_enabled          = var.health_check_enabled
  endpoint_request_protocol     = var.endpoint_request_protocol
  name                          = var.name
  endpoint_group_region         = var.endpoint_group_region
  health_check_protocol         = var.health_check_protocol
  health_check_port             = var.health_check_port
  accelerator_id                = var.accelerator_id
  endpoint_configurations       = var.endpoint_configurations
  endpoint_group_type           = var.endpoint_group_type
  listener_id                   = var.listener_id
}

output "endpoint_group_id" {
  value       = alicloud_ga_endpoint_group.endpoint_group.id
  description = "The ID of the endpoint group."
}

