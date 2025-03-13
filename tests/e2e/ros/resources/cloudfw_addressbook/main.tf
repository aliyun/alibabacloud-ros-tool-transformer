variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Name Address book."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "地址簿的名称"
    }
  }
  EOT
}

variable "description" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Address book description."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "地址簿的描述信息"
    },
    "MinLength": 1
  }
  EOT
}

variable "tag_relation" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The relationship between the labels to be matched more ECS.\nand: the relationship between multiple labels \"and\" that matches both ECS IP public network more tags will be added to the address book.\nor: a plurality of inter-labeled \"or\" relationship, i.e., as long as a matching tag ECS ​​public IP address book will be added."
    },
    "AllowedValues": [
      "and",
      "or"
    ],
    "Label": {
      "en": "TagRelation",
      "zh-cn": "待匹配的多个ECS标签间的关系"
    }
  }
  EOT
}

variable "group_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "domain",
      "ip",
      "port",
      "tag"
    ],
    "Description": {
      "en": "Type the address book, the optional values ​​are:\nip: IP Address Book\ndomain: domain name address book\nport: Port Address Book\ntag: ECS label address book"
    },
    "Label": {
      "en": "GroupType",
      "zh-cn": "地址簿的类型"
    }
  }
  EOT
}

variable "tag_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TagKey": {
          "Type": "String",
          "Description": {
            "en": "ECS labels to be matched Key."
          },
          "Required": false
        },
        "TagValue": {
          "Type": "String",
          "Description": {
            "en": "ECS tag value to be matched."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "TagList",
      "zh-cn": "待匹配的ECS标签"
    },
    "MaxLength": 100
  }
  EOT
}

variable "region_id" {
  type        = string
  default     = "cn-hangzhou"
  description = <<EOT
  {
    "Description": {
      "en": "Region ID. Default to cn-hangzhou.",
      "zh-cn": "地域。默认值：cn-hangzhou。"
    },
    "AllowedValues": [
      "cn-hangzhou",
      "ap-southeast-1"
    ],
    "Label": {
      "en": "RegionId",
      "zh-cn": "地域"
    }
  }
  EOT
}

variable "auto_add_tag_ecs" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to automatically add new ECS public network IP matching tags to the address book. Default to false."
    },
    "Label": {
      "en": "AutoAddTagEcs",
      "zh-cn": "是否自动添加新匹配标签的ECS公网IP到地址簿"
    }
  }
  EOT
}

variable "address_list" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Address list of the address book, between multiple addresses separated by commas.\nNote: When GroupType ip, it must be set to port or domain.\nWhen GroupType as ip, address list, fill in the IP address. For example: 1.2.3.4/32, 1.2.3.0/24\nWhen GroupType for the port, the address list to fill in ports or port ranges. For example: 80, 100/200\nWhen GroupType for the domain, the domain name to fill in the address list. For example: demo1.aliyun.com, demo2.aliyun.com",
      "zh-cn": "地址簿的地址列表，多个地址间用英文逗号分隔。说明 当GroupType为IP、port或domain时必须设置。"
    },
    "Label": {
      "en": "AddressList",
      "zh-cn": "地址簿的地址列表"
    }
  }
  EOT
}

resource "alicloud_cloud_firewall_address_book" "address_book" {
  group_name       = var.group_name
  description      = var.description
  tag_relation     = var.tag_relation
  group_type       = var.group_type
  ecs_tags         = var.tag_list
  auto_add_tag_ecs = var.auto_add_tag_ecs
  address_list     = var.address_list
}

output "group_uuid" {
  value       = alicloud_cloud_firewall_address_book.address_book.id
  description = "After a successful return to the address book to add unique identification ID."
}

