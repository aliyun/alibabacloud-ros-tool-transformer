variable "disk_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of cloud disk for which you want to create snapshots."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of cloud disk for which you want to create snapshots. You can specify multiple cloud disk IDs across instances within the same zone. The length of the list ranges from 1 to 16. A single snapshot-consistent group can contain snapshots of up to 16 cloud disks whose total disk size does not exceed 32 TiB.\nTake note of the following items:\nYou cannot specify both DiskIds and ExcludeDiskIdin the same request.\nIf InstanceId is set, you can use DiskIds to specify only cloud disks attached to the instance specified by InstanceId, and you cannot use DiskIds to specify cloud disks attached to multiple instances."
    },
    "Label": {
      "en": "DiskIds",
      "zh-cn": "指定创建快照一致性组的云盘 ID"
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
      "en": "The description of the snapshot-consistent group. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "The ID of the resource group to which the snapshot-consistent group belongs."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "快照一致性组所属的资源组 ID"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The instance ID."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例 ID"
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
      "en": "Tags to attach to snapshot-consistent group. Max support 20 tags to add during create snapshot-consistent group. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "exclude_disk_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The ID of cloud disk for which you do not want to create snapshots."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of cloud disk for which you do not want to create snapshots. If this parameter is specified, the created snapshot-consistent group does not contain snapshots of the cloud disk. The length of the list ranges from 1 to 16.\nThis parameter is empty by default, which indicates that snapshots are created for all the disks of the instance.\nNote You cannot specify ExcludeDiskIds and DiskIds in the same request."
    },
    "Label": {
      "en": "ExcludeDiskIds",
      "zh-cn": "实例中不需要创建快照的云盘 ID"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the snapshot-consistent group. The name must be 2 to 128 characters in length. The name can contain letters, digits, periods (.), underscores (_), hyphens (-), and colons (:). It must start with a letter and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "快照一致性组名称"
    }
  }
  EOT
}

resource "alicloud_ecs_snapshot_group" "snapshot_group" {
  description       = var.description
  resource_group_id = var.resource_group_id
  instance_id       = var.instance_id
  tags              = var.tags
}

output "snapshot_group_id" {
  value       = alicloud_ecs_snapshot_group.snapshot_group.id
  description = "The ID of the snapshot-consistent group."
}

