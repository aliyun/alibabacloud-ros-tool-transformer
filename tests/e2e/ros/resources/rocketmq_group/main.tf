variable "group_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Group ID specify the creation of applicable agreements. Group ID TCP protocol and the HTTP protocol can not be shared, the need to create separately. Value as follows:\ntcp: Default, indicates Group ID is created only for the TCP protocol messaging.\nhttp: represents the Group ID was created only for the HTTP protocol messaging."
    },
    "AllowedValues": [
      "tcp",
      "http"
    ],
    "Label": {
      "en": "GroupType",
      "zh-cn": "Group ID适用的协议"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "需创建的Group ID所对应的实例ID"
    }
  }
  EOT
}

variable "remark" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The remarks on the request."
    },
    "Label": {
      "en": "Remark",
      "zh-cn": "备注"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The group ID of the consumption cluster. When creating a group ID, pay attention to the following aspects:\nA group ID starts with\"GID_\" or \"GID-\", and contains letters, numbers, hyphens (-), and underscores (_).\nA group ID ranges from 7 to 64 bytes.\nOnce a group ID is created, it cannot be edited anymore."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "创建的消费集群的Group ID"
    },
    "MinLength": 7,
    "MaxLength": 64
  }
  EOT
}

resource "alicloud_ons_group" "group" {
  group_type  = var.group_type
  instance_id = var.instance_id
  remark      = var.remark
  group_id    = var.group_id
}

output "group_type" {
  value       = alicloud_ons_group.group.group_type
  description = "Group Type"
}

output "instance_id" {
  value       = alicloud_ons_group.group.instance_id
  description = "Instance ID"
}

output "group_id" {
  value       = alicloud_ons_group.group.group_id
  description = "Group ID"
}

