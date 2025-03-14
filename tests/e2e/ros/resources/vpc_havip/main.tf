variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the HAVIP.\nThe description must be 1 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "自定义描述信息"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the HAVIP belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "高可用虚拟 IP 所属的资源组 ID"
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
      "en": "The ID of the vSwitch to which the HAVIP belongs."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The IP address of the HAVIP. The specified IP address must be an idle IP address that falls within the CIDR block of the vSwitch. If this parameter is not set, an idle IP address from the CIDR block of the vSwitch is randomly assigned to the HAVIP.",
      "zh-cn": "HaVip的IP地址。不填写该地址，则随机指定当前交换机下的一个地址。"
    },
    "Label": {
      "en": "IpAddress",
      "zh-cn": "HaVip的IP地址"
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
      "zh-cn": "自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the HAVIP.\nThe name must be 1 to 128 characters in length, and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "HaVip 实例的名称"
    }
  }
  EOT
}

resource "alicloud_vpc_ha_vip" "ha_vip" {
  description       = var.description
  resource_group_id = var.resource_group_id
  vswitch_id        = var.vswitch_id
  ip_address        = var.ip_address
  tags              = var.tags
  ha_vip_name       = var.name
}

output "ip_address" {
  value       = alicloud_vpc_ha_vip.ha_vip.ip_address
  description = "The IP address of the HAVIP."
}

output "ha_vip_id" {
  value       = alicloud_vpc_ha_vip.ha_vip.id
  description = "Assigned HaVip ID."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

