variable "fset_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Fileset ID."
    },
    "Label": {
      "en": "FsetId",
      "zh-cn": "Fileset ID"
    }
  }
  EOT
}

variable "source_storage" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Access path stored at the source.Format: <storage Type>: // <PATH>.\nin:\nStorage Type: Currently only supports OSS.\nPATH: OSS's bucket name.Limit the following.\nOnly support the lowercase letters, numbers and short strokes (-) and must start with a lowercase letter or number.\nThe length is 8 ~ 128 English characters.\nUse UTF-8 encoding.\nCan't start with http: // and https: //.\nExplain that the OSS BUCKET must be the bucket that exists in the region."
    },
    "Label": {
      "en": "SourceStorage",
      "zh-cn": "源端存储的访问路径"
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
      "en": "Description of data flow.\nlimit:\nThe length is 2 to 128 English or Chinese characters.\nStart with a lowercase letter or Chinese, and you cannot start with http:// and https: //.\nIt can contain numbers, half-horn colon (:), down line (_) or short lines (-)."
    },
    "AllowedPattern": "^(?!http://|https://)[a-zA-Z一-龥][0-9a-zA-Z:-_]{1,127}$",
    "Label": {
      "en": "Description",
      "zh-cn": "数据流动的描述"
    }
  }
  EOT
}

variable "source_security_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of safety protection types of the source storage. If the source storage must be protected through safety protection, please specify the type of safety protection type storage.Value:\nNo (default value): It means that the source storage does not need to be accessed by safe protection.\nSSL: Protective access through SSL certificates."
    },
    "AllowedValues": [
      "SSL"
    ],
    "Label": {
      "en": "SourceSecurityType",
      "zh-cn": "源端存储的安全保护类型"
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
      "en": "File system ID."
    },
    "Label": {
      "en": "FileSystemId",
      "zh-cn": "文件系统ID"
    }
  }
  EOT
}

variable "throughput" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      600,
      1200,
      1500
    ],
    "Description": {
      "en": "The upper limit of transmission bandwidth for data flow, unit: MB/s.\nValue: \n600\n1200\n1500\n\nExplanation The transmission bandwidth of the data flow must be smaller than the IO bandwidth of the file system."
    },
    "Label": {
      "en": "Throughput",
      "zh-cn": "数据流动的传输带宽上限"
    }
  }
  EOT
}

variable "auto_refreshs" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RefreshPath": {
          "Type": "String",
          "Description": {
            "en": "Automatic update directory, data modification incident stored at the CPFS registration source end, check whether the source data in the directory is updated and automatically imported the updated data.\nThe default is empty. Any data update stored at the source will not automatically import the CPFS. You need to import and update through manual tasks.\nlimit:\nThe length is 2 to 1024 characters.\nUse UTF-8 encoding.\nIt must start with a positive oblique line (/).\nThis directory must be existing directory on CPFS and must be located in the Fileset directory that flows in the data."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "AutoRefreshs",
      "zh-cn": "自动更新配置信息集合"
    }
  }
  EOT
}

variable "auto_refresh_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Automatic update strategy, after the source data is updated, the data update is introduced to the CPFS strategy.\nNone (default): The data update of the source is not automatically imported into CPFS. Users can import data update at the source end of the source through data flow tasks.\nImportchanged: The data update at the source automatically imports CPFS."
    },
    "Label": {
      "en": "AutoRefreshPolicy",
      "zh-cn": "自动更新策略"
    }
  }
  EOT
}

variable "auto_refresh_interval" {
  type        = number
  default     = 10
  description = <<EOT
  {
    "Description": {
      "en": "The automatic update interval time, every time the interval, the CPFS checks whether there is a data update in the directory. If there is data update, start the automatic update task, unit: minute.\nScope of value: 5 ~ 525600, default value: 10."
    },
    "MinValue": 5,
    "Label": {
      "en": "AutoRefreshInterval",
      "zh-cn": "自动更新间隔时间"
    },
    "MaxValue": 525600
  }
  EOT
}

resource "alicloud_nas_data_flow" "data_flow" {
  fset_id              = var.fset_id
  source_storage       = var.source_storage
  description          = var.description
  source_security_type = var.source_security_type
  file_system_id       = var.file_system_id
  throughput           = var.throughput
}

output "file_system_id" {
  value       = alicloud_nas_data_flow.data_flow.file_system_id
  description = "File system ID."
}

output "data_flow_id" {
  value       = alicloud_nas_data_flow.data_flow.id
  description = "Data flow ID."
}

