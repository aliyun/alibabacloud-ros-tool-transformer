variable "alias_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "- The display name of the key. You can use the alias to call APIs such as Encrypt, GenerateDataKey, and DescribeKey. - Not including the prefix, the minimum length of an alias is 1 and the maximum length is 255. - The prefix alias/ must be included.",
      "zh-cn": "CMK 的别名，可以使用别名调用 Encrypt、GenerateDataKey、 DescribeKey。"
    },
    "Label": {
      "en": "AliasName",
      "zh-cn": "CMK 的别名"
    },
    "MinLength": 1,
    "MaxLength": 255
  }
  EOT
}

variable "key_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Globally unique identifier of the CMK."
    },
    "Label": {
      "en": "KeyId",
      "zh-cn": "Key的全局唯一标识符"
    }
  }
  EOT
}

resource "alicloud_kms_alias" "alias" {
  alias_name = var.alias_name
  key_id     = var.key_id
}

