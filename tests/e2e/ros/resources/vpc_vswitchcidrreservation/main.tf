variable "vswitch_cidr_reservation_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of reserved CIDR block. Set the value to prefix.\nNote When a user or a cloud service allocates a CIDR block to an elastic network interface (ENI), the CIDR block must be allocated from the reserved CIDR block. If the reserved CIDR block is exhausted, an error is returned."
    },
    "AllowedValues": [
      "prefix"
    ],
    "Label": {
      "en": "VSwitchCidrReservationType",
      "zh-cn": "交换机预留网段的类型"
    }
  }
  EOT
}

variable "vswitch_cidr_reservation_cidr" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The reserved CIDR block of the vSwitch.\nWhen IpVersion is set to IPv4, the reserved CIDR block must be a proper subset of the IPv4 CIDR block of the vSwitch and the subnet mask length of the reserved CIDR block cannot be greater than 28.\nWhen IpVersion is set to IPv6, the reserved CIDR block must be a proper subset of the IPv6 CIDR block of the vSwitch and the subnet mask length of the reserved CIDR block cannot be greater than 80.\nNote You must specify one of VSwitchCidrReservationMask and VSwitchCidrReservationCidr."
    },
    "Label": {
      "en": "VSwitchCidrReservationCidr",
      "zh-cn": "交换机预留网段"
    }
  }
  EOT
}

variable "vswitch_cidr_reservation_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the reserved CIDR block. This parameter is empty by default.\nThe description must be 2 to 256 characters in length. It must start with a letter and cannot start with http:// or https://."
    },
    "Label": {
      "en": "VSwitchCidrReservationDescription",
      "zh-cn": "交换机预留网段的描述信息"
    }
  }
  EOT
}

variable "ip_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP version of the reserved CIDR block. Valid values:\nIPv4 (default)\nIPv6"
    },
    "AllowedValues": [
      "IPv6",
      "IPv4"
    ],
    "Label": {
      "en": "IpVersion",
      "zh-cn": "交换机预留网段的IP版本"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the vSwitch to which the reserved CIDR block belongs."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "要创建的交换机预留网段所属的交换机ID"
    }
  }
  EOT
}

variable "vswitch_cidr_reservation_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the reserved CIDR block.\nThe name must be 2 to 128 characters in length and can contain digits, underscores (_), and hyphens (-). It must start with a letter."
    },
    "Label": {
      "en": "VSwitchCidrReservationName",
      "zh-cn": "交换机预留网段的名称"
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
          "Description": {
            "en": "The value of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag value can be an empty string. The tag value can be up to 128 characters in length and cannot start with acs:. The tag value cannot contain http:// or https://."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The key of tag N to add to the capacity reservation. Valid values of N: 1 to 20. The tag key cannot be an empty string. The tag key can be up to 128 characters in length and cannot contain http:// or https://. It cannot start with acs: or aliyun."
          },
          "Required": false
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
    "Label": {
      "en": "Tags",
      "zh-cn": "标签列表"
    },
    "MaxLength": 20
  }
  EOT
}

variable "vswitch_cidr_reservation_mask" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The subnet mask of the reserved CIDR block.\nWhen IpVersion is set to IPv4, the subnet mask length of the CIDR block must be greater than the IPv4 subnet mask length of the vSwitch and cannot be greater than 28.\nWhen IpVersion is set to IPv6, the subnet mask length of the CIDR block must be greater than the IPv6 subnet mask length of the vSwitch and cannot be greater than 80.\nNote You must specify one of VSwitchCidrReservationMask and VSwitchCidrReservationCidr."
    },
    "Label": {
      "en": "VSwitchCidrReservationMask",
      "zh-cn": "交换机预留网段的掩码"
    }
  }
  EOT
}

resource "alicloud_vpc_vswitch_cidr_reservation" "vswitch_cidr_reservation" {
  ip_version = var.ip_version
  vswitch_id = var.vswitch_id
}

output "vswitch_cidr_reservation_id" {
  value       = alicloud_vpc_vswitch_cidr_reservation.vswitch_cidr_reservation.id
  description = "The ID of the reserved CIDR block."
}

