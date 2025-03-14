variable "max_entries" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of entries that the prefix list can contain. Valid values: 1 to 200."
    },
    "MinValue": 1,
    "Label": {
      "en": "MaxEntries",
      "zh-cn": "前缀列表支持的最大条目容量"
    },
    "MaxValue": 200
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the prefix list. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "前缀列表的描述信息"
    }
  }
  EOT
}

variable "prefix_list_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the prefix. The name must be 2 to 128 characters in length. It must start with a letter and cannot start with http://, https://, com.aliyun, or com.alibabacloud. It can contain letters, digits, colons (:), underscores (_), periods (.), and hyphens (-)."
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
            "en": "The description in entry. The description must be 2 to 32 characters in length and cannot start with http:// or https://."
          },
          "Required": false
        },
        "Cidr": {
          "Type": "String",
          "Description": {
            "en": "The CIDR block in entry. Take note of the following items: \nThe total number of entries must not exceed the MaxEntries value.\nCIDR block types are determined by the IP address family. You cannot combine IPv4 and IPv6 CIDR blocks in a single prefix list.\nCIDR blocks must be unique across all entries in a prefix list. For example, you cannot specify 192.168.1.0/24 twice in the entries of the prefix list.\nIP addresses are supported. \nThe system converts IP addresses into CIDR blocks. For example, if you specify 192.168.1.100, the system converts it into the 192.168.1.100/32 CIDR block.\nIf an IPv6 CIDR block is used, the system converts it to the zero compression format and changes uppercase letters into lowercase ones. For example, if you specify 2001:0DB8:0000:0000:0000:0000:0000:0000/32,the system converts it into 2001:db8::/32."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Entries",
      "zh-cn": "前缀列表的条目信息"
    },
    "MaxLength": 200
  }
  EOT
}

variable "address_family" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Ipv4",
      "Ipv6"
    ],
    "Description": {
      "en": "The IP address family. Valid values: IPv4 IPv6"
    },
    "Label": {
      "en": "AddressFamily",
      "zh-cn": "前缀列表的地址群"
    }
  }
  EOT
}

resource "alicloud_ecs_prefix_list" "prefix_list" {
  max_entries      = var.max_entries
  description      = var.description
  prefix_list_name = var.prefix_list_name
  entry            = var.entries
  address_family   = var.address_family
}

output "prefix_list_id" {
  value       = alicloud_ecs_prefix_list.prefix_list.id
  description = "The ID of the prefix list."
}

