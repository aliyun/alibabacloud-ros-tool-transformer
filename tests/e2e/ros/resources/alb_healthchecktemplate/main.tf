variable "health_check_interval" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The interval between two consecutive health checks. Unit: seconds.\nValid values: 1 to 50.\nDefault value: 2."
    },
    "Label": {
      "en": "HealthCheckInterval",
      "zh-cn": "健康检查的时间间隔"
    }
  }
  EOT
}

variable "health_check_codes" {
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
      "en": "The HTTP status code for a successful health check.\nIf HealthCheckProtocol is set to HTTP, HealthCheckCodes can be set to http_2xx (default), http_3xx, http_4xx, and http_5xx. Separate multiple HTTP status codes with commas (,).\nIf HealthCheckProtocol is set to gRPC, HealthCheckCodes can be set to 0 to 99. Default value: 0. Value ranges are supported. You can enter at most 20 value ranges and must separate\nthem with commas (,).\nNote This parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
    },
    "Label": {
      "en": "HealthCheckCodes",
      "zh-cn": "健康检查正常的HTTP状态码"
    },
    "MaxLength": 20
  }
  EOT
}

variable "health_check_connect_port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The port that is used for health checks.\nValid values: 0 to 65535.\nDefault value: 0. This value indicates that the port on a backend server is used for health checks."
    },
    "Label": {
      "en": "HealthCheckConnectPort",
      "zh-cn": "健康检查使用的端口"
    }
  }
  EOT
}

variable "unhealthy_threshold" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of times that a healthy backend server must consecutively fail health checks\nbefore it is declared unhealthy. In this case, the health status is changed from success to fail.\nValid values: 2 to 10.\nDefault value: 3.",
      "zh-cn": "健康检查连续失败多少次后，将后端服务器的健康检查状态由成功判定为失败。"
    },
    "Label": {
      "en": "UnhealthyThreshold",
      "zh-cn": "健康检查连续失败多少次后"
    }
  }
  EOT
}

variable "health_check_method" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The HTTP method that is used for health checks. Valid values:\nHEAD: By default, the ALB instance sends HEAD requests to a backend server to perform\nHTTP health checks.\nPOST: By default, gRPC health checks use the POST method.\nGET: If the length of a response exceeds 8 KB, the response is truncated. However, the\nhealth check result is not affected.\nNote This parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
    },
    "AllowedValues": [
      "HEAD",
      "GET",
      "POST"
    ],
    "Label": {
      "en": "HealthCheckMethod",
      "zh-cn": "健康检查方法"
    }
  }
  EOT
}

variable "healthy_threshold" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of times that an unhealthy backend server must consecutively pass health\nchecks before it is declared healthy. In this case, the health status is changed from\nfail to success.\nValid values: 2 to 10.\nDefault value: 3.",
      "zh-cn": "健康检查连续成功多少次后，将后端服务器的健康检查状态由失败判定为成功。"
    },
    "Label": {
      "en": "HealthyThreshold",
      "zh-cn": "健康检查连续成功多少次后"
    }
  }
  EOT
}

variable "health_check_template_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the health check template.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods\n(.), underscores (_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "HealthCheckTemplateName",
      "zh-cn": "健康检查模板名称"
    }
  }
  EOT
}

variable "health_check_host" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The domain name that is used for health checks.\nDefault value: $SERVER_IP. The domain name is 1 to 80 characters in length. Make sure that the destination\nCIDR block meets the following requirements:\nThe domain name can contain lowercase letters, digits, hyphens (-), and periods (.).\nThe domain name contains at least one period (.) but does not start or end with a\nperiod (.).\nThe rightmost domain label can contain only letters, and cannot contain digits or\nhyphens (-).\nOther domain labels cannot start or end with a hyphen (-).\nThis parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
    },
    "Label": {
      "en": "HealthCheckHost",
      "zh-cn": "用于健康检查的域名"
    }
  }
  EOT
}

variable "health_check_path" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The URL path that is used for health checks.\nIt must be 1 to 80 characters in length, and can contain letters, digits, hyphens\n(-), forward slashes (/), periods (.), percent signs (%), question marks (?), number\nsigns (#), and ampersands (&). It can also contain the following extended characters:\n_ ; ~ ! ( ) * [ ] @ $ ^ : ' , +. The URL path must start with a forward slash (/).\nNote This parameter is required only if the HealthCheckProtocol parameter is set to HTTP."
    },
    "Label": {
      "en": "HealthCheckPath",
      "zh-cn": "用于健康检查的URL"
    }
  }
  EOT
}

variable "health_check_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The protocol that is used for health checks. Valid values:\nHTTP: The ALB instance sends HEAD or GET requests to a backend server to simulate access\nfrom a browser and check whether the backend server is healthy. This is the default\nprotocol.\nTCP: To perform TCP health checks, ALB sends SYN packets to a backend server to check\nwhether the port of the backend server is available to receive requests.\nGRPC: To perform gRPC health checks, ALB sends POST or GET requests to a backend server\nto check whether the backend server is healthy."
    },
    "AllowedValues": [
      "HTTP",
      "TCP",
      "gRPC"
    ],
    "Label": {
      "en": "HealthCheckProtocol",
      "zh-cn": "健康检查采用的协议"
    }
  }
  EOT
}

variable "health_check_timeout" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period of a health check. Unit: seconds. If a backend server does not\nrespond within the specified timeout period, the backend server fails the health check.\nValid values: 1 to 300.\nDefault value: 5.\nNote If the value of the HealthCheckTimeout parameter is smaller than that of the HealthCheckInterval parameter, the timeout period specified by the HealthCheckTimeout parameter is ignored and the value of the HealthCheckInterval parameter is used as the timeout period."
    },
    "Label": {
      "en": "HealthCheckTimeout",
      "zh-cn": "接收来自运行状况检查响应需要等待的时间"
    }
  }
  EOT
}

resource "alicloud_alb_health_check_template" "health_check_template" {
  health_check_interval      = var.health_check_interval
  health_check_codes         = var.health_check_codes
  health_check_connect_port  = var.health_check_connect_port
  unhealthy_threshold        = var.unhealthy_threshold
  health_check_method        = var.health_check_method
  healthy_threshold          = var.healthy_threshold
  health_check_template_name = var.health_check_template_name
  health_check_host          = var.health_check_host
  health_check_path          = var.health_check_path
  health_check_protocol      = var.health_check_protocol
  health_check_timeout       = var.health_check_timeout
}

output "health_check_template_id" {
  value       = alicloud_alb_health_check_template.health_check_template.id
  description = "The ID of the health check template."
}

