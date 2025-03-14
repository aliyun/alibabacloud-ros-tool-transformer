variable "rr" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Host record, if you want to resolve @.exmaple.com, the host record should fill in \"@\" instead of empty"
    },
    "Label": {
      "en": "RR",
      "zh-cn": "主机记录"
    }
  }
  EOT
}

variable "line" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Parse the line, the default is default. See parsing line enumeration"
    },
    "Label": {
      "en": "Line",
      "zh-cn": "解析线路"
    }
  }
  EOT
}

variable "type" {
  type        = string
  default     = "A"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "A": {
          "en": "A-Points a domain name to an IPv4 address.",
          "zh-cn": "A——将域名指向一个IPV4地址"
        },
        "TXT": {
          "en": "TXT-Serves an SPF record to protect against spam and can be up to 512 characters in length.",
          "zh-cn": "TXT——文本长度限制512，通常做SPF记录（反垃圾邮件）"
        },
        "CAA": {
          "en": "CAA-Specifies a CA that is authorized to issue certificates for a domain name.",
          "zh-cn": "CAA——CA证书颁发机构授权检验"
        },
        "FORWARD_URL": {
          "en": "Implicit URL Forwarding-Redirects a domain name to another address but hides the destination address.",
          "zh-cn": "隐性URL——与显性URL类似，但是会隐藏真实目标地址"
        },
        "NS": {
          "en": "NS-Delegates a subdomain name to third-party DNS servers.",
          "zh-cn": "NS——将子域名指定其他DNS服务器解析"
        },
        "SRV": {
          "en": "SRV-Specifies the servers that host specific services.",
          "zh-cn": "SRV——记录提供特定的服务的服务器"
        },
        "CNAME": {
          "en": "CNAME-Points a domain name to another domain name.",
          "zh-cn": "CNAME——将域名指向另外一个域名"
        },
        "MX": {
          "en": "MX-Points a domain name to an email server address.",
          "zh-cn": "MX——将域名指向邮件服务器地址"
        },
        "REDIRECT_URL": {
          "en": "Explicit URL Forwarding-Redirects a domain name to another address.",
          "zh-cn": "显性URL——将域名重定向到另外一个地址"
        },
        "AAAA": {
          "en": "AAAA-Points a domain name to an IPv6 address.",
          "zh-cn": "AAAA——将域名指向一个IPV6地址"
        }
      },
      "AutoChangeType": false
    },
    "Description": {
      "en": "Parse record type, see parsing record type format"
    },
    "AllowedValues": [
      "A",
      "NS",
      "MX",
      "TXT",
      "CNAME",
      "SRV",
      "AAAA",
      "CAA",
      "REDIRECT_URL",
      "FORWARD_URL"
    ],
    "Label": {
      "en": "Type",
      "zh-cn": "解析记录类型"
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

variable "priority" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The priority of the MX record, the value range [1,10], when the record type is MX record, this parameter must be"
    },
    "MinValue": 1,
    "Label": {
      "en": "Priority",
      "zh-cn": "MX记录的优先级"
    },
    "MaxValue": 10
  }
  EOT
}

variable "value" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Record value"
    },
    "Label": {
      "en": "Value",
      "zh-cn": "记录值"
    }
  }
  EOT
}

variable "ttl" {
  type        = number
  default     = 600
  description = <<EOT
  {
    "Description": {
      "en": "The resolution time is valid. The default is 600 seconds (10 minutes). See the TTL definition."
    },
    "Label": {
      "en": "TTL",
      "zh-cn": "解析生效时间"
    }
  }
  EOT
}

resource "alicloud_dns_record" "domain_record" {
  host_record = var.rr
  type        = var.type
  name        = var.domain_name
  priority    = var.priority
  value       = var.value
}

output "record_id" {
  value       = alicloud_dns_record.domain_record.id
  description = "Parse the ID of the record"
}

