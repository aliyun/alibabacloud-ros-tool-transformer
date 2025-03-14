variable "key_pair_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the key pair. The name must conform to the following naming conventions:\nThe name must be 2 to 128 characters in length, and can contain letters, digits, colons (:), underscores (_), and hyphens (-).\nIt must start with a letter but cannot start with http:// or https://."
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
  description = <<EOT
  {
    "Description": {
      "en": "SSH Public key. If PublicKeyBody is specified, existed public key body will be imported instead of creating new SSH key pair."
    },
    "Label": {
      "en": "PublicKeyBody",
      "zh-cn": "密钥对的公钥内容"
    }
  }
  EOT
}

resource "alicloud_ens_key_pair" "key_pair" {
  key_pair_name = var.key_pair_name
}

output "key_pair_finger_print" {
  // Could not transform ROS Attribute KeyPairFingerPrint to Terraform attribute.
  value       = null
  description = "The fingerprint of the key pair. The message-digest algorithm 5 (MD5) is used based on the public key fingerprint format defined in RFC 4716. For more information, see RFC 4716."
}

output "key_pair_name" {
  value       = alicloud_ens_key_pair.key_pair.id
  description = "SSH Key pair name."
}

output "private_key_body" {
  // Could not transform ROS Attribute PrivateKeyBody to Terraform attribute.
  value       = null
  description = "The private key of the key pair. The private key is encoded with PEM in the PKCS#8 format."
}

