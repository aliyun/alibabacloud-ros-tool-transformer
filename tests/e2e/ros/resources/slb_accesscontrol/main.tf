variable "acl_entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Comment": {
          "Type": "String",
          "Description": {
            "en": "Description of the entry."
          },
          "Required": false
        },
        "Entry": {
          "Type": "String",
          "Description": {
            "en": "IP addresses or CIDR blocks. For example: \"10.0.0.1\" or \"192.168.0.0/16\""
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "A list of acl entries. Each entry can be IP addresses or CIDR blocks. Max length: 300."
    },
    "Label": {
      "en": "AclEntries",
      "zh-cn": "访问控制策略组的信息列表"
    },
    "MaxLength": 300
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
      "zh-cn": "访问控制策略组所属的资源组ID"
    }
  }
  EOT
}

variable "addressipversion" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "IP version. Could be \"ipv4\" or \"ipv6\"."
    },
    "AllowedValues": [
      "ipv4",
      "ipv6"
    ],
    "Label": {
      "en": "AddressIPVersion",
      "zh-cn": "IP版本"
    }
  }
  EOT
}

variable "acl_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the access control list."
    },
    "Label": {
      "en": "AclName",
      "zh-cn": "访问控制策略组名称"
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

resource "alicloud_slb_acl" "access_control" {
  entry_list        = var.acl_entries
  resource_group_id = var.resource_group_id
  ip_version        = var.addressipversion
  name              = var.acl_name
  tags              = var.tags
}

output "acl_id" {
  value       = alicloud_slb_acl.access_control.id
  description = "The ID of the access control list."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

