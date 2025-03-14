variable "network_acl_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the network ACL."
    },
    "Label": {
      "en": "NetworkAclId",
      "zh-cn": "网络ACL的ID"
    }
  }
  EOT
}

variable "resources" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the associated resource."
          },
          "Required": true
        },
        "ResourceType": {
          "Type": "String",
          "Description": {
            "en": "The type of the associated resource. Valid value: VSwitch."
          },
          "AllowedValues": [
            "VSwitch"
          ],
          "Required": false,
          "Default": "VSwitch"
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The list of resources that need to be associated with network ACL."
    },
    "Label": {
      "en": "Resources",
      "zh-cn": "网络ACL关联的资源"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_network_acl_attachment" "network_acl_association" {
  network_acl_id = var.network_acl_id
  resources      = var.resources
}

output "network_acl_id" {
  value       = alicloud_network_acl_attachment.network_acl_association.network_acl_id
  description = "The ID of the network ACL."
}

