variable "acl_entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Entry": {
          "Type": "String",
          "Description": {
            "en": "The CIDR block for the ACL entry."
          },
          "Required": true
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of ACL entries. The description must be 2 to 256 characters in length, and can contain only the characters specified by the following expression:/^([^\\x00-\\xff]|[\\w.,;/@-]){2,256}$/."
          },
          "Required": false,
          "MinLength": 2,
          "MaxLength": 256
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "AclEntries",
      "zh-cn": "访问控制条目配置"
    },
    "MaxLength": 1000
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "acl_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the ACL. The name must be 2 to 128 characters in length, and can contain\nletters, digits, hyphens (-) and underscores (_). It must start with a letter."
    },
    "Label": {
      "en": "AclName",
      "zh-cn": "访问控制策略组名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_alb_acl" "acl" {
  acl_entries       = var.acl_entries
  resource_group_id = var.resource_group_id
  acl_name          = var.acl_name
}

output "acl_id" {
  value       = alicloud_alb_acl.acl.id
  description = "The ID of the ACL."
}

