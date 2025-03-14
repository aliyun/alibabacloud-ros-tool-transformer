variable "certificates" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CertificateId": {
          "Type": "String",
          "Description": {
            "en": "The ID of additional certificate."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of the additional certificates."
    },
    "Label": {
      "en": "Certificates",
      "zh-cn": "扩展证书列表"
    },
    "MinLength": 1,
    "MaxLength": 300
  }
  EOT
}

variable "listener_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the listener."
    },
    "Label": {
      "en": "ListenerId",
      "zh-cn": "监听ID"
    }
  }
  EOT
}

resource "alicloud_alb_listener_additional_certificate_attachment" "additional_certificate_association" {
  listener_id = var.listener_id
}

output "listener_id" {
  value       = alicloud_alb_listener_additional_certificate_attachment.additional_certificate_association.listener_id
  description = "The ID of the listener."
}

