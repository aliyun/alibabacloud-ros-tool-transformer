variable "source_ip" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the source IP address of the request."
    },
    "Label": {
      "en": "SourceIp",
      "zh-cn": "指定请求的来源IP地址"
    }
  }
  EOT
}

variable "lang" {
  type        = string
  default     = "zh"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "Language"
    },
    "Description": {
      "en": "Specifies the language type for requesting and receiving messages."
    },
    "AllowedValues": [
      "zh",
      "en"
    ],
    "Label": {
      "en": "Lang",
      "zh-cn": "指定请求和接收消息的语言类型"
    }
  }
  EOT
}

variable "cert" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specify the content of the certificate. To use the PEM encoding format.",
      "zh-cn": "指定证书内容。要使用PEM编码格式。"
    },
    "Label": {
      "en": "Cert",
      "zh-cn": "指定证书内容"
    }
  }
  EOT
}

variable "key" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specify the certificate private key content. To use the PEM encoding format.",
      "zh-cn": "指定证书私钥内容。要使用PEM编码格式。"
    },
    "Label": {
      "en": "Key",
      "zh-cn": "指定证书私钥内容"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Custom certificate name. The certificate name under a user cannot be duplicated.",
      "zh-cn": "自定义证书名称。一个用户下的证书名称不能重复。"
    },
    "Label": {
      "en": "Name",
      "zh-cn": "自定义证书名称"
    }
  }
  EOT
}

resource "alicloud_ssl_certificates_service_certificate" "certificate" {
  lang             = var.lang
  cert             = var.cert
  key              = var.key
  certificate_name = var.name
}

output "cert_id" {
  value       = alicloud_ssl_certificates_service_certificate.certificate.id
  description = "Certificate ID."
}

