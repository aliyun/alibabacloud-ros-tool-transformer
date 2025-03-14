variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Description of the VSwitch, [2, 256] characters. Do not fill or empty, the default is empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "交换机描述"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VPC id to create vswtich."
    },
    "Label": {
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The availability zone in which the VSwitch will be created."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/24"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "RecommendValues": [
        "10.0.0.0/24",
        "172.16.0.0/24",
        "192.168.0.0/24"
      ],
      "RecommendDescription": {
        "en": "You can choose the following values for quick setup.",
        "zh-cn": "您可以选择以下值进行快速设置。"
      }
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::CidrBlock",
    "Description": {
      "en": "CIDR Block of created VSwitch, It must belong to itself VPC CIDR block.",
      "zh-cn": "建议您使用RFC私网地址作为交换机的网段如10.0.0.0/24，172.16.0.0/24，192.168.0.0/24。必须是所属专有网络的子网段，并且没有被其他交换机占用。"
    },
    "Label": {
      "en": "CidrBlock",
      "zh-cn": "交换机网段"
    }
  }
  EOT
}

variable "vswitch_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the vSwitch instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'"
    },
    "Label": {
      "en": "VSwitchName",
      "zh-cn": "交换机名称"
    }
  }
  EOT
}

variable "vpc_ipv6_cidr_block" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IPv6 CIDR block of the VPC."
    },
    "Label": {
      "en": "VpcIpv6CidrBlock",
      "zh-cn": "专有网络的IPv6网段"
    }
  }
  EOT
}

variable "ipv6_cidr_block" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The IPv6 network segment of the switch supports the last 8 bits of the VPC IPv6 network segment. Value: 0-255 (decimal).\nThe IPv6 segment mask of the switch defaults to 64 bits."
    },
    "MinValue": 0,
    "Label": {
      "en": "Ipv6CidrBlock",
      "zh-cn": "交换机的IPv6网段"
    },
    "MaxValue": 255
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
      "en": "Tags to attach to vswitch. Max support 20 tags to add during create vswitch. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "zone_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the zones to be queried. \nDefault value: AvailabilityZone. This value indicates Alibaba Cloud zones.\n"
    },
    "Label": {
      "en": "ZoneType",
      "zh-cn": "要查询的分区类型"
    }
  }
  EOT
}

resource "alicloud_vswitch" "vswitch" {
  description     = var.description
  vpc_id          = var.vpc_id
  zone_id         = var.zone_id
  cidr_block      = var.cidr_block
  vswitch_name    = var.vswitch_name
  ipv6_cidr_block = var.ipv6_cidr_block
  tags            = var.tags
}

output "vswitch_id" {
  value       = alicloud_vswitch.vswitch.id
  description = "Id of created VSwitch."
}

output "cidr_block" {
  value       = alicloud_vswitch.vswitch.cidr_block
  description = "CIDR Block of created VSwitch"
}

output "vswitch_name" {
  value       = alicloud_vswitch.vswitch.vswitch_name
  description = "The name of the VSwitch"
}

output "ipv6_cidr_block" {
  value       = alicloud_vswitch.vswitch.ipv6_cidr_block
  description = "The IPv6 network segment of the VSwitch"
}

