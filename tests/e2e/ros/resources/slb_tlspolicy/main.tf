variable "ciphers" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The supported cipher suite."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The supported cipher suites, which are determined by the TLS protocol version. You can specify at most 32 cipher suites.TLS 1.0 and TLS 1.1 support the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nTLS 1.2 supports the following cipher suites:\nECDHE-ECDSA-AES128-SHA\nECDHE-ECDSA-AES256-SHA\nECDHE-RSA-AES128-SHA\nECDHE-RSA-AES256-SHA\nAES128-SHA\nAES256-SHA\nDES-CBC3-SHA\nECDHE-ECDSA-AES128-GCM-SHA256\nECDHE-ECDSA-AES256-GCM-SHA384\nECDHE-ECDSA-AES128-SHA256\nECDHE-ECDSA-AES256-SHA384\nECDHE-RSA-AES128-GCM-SHA256\nECDHE-RSA-AES256-GCM-SHA384\nECDHE-RSA-AES128-SHA256\nECDHE-RSA-AES256-SHA384\nAES128-GCM-SHA256\nAES256-GCM-SHA384\nAES128-SHA256\nAES256-SHA256\nTLS 1.3 supports the following cipher suites:\nTLS_AES_128_GCM_SHA256\nTLS_AES_256_GCM_SHA384\nTLS_CHACHA20_POLY1305_SHA256\nTLS_AES_128_CCM_SHA256\nTLS_AES_128_CCM_8_SHA256"
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

variable "tlspolicy_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the TLS policy. The name must be 1 to 200 characters in length, and can contain letters, digits, periods (.), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "TLSPolicyName",
      "zh-cn": "TLS策略名称"
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
        "Type": "String",
        "Description": {
          "en": "The version of the TLS protocol. Valid values: TLSv1.0, TLSv1.1, TLSv1.2, and TLSv1.3. You can specify at most four TLS versions."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The version of the TLS protocol."
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

resource "alicloud_slb_tls_cipher_policy" "extension_resource" {
  ciphers      = var.ciphers
  tls_versions = var.tls_versions
}

output "ciphers" {
  value       = alicloud_slb_tls_cipher_policy.extension_resource.ciphers
  description = "The supported cipher suites, which are determined by the TLS protocol version."
}

output "tlspolicy_name" {
  // Could not transform ROS Attribute TLSPolicyName to Terraform attribute.
  value       = null
  description = "The name of the TLS policy."
}

output "instance_id" {
  // Could not transform ROS Attribute InstanceId to Terraform attribute.
  value       = null
  description = "The ID of the policy."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "Creation time."
}

output "tls_versions" {
  value       = alicloud_slb_tls_cipher_policy.extension_resource.tls_versions
  description = "The version of the TLS protocol."
}

