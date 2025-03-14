variable "standby_zone_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The standby zone ID of the instance."
    }
  }
  EOT
}

variable "master_node_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of master nodes. Minimum is 1, max is 2."
    },
    "MinValue": 1,
    "Label": {
      "en": "MasterNodeNum",
      "zh-cn": "Master节点数量"
    },
    "MaxValue": 2
  }
  EOT
}

variable "instance_spec" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The specification of segment nodes.\n- When DBInstanceCategory is HighAvailability, Valid values: 2C16G, 4C32G, 8C64G, 16C128G.\n- When DBInstanceCategory is Basic, Valid values: 2C8G, 4C16G, 8C32G, 16C64G.\n- When DBInstanceCategory is Serverless, Valid values: 4C16G, 8C32G.\nThis parameter must be passed to create a storage elastic mode instance and a serverless version instance."
    },
    "AllowedValues": [
      "2C8G",
      "2C16G",
      "4C16G",
      "4C32G",
      "8C32G",
      "16C64G",
      "16C128G"
    ],
    "Label": {
      "en": "InstanceSpec",
      "zh-cn": "计算节点规格"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Private IP address."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "私有IP地址"
    }
  }
  EOT
}

variable "idle_time" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ServerlessMode}",
            "Auto"
          ]
        }
      }
    },
    "Description": {
      "en": "Idle release wait time. That is, when the period of no service traffic reaches the specified period, the instance becomes idle. The unit is second. The minimum value is 60. The default value is 600."
    },
    "MinValue": 60,
    "Label": {
      "en": "IdleTime",
      "zh-cn": "空闲释放等待时长"
    }
  }
  EOT
}

variable "ainode_spec_infos" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AINodeSpec": {
          "Type": "String",
          "Description": {
            "en": "The spec of ai node."
          },
          "Required": true
        },
        "AINodeNum": {
          "Type": "Number",
          "Description": {
            "en": "The number of ai node."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "AI node spec infos."
    },
    "MinLength": 1,
    "MaxLength": 1
  }
  EOT
}

variable "seg_node_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Calculate the number of nodes. The value can be:\n- When DBInstanceMode is StorageElastic and DBInstanceCategory is HighAvailability, the value ranges from 4 to 512. The value must be a multiple of 4.\n- When DBInstanceMode is StorageElastic and DBInstanceCategory is Basic, the value ranges from 2 to 512. The value must be a multiple of 2.\n- When DBInstanceMode is Serverless, The value ranges from 2 to 512. The value must be a multiple of 2."
    },
    "MinValue": 2,
    "Label": {
      "en": "SegNodeNum",
      "zh-cn": "计算节点个数"
    },
    "MaxValue": 512
  }
  EOT
}

variable "seg_storage_type" {
  type        = string
  default     = "cloud_essd"
  description = <<EOT
  {
    "Description": {
      "en": "The disk type of segment nodes. For example: cloud_essd, cloud_efficiency.\nThis parameter must be passed in to create a storage elastic mode instance.\nStorage Elastic Mode Basic Edition instances only support ESSD cloud disks."
    },
    "Label": {
      "en": "SegStorageType",
      "zh-cn": "磁盘存储类型"
    }
  }
  EOT
}

variable "encryption_key" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${EncryptionType}",
            "CloudDisk"
          ]
        }
      }
    },
    "Description": {
      "en": "If the EncryptionType parameter is set to CloudDisk, you must specify this parameter to the encryption key that is in the same region with the disks that is specified by the EncryptionType parameter. Otherwise, leave this parameter empty."
    },
    "Label": {
      "en": "EncryptionKey",
      "zh-cn": "密钥ID"
    }
  }
  EOT
}

variable "dbinstance_group_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of compute nodes in the instance.\nThe value can be 2, 4, 8, 12, 16, 24, 32, 64, 96, or 128."
    },
    "MinValue": 1,
    "Label": {
      "en": "DBInstanceGroupCount",
      "zh-cn": "AnalyticDB for PostgreSQL计算组的数量"
    }
  }
  EOT
}

variable "standbyvswitch_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The standby VSwitch ID of the instance."
    }
  }
  EOT
}

variable "dbinstance_category" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "DB instance category, valid values: Basic, HighAvailability.\nThis parameter must be passed in to create a storage reservation mode instance."
    },
    "AllowedValues": [
      "HighAvailability",
      "Basic"
    ],
    "Label": {
      "en": "DBInstanceCategory",
      "zh-cn": "实例系列"
    }
  }
  EOT
}

variable "vector_configuration_status" {
  type        = string
  default     = "false"
  description = <<EOT
  {
    "Description": {
      "en": "the status of vector configuration. The value can be:Y: Turn on vector engine optimization.N: Turn off vector engine optimization (default value)."
    },
    "AllowedValues": [
      "false",
      "true"
    ],
    "Label": {
      "en": "VectorConfigurationStatus",
      "zh-cn": "是否开启向量引擎优化"
    }
  }
  EOT
}

variable "deploy_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The deployment mode of the instance."
    },
    "AllowedValues": [
      "single",
      "multiple"
    ]
  }
  EOT
}

variable "securityiplist" {
  type        = string
  default     = "127.0.0.1"
  description = <<EOT
  {
    "Description": {
      "en": "The whitelist of IP addresses that are allowed to access the instance. Default value:\n127.0.0.1."
    },
    "Label": {
      "en": "SecurityIPList",
      "zh-cn": "IP地址白名单"
    }
  }
  EOT
}

variable "serverless_resource" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ServerlessMode}",
            "Auto"
          ]
        }
      }
    },
    "Description": {
      "en": "Computing resource threshold. The value ranges from 8 to 32. The step length is 8.\nThe unit is ACU. The default value is 32."
    },
    "AllowedValues": [
      8,
      16,
      24,
      32
    ],
    "Label": {
      "en": "ServerlessResource",
      "zh-cn": "计算资源阈值"
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
          "Description": {
            "en": "The value of the tag."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "The keyword of the tag."
          },
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
      "en": "The list of instance tags in the form of key/value pairs.\nYou can define a maximum of 20 tags for instance."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "dbinstance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the instance. The description cannot exceed 256 characters in length."
    },
    "Label": {
      "en": "DBInstanceDescription",
      "zh-cn": "实例描述"
    },
    "MaxLength": 256
  }
  EOT
}

variable "encryption_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the encryption. Default value: NULL. Valid values:\nNULL: Encryption is disabled.\nCloudDisk: Encryption is enabled on disks and the encryption key is specified by using the EncryptionKey parameter.\nNote: Disk encryption cannot be disabled after it is enabled."
    },
    "AllowedValues": [
      "NULL",
      "CloudDisk"
    ],
    "Label": {
      "en": "EncryptionType",
      "zh-cn": "加密类型"
    }
  }
  EOT
}

variable "serverless_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mode of the Serverless instance. The value can be:\nManual: manual scheduling is the default value.\nAuto: indicates automatic scheduling."
    },
    "AllowedValues": [
      "Manual",
      "Auto"
    ],
    "Label": {
      "en": "ServerlessMode",
      "zh-cn": "Serverless实例的模式"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "6.0",
      "6.0x"
    ],
    "Description": {
      "en": "The version of the database engine. For example: 6.0、7.0"
    },
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "引擎版本"
    }
  }
  EOT
}

variable "create_sample_data" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to load the sample data set after the instance is created. The value can be:\ntrue: load the sample dataset.\nfalse: not to load the sample dataset"
    },
    "Label": {
      "en": "CreateSampleData",
      "zh-cn": "是否在实例创建完成后加载样本数据集"
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
      "en": "The zone ID of the instance, such as cn-hangzhou-d. You can call the DescribeRegions\noperation to query the most recent zone list."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "vpcid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC ID of the instance. If you set the InstanceNetworkType parameter to VPC, you\nmust also specify the VPCId parameter. The specified region of the VPC must be the\nsame as the RegionId value."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "dbinstance_class" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The instance type."
    },
    "Label": {
      "en": "DBInstanceClass",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "prod_type" {
  type        = string
  default     = "standard"
  description = <<EOT
  {
    "Description": {
      "en": "Prod type. The value can be: standard, cost-effective. The default value is standard."
    },
    "AllowedValues": [
      "standard",
      "cost-effective"
    ],
    "Label": {
      "en": "ProdType",
      "zh-cn": "产品类型"
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
      "VpcId": "$${VPCId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The vSwitch ID of the instance."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "storage_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of per segment node. Unit: GB. Minimum is 50, max is 4000, step is 50."
    },
    "MinValue": 50,
    "Label": {
      "en": "StorageSize",
      "zh-cn": "存储空间大小"
    },
    "MaxValue": 4000
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription period. While choose by pay by month, it could be from 1 to 11. While choose pay by year, it could be from 1 to 3."
    },
    "MinValue": 1,
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    },
    "MaxValue": 11
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "Postpaid"
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
            9,
            12,
            24,
            36,
            48,
            60
          ],
          "Year": [
            1,
            2,
            3
          ]
        },
        "Postpaid": {}
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the instance. Default value: Postpaid. Valid values:\nPostpaid: pay-as-you-go\nPrepaid: subscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "mastercu" {
  type        = number
  default     = 8
  description = <<EOT
  {
    "Description": {
      "en": "Master resources. Default is 8."
    },
    "AllowedValues": [
      2,
      4,
      8,
      16,
      32,
      64,
      128
    ]
  }
  EOT
}

variable "dbinstance_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The db instance mode. Valid values: StorageElastic, Serverless, Classic."
    },
    "AllowedValues": [
      "StorageElastic",
      "Serverless",
      "Classic"
    ],
    "Label": {
      "en": "DBInstanceMode",
      "zh-cn": "实例资源类型"
    }
  }
  EOT
}

variable "seg_disk_performance_level" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "Seg disk performance level. The value can be:\npl0、pl1 and pl2"
    },
    "AllowedValues": [
      "pl0",
      "pl1",
      "pl2"
    ],
    "Label": {
      "en": "SegDiskPerformanceLevel",
      "zh-cn": "ESSD云盘的性能级别"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of subscription period, it could be Month/Year. Default value is Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "购买资源的时长单位"
    }
  }
  EOT
}

resource "alicloud_gpdb_instance" "dbinstance" {
  master_node_num             = var.master_node_num
  instance_spec               = var.instance_spec
  private_ip_address          = var.private_ip_address
  seg_node_num                = var.seg_node_num
  seg_storage_type            = var.seg_storage_type
  encryption_key              = var.encryption_key
  instance_group_count        = var.dbinstance_group_count
  db_instance_category        = var.dbinstance_category
  vector_configuration_status = var.vector_configuration_status
  tags                        = var.tags
  description                 = var.dbinstance_description
  encryption_type             = var.encryption_type
  engine_version              = var.engine_version
  create_sample_data          = var.create_sample_data
  availability_zone           = var.zone_id
  vpc_id                      = var.vpcid
  db_instance_class           = var.dbinstance_class
  vswitch_id                  = var.vswitch_id
  storage_size                = var.storage_size
  period                      = var.period
  instance_charge_type        = var.pay_type
  db_instance_mode            = var.dbinstance_mode
}

output "dbinstance_id" {
  value       = alicloud_gpdb_instance.dbinstance.id
  description = "The ID of the instance."
}

output "port" {
  value       = alicloud_gpdb_instance.dbinstance.port
  description = "The port used to connect to the instance."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order ID of the instance."
}

output "connection_string" {
  value       = alicloud_gpdb_instance.dbinstance.connection_string
  description = "The endpoint of the instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

