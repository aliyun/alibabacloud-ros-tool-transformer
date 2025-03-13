variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "File system description (space characters are not allowed)"
    },
    "Label": {
      "en": "Description",
      "zh-cn": "文件系统描述"
    }
  }
  EOT
}

variable "storage_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "standard"
            ]
          },
          "Value": [
            "Performance",
            "Capacity"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "extreme"
            ]
          },
          "Value": [
            "standard",
            "advance"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "cpfs"
            ]
          },
          "Value": [
            "advance_100",
            "advance_200"
          ]
        }
      ],
      "LocaleKey": "NasStorageType"
    },
    "Description": {
      "en": "The storage type of the file System.\nValid values:\nPerformance、Capacity(Available when the file_system_type is standard)\nstandard、advance(Available when the file_system_type is extreme)\nadvance_100、advance_200(Available when the file_system_type is cpfs)\n"
    },
    "AllowedValues": [
      "Performance",
      "Capacity",
      "standard",
      "advance",
      "advance_100",
      "advance_200"
    ],
    "Label": {
      "en": "StorageType",
      "zh-cn": "存储类型"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "Zone ID."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
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
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "VSwitch ID.",
      "zh-cn": "交换机ID，指定VpcId和VSwitchId可以在创建文件系统实例的同时预配置一个默认挂载点。"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ChargeType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "The period of subscription in months. Required and valid when ChargeType is Subscription.\nWhen the annual and monthly subscription instance expires without renewal, the instance will automatically expire and be released."
    },
    "Label": {
      "en": "Duration",
      "zh-cn": "包年包月时长"
    }
  }
  EOT
}

variable "snapshot_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Snapshot ID."
    },
    "Label": {
      "en": "SnapshotId",
      "zh-cn": "快照ID"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether delete all mount targets on the file system and then delete file system. Default is false"
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除"
    }
  }
  EOT
}

variable "encrypt_type" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${FileSystemType}",
                "standard"
              ]
            },
            {
              "Fn::Equals": [
                "$${FileSystemType}",
                "extreme"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to encrypt data. You can use keys that are hosted by Key Management Service (KMS) to encrypt data stored on a file system. Data is automatically decrypted when you access encrypted data. Valid values:\n0: specifies that no encryption is applied to data on the file system.\n1: specifies that encryption is applied to data on the file system.",
      "zh-cn": "文件系统是否加密。使用KMS托管密钥，对文件系统落盘数据进行加密存储。在读写加密数据时，无需解密。"
    },
    "AllowedValues": [
      0,
      1
    ],
    "Label": {
      "en": "EncryptType",
      "zh-cn": "文件系统是否加密"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "Vpc ID.",
      "zh-cn": "专有网络ID，指定VpcId和VSwitchId可以在创建文件系统实例的同时预配置一个默认挂载点。"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "capacity" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "File system capacity, the unit is GB. Required and valid when FileSystemType=extreme or cpfs.",
      "zh-cn": "FileSystemType取值为extreme或cpfs时该参数有效且必须指定。当FileSystemType取值为extreme时：100~262,144。当FileSystemType取值为cpfs时：2048~512,000。单位：GB。"
    },
    "Label": {
      "en": "Capacity",
      "zh-cn": "文件系统容量"
    }
  }
  EOT
}

variable "protocol_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "standard"
            ]
          },
          "Value": [
            "NFS",
            "SMB"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "extreme"
            ]
          },
          "Value": [
            "NFS"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${FileSystemType}",
              "cpfs"
            ]
          },
          "Value": [
            "cpfs"
          ]
        }
      ]
    },
    "Description": {
      "en": "Type of protocol used. Valid values: NFS, SMB, cpfs."
    },
    "AllowedValues": [
      "NFS",
      "SMB",
      "cpfs"
    ],
    "Label": {
      "en": "ProtocolType",
      "zh-cn": "协议类型"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Type of payment:\nPayAsYouGo (pay as you go)\nSubscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "file_system_type" {
  type        = string
  default     = "standard"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NasFileSystemType"
    },
    "Description": {
      "en": "File system type. Allowed values: standard(default), extreme, cpfs"
    },
    "AllowedValues": [
      "standard",
      "extreme",
      "cpfs"
    ],
    "Label": {
      "en": "FileSystemType",
      "zh-cn": "文件系统类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum file system throughput, unit is MB/s. Required and valid only when FileSystemType=cpfs."
    },
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "文件系统吞吐上限"
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
      "en": "Tags to attach to filesystem. Max support 20 tags to add during create filesystem. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_nas_file_system" "file_system" {
  description      = var.description
  storage_type     = var.storage_type
  zone_id          = var.zone_id
  vswitch_id       = var.vswitch_id
  encrypt_type     = var.encrypt_type
  vpc_id           = var.vpc_id
  capacity         = var.capacity
  protocol_type    = var.protocol_type
  file_system_type = var.file_system_type
  tags             = var.tags
}

output "file_system_id" {
  value       = alicloud_nas_file_system.file_system.id
  description = "ID of the file system created"
}

