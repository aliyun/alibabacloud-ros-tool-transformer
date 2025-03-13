variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the user gateway.\nThe length is 2-256 characters and must start with a letter or Chinese, but cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "用户网关的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "ip_address" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IP address of the user gateway."
    },
    "Label": {
      "en": "IpAddress",
      "zh-cn": "用户网关的IP地址"
    }
  }
  EOT
}

variable "asn" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The autonomous system number of the local data center gateway device."
    },
    "MinValue": 1,
    "Label": {
      "en": "Asn",
      "zh-cn": "本地数据中心网关设备的自治系统号"
    },
    "MaxValue": 4294967295
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the user gateway.\nThe length is 2-128 characters and must start with a letter or Chinese. It can contain numbers, periods (.), underscores (_), and dashes (-). But it can't start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "用户网关的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_vpn_customer_gateway" "customer_gateway" {
  description = var.description
  ip_address  = var.ip_address
  asn         = var.asn
  name        = var.name
}

output "customer_gateway_id" {
  value       = alicloud_vpn_customer_gateway.customer_gateway.id
  description = "The ID of the user gateway."
}

