variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Status, including Active and Inactive"
    },
    "AllowedValues": [
      "Active",
      "Inactive"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "状态"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "Vpc"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VPC network ID"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "VPC网络ID"
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
      "Vpc",
      "Classic"
    ],
    "Description": {
      "en": "Network type, including Vpc and Classic networks."
    },
    "Label": {
      "en": "NetworkType",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security group Id"
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "Vpc"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "VSwitch ID."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "access_group_name" {
  type        = string
  default     = "DEFAULT_VPC_GROUP_NAME"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Permission group name. Default to DEFAULT_VPC_GROUP_NAME."
    },
    "Label": {
      "en": "AccessGroupName",
      "zh-cn": "权限组名称"
    }
  }
  EOT
}

variable "file_system_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::NAS::FileSystem::FileSystemId",
    "Description": {
      "en": "File system ID"
    },
    "Label": {
      "en": "FileSystemId",
      "zh-cn": "文件系统ID"
    }
  }
  EOT
}

variable "enable_ipv6" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to create an IPv6 mount point.Value:\ntrue: create\nfalse (default): do not create\nNote Currently, only the ultra-fast NAS in mainland China supports the IPv6 function, and the file system needs to enable the IPv6 function."
    },
    "Label": {
      "en": "EnableIpv6",
      "zh-cn": "是否创建IPv6挂载点"
    }
  }
  EOT
}

resource "alicloud_nas_mount_target" "mount_target" {
  status            = var.status
  vpc_id            = var.vpc_id
  network_type      = var.network_type
  security_group_id = var.security_group_id
  vswitch_id        = var.vswitch_id
  access_group_name = var.access_group_name
  file_system_id    = var.file_system_id
}

output "mount_target_domain" {
  value       = alicloud_nas_mount_target.mount_target.id
  description = "Mount point domain name"
}

