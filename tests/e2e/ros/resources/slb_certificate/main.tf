variable "certificate_type" {
  type        = string
  default     = "Server"
  description = <<EOT
  {
    "Description": {
      "en": "The type of the certificate."
    },
    "AllowedValues": [
      "Server",
      "CA"
    ],
    "Label": {
      "en": "CertificateType",
      "zh-cn": "证书类型"
    }
  }
  EOT
}

variable "ali_cloud_certificate_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Alibaba Cloud certificate."
    },
    "Label": {
      "en": "AliCloudCertificateName",
      "zh-cn": "阿里云的云上证书名称"
    }
  }
  EOT
}

variable "private_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The private key."
    },
    "Label": {
      "en": "PrivateKey",
      "zh-cn": "需要上传的私钥"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "certificate_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the certificate."
    },
    "Label": {
      "en": "CertificateName",
      "zh-cn": "证书名称"
    }
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
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "certificate" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The content of the certificate public key."
    },
    "Label": {
      "en": "Certificate",
      "zh-cn": "需要上传证书的内容"
    }
  }
  EOT
}

variable "ali_cloud_certificate_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Alibaba Cloud certificate."
    },
    "Label": {
      "en": "AliCloudCertificateId",
      "zh-cn": "阿里云的云上证书ID"
    }
  }
  EOT
}

resource "alicloud_slb_ca_certificate" "slbcertificate" {
  resource_group_id   = var.resource_group_id
  ca_certificate_name = var.certificate_name
  tags                = var.tags
  ca_certificate      = var.certificate
}

output "fingerprint" {
  // Could not transform ROS Attribute Fingerprint to Terraform attribute.
  value       = null
  description = "The fingerprint of the certificate."
}

output "certificate_id" {
  value       = alicloud_slb_ca_certificate.slbcertificate.id
  description = "The ID of the certificate."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

