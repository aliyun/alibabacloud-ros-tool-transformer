variable "max_entries" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of entries for CIDR address blocks in the prefix list."
    },
    "MinValue": 1,
    "Label": {
      "en": "MaxEntries",
      "zh-cn": "前缀列表中CIDR地址块的最大条目数"
    },
    "MaxValue": 100
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the VPC belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "前缀列表所属的资源组ID"
    }
  }
  EOT
}

variable "prefix_list_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the prefix list.\nIt must be 2 to 256 characters in length and must start with a letter or Chinese, but cannot start with http:// or https."
    },
    "Label": {
      "en": "PrefixListDescription",
      "zh-cn": "前缀列表的描述信息"
    }
  }
  EOT
}

variable "ip_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP version of the prefix list. Value:\n- **IPvv4**:IPv4 version.\n- **IPv6**:IPv6."
    },
    "AllowedValues": [
      "IPv4",
      "IPv6"
    ],
    "Label": {
      "en": "IpVersion",
      "zh-cn": "IP版本类型"
    }
  }
  EOT
}

variable "prefix_list_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the prefix list."
    },
    "Label": {
      "en": "PrefixListName",
      "zh-cn": "前缀列表的名称"
    }
  }
  EOT
}

variable "entries" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the CIDR entry."
          },
          "Required": false
        },
        "Cidr": {
          "Type": "String",
          "Description": {
            "en": "CIDR block."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The CIDR address block list of the prefix list."
    },
    "Label": {
      "en": "Entries",
      "zh-cn": "前缀列表CIDR地址块列表"
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
      "en": "Tags of prefix list."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_vpc_prefix_list" "extension_resource" {
  max_entries             = var.max_entries
  resource_group_id       = var.resource_group_id
  prefix_list_description = var.prefix_list_description
  ip_version              = var.ip_version
  prefix_list_name        = var.prefix_list_name
  entrys                  = var.entries
  tags                    = var.tags
}

output "max_entries" {
  value       = alicloud_vpc_prefix_list.extension_resource.max_entries
  description = "The maximum number of entries for CIDR address blocks in the prefix list."
}

output "resource_group_id" {
  value       = alicloud_vpc_prefix_list.extension_resource.resource_group_id
  description = "The ID of the resource group to which the VPC belongs."
}

output "owner_id" {
  // Could not transform ROS Attribute OwnerId to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud account (primary account) to which the prefix list belongs."
}

output "prefix_list_description" {
  value       = alicloud_vpc_prefix_list.extension_resource.prefix_list_description
  description = "The description of the prefix list."
}

output "ip_version" {
  value       = alicloud_vpc_prefix_list.extension_resource.ip_version
  description = "The IP version of the prefix list."
}

output "prefix_list_id" {
  value       = alicloud_vpc_prefix_list.extension_resource.id
  description = "The ID of the query Prefix List."
}

output "prefix_list_name" {
  value       = alicloud_vpc_prefix_list.extension_resource.prefix_list_name
  description = "The name of the prefix list."
}

output "create_time" {
  value       = alicloud_vpc_prefix_list.extension_resource.create_time
  description = "The time when the prefix list was created."
}

output "entries" {
  value       = alicloud_vpc_prefix_list.extension_resource.entrys
  description = "The CIDR address block list of the prefix list."
}

output "tags" {
  value       = alicloud_vpc_prefix_list.extension_resource.tags
  description = "The tags of PrefixList."
}

output "share_type" {
  value       = alicloud_vpc_prefix_list.extension_resource.share_type
  description = "The share type of the prefix list."
}

