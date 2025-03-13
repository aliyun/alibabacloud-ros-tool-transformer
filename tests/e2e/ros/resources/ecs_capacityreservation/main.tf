variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the capacity reservation. The description must be 2 to 256 characters in length and cannot start with http:// or https://.\nThis parameter is empty by default."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "容量预定服务的描述信息"
    }
  }
  EOT
}

variable "instance_amount" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The total number of instances for which to reserve capacity of an instance type.",
      "zh-cn": "在一个实例规格内，需要预留的实例的总数量。"
    },
    "MinValue": 1,
    "Label": {
      "en": "InstanceAmount",
      "zh-cn": "在一个实例规格内"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "end_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the capacity reservation expires. Specify the time in the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time must be in UTC. For more information, see ISO 8601."
    },
    "Label": {
      "en": "EndTime",
      "zh-cn": "容量预定服务的失效时间"
    }
  }
  EOT
}

variable "private_pool_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MatchCriteria": {
          "Type": "String",
          "Description": {
            "en": "The type of the private pool to generate after the capacity reservation takes effect. Valid values:\nOpen: open private pool\nTarget: targeted private pool\nDefault value: Open."
          },
          "AllowedValues": [
            "Open",
            "Target"
          ],
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the capacity reservation. The name must be 2 to 128 characters in length. The description must start with a letter but cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "PrivatePoolOptions",
      "zh-cn": "容量预定服务配置"
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
      "en": "The ID of zone N within the region in which to create the capacity reservation. A capacity reservation can reserve resources within only a single zone."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "容量预定服务所属地域下的可用区ID"
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
      "en": "The ID of the resource group to which to assign the capacity reservation."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "容量预定服务所在的企业资源组ID"
    }
  }
  EOT
}

variable "end_time_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The release mode of the capacity reservation. Valid values:\nLimited: The capacity reservation is automatically released at the specified time. If you specify this parameter, you must also specify the EndTime parameter.\nUnlimited: The capacity reservation must be manually released. You can release it anytime."
    },
    "AllowedValues": [
      "Limited",
      "Unlimited"
    ],
    "Label": {
      "en": "EndTimeType",
      "zh-cn": "容量预定服务的失效方式"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The instance type. A capacity reservation can be created to reserve the capacity of only a single instance type. You can call the DescribeInstanceTypes operation to query the instance types provided by ECS."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例规格"
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
      "zh-cn": "实例标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ecs_capacity_reservation" "capacity_reservation" {
  description       = var.description
  instance_amount   = var.instance_amount
  end_time          = var.end_time
  resource_group_id = var.resource_group_id
  end_time_type     = var.end_time_type
  instance_type     = var.instance_type
  tags              = var.tags
}

output "private_pool_options_id" {
  value       = alicloud_ecs_capacity_reservation.capacity_reservation.id
  description = "The ID of the capacity reservation."
}

