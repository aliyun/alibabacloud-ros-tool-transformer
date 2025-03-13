variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "The instanceId to attach the disk."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "需挂载磁盘的实例ID"
    }
  }
  EOT
}

variable "device" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The device where the volume is exposed on the instance. could be /dev/xvd[b-z]. If not specification, will use default value."
    },
    "Label": {
      "en": "Device",
      "zh-cn": "磁盘设备名"
    }
  }
  EOT
}

variable "delete_with_instance" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "If property is true, the disk will be deleted while instance is deleted, if property is false, the disk will be retain after instance is deleted."
    },
    "Label": {
      "en": "DeleteWithInstance",
      "zh-cn": "磁盘是否随实例释放"
    }
  }
  EOT
}

variable "delete_auto_snapshot" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether the auto snapshot is released with the disk. Default to true."
    },
    "Label": {
      "en": "DeleteAutoSnapshot",
      "zh-cn": "删除磁盘时是否删除自动快照"
    }
  }
  EOT
}

variable "disk_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Disk::DiskId",
    "Description": {
      "en": "The disk id to attached."
    },
    "Label": {
      "en": "DiskId",
      "zh-cn": "磁盘ID"
    }
  }
  EOT
}

resource "alicloud_ecs_disk_attachment" "disk_attachment" {
  instance_id          = var.instance_id
  device               = var.device
  delete_with_instance = var.delete_with_instance
  disk_id              = var.disk_id
}

output "status" {
  // Could not transform ROS Attribute Status to Terraform attribute.
  value       = null
  description = "The disk status now."
}

output "device" {
  value       = alicloud_ecs_disk_attachment.disk_attachment.device
  description = "The device where the volume is exposed on ecs instance."
}

output "disk_id" {
  value       = alicloud_ecs_disk_attachment.disk_attachment.disk_id
  description = "The disk id of created disk"
}

