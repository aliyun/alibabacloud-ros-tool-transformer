variable "key_pair_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the key pair. The name must be globally unique. The name must be 2 to 128 characters in length. The name must start with a letter but cannot start with http:// or https://. The name can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对名称"
    }
  }
  EOT
}

variable "public_key_body" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The public key content of the key pair."
    },
    "Label": {
      "en": "PublicKeyBody",
      "zh-cn": "密钥对的公钥内容"
    }
  }
  EOT
}

resource "alicloud_ecp_key_pair" "extension_resource" {
  key_pair_name   = var.key_pair_name
  public_key_body = var.public_key_body
}

output "key_pair_finger_print" {
  // Could not transform ROS Attribute KeyPairFingerPrint to Terraform attribute.
  value       = null
  description = "The fingerprint of the key pair. The message-digest algorithm 5 (MD5) is used based on the public key fingerprint format defined in RFC 4716."
}

output "key_pair_name" {
  value       = alicloud_ecp_key_pair.extension_resource.id
  description = "The name of the key pair."
}

output "create_time" {
  // Could not transform ROS Attribute CreateTime to Terraform attribute.
  value       = null
  description = "The creation time of the resource."
}

