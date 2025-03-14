variable "host_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Host Class"
    },
    "Label": {
      "en": "HostClass",
      "zh-cn": "主机的规格"
    }
  }
  EOT
}

variable "os_password" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "OsPassword",
      "zh-cn": "主机的密码"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Zone ID"
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "dedicated_host_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Dedicated Host Group ID"
    },
    "Label": {
      "en": "DedicatedHostGroupId",
      "zh-cn": "目标专属集群ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether Auto Renew"
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否开启自动续费功能"
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
      "en": "VSwitch ID"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机的ID"
    }
  }
  EOT
}

variable "used_time" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Label": {
      "en": "UsedTime",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "image_category" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "WindowsWithMssqlEntAlwaysonLicense": {
          "en": "Windows with MSSQL Enterprise Alwayson License",
          "zh-cn": "SQL Server集群版"
        },
        "WindowsWithMssqlStdLicense": {
          "en": "Windows with MSSQL Standard License",
          "zh-cn": "SQL Server标准版"
        },
        "WindowsWithMssqlWebLicense": {
          "en": "Windows with MSSQL Web License",
          "zh-cn": "SQL Server Web版"
        },
        "WindowsWithMssqlEntLicense": {
          "en": "Windows with MSSQL Enterprise License",
          "zh-cn": "SQL Server企业版"
        },
        "AliLinux": {
          "en": "AliLinux",
          "zh-cn": "其他主机镜像"
        }
      }
    },
    "Description": {
      "en": "Host Image Category"
    },
    "AllowedValues": [
      "WindowsWithMssqlEntAlwaysonLicense",
      "WindowsWithMssqlStdLicense",
      "WindowsWithMssqlEntLicense",
      "WindowsWithMssqlWebLicense",
      "AliLinux"
    ],
    "Label": {
      "en": "ImageCategory",
      "zh-cn": "主机的镜像"
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "AllowedValues": [
      "Month",
      "Year",
      "Week"
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "主机的预付费周期"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  default     = "Prepaid"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "Prepaid": {
          "Month": [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9
          ],
          "Year": [
            1,
            2,
            3,
            4,
            5
          ],
          "Week": [
            1,
            2,
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Payment Type"
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "主机的付费类型"
    }
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Host Name"
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "主机的名称"
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
        "TagKey": {
          "Type": "String",
          "Description": {
            "en": "The key of the tags"
          },
          "Required": false
        },
        "TagValue": {
          "Type": "String",
          "Description": {
            "en": "The value of the tags"
          },
          "Required": false
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
      "en": "The tag of the resource"
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    }
  }
  EOT
}

resource "alicloud_cddc_dedicated_host" "cddcdedicated_host" {
  host_class              = var.host_class
  os_password             = var.os_password
  zone_id                 = var.zone_id
  dedicated_host_group_id = var.dedicated_host_group_id
  vswitch_id              = var.vswitch_id
  used_time               = var.used_time
  image_category          = var.image_category
  period                  = var.period
  payment_type            = var.payment_type
  host_name               = var.host_name
  tags                    = var.tags
}

output "disk_allocation_ratio" {
  // Could not transform ROS Attribute DiskAllocationRatio to Terraform attribute.
  value       = null
  description = "Disk Allocation Ratio"
}

output "dedicated_host_id" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.id
  description = "The first ID of the resource"
}

output "mem_allocation_ratio" {
  // Could not transform ROS Attribute MemAllocationRatio to Terraform attribute.
  value       = null
  description = "Memory Allocation Ratio"
}

output "zone_id" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.zone_id
  description = "Zone ID"
}

output "dedicated_host_group_id" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.dedicated_host_group_id
  description = "Dedicated Host Group ID"
}

output "auto_renew" {
  // Could not transform ROS Attribute AutoRenew to Terraform attribute.
  value       = null
  description = "Whether Auto Renew"
}

output "vswitch_id" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.vswitch_id
  description = "VSwitch ID"
}

output "image_category" {
  // Could not transform ROS Attribute ImageCategory to Terraform attribute.
  value       = null
  description = "Host Image Category"
}

output "host_storage" {
  // Could not transform ROS Attribute HostStorage to Terraform attribute.
  value       = null
  description = "Host Storage"
}

output "storage_used" {
  // Could not transform ROS Attribute StorageUsed to Terraform attribute.
  value       = null
  description = "Storage Used"
}

output "open_permission" {
  // Could not transform ROS Attribute OpenPermission to Terraform attribute.
  value       = null
  description = "Whether Open OS Permission"
}

output "host_type" {
  // Could not transform ROS Attribute HostType to Terraform attribute.
  value       = null
  description = "Host Storage Type"
}

output "host_class" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.host_class
  description = "Host Class"
}

output "host_cpu" {
  // Could not transform ROS Attribute HostCpu to Terraform attribute.
  value       = null
  description = "Host CPU"
}

output "vpc_id" {
  // Could not transform ROS Attribute VpcId to Terraform attribute.
  value       = null
  description = "VPC ID"
}

output "ecs_class_code" {
  // Could not transform ROS Attribute EcsClassCode to Terraform attribute.
  value       = null
  description = "ECS Class Code"
}

output "cpu_allocation_ratio" {
  // Could not transform ROS Attribute CpuAllocationRatio to Terraform attribute.
  value       = null
  description = "CPU Allocation Ratio"
}

output "host_mem" {
  // Could not transform ROS Attribute HostMem to Terraform attribute.
  value       = null
  description = "Host Memory"
}

output "payment_type" {
  // Could not transform ROS Attribute PaymentType to Terraform attribute.
  value       = null
  description = "Payment Type"
}

output "memory_used" {
  // Could not transform ROS Attribute MemoryUsed to Terraform attribute.
  value       = null
  description = "Host Memory Used"
}

output "ip_address" {
  // Could not transform ROS Attribute IpAddress to Terraform attribute.
  value       = null
  description = "Host IP Address"
}

output "cpu_used" {
  // Could not transform ROS Attribute CpuUsed to Terraform attribute.
  value       = null
  description = "CPU Used"
}

output "host_name" {
  value       = alicloud_cddc_dedicated_host.cddcdedicated_host.host_name
  description = "Host Name"
}

