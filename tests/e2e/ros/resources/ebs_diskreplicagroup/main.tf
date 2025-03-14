variable "rpo" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The RPO value set by the consistency group in seconds."
    },
    "Label": {
      "en": "RPO",
      "zh-cn": "一致性组设定的RPO值"
    }
  }
  EOT
}

variable "source_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region to which the production site belongs."
    },
    "Label": {
      "en": "SourceRegionId",
      "zh-cn": "生产站点所属的地域ID"
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
      "en": "The description of the consistent replication group."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "生产站点所属的可用区ID"
    }
  }
  EOT
}

variable "disk_replica_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Consistent replication group name."
    },
    "Label": {
      "en": "DiskReplicaGroupName",
      "zh-cn": "一致性复制组的名称"
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
      "en": "The ID of resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "destination_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region to which the disaster recovery site belongs."
    },
    "Label": {
      "en": "DestinationRegionId",
      "zh-cn": "灾备站点所属的地域ID"
    }
  }
  EOT
}

variable "destination_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the zone to which the disaster recovery site belongs."
    },
    "Label": {
      "en": "DestinationZoneId",
      "zh-cn": "灾备站点所属的可用区ID"
    }
  }
  EOT
}

variable "source_zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the zone to which the production site belongs."
    },
    "Label": {
      "en": "SourceZoneId",
      "zh-cn": "生产站点所属的可用区ID"
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
      "en": "Tags of disk replica group."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "自定义标签信息"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_ebs_disk_replica_group" "extension_resource" {
  source_region_id      = var.source_region_id
  description           = var.description
  destination_region_id = var.destination_region_id
  destination_zone_id   = var.destination_zone_id
  source_zone_id        = var.source_zone_id
}

output "site" {
  // Could not transform ROS Attribute Site to Terraform attribute.
  value       = null
  description = "Site information sources for replication pairs and consistent replication groups. Possible values:"
}

output "description" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.description
  description = "The description of the consistent replication group."
}

output "pair_number" {
  // Could not transform ROS Attribute PairNumber to Terraform attribute.
  value       = null
  description = "The number of replication pairs contained in a consistent replication group."
}

output "disk_replica_group_name" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.group_name
  description = "Consistent replication group name."
}

output "standby_zone" {
  // Could not transform ROS Attribute StandbyZone to Terraform attribute.
  value       = null
  description = "The initial destination zone of the replication group."
}

output "resource_group_id" {
  // Could not transform ROS Attribute ResourceGroupId to Terraform attribute.
  value       = null
  description = "resource group ID of enterprise"
}

output "primary_region" {
  // Could not transform ROS Attribute PrimaryRegion to Terraform attribute.
  value       = null
  description = "The initial source region of the replication group."
}

output "last_recover_point" {
  // Could not transform ROS Attribute LastRecoverPoint to Terraform attribute.
  value       = null
  description = "The time when the last asynchronous replication operation of the consistent replication group completed. This parameter provides the return value as a timestamp. Unit: seconds."
}

output "pair_ids" {
  // Could not transform ROS Attribute PairIds to Terraform attribute.
  value       = null
  description = "List of replication pair IDs contained in a consistent replication group."
}

output "replica_group_id" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.id
  description = "The ID of the consistent replication group."
}

output "rpo" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.rpo
  description = "The RPO value set by the consistency group in seconds."
}

output "source_region_id" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.source_region_id
  description = "The ID of the region to which the production site belongs."
}

output "destination_region_id" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.destination_region_id
  description = "The ID of the region to which the disaster recovery site belongs."
}

output "destination_zone_id" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.destination_zone_id
  description = "The ID of the zone to which the disaster recovery site belongs."
}

output "primary_zone" {
  // Could not transform ROS Attribute PrimaryZone to Terraform attribute.
  value       = null
  description = "The initial source available area of the replication group."
}

output "source_zone_id" {
  value       = alicloud_ebs_disk_replica_group.extension_resource.source_zone_id
  description = "The ID of the zone to which the production site belongs."
}

output "standby_region" {
  // Could not transform ROS Attribute StandbyRegion to Terraform attribute.
  value       = null
  description = "The initial destination region of the replication group."
}

output "tags" {
  // Could not transform ROS Attribute Tags to Terraform attribute.
  value       = null
  description = "The tags of the disk replica group."
}

