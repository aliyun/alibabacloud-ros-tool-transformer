variable "detection_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Image detection policy. If this parameter is not configured, detection will not be triggered. Only Standard detection mode is supported.Currently, most Linux/Windows versions are supported."
    },
    "AllowedValues": [
      "Standard"
    ],
    "Label": {
      "en": "DetectionStrategy",
      "zh-cn": "镜像检测策略"
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
      "en": "The description of the image.\nIt can be [0, 256] letters in length.\nIt cannot begin with http:// or https://.\nDefault value: null."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "自定义镜像的描述信息"
    }
  }
  EOT
}

variable "platform" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "After specifying the data disk snapshot as the mirrored system disk, you need to determine the operating system release of the system disk through Platform.",
      "zh-cn": "指定数据盘快照作为自定义镜像的系统盘后，需要通过Platform确定系统盘的操作系统发行版。"
    },
    "Label": {
      "en": "Platform",
      "zh-cn": "指定数据盘快照作为自定义镜像的系统盘后"
    }
  }
  EOT
}

variable "architecture" {
  type        = string
  default     = "x86_64"
  description = <<EOT
  {
    "Description": {
      "en": "After specifying the data disk snapshot as the mirrored system disk, you need to determine the system architecture of the system disk through Architecture. Ranges:\nI386\nX86_64 (default)",
      "zh-cn": "指定数据盘快照作为自定义镜像的系统盘后，需要通过Architecture确定系统盘的系统架构。"
    },
    "AllowedValues": [
      "i386",
      "x86_64"
    ],
    "Label": {
      "zh-cn": "系统架构"
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
      "en": "The ID of the resource group to which to assign the custom image."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "自定义镜像所在的企业资源组ID"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "RegionId": "$${SourceRegionId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "Instance ID."
    },
    "Label": {
      "zh-cn": "ECS实例ID"
    }
  }
  EOT
}

variable "boot_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Modify the startup mode of the image. Ranges:\nBIOS: BIOS boot mode.\nUEFI: UEFI boot mode.\nYou need to know the startup mode supported by the specified image. After modifying the startup mode through this parameter, it must match the startup mode supported by the image itself so that the instance can start normally."
    },
    "AllowedValues": [
      "BIOS",
      "UEFI"
    ],
    "Label": {
      "zh-cn": "修改镜像的启动模式"
    }
  }
  EOT
}

variable "image_family" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the image family of the image. The name must be 2 to 128 characters in length and can contain letters, digits, colons (:), underscores (_), and hyphens (-). It cannot contain http:// or https://. It must start with a letter and cannot start with acs: or aliyun.This parameter is empty by default."
    },
    "Label": {
      "en": "ImageFamily",
      "zh-cn": "镜像族系名称"
    }
  }
  EOT
}

variable "disk_device_mapping" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DiskType": {
          "Type": "String",
          "Description": {
            "en": "Specifies the disk type of DiskDeviceMapping.N. in the new image. You can use the data disk snapshot as the mirrored system disk. If not specified, the default is the disk type corresponding to the snapshot. Ranges:\nSystem: system disk\nData: data disk"
          },
          "AllowedValues": [
            "system",
            "data"
          ],
          "Required": false,
          "Label": {
            "zh-cn": "自定义镜像中的云盘类型"
          }
        },
        "SnapshotId": {
          "AssociationPropertyMetadata": {
            "RegionId": "$${SourceRegionId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Snapshot::SnapshotId",
          "Type": "String",
          "Description": {
            "en": "The snapshot ID of the disk DiskDeviceMapping.N.."
          },
          "Required": false
        },
        "Device": {
          "Type": "String",
          "Description": {
            "en": "Specify the device name in DiskMirrorMapping.N. in the custom image. Value range: /dev/xvda~/dev/xvdz"
          },
          "Required": false
        },
        "Size": {
          "Type": "Number",
          "Description": {
            "en": "The size of a disk. The unit of measurement is GiB. Value range: [5, 2000] GiB.\nThe default value is the value of snapshot size (DiskDeviceMapping.N.SnapshotId) if you do not specify this parameter.\nIf you do not specify the snapshot ID (DiskDeviceMapping.N.SnapshotId), the default size is 5 GiB.\nThe size value cannot be less than the size of the snapshot (DiskDeviceMapping.N.SnapshotId).\nThe value range of n in DiskDeviceMapping.n is: [1, 17].\nn =1: Indicates the specified disk is a system disk.\nn =2, 3, ...17: Indicates the specified disk is a data disk."
          },
          "Required": false,
          "Label": {
            "zh-cn": "容量"
          }
        }
      },
      "ListMetadata": {
        "Order": [
          "Device",
          "Size",
          "DiskType",
          "SnapshotId"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "DiskDeviceMapping",
      "zh-cn": "自定义镜像和快照的关系"
    }
  }
  EOT
}

variable "image_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Image name.\nCan contain [2, 128] characters in length. Must begin with an English letter or Chinese character. Can contain digits, colons (:), underscores (_), or hyphens (-).\nCannot begin with http:// or https://."
    },
    "Label": {
      "en": "ImageName",
      "zh-cn": "自定义镜像名称"
    }
  }
  EOT
}

variable "source_region_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::RegionId",
    "Description": {
      "en": "ID of the region to where the instance/snapshot belongs. Default is current region ID."
    },
    "Label": {
      "en": "SourceRegionId",
      "zh-cn": "实例或快照所在的地域ID"
    }
  }
  EOT
}

variable "snapshot_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "RegionId": "$${SourceRegionId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Snapshot::SnapshotId",
    "Description": {
      "en": "The snapshot ID. A custom image is created from the specified snapshot."
    },
    "Label": {
      "en": "SnapshotId",
      "zh-cn": "快照ID"
    }
  }
  EOT
}

variable "image_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Image version.\nWhen you specify an instance ID (InstanceId) and the image of the instance is a cloud market image or a custom image created from a cloud market image. This parameter must be the same as the ImageVersion of the current instance image or set to empty."
    },
    "Label": {
      "en": "ImageVersion",
      "zh-cn": "镜像版本"
    }
  }
  EOT
}

variable "tag" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "The value of a tag of which n is a number from 1 to 20. Once you use this parameter, it can be a null string. It can be up to 128 characters in length. It cannot begin with \"aliyun\", \"acs:\", \"http://\", or \"https://\"."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The key of a tag of which n is from 1 to 20. Once you use this parameter, it cannot be a null string. It can be up to 64 characters in length. It cannot begin with \"aliyun\", \"acs:\", \"http://\", or \"https://\"."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Tag",
      "zh-cn": "标签"
    }
  }
  EOT
}

resource "alicloud_image" "custom_image" {
  detection_strategy  = var.detection_strategy
  description         = var.description
  platform            = var.platform
  architecture        = var.architecture
  resource_group_id   = var.resource_group_id
  instance_id         = var.instance_id
  boot_mode           = var.boot_mode
  image_family        = var.image_family
  disk_device_mapping = var.disk_device_mapping
  image_name          = var.image_name
  snapshot_id         = var.snapshot_id
  image_version       = var.image_version
}

output "source_region_id" {
  // Could not transform ROS Attribute SourceRegionId to Terraform attribute.
  value       = null
  description = "ID of the region to where the instance/snapshot belongs."
}

output "image_id" {
  value       = alicloud_image.custom_image.id
  description = "Image ID"
}

