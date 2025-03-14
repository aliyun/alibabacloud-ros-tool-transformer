variable "http_to_user_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Http back to source",
      "zh-cn": "是否开启HTTP回源功能。开启后HTTPS访问请求将通过HTTP协议转发回源站，默认回源端口为80端口。"
    },
    "Label": {
      "en": "HttpToUserIp",
      "zh-cn": "是否开启HTTP回源功能"
    }
  }
  EOT
}

variable "http_port" {
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
      "en": "Http port configuration"
    },
    "Label": {
      "en": "HttpPort",
      "zh-cn": "HTTP协议配置的端口"
    }
  }
  EOT
}

variable "is_access_product" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Is there a seven-layer agency before WAF",
      "zh-cn": "该域名在WAF前是否配置有七层代理（例如：高防、CDN等），即客户端访问流量到WAF前是否有经过其它七层代理转发。"
    },
    "Label": {
      "en": "IsAccessProduct",
      "zh-cn": "该域名在WAF前是否配置有七层代理（例如：高防、CDN等）"
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
      "en": "Resource group Id"
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "域名在资源管理产品中所属的资源组ID"
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
      "en": "Domain name"
    },
    "Label": {
      "en": "DomainName",
      "zh-cn": "域名名称"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance id"
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "WAF实例ID"
    }
  }
  EOT
}

variable "source_ips" {
  type        = any
  nullable    = false
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
      "en": "Back to source IP configuration"
    },
    "Label": {
      "en": "SourceIps",
      "zh-cn": "域名对应的源站服务器IP或服务器回源域名"
    }
  }
  EOT
}

variable "read_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Read connection timeout period"
    },
    "Label": {
      "en": "ReadTime",
      "zh-cn": "WAF独享集群读连接超时时长"
    }
  }
  EOT
}

variable "cluster_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Cluster type"
    },
    "Label": {
      "en": "ClusterType",
      "zh-cn": "WAF实例的集群类别"
    }
  }
  EOT
}

variable "load_balancing" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Load balancing configuration"
    },
    "Label": {
      "en": "LoadBalancing",
      "zh-cn": "回源时采用的负载均衡算法"
    }
  }
  EOT
}

variable "log_headers" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "V": {
          "Type": "String",
          "Description": {
            "en": "The value of the traffic tag of the domain name"
          },
          "Required": false
        },
        "K": {
          "Type": "String",
          "Description": {
            "en": "The field name of the traffic tag of the domain name"
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Domain traffic tagging",
      "zh-cn": "域名的流量标记字段和值，用于标记经过WAF的流量。  该参数值的样式为[{\"k\":\"_key_\",\"v\":\"_value_\"}]。其中，_key_表示自定义请求头部字段，_value_表示为该字段设定的值。  通过指定自定义请求头部字段和对应的值，当域名的访问流量经过WAF时，系统将自动在请求头部中添加设定的自定义字段值作为流量标记，便于后端服务统计相关信息。"
    },
    "Label": {
      "en": "LogHeaders",
      "zh-cn": "域名的流量标记字段和值"
    }
  }
  EOT
}

variable "write_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Write connection timeout period"
    },
    "Label": {
      "en": "WriteTime",
      "zh-cn": "WAF独享集群写连接超时时长"
    }
  }
  EOT
}

variable "http2_port" {
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
      "en": "Http2 port configuration"
    },
    "Label": {
      "en": "Http2Port",
      "zh-cn": "HTTP 2.0协议配置的端口"
    }
  }
  EOT
}

variable "connection_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Connection timeout"
    },
    "Label": {
      "en": "ConnectionTime",
      "zh-cn": "WAF独享集群连接超时时长"
    }
  }
  EOT
}

variable "https_redirect" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Https forced redirect configuration"
    },
    "Label": {
      "en": "HttpsRedirect",
      "zh-cn": "是否开启HTTPS强制跳转"
    }
  }
  EOT
}

variable "https_port" {
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
      "en": "Https port configuration"
    },
    "Label": {
      "en": "HttpsPort",
      "zh-cn": "HTTPS协议配置的端口"
    }
  }
  EOT
}

resource "alicloud_waf_domain" "wafdomain" {
  http_to_user_ip   = var.http_to_user_ip
  http_port         = var.http_port
  is_access_product = var.is_access_product
  resource_group_id = var.resource_group_id
  domain_name       = var.domain_name
  instance_id       = var.instance_id
  source_ips        = var.source_ips
  read_time         = var.read_time
  cluster_type      = var.cluster_type
  load_balancing    = var.load_balancing
  log_headers       = var.log_headers
  write_time        = var.write_time
  http2_port        = var.http2_port
  connection_time   = var.connection_time
  https_redirect    = var.https_redirect
  https_port        = var.https_port
}

output "http_to_user_ip" {
  value       = alicloud_waf_domain.wafdomain.http_to_user_ip
  description = "Http back to source"
}

output "http_port" {
  value       = alicloud_waf_domain.wafdomain.http_port
  description = "Http port configuration"
}

output "is_access_product" {
  value       = alicloud_waf_domain.wafdomain.is_access_product
  description = "Is there a seven-layer agency before WAF"
}

output "resource_group_id" {
  value       = alicloud_waf_domain.wafdomain.resource_group_id
  description = "Resource group Id"
}

output "domain_name" {
  value       = alicloud_waf_domain.wafdomain.domain_name
  description = "Domain name"
}

output "instance_id" {
  value       = alicloud_waf_domain.wafdomain.instance_id
  description = "Instance id"
}

output "source_ips" {
  value       = alicloud_waf_domain.wafdomain.source_ips
  description = "Back to source IP configuration"
}

output "cluster_type" {
  value       = alicloud_waf_domain.wafdomain.cluster_type
  description = "Cluster type"
}

output "cname" {
  value       = alicloud_waf_domain.wafdomain.cname
  description = "CNAME assigned by WAF instance"
}

output "load_balancing" {
  value       = alicloud_waf_domain.wafdomain.load_balancing
  description = "Load balancing configuration"
}

output "log_headers" {
  // Could not transform ROS Attribute LogHeaders to Terraform attribute.
  value       = null
  description = "Domain traffic tagging"
}

output "http2_port" {
  value       = alicloud_waf_domain.wafdomain.http2_port
  description = "Http2 port configuration"
}

output "version" {
  // Could not transform ROS Attribute Version to Terraform attribute.
  value       = null
  description = "Optimistic lock version"
}

output "https_redirect" {
  value       = alicloud_waf_domain.wafdomain.https_redirect
  description = "Https forced redirect configuration"
}

output "https_port" {
  value       = alicloud_waf_domain.wafdomain.https_port
  description = "Https port configuration"
}

