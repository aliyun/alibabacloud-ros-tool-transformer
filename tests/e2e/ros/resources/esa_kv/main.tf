variable "expiration_ttl" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The time when the key-value pair expires, which cannot be earlier than the current time. The value is a timestamp in seconds. If you specify both Expiration and ExpirationTtl, only ExpirationTtl takes effect."
    },
    "Label": {
      "en": "ExpirationTtl",
      "zh-cn": "键的过期时间"
    }
  }
  EOT
}

variable "expiration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The content of the key, which can be up to 2 MB (2 × 1000 × 1000). If the content is larger than 2 MB, call [PutKvWithHighCapacity] https://www.alibabacloud.com/help/en/doc-detail/2850486.html."
    },
    "Label": {
      "en": "Expiration",
      "zh-cn": "键的过期时间"
    }
  }
  EOT
}

variable "value" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The content of the key. If the content has more than 256 characters in length, the system displays the first 100 and the last 100 characters, and omits the middle part."
    },
    "Label": {
      "en": "Value",
      "zh-cn": "键的内容，"
    }
  }
  EOT
}

variable "namespace" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name specified when calling [CreatevNamespace] https://help.aliyun.com/document_detail/2850317.html."
    },
    "Label": {
      "en": "Namespace",
      "zh-cn": "KV 存储空间的名字"
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
      "en": "The key name. The name can be up to 512 characters in length and cannot contain spaces or backslashes (\\)."
    },
    "Label": {
      "en": "Key",
      "zh-cn": "需要设置的键名称"
    }
  }
  EOT
}

resource "alicloud_esa_kv" "extension_resource" {
  expiration_ttl = var.expiration_ttl
  expiration     = var.expiration
  value          = var.value
  namespace      = var.namespace
  key            = var.key
}

