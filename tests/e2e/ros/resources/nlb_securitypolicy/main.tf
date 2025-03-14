variable "ciphers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "AutoChangeType": false
        },
        "Type": "String",
        "Description": {
          "en": "TLS 1.0 and TLS 1.1 support the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nTLS 1.2 supports the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nECDHE-ECDSA-AES128-GCM-SHA256\nECDHE-ECDSA-AES256-GCM-SHA384\nECDHE-ECDSA-AES128-SHA256\nECDHE-ECDSA-AES256-SHA384\nECDHE-RSA-AES128-GCM-SHA256\nECDHE-RSA-AES256-GCM-SHA384\nECDHE-RSA-AES128-SHA256\nECDHE-RSA-AES256-SHA384\nAES128-GCM-SHA256\nAES256-GCM-SHA384\nAES128-SHA256\nAES256-SHA256\nTLS 1.3 supports the following cipher suites:\nTLS_AES_128_GCM_SHA256\nTLS_AES_256_GCM_SHA384\nTLS_CHACHA20_POLY1305_SHA256\nTLS_AES_128_CCM_SHA256\nTLS_AES_128_CCM_8_SHA256"
        },
        "AllowedValues": [
          "ECDHE-ECDSA-AES128-SHA",
          "ECDHE-ECDSA-AES256-SHA",
          "ECDHE-RSA-AES128-SHA",
          "ECDHE-RSA-AES256-SHA",
          "AES128-SHA",
          "AES256-SHA",
          "DES-CBC3-SHA",
          "ECDHE-ECDSA-AES128-GCM-SHA256",
          "ECDHE-ECDSA-AES256-GCM-SHA384",
          "ECDHE-ECDSA-AES128-SHA256",
          "ECDHE-ECDSA-AES256-SHA384",
          "ECDHE-RSA-AES128-GCM-SHA256",
          "ECDHE-RSA-AES256-GCM-SHA384",
          "ECDHE-RSA-AES128-SHA256",
          "ECDHE-RSA-AES256-SHA384",
          "AES128-GCM-SHA256AES256-GCM-SHA384",
          "AES128-SHA256",
          "AES256-SHA256",
          "TLS_AES_128_GCM_SHA256",
          "TLS_AES_256_GCM_SHA384",
          "TLS_CHACHA20_POLY1305_SHA256",
          "TLS_AES_128_CCM_SHA256",
          "TLS_AES_128_CCM_8_SHA256"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "TThe supported cipher suites, which are determined by the TLS protocol version. You can specify at most 32 cipher suites."
    },
    "Label": {
      "en": "Ciphers",
      "zh-cn": "支持的加密套件列表"
    },
    "MinLength": 1,
    "MaxLength": 32
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

variable "security_policy_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the security policy.\nThe name must be 1 to 200 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "SecurityPolicyName",
      "zh-cn": "安全策略名称"
    }
  }
  EOT
}

variable "tls_versions" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "AutoChangeType": false
        },
        "Type": "String",
        "AllowedValues": [
          "TLSv1.0",
          "TLSv1.1",
          "TLSv1.2",
          "TLSv1.3"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The supported versions of the Transport Layer Security (TLS) protocol. Valid values: TLSv1.0, TLSv1.1, TLSv1.2, and TLSv1.3."
    },
    "Label": {
      "en": "TlsVersions",
      "zh-cn": "支持的TLS协议版本"
    },
    "MinLength": 1,
    "MaxLength": 4
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_nlb_security_policy" "security_policy" {
  ciphers              = var.ciphers
  resource_group_id    = var.resource_group_id
  security_policy_name = var.security_policy_name
  tls_versions         = var.tls_versions
  tags                 = var.tags
}

output "security_policy_id" {
  value       = alicloud_nlb_security_policy.security_policy.id
  description = "The ID of the security policy."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

