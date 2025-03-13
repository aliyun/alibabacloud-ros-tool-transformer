variable "disk_allocation_ratio" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Disk Allocation Ratio"
    },
    "Label": {
      "en": "DiskAllocationRatio",
      "zh-cn": "专属集群的空间超配比"
    }
  }
  EOT
}

variable "allocation_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Intensively": {
          "en": "Intensively",
          "zh-cn": "密集分配"
        },
        "Evenly": {
          "en": "Evenly",
          "zh-cn": "平均分配"
        }
      }
    },
    "Description": {
      "en": "Allocation Policy"
    },
    "AllowedValues": [
      "Evenly",
      "Intensively"
    ],
    "Label": {
      "en": "AllocationPolicy",
      "zh-cn": "专属集群资源调度的分配策略"
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
      "en": "VPC ID"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专属集群归属的专有网络ID"
    }
  }
  EOT
}

variable "mem_allocation_ratio" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Memory Allocation Ratio"
    },
    "Label": {
      "en": "MemAllocationRatio",
      "zh-cn": "专属集群中每台主机的内存最大使用率"
    }
  }
  EOT
}

variable "host_replace_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Host Replace Policy"
    },
    "AllowedValues": [
      "Auto",
      "Manual"
    ],
    "Label": {
      "en": "HostReplacePolicy",
      "zh-cn": "主机故障时系统的处理策略"
    }
  }
  EOT
}

variable "cpu_allocation_ratio" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Cpu Allocation Ratio"
    },
    "Label": {
      "en": "CpuAllocationRatio",
      "zh-cn": "专属集群的CPU超配比"
    }
  }
  EOT
}

variable "engine" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "MySQL",
      "SQLServer",
      "PostgreSQL",
      "Redis"
    ],
    "Description": {
      "en": "Database Engine Type"
    },
    "Label": {
      "en": "Engine",
      "zh-cn": "数据库引擎类型"
    }
  }
  EOT
}

variable "dedicated_host_group_desc" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Dedicated Host Group Description"
    },
    "Label": {
      "en": "DedicatedHostGroupDesc",
      "zh-cn": "专属集群的名称"
    }
  }
  EOT
}

variable "open_permission" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether Open OS Permission"
    },
    "Label": {
      "en": "OpenPermission",
      "zh-cn": "是否开放专属集群内的主机的操作系统权限"
    }
  }
  EOT
}

resource "alicloud_cddc_dedicated_host_group" "cddcdedicated_host_group" {
  disk_allocation_ratio     = var.disk_allocation_ratio
  allocation_policy         = var.allocation_policy
  vpc_id                    = var.vpc_id
  mem_allocation_ratio      = var.mem_allocation_ratio
  host_replace_policy       = var.host_replace_policy
  cpu_allocation_ratio      = var.cpu_allocation_ratio
  engine                    = var.engine
  dedicated_host_group_desc = var.dedicated_host_group_desc
}

output "deploy_type" {
  // Could not transform ROS Attribute DeployType to Terraform attribute.
  value       = null
  description = "DeployType"
}

output "disk_allocation_ratio" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.disk_allocation_ratio
  description = "Disk Allocation Ratio"
}

output "disk_used_amount" {
  // Could not transform ROS Attribute DiskUsedAmount to Terraform attribute.
  value       = null
  description = "DiskUsedAmount"
}

output "instance_number" {
  // Could not transform ROS Attribute InstanceNumber to Terraform attribute.
  value       = null
  description = "Total Instance Number"
}

output "allocation_policy" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.allocation_policy
  description = "Allocation Policy"
}

output "host_replace_policy" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.host_replace_policy
  description = "Host Replace Policy"
}

output "dedicated_host_group_id" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.id
  description = "Dedicated Host Group ID"
}

output "bastion_instance_id" {
  // Could not transform ROS Attribute BastionInstanceId to Terraform attribute.
  value       = null
  description = "BastionInstanceId"
}

output "mem_allocated_amount" {
  // Could not transform ROS Attribute MemAllocatedAmount to Terraform attribute.
  value       = null
  description = "MemAllocatedAmount"
}

output "open_permission" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.open_permission
  description = "Whether Open OS Permission"
}

output "mem_allocate_ration" {
  // Could not transform ROS Attribute MemAllocateRation to Terraform attribute.
  value       = null
  description = "MemAllocateRation"
}

output "disk_allocated_amount" {
  // Could not transform ROS Attribute DiskAllocatedAmount to Terraform attribute.
  value       = null
  description = "DiskAllocatedAmount"
}

output "engine" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.engine
  description = "Database Engine Type"
}

output "mem_utility" {
  // Could not transform ROS Attribute MemUtility to Terraform attribute.
  value       = null
  description = "MemUtility"
}

output "mem_allocation_ratio" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.mem_allocation_ratio
  description = "Memory Allocation Ratio"
}

output "cpu_allocate_ration" {
  // Could not transform ROS Attribute CpuAllocateRation to Terraform attribute.
  value       = null
  description = "CpuAllocateRation"
}

output "text" {
  // Could not transform ROS Attribute Text to Terraform attribute.
  value       = null
  description = "Text"
}

output "mem_used_amount" {
  // Could not transform ROS Attribute MemUsedAmount to Terraform attribute.
  value       = null
  description = "MemUsedAmount"
}

output "dedicated_host_group_desc" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.dedicated_host_group_desc
  description = "Dedicated Host Group Description"
}

output "vpc_id" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.vpc_id
  description = "VPC ID"
}

output "disk_utility" {
  // Could not transform ROS Attribute DiskUtility to Terraform attribute.
  value       = null
  description = "DiskUtility"
}

output "cpu_allocation_ratio" {
  value       = alicloud_cddc_dedicated_host_group.cddcdedicated_host_group.cpu_allocation_ratio
  description = "Cpu Allocation Ratio"
}

output "disk_allocate_ration" {
  // Could not transform ROS Attribute DiskAllocateRation to Terraform attribute.
  value       = null
  description = "DiskAllocateRation"
}

output "host_number" {
  // Could not transform ROS Attribute HostNumber to Terraform attribute.
  value       = null
  description = "Total Host Number"
}

output "cpu_allocated_amount" {
  // Could not transform ROS Attribute CpuAllocatedAmount to Terraform attribute.
  value       = null
  description = "CpuAllocatedAmount"
}

