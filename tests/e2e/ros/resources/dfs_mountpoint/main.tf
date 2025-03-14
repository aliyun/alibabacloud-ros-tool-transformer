variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The status of the Mount Point.\nValid values: Active, Inactive"
    },
    "AllowedValues": [
      "Active",
      "Inactive"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "挂载点状态"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the Mount Point."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "挂载点的描述信息"
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
      "en": "The vpc id."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "VPC"
    ],
    "Description": {
      "en": "The network type of the Mount Point. Valid values: VPC."
    },
    "Label": {
      "en": "NetworkType",
      "zh-cn": "挂载点的网络类型"
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
      "en": "The vswitch id."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "file_system_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the File System."
    },
    "Label": {
      "en": "FileSystemId",
      "zh-cn": "文件系统ID"
    }
  }
  EOT
}

variable "access_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the Access Group."
    },
    "Label": {
      "en": "AccessGroupId",
      "zh-cn": "权限组ID"
    }
  }
  EOT
}

resource "alicloud_dfs_mount_point" "mount_point" {
  status          = var.status
  description     = var.description
  vpc_id          = var.vpc_id
  network_type    = var.network_type
  vswitch_id      = var.vswitch_id
  file_system_id  = var.file_system_id
  access_group_id = var.access_group_id
}

output "mount_point_id" {
  value       = alicloud_dfs_mount_point.mount_point.id
  description = "The ID of the mount point."
}

