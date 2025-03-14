variable "ssl_vpn_server_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ID of the SSL-VPN server."
    },
    "Label": {
      "en": "SslVpnServerId",
      "zh-cn": "SSL-VPN服务端的ID"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the client certificate.\nThe length is 2-128 characters and must start with a letter or Chinese. It can contain numbers, periods (.), underscores (_), and dashes (-). But it can't start with http:// or https://.",
      "zh-cn": "客户端证书的名称。长度为2-128个字符，必须以字母或中文开头，可包含数字，点号（.），下划线（_）和短横线（-）。但不能以http://或https://开头。"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "客户端证书的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_ssl_vpn_client_cert" "ssl_vpn_client_cert" {
  ssl_vpn_server_id = var.ssl_vpn_server_id
  name              = var.name
}

output "ssl_vpn_client_cert_id" {
  value       = alicloud_ssl_vpn_client_cert.ssl_vpn_client_cert.id
  description = "The ID of the client certificate."
}

