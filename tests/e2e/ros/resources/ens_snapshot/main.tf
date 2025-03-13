variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the snapshot. The description must be 2 to 256 characters in length and cannot start with http:// or https://.\nBy default, this parameter is left empty."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "快照的描述"
    }
  }
  EOT
}

variable "ens_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the edge node."
    },
    "Label": {
      "en": "EnsRegionId",
      "zh-cn": "ENS节点ID"
    }
  }
  EOT
}

variable "snapshot_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the snapshot. The name must be 2 to 128 characters in length. It must start with a letter and cannot start with http:// or https://. It can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "SnapshotName",
      "zh-cn": "快照的显示名称"
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
      "en": "The ID of the cloud disk."
    },
    "Label": {
      "en": "DiskId",
      "zh-cn": "云盘ID"
    }
  }
  EOT
}

resource "alicloud_ens_snapshot" "snapshot" {
  description   = var.description
  ens_region_id = var.ens_region_id
  snapshot_name = var.snapshot_name
  disk_id       = var.disk_id
}

output "snap_shot_id" {
  value       = alicloud_ens_snapshot.snapshot.id
  description = "The ID of the snapshot."
}

