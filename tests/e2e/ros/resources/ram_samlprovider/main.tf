variable "samlprovider_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "IdP Name. The IdP name can contain a maximum of 128 characters and only letters, numbers, and the following special characters are accepted: hyphens (-), periods (.), and underscores (_). It cannot start or end with a special character."
    },
    "Label": {
      "en": "SAMLProviderName",
      "zh-cn": "身份提供商名称"
    },
    "MinLength": 1,
    "MaxLength": 128
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description can contain a maximum of 256 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "备注"
    },
    "MaxLength": 256
  }
  EOT
}

variable "samlmetadata_documenturl" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The URL for the file that contains the SAML metadata document. The URL must point to a document located in an HTTP or HTTPS web server or an Alibaba Cloud OSS bucket. Examples: oss://ros/document/demo and oss://ros/document/demo?RegionId=cn-hangzhou. The URL can be up to 1,024 bytes in length.\nOnly one of the three properties SAMLMetadataDocument, SAMLMetadataDocumentURL, EncodedSAMLMetadataDocument can be set."
    },
    "Label": {
      "en": "SAMLMetadataDocumentURL",
      "zh-cn": "元数据文档地址"
    },
    "MinLength": 1,
    "MaxLength": 1024
  }
  EOT
}

variable "encodedsamlmetadata_document" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SAML metadata document.Base64 encoded. Provided by an identity provider that supports the SAML2.0 protocol.\nOnly one of the three properties SAMLMetadataDocument, SAMLMetadataDocumentURL, EncodedSAMLMetadataDocument can be set.",
      "zh-cn": "元数据文档。经过Base64编码。"
    },
    "Label": {
      "en": "EncodedSAMLMetadataDocument",
      "zh-cn": "元数据文档"
    },
    "MaxLength": 102400
  }
  EOT
}

variable "samlmetadata_document" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SAML metadata document. The content must be 1 to 102,400 bytes in length.\nOnly one of the three properties SAMLMetadataDocument, SAMLMetadataDocumentURL, EncodedSAMLMetadataDocument can be set."
    },
    "Label": {
      "en": "SAMLMetadataDocument",
      "zh-cn": "元数据文档内容"
    },
    "MinLength": 1,
    "MaxLength": 102400
  }
  EOT
}

resource "alicloud_ram_saml_provider" "samlprovider" {
  saml_provider_name            = var.samlprovider_name
  description                   = var.description
  encodedsaml_metadata_document = var.samlmetadata_document
}

output "samlprovider_name" {
  value       = alicloud_ram_saml_provider.samlprovider.id
  description = "IdP Name."
}

output "arn" {
  value       = alicloud_ram_saml_provider.samlprovider.arn
  description = "ARN."
}

