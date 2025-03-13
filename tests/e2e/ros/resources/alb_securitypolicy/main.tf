variable "ciphers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "TLS 1.0 and TLS 1.1 support the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nTLS 1.2 supports the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nECDHE-ECDSA-AES128-GCM-SHA256\nECDHE-ECDSA-AES256-GCM-SHA384\nECDHE-ECDSA-AES128-SHA256\nECDHE-ECDSA-AES256-SHA384\nECDHE-RSA-AES128-GCM-SHA256\nECDHE-RSA-AES256-GCM-SHA384\nECDHE-RSA-AES128-SHA256\nECDHE-RSA-AES256-SHA384\nAES128-GCM-SHA256\nAES256-GCM-SHA384\nAES128-SHA256\nAES256-SHA256\nTLS 1.3 supports the following cipher suites:\nTLS_AES_128_GCM_SHA256\nTLS_AES_256_GCM_SHA384\nTLS_CHACHA20_POLY1305_SHA256\nTLS_AES_128_CCM_SHA256\nTLS_AES_128_CCM_8_SHA256"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The supported cipher suites, which are determined by the TLS protocol version.\nThe specified cipher suites must be supported by at least one TLS protocol version that you specify.\nNote For example, if you set the TLSVersions parameter to TLSv1.3, you must specify cipher suites that are supported by TLS 1.3."
    },
    "Label": {
      "en": "Ciphers",
      "zh-cn": "支持的加密套件"
    },
    "MinLength": 1,
    "MaxLength": 20
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "tlsversions" {
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
      "en": "The supported versions of the Transport Layer Security (TLS) protocol. Valid values: TLSv1.0, TLSv1.1, TLSv1.2, and TLSv1.3 and so on."
    },
    "Label": {
      "en": "TLSVersions",
      "zh-cn": "支持的TLS协议版本"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "security_policy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the security policy.\nThe name must be 2 to 128 characters in length, and can contain letters, digits, periods\n(.), underscores (_), and hyphens (-). The name must start with a letter."
    },
    "Label": {
      "en": "SecurityPolicyName",
      "zh-cn": "安全策略名称"
    }
  }
  EOT
}

resource "alicloud_alb_security_policy" "security_policy" {
  ciphers              = var.ciphers
  resource_group_id    = var.resource_group_id
  security_policy_name = var.security_policy_name
}

output "security_policy_id" {
  value       = alicloud_alb_security_policy.security_policy.id
  description = "The ID of the security policy."
}

