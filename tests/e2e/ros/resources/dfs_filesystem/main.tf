variable "space_capacity" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Capacity of the file system.\nWhen the actual data volume reaches the file system capacity, data cannot be written.\nUnit: GB"
    },
    "Label": {
      "en": "SpaceCapacity",
      "zh-cn": "文件系统容量预算"
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
      "en": "The description of the file system."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "文件系统的描述信息"
    },
    "MaxLength": 100
  }
  EOT
}

variable "storage_type" {
  type        = string
  default     = "STANDARD"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Type of storage media.\nValues:\nSTANDARD (default) : standard type.\nPERFORMANCE: performance type."
    },
    "AllowedValues": [
      "STANDARD",
      "PERFORMANCE"
    ],
    "Label": {
      "en": "StorageType",
      "zh-cn": "存储介质类型"
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
      "en": "zone id"
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "partition_number" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The reserved parameters"
    },
    "Label": {
      "en": "PartitionNumber",
      "zh-cn": "预留参数"
    }
  }
  EOT
}

variable "protocol_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "HDFS"
    ],
    "Description": {
      "en": "Protocol type, only support HDFS（HadoopFileSystem）"
    },
    "Label": {
      "en": "ProtocolType",
      "zh-cn": "协议类型"
    }
  }
  EOT
}

variable "data_redundancy_type" {
  type        = string
  default     = "LRS"
  description = <<EOT
  {
    "Description": {
      "en": "Redundancy mode of the file system.\nValues:\nLRS (default) : local redundancy.\nZRS: in-city redundancy."
    },
    "AllowedValues": [
      "LRS",
      "ZRS"
    ],
    "Label": {
      "en": "DataRedundancyType",
      "zh-cn": "文件系统的冗余模式"
    }
  }
  EOT
}

variable "file_system_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of the file system. The naming rules are as follows:\nThe value contains 6 to 100 characters. \nGlobally unique and cannot be an empty string.\nThe value can contain letters and digits and underscores (_)."
    },
    "Label": {
      "en": "FileSystemName",
      "zh-cn": "文件系统名称"
    },
    "MinLength": 6,
    "MaxLength": 100
  }
  EOT
}

variable "provisioned_throughput_in_mi_bps" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Preset handling capacity.\nUnit: MB/sdata range: 1-5120"
    },
    "MinValue": 1,
    "Label": {
      "en": "ProvisionedThroughputInMiBps",
      "zh-cn": "预置吞吐量"
    },
    "MaxValue": 5120
  }
  EOT
}

variable "throughput_mode" {
  type        = string
  default     = "Standard"
  description = <<EOT
  {
    "Description": {
      "en": "Throughput mode\nValues:\nStandard（default）: standard throughputProvisioned: preset throughput"
    },
    "AllowedValues": [
      "Standard",
      "Provisioned"
    ],
    "Label": {
      "en": "ThroughputMode",
      "zh-cn": "吞吐模式"
    }
  }
  EOT
}

variable "storage_set_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The reserved parameters."
    },
    "Label": {
      "en": "StorageSetName",
      "zh-cn": "预留参数"
    },
    "MaxLength": 100
  }
  EOT
}

resource "alicloud_dfs_file_system" "file_system" {
  space_capacity                   = var.space_capacity
  description                      = var.description
  storage_type                     = var.storage_type
  zone_id                          = var.zone_id
  partition_number                 = var.partition_number
  protocol_type                    = var.protocol_type
  data_redundancy_type             = var.data_redundancy_type
  file_system_name                 = var.file_system_name
  provisioned_throughput_in_mi_bps = var.provisioned_throughput_in_mi_bps
  throughput_mode                  = var.throughput_mode
  storage_set_name                 = var.storage_set_name
}

output "file_system_id" {
  value       = alicloud_dfs_file_system.file_system.id
  description = "The ID of the file system."
}

