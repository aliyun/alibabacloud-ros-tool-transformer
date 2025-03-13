variable "image_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the image. The name must be 2 to 128 characters in length. \nThe name can contain letters, digits, colons (:), underscores (_), and hyphens (-). \nIt must start with a letter but cannot start with http:// or https://. \nThe name can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "ImageName",
      "zh-cn": "镜像名称"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance corresponding to the image."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例 ID"
    }
  }
  EOT
}

variable "delete_after_image_upload" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the instance is automatically released after the image is packaged and uploaded successfully, only the build machine is supported.\nOptional values:\ntrue: When the instance is released, the image is released together with the instance.\nfalse: When the instance is released, the image is retained and is not released together with the instance.\nEmpty means false by default."
    },
    "Label": {
      "en": "DeleteAfterImageUpload",
      "zh-cn": "镜像打包上传成功后是否自动随实例一起释放镜像"
    }
  }
  EOT
}

resource "alicloud_ens_image" "extension_resource" {
  image_name  = var.image_name
  instance_id = var.instance_id
}

output "image_owner_alias" {
  // Could not transform ROS Attribute ImageOwnerAlias to Terraform attribute.
  value       = null
  description = <<EOT
  "The source of the image. Valid values:\nsystem: public images\nself: your custom images"
  EOT
}

output "image_name" {
  value       = alicloud_ens_image.extension_resource.image_name
  description = "The name of the image."
}

output "snapshot_id" {
  // Could not transform ROS Attribute SnapshotId to Terraform attribute.
  value       = null
  description = "The ID of the snapshot corresponding to the image."
}

output "platform" {
  // Could not transform ROS Attribute Platform to Terraform attribute.
  value       = null
  description = <<EOT
  "The type of operating system used by the image.\ncentos\nubuntu\nalios\ndebian\nrhel\nwindows"
  EOT
}

output "architecture" {
  // Could not transform ROS Attribute Architecture to Terraform attribute.
  value       = null
  description = <<EOT
  "The image architecture. Valid values:\ni386\nx86_64"
  EOT
}

output "image_size" {
  // Could not transform ROS Attribute ImageSize to Terraform attribute.
  value       = null
  description = "The size of the image. Unit: GiB."
}

output "instance_id" {
  value       = alicloud_ens_image.extension_resource.instance_id
  description = "The ID of the instance corresponding to the image."
}

output "os_version" {
  // Could not transform ROS Attribute OsVersion to Terraform attribute.
  value       = null
  description = "The operating system version."
}

output "create_time" {
  value       = alicloud_ens_image.extension_resource.create_time
  description = "The image creation time. The time follows the ISO 8601 standard in the yyyy-MM-ddTHH:mm:ssZ format. The time is displayed in UTC."
}

output "image_id" {
  value       = alicloud_ens_image.extension_resource.id
  description = "The ID of the image."
}

output "compute_type" {
  // Could not transform ROS Attribute ComputeType to Terraform attribute.
  value       = null
  description = <<EOT
  "Computing type. ens_vm/ens: x86 computing.\n bare_metal: x86 bare machine or x86 bare metal. \narm_vm: ARM computing. \narm_bare_metal: ARM bare machine or ARM bare metal.\npcfarm: heterogeneous computing."
  EOT
}

