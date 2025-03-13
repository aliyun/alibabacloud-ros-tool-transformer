variable "key_pair_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "SSH key pair name. It must be unique. [2, 128] characters. All character sets are supported. Do not start with a special character, digit, http://, or https://. It can contain digits, \".\", \"_\", or \"-\"."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对的名称"
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
      "zh-cn": "实例所在的资源组ID"
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

resource "alicloud_ecs_key_pair" "sshkey_pair" {
  key_name          = var.key_pair_name
  resource_group_id = var.resource_group_id
  public_key        = var.public_key_body
  tags              = var.tags
}

output "key_pair_finger_print" {
  // Could not transform ROS Attribute KeyPairFingerPrint to Terraform attribute.
  value       = null
  description = "The fingerprint of the key pair. The public key fingerprint format defined in RFC4716: MD5 message digest algorithm. Refer to http://tools.ietf.org/html/rfc4716."
}

output "key_pair_name" {
  value       = alicloud_ecs_key_pair.sshkey_pair.id
  description = "SSH Key pair name."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "private_key_body" {
  // Could not transform ROS Attribute PrivateKeyBody to Terraform attribute.
  value       = null
  description = "The private key of the key pair. Content of the RSA private key in the PKCS#8 format of the unencrypted PEM encoding. Refer to: https://www.openssl.org/docs/apps/pkcs8.html.User only can get the private key one time when and only when SSH key pair is created."
}

