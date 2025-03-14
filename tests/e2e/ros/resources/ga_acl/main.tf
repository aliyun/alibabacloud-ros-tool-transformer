variable "acl_entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Entry": {
          "Type": "String",
          "Description": {
            "en": "The IP addresses (192.168.XX.XX) or CIDR blocks (10.0.XX.XX/24) that you want to add to the ACL."
          },
          "Required": false
        },
        "EntryDescription": {
          "Type": "String",
          "Description": {
            "en": "The description of the entry that you want to add to the AC,The description must be 1 to 256 characters in length, and can contain letters, digits, hyphens (-), forward slashes (/), periods (.), and underscores (_)."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The entries of IP addresses or CIDR blocks to add to the ACL. You can add up to 20 entries.",
      "zh-cn": "访问控制策略组条目，即 IP 地址条目或 IP 地址段条目。"
    },
    "Label": {
      "en": "AclEntries",
      "zh-cn": "访问控制策略组条目"
    },
    "MinLength": 0,
    "MaxLength": 20
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
      "zh-cn": "资源组 ID"
    }
  }
  EOT
}

variable "addressipversion" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The IP version of the ACL."
    },
    "Label": {
      "en": "AddressIPVersion",
      "zh-cn": "访问控制策略组的 IP 版本"
    }
  }
  EOT
}

variable "acl_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the ACL."
    },
    "Label": {
      "en": "AclName",
      "zh-cn": "访问控制策略组的名称"
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
      "en": "Tags of the ACL."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "访问控制策略组的标签信息"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ga_acl" "extension_resource" {
  acl_entries       = var.acl_entries
  resource_group_id = var.resource_group_id
  acl_name          = var.acl_name
  tags              = var.tags
}

output "acl_entries" {
  // Could not transform ROS Attribute AclEntries to Terraform attribute.
  value       = null
  description = "The entries of the ACL."
}

output "resource_group_id" {
  value       = alicloud_ga_acl.extension_resource.resource_group_id
  description = "The ID of the resource group."
}

output "acl_id" {
  value       = alicloud_ga_acl.extension_resource.id
  description = "The  ID of the ACL."
}

output "addressipversion" {
  // Could not transform ROS Attribute AddressIPVersion to Terraform attribute.
  value       = null
  description = "The IP version of the ACL."
}

output "tags" {
  value       = alicloud_ga_acl.extension_resource.tags
  description = "The tags of the resource."
}

output "acl_name" {
  value       = alicloud_ga_acl.extension_resource.acl_name
  description = "The name of the ACL."
}

