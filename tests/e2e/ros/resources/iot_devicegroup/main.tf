variable "group_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the group. The name can contain Chinese characters, English letters, digits, and underscores (_). The length must be 4 to 30 characters (a Chinese character counts as two characters)."
    },
    "Label": {
      "en": "GroupName",
      "zh-cn": "分组名称"
    }
  }
  EOT
}

variable "iot_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Public instance does not pass this parameter; instance that you need to buy the incoming instance ID."
    },
    "Label": {
      "en": "IotInstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "super_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the parent group.\nIf you want to create a first-level group, do not enter this parameter.",
      "zh-cn": "父组ID。若要创建一级分组，则不传入此参数。"
    },
    "Label": {
      "en": "SuperGroupId",
      "zh-cn": "父组ID"
    }
  }
  EOT
}

variable "group_desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the group. You can enter a description with up to 100 characters."
    },
    "Label": {
      "en": "GroupDesc",
      "zh-cn": "分组描述"
    }
  }
  EOT
}

resource "alicloud_iot_device_group" "device_group" {
  group_name      = var.group_name
  iot_instance_id = var.iot_instance_id
  super_group_id  = var.super_group_id
  group_desc      = var.group_desc
}

output "iot_instance_id" {
  // Could not transform ROS Attribute IotInstanceId to Terraform attribute.
  value       = null
  description = "IOT instance ID."
}

output "group_id" {
  value       = alicloud_iot_device_group.device_group.id
  description = "Packet, ID, System for the globally unique identifier generated packet."
}

