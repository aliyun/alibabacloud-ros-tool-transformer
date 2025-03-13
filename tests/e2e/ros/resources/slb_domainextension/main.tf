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
      "zh-cn": "负载均衡实例HTTPS监听的前端端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "server_certificate_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the certificate corresponding to the domain name."
    },
    "Label": {
      "en": "ServerCertificateId",
      "zh-cn": "与域名对应的证书ID"
    }
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
      "zh-cn": "负载均衡实例的ID"
    }
  }
  EOT
}

variable "domain" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The domain name."
    },
    "Label": {
      "en": "Domain",
      "zh-cn": "域名"
    }
  }
  EOT
}

resource "alicloud_slb_domain_extension" "domain_extension" {
  frontend_port         = var.listener_port
  server_certificate_id = var.server_certificate_id
  load_balancer_id      = var.load_balancer_id
  domain                = var.domain
}

output "domain_extension_id" {
  value       = alicloud_slb_domain_extension.domain_extension.id
  description = "The ID of the created domain name extension."
}

output "listener_port" {
  // Could not transform ROS Attribute ListenerPort to Terraform attribute.
  value       = null
  description = <<EOT
  "The front-end HTTPS listener port of the Server Load Balancer instance. Valid value:\n1-65535"
  EOT
}

