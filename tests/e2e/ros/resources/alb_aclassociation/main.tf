variable "acl_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "White",
      "Black"
    ],
    "Description": {
      "en": "The type of ACL."
    },
    "Label": {
      "en": "AclType",
      "zh-cn": "访问控制类型"
    }
  }
  EOT
}

variable "acl_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the ACLs. You can specify up to three IDs at a time."
    },
    "Label": {
      "en": "AclIds",
      "zh-cn": "访问控制策略组ID列表"
    },
    "MinLength": 1,
    "MaxLength": 3
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
      "zh-cn": "监听实例ID"
    }
  }
  EOT
}

resource "alicloud_alb_listener_acl_attachment" "acl_association" {
  acl_type    = var.acl_type
  listener_id = var.listener_id
}

output "listener_id" {
  value       = alicloud_alb_listener_acl_attachment.acl_association.listener_id
  description = "The ID of the listener."
}

