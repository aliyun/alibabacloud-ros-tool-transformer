variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance ID."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "delete_with_instance" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether the cloud disk to be mounted is released with the instance\nValue:\ntrue: When the instance is released, the cloud disk is released together with the instance.\nfalse: When the instance is released, the cloud disk is retained and is not released together with the instance.\n Empty means false by default."
    },
    "Label": {
      "en": "DeleteWithInstance",
      "zh-cn": "待挂载的云盘是否随实例释放"
    }
  }
  EOT
}

variable "disk_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the cloud disk to be mounted. The Cloud Disk (DiskId) and the instance (InstanceId) must be on the same node."
    },
    "Label": {
      "en": "DiskId",
      "zh-cn": "待挂载的云盘ID"
    }
  }
  EOT
}

resource "alicloud_ens_disk_instance_attachment" "extension_resource" {
  instance_id          = var.instance_id
  delete_with_instance = var.delete_with_instance
  disk_id              = var.disk_id
}

output "instance_id" {
  value       = alicloud_ens_disk_instance_attachment.extension_resource.instance_id
  description = "Instance ID."
}

output "disk_id" {
  value       = alicloud_ens_disk_instance_attachment.extension_resource.disk_id
  description = "The ID of the cloud disk to be mounted. The Cloud Disk (DiskId) and the instance (InstanceId) must be on the same node."
}

