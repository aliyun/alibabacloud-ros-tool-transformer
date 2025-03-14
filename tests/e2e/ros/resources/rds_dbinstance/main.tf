variable "period_type" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Charge period for created instances."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodType",
      "zh-cn": "周期类型"
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
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "archive_backup_retention_period" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of days for which to retain archived backups. \n The default value 0 specifies not to enable the backup archiving function. Valid values: 30 to 1095."
    },
    "MinValue": 30,
    "Label": {
      "en": "ArchiveBackupRetentionPeriod",
      "zh-cn": "归档备份的保留天数"
    },
    "MaxValue": 1095
  }
  EOT
}

variable "dbtime_zone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The UTC time zone of the instance. Valid values: -12:00 to +12:00. The time zone must be an integer value such as +08:00. Values such as +08:30 are not allowed."
    },
    "Label": {
      "en": "DBTimeZone",
      "zh-cn": "UTC时区"
    }
  }
  EOT
}

variable "port" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The port of the database service."
    },
    "MinValue": 1,
    "Label": {
      "en": "Port",
      "zh-cn": "实例端口"
    },
    "MaxValue": 65535
  }
  EOT
}

variable "storage_threshold" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${StorageAutoScale}",
            "Enable"
          ]
        }
      }
    },
    "Description": {
      "en": "Storage space automatic expansion trigger threshold (percentage)"
    },
    "Label": {
      "zh-cn": "存储空间自动扩容触发阈值（百分比）"
    }
  }
  EOT
}

variable "storage_auto_scale" {
  type        = string
  default     = "Disable"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Storage space automatic expansion switch, only supported by MySQL and PostgreSQL"
    },
    "AllowedValues": [
      "Disable",
      "Enable"
    ],
    "Label": {
      "zh-cn": "存储空间自动扩容开关"
    }
  }
  EOT
}

variable "instance_network_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceNetworkType"
    },
    "Description": {
      "en": "Instance network type, VPC or Classic"
    },
    "AllowedValues": [
      "VPC",
      "Classic"
    ],
    "Label": {
      "en": "InstanceNetworkType",
      "zh-cn": "实例的网络类型"
    }
  }
  EOT
}

variable "archive_backup_keep_count" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of archived backups that can be retained. Default value: 1. Valid values: \nThe value of this parameter ranges from 1 to 31 when the ArchiveBackupKeepPolicy \n parameter is set to ByMonth. \nThe value of this parameter ranges from 1 to 7 when the ArchiveBackupKeepPolicy \n parameter is set to ByWeek. \nNote You do not need to specify this parameter when the ArchiveBackupKeepPolicy \nparameter is set to KeepAll."
    },
    "MinValue": 1,
    "Label": {
      "en": "ArchiveBackupKeepCount",
      "zh-cn": "归档备份的保留个数"
    },
    "MaxValue": 31
  }
  EOT
}

variable "log_backup_retention_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of days for which to retain log backup files. Valid values: 7 to 730. The log backup \n retention period cannot be longer than the data backup retention period.Note If you enable the log \n backup function, you can specify the log backup retention period. This applies only when the \n instance runs MySQL, PostgreSQL, or PPAS."
    },
    "MinValue": 7,
    "Label": {
      "en": "LogBackupRetentionPeriod",
      "zh-cn": "日志备份保留天数"
    },
    "MaxValue": 730
  }
  EOT
}

variable "dbinstance_storage" {
  type        = number
  default     = 100
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of the instance. Unit: GB. The storage capacity increases in increments of 5 GB. \nYou can call the DescribeAvailableResource operation to query the storage capacity range that is supported for a specified instance type in a region."
    },
    "Label": {
      "en": "DBInstanceStorage",
      "zh-cn": "数据库存储空间"
    }
  }
  EOT
}

variable "dbmappings" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CharacterSetName": {
          "AssociationPropertyMetadata": {
            "AllowedValues": [
              {
                "Condition": {
                  "Fn::Or": [
                    {
                      "Fn::Equals": [
                        "$${Engine}",
                        "MySQL"
                      ]
                    },
                    {
                      "Fn::Equals": [
                        "$${Engine}",
                        "MariaDB"
                      ]
                    }
                  ]
                },
                "Value": [
                  "utf8",
                  "gbk",
                  "latin1",
                  "utf8mb4"
                ]
              },
              {
                "Condition": {
                  "Fn::Equals": [
                    "$${Engine}",
                    "SQLServer"
                  ]
                },
                "Value": [
                  "Chinese_PRC_CI_AS",
                  "Chinese_PRC_CS_AS",
                  "SQL_Latin1_General_CP1_CI_AS",
                  "SQL_Latin1_General_CP1_CS_AS",
                  "Chinese_PRC_BIN"
                ]
              }
            ]
          },
          "Type": "String",
          "Description": {
            "en": "For supported engines, specifies the character set to associate with the database instance."
          },
          "Required": true
        },
        "DBDescription": {
          "Type": "String",
          "Description": {
            "en": "Specifies the database description, containing up to 256 characters."
          },
          "Required": false,
          "MaxLength": 256
        },
        "DBName": {
          "Type": "String",
          "Description": {
            "en": "Consists of [2, 64] lower case letters, numbers, underscores, lines, letters. Must start with a letter, end with letters or numbers"
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Database mappings to attach to db instance."
    },
    "Label": {
      "en": "DBMappings",
      "zh-cn": "实例下创建新的数据库"
    }
  }
  EOT
}

variable "connection_string_prefix" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The prefix of the endpoint. \nOnly the prefix of the CurrentConnectionString parameter value can be modified.\nThe prefix must be 8 to 64 characters in length and can contain letters, digits, and hyphens (-). "
    },
    "AllowedPattern": "[a-zA-Z0-9-]{8,64}",
    "Label": {
      "en": "ConnectionStringPrefix",
      "zh-cn": "连接地址的前缀"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The tags of an instance.\nYou should input the information of the tag with the format of the Key-Value, such as {\"key1\":\"value1\",\"key2\":\"value2\", ... \"key5\":\"value5\"}.\nAt most 20 tags can be specified.\nKey\nIt can be up to 64 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCannot be a null string.\nValue\nIt can be up to 128 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCan be a null string.",
      "zh-cn": "实例的标签。以Key-Value的格式输入标签的信息，例如 {\"key1\":\"value1\", ... \"key5\":\"value5\"}。最多可以指定 20 个标签。"
    },
    "Label": {
      "zh-cn": "标签列表"
    }
  }
  EOT
}

variable "engine" {
  type        = string
  default     = "MySQL"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "AssociationProperty": "ALIYUN::RDS::Engine::EngineId",
    "Description": {
      "en": "Database instance engine type. Support MySQL/SQLServer/PostgreSQL/PPAS/MariaDB now."
    },
    "AllowedValues": [
      "MySQL",
      "SQLServer",
      "PostgreSQL",
      "MariaDB"
    ],
    "Label": {
      "en": "Engine",
      "zh-cn": "数据库类型"
    }
  }
  EOT
}

variable "dbinstance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of created database instance."
    },
    "Label": {
      "en": "DBInstanceDescription",
      "zh-cn": "实例的描述或备注信息"
    }
  }
  EOT
}

variable "io_acceleration_enabled" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable IO Acceleration, 1 for enable 0 for disable."
    },
    "AllowedValues": [
      "0",
      "1"
    ],
    "Label": {
      "zh-cn": "开启IO加速"
    }
  }
  EOT
}

variable "target_dedicated_host_id_for_master" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the host to which the instance belongs if you create a primary instance in a host group.",
      "zh-cn": "在专属集群内创建实例时，指定主实例的主机ID。"
    },
    "Label": {
      "zh-cn": "主实例的主机ID"
    }
  }
  EOT
}

variable "engine_version" {
  type        = string
  default     = "8.0"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Engine": "$${Engine}"
    },
    "AssociationProperty": "ALIYUN::RDS::Engine::EngineVersion",
    "Description": {
      "en": "Database instance version of the relative engine type. Support:\nValid values when you set the Engine parameter to MySQL: 5.5, 5.6, 5.7, and 8.0\nValid values when you set the Engine parameter to SQL Server: 2008r2, 08r2_ent_ha, 2012, 2012_ent_ha, 2012_std_ha, 2012_web, 2014_std_ha, 2016_ent_ha, 2016_std_ha, 2016_web, 2017_std_ha, 2017_ent, 2019_std_ha, and 2019_ent\nValid values when you set the Engine parameter to PostgreSQL: 10.0, 11.0, 12.0, 13.0, and 14.0\nValid values when you set the Engine parameter to MariaDB: 10.3"
    },
    "Label": {
      "en": "EngineVersion",
      "zh-cn": "数据库版本号"
    },
    "MinLength": 1,
    "MaxLength": 16
  }
  EOT
}

variable "dbinstance_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Category": "$${Category}",
      "EngineVersion": "$${EngineVersion}",
      "ZoneId": "$${ZoneId}",
      "InstanceChargeType": "$${PayType}",
      "DBInstanceStorageType": "$${DBInstanceStorageType}",
      "Engine": "$${Engine}"
    },
    "AssociationProperty": "ALIYUN::RDS::Instance::InstanceType",
    "Description": {
      "en": "Database instance type. Refer the RDS database instance type reference, such as 'rds.mys2.large', 'rds.mss1.large', 'rds.pg.s1.small' etc"
    },
    "Label": {
      "en": "DBInstanceClass",
      "zh-cn": "实例规格"
    },
    "MinLength": 1,
    "MaxLength": 64
  }
  EOT
}

variable "archive_backup_keep_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ArchiveBackupKeepPolicy"
    },
    "Description": {
      "en": "The period for which to retain archived backups. The number of archived backups that can \n be retained within the specified period is determined by the ArchiveBackupKeepCount parameter. \n Default value: 0. Valid values: \nByMonth \n ByWeek \n KeepAll"
    },
    "AllowedValues": [
      "ByMonth",
      "ByWeek",
      "KeepAll"
    ],
    "Label": {
      "en": "ArchiveBackupKeepPolicy",
      "zh-cn": "归档备份的保留周期"
    }
  }
  EOT
}

variable "backup_policy_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSBackupPolicyMode"
    },
    "Description": {
      "en": "Backup type, \nDataBackupPolicy: data backup \nLogBackupPolicy: log backup"
    },
    "AllowedValues": [
      "DataBackupPolicy",
      "LogBackupPolicy"
    ],
    "Label": {
      "en": "BackupPolicyMode",
      "zh-cn": "备份类型"
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
      "en": "The vSwitch id of created instance. For VPC network, the property is required."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The subscription duration. Valid values:\nWhen PeriodType is Month, it could be from 1 to 12, 24, 36, 48, 60.\n When PeriodType is Year, it could be from 1 to 5."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费时长"
    }
  }
  EOT
}

variable "local_log_retention_hours" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "LogBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of hours for which to retain log backup files on the instance. \nValid values: 0 to 168. The value 0 specifies not to retain log backup files on the instance. \nYou can retain the default value. Note You must specify this parameter when the BackupPolicyMode \nparameter is set to LogBackupPolicy."
    },
    "MinValue": 0,
    "Label": {
      "en": "LocalLogRetentionHours",
      "zh-cn": "本地日志备份保留小时数"
    },
    "MaxValue": 168
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "PayAsYouGo"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Serverless": {},
        "Subscription": {
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
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The charge type of created instance."
    },
    "AllowedValues": [
      "Serverless",
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the instance. This feature is available only for pay-as-you-go instances. Default is false."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否已开启释放保护功能"
    }
  }
  EOT
}

variable "high_space_usage_protection" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "LogBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to forcibly delete log backup files when the space usage of the \n instance exceeds 80% or the remaining space is less than 5 GB. Valid values: \n Enable and Disable. You can retain the default value. Note You must specify \n this parameter when the BackupPolicyMode parameter is set to LogBackupPolicy.",
      "zh-cn": "指定当磁盘空间不足（实例超过80％或剩余空间少于5 GB）时是否强制删除日志备份文件 。"
    },
    "AllowedValues": [
      "Enable",
      "Disable"
    ],
    "Label": {
      "zh-cn": "空间使用率保护"
    }
  }
  EOT
}

variable "rolearn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Alibaba Cloud Resource Name (ARN) provided to the service account of the instance by your Alibaba Cloud account to connect to KMS. You can copy the ARN from the RAM console.",
      "zh-cn": "角色ARN。RDS通过该角色访问KMS。"
    },
    "Label": {
      "en": "RoleARN",
      "zh-cn": "角色ARN"
    }
  }
  EOT
}

variable "master_user_password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The master password for the database instance. "
    },
    "Label": {
      "en": "MasterUserPassword",
      "zh-cn": "数据库实例的主账号密码"
    },
    "MinLength": 8,
    "MaxLength": 32
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC id of created database instance. For VPC network, the property is required."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "sslsetting" {
  type        = string
  default     = "Disabled"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSSSLSetting"
    },
    "Description": {
      "en": "Secure Sockets Layer (SSL) link setting of the instance. Valid values:\nDisabled: Disable SSL\nEnabledForPublicConnection: Public connection address will be protected by the SSL certificate. It requires AllocatePublicConnection is true.\nEnabledForInnerConnection: Private connection address will be protected by the SSL certificate.\nDefault value is Disabled."
    },
    "AllowedValues": [
      "Disabled",
      "EnabledForPublicConnection",
      "EnabledForInnerConnection"
    ],
    "Label": {
      "en": "SSLSetting",
      "zh-cn": "实例的安全套接层（SSL）链接设置"
    }
  }
  EOT
}

variable "master_username" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The master user name for the database instance. "
    },
    "Label": {
      "en": "MasterUsername",
      "zh-cn": "数据库实例的主账号名称"
    }
  }
  EOT
}

variable "connection_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSConnectionMode"
    },
    "Description": {
      "en": "Connection Mode for database instance,support 'Standard' and 'Safe' mode. Default is RDS system assigns. "
    },
    "Label": {
      "en": "ConnectionMode",
      "zh-cn": "数据库的连接模式"
    }
  }
  EOT
}

variable "local_log_retention_space" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "LogBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The maximum percentage of space that is allowed to store log backup files on the instance. \n If the space usage for log backup files exceeds this percentage, the system deletes earlier \n log backup files until the space usage falls below this percentage. Valid values:0 to 50. \n You can retain the default value. Note You must specify this parameter when the \n BackupPolicyMode parameter is set to LogBackupPolicy."
    },
    "MinValue": 0,
    "Label": {
      "en": "LocalLogRetentionSpace",
      "zh-cn": "实例上允许存储日志备份文件的最大空间百分比"
    },
    "MaxValue": 50
  }
  EOT
}

variable "storage_upper_bound" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${StorageAutoScale}",
            "Enable"
          ]
        }
      }
    },
    "Description": {
      "en": "The total storage space upper limit for automatic storage space expansion, that is, automatic expansion will not cause the total storage space of the instance to exceed this value."
    },
    "Label": {
      "zh-cn": "存储空间自动扩容的总存储空间上限值"
    }
  }
  EOT
}

variable "category" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${PayType}",
              "Serverless"
            ]
          },
          "Value": [
            "serverless_basic",
            "serverless_standard",
            "serverless_ha"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "Subscription"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "PayAsYouGo"
                    ]
                  }
                ]
              },
              {
                "Fn::Equals": [
                  "$${Engine}",
                  "MySQL"
                ]
              }
            ]
          },
          "Value": [
            "Basic",
            "HighAvailability",
            "cluster"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "Subscription"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "PayAsYouGo"
                    ]
                  }
                ]
              },
              {
                "Fn::Equals": [
                  "$${Engine}",
                  "SQLServer"
                ]
              }
            ]
          },
          "Value": [
            "Basic",
            "HighAvailability",
            "AlwaysOn"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "Subscription"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "PayAsYouGo"
                    ]
                  }
                ]
              },
              {
                "Fn::Equals": [
                  "$${Engine}",
                  "PostgreSQL"
                ]
              }
            ]
          },
          "Value": [
            "Basic",
            "HighAvailability"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "Subscription"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${PayType}",
                      "PayAsYouGo"
                    ]
                  }
                ]
              },
              {
                "Fn::Equals": [
                  "$${Engine}",
                  "MariaDB"
                ]
              }
            ]
          },
          "Value": [
            "HighAvailability"
          ]
        }
      ],
      "LocaleKey": "RDSCategory"
    },
    "Description": {
      "en": "The edition of the instance. Valid values:\nBasic: RDS Basic Edition\nHighAvailability: RDS High-availability Edition\ncluster: RDS Cluster Edition\nAlwaysOn: RDS Cluster Edition for SQL Server\nFinance: RDS Enterprise Edition\nserverless_basic: RDS Serverless Basic Edition"
    },
    "AllowedValues": [
      "Basic",
      "HighAvailability",
      "cluster",
      "AlwaysOn",
      "serverless_basic",
      "serverless_standard",
      "serverless_ha"
    ],
    "Label": {
      "en": "Category",
      "zh-cn": "实例系列"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The private ip for created instance."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "VSwitchId下的私网IP"
    }
  }
  EOT
}

variable "target_dedicated_host_id_for_slave" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the host to which the instance belongs if you create a secondary instance in a host group.",
      "zh-cn": "在专属集群内创建实例时，指定备份实例的主机ID。"
    },
    "Label": {
      "zh-cn": "备实例的主机ID"
    }
  }
  EOT
}

variable "dbinstance_net_type" {
  type        = string
  default     = "Intranet"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetType"
    },
    "Description": {
      "en": "Database instance net type, default is Intranet.Internet for public access, Intranet for private access."
    },
    "AllowedValues": [
      "Internet",
      "Intranet"
    ],
    "Label": {
      "en": "DBInstanceNetType",
      "zh-cn": "数据库实例的网络类型"
    }
  }
  EOT
}

variable "released_keep_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSReleasedKeepPolicy",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The policy used to retain archived backups if the instance is released. Default value: None. \n Valid values: \nLastest: Only the last archived backup is retained. \n All: All of the archived backups are retained."
    },
    "AllowedValues": [
      "Lastest",
      "All"
    ],
    "Label": {
      "en": "ReleasedKeepPolicy",
      "zh-cn": "实例释放后的归档备份保留策略"
    }
  }
  EOT
}

variable "dedicated_host_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the host group to which the instance belongs if you create an instance in a host group.",
      "zh-cn": "在专属集群内创建实例时，指定专属集群ID。"
    },
    "Label": {
      "zh-cn": "专属集群ID"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PayType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable auto-renewal. Valid values: true and false. Note\n:Monthly subscription: The auto-renewal cycle is one month.\nAnnual subscription: The auto-renewal cycle is one year."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
    }
  }
  EOT
}

variable "encryption_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the encryption key that is used to encrypt data on SSDs in the region. You can view the encryption key ID in the Key Management Service (KMS) console. You can also create an encryption key.",
      "zh-cn": "同地域内的云盘加密的密钥ID。您可以在密钥管理服务控制台查看密钥ID，也可以创建新的密钥。"
    },
    "Label": {
      "en": "EncryptionKey",
      "zh-cn": "同地域内的云盘加密的密钥ID"
    }
  }
  EOT
}

variable "preferred_backup_period" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      },
      "Parameter": {
        "Type": "String",
        "AllowedValues": [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The backup period. Separate multiple values with commas (,). The default value is the original value. Valid values:Monday Tuesday Wednesday Thursday Friday Saturday Sunday Note When the BackupPolicyMode parameter is set to DataBackupPolicy, this parameter is required."
    },
    "Label": {
      "en": "PreferredBackupPeriod",
      "zh-cn": "备份周期"
    }
  }
  EOT
}

variable "log_backup_local_retention_number" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "LogBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of log backup files that can be retained on the instance. \nDefault value: 60. Valid values: 6 to 100."
    },
    "MinValue": 6,
    "Label": {
      "en": "LogBackupLocalRetentionNumber",
      "zh-cn": "实例上可以保留的日志备份文件数"
    },
    "MaxValue": 100
  }
  EOT
}

variable "securityiplist" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Security ip to access the database instance, combine with comma, 0.0.0.0/0 means no limitation."
    },
    "Label": {
      "en": "SecurityIPList",
      "zh-cn": "允许访问该实例下所有数据库的IP白名单"
    }
  }
  EOT
}

variable "dbis_ignore_case" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSDBIsIgnoreCase"
    },
    "Description": {
      "en": "Specifies whether table names are case-sensitive. Valid values:\n1: Table names are not case-sensitive. This is the default value.\n0: Table names are case-sensitive."
    },
    "AllowedValues": [
      0,
      1
    ],
    "Label": {
      "en": "DBIsIgnoreCase",
      "zh-cn": "表名是否区分大小写"
    }
  }
  EOT
}

variable "maintain_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The period during which the maintenance performs. The format is HH:mmZ-HH:mmZ."
    },
    "Label": {
      "en": "MaintainTime",
      "zh-cn": "实例的可维护时间段"
    }
  }
  EOT
}

variable "dbparam_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the parameter template used by the instance."
    },
    "Label": {
      "en": "DBParamGroupId",
      "zh-cn": "参数模板ID"
    }
  }
  EOT
}

variable "bursting_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable bursting."
    },
    "Label": {
      "zh-cn": "开启Bursting"
    }
  }
  EOT
}

variable "cold_data_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable cold data storage."
    },
    "Label": {
      "zh-cn": "开启冷备"
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
      "en": "selected zone to create database instance. You cannot set the ZoneId parameter if the MultiAZ parameter is set to true."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "target_dedicated_host_id_for_log" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the host to which the instance belongs if you create a log instance in a host group.",
      "zh-cn": "在专属集群内创建实例时，指定日志实例的主机ID。"
    },
    "Label": {
      "zh-cn": "日志实例的主机ID"
    }
  }
  EOT
}

variable "allocate_public_connection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "If true, allocate public connection automate."
    },
    "Label": {
      "en": "AllocatePublicConnection",
      "zh-cn": "是否申请实例的外网连接串"
    }
  }
  EOT
}

variable "preferred_backup_time" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The time when the backup task is performed. Format: yyyy-MM-ddZ-HH:mm:ssZ.Note When the BackupPolicyMode parameter is set to DataBackupPolicy, this parameter is required."
    },
    "Label": {
      "en": "PreferredBackupTime",
      "zh-cn": "备份时间"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "The ID of the ECS security groups. \nEach RDS instance can be associated with up to three ECS security groups. \nYou must separate them with commas (,). \nTo delete an ECS Security group, leave this parameter empty. \n"
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "关联的安全组ID"
    }
  }
  EOT
}

variable "dbinstance_storage_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Not": {
              "Fn::Equals": [
                "$${PayType}",
                "Serverless"
              ]
            }
          },
          "Value": [
            "local_ssd",
            "cloud_ssd",
            "cloud_essd",
            "cloud_essd2",
            "cloud_essd3",
            "general_essd"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${PayType}",
              "Serverless"
            ]
          },
          "Value": [
            "cloud_essd"
          ]
        }
      ],
      "Value": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${PayType}",
              "Serverless"
            ]
          },
          "Value": "cloud_essd"
        }
      ]
    },
    "Description": {
      "en": "The storage type of the instance. Valid values:\nlocal_ssd: specifies to use local SSDs. This is the recommended storage type.\ncloud_ssd: specifies to use standard SSDs.\ncloud_essd: enhanced SSD of performance level (PL)1.\ncloud_essd2: enhanced SSD of PL2.\ncloud_essd3: enhanced SSD of PL3."
    },
    "AllowedValues": [
      "local_ssd",
      "cloud_ssd",
      "cloud_essd",
      "cloud_essd2",
      "cloud_essd3",
      "general_essd"
    ],
    "Label": {
      "en": "DBInstanceStorageType",
      "zh-cn": "实例存储类型"
    }
  }
  EOT
}

variable "back_up_category" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSBackUpCategory",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable the second-level backup function. This function allows a backup \nto be completed within seconds. Valid values: \nFlash: specifies to enable the second-level backup function. \n Standard: specifies to disable the second-level backup function."
    },
    "AllowedValues": [
      "Flash",
      "Standard"
    ],
    "Label": {
      "en": "BackUpCategory",
      "zh-cn": "是否开启秒级备份"
    }
  }
  EOT
}

variable "compress_type" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSCompressType",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The format used to compress backups. Valid values: \n 1: The zlib tool is used to compress backups into .tar.gz files. \n 4: The QuickLZ tool is used to compress backups into .xb.gz files. \nThis compression format is supported only when the instance runs MySQL 5.6 or 5.7. \nIt can be used to restore individual databases and tables. \n 8: The QuickLZ tool is used to compress backups into .xb.gz files. \n This compression format is supported only when the instance runs MySQL 8.0. \nIt cannot be used to restore individual databases or tables."
    },
    "AllowedValues": [
      1,
      4,
      8
    ],
    "Label": {
      "en": "CompressType",
      "zh-cn": "备份压缩方式"
    }
  }
  EOT
}

variable "log_backup_frequency" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The frequency at which to back up logs. Valid values: \nThe value LogInterval specifies to back up logs every 30 minutes. \n The default value of this parameter is the same as the data backup frequency. \nNote The value LogInterval is supported only when the instance runs SQL Server."
    },
    "Label": {
      "en": "LogBackupFrequency",
      "zh-cn": "日志备份频率"
    }
  }
  EOT
}

variable "connection_string_type" {
  type        = string
  default     = "Inner"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSConnectionStringType"
    },
    "Description": {
      "en": "The endpoint type of the instance, allow values: Inner, Public"
    },
    "AllowedValues": [
      "Inner",
      "Public"
    ],
    "Label": {
      "en": "ConnectionStringType",
      "zh-cn": "连接地址的类型"
    }
  }
  EOT
}

variable "master_user_type" {
  type        = string
  default     = "Normal"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "RDSAccountType"
    },
    "Description": {
      "en": "Privilege type of account.\n Normal: Common privilege. \n Super: High privilege. \nSysadmin: Super privileges (SA) (only supported by SQL Server)\nThe default value is Normal."
    },
    "AllowedValues": [
      "Normal",
      "Super",
      "Sysadmin"
    ],
    "Label": {
      "en": "MasterUserType",
      "zh-cn": "主账号类型"
    }
  }
  EOT
}

variable "serverless_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SwitchForce": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable mandatory elastic scaling of serverless instances. Value:\ntrue: enabled.\nfalse: not enabled (default)."
          },
          "Required": false
        },
        "MinCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The minimum value of the automatic scaling range of an instance RCU (RDS Capacity Unit). Value: 0.5-8."
          },
          "Required": true,
          "MinValue": 0.5,
          "MaxValue": 8
        },
        "AutoPause": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable intelligent pause and start of serverless instances. Value:\ntrue: enabled.\nfalse: not enabled (default)."
          },
          "Required": false
        },
        "MaxCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The maximum value of the automatic scaling range of an instance RCU (RDS Capacity Unit). Value: 0.5-8."
          },
          "Required": true,
          "MinValue": 0.5,
          "MaxValue": 8
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PayType}",
            "Serverless"
          ]
        }
      }
    },
    "Description": {
      "en": "The config of RDS serverless instance. This is required when creating serverless instance."
    },
    "Label": {
      "en": "ServerlessConfig",
      "zh-cn": "RDS Serverless实例的相关设置"
    }
  }
  EOT
}

variable "enable_backup_log" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "LogBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable the log backup function. Valid values: \nTrue: specifies to enable the log backup function. \nFalse: specifies to disable the log backup function. \nNote You must specify this parameter when the BackupPolicyMode parameter is set to LogBackupPolicy."
    },
    "Label": {
      "en": "EnableBackupLog",
      "zh-cn": "是否启用日志备份功能"
    }
  }
  EOT
}

variable "sqlcollector_status" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable or disable the SQL Explorer (SQL audit) feature. \nValid values:Enable | Disabled."
    },
    "AllowedValues": [
      "Enable",
      "Disabled"
    ],
    "Label": {
      "en": "SQLCollectorStatus",
      "zh-cn": "是否开启SQL洞察（SQL审计）"
    }
  }
  EOT
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${BackupPolicyMode}",
            "DataBackupPolicy"
          ]
        }
      }
    },
    "Description": {
      "en": "The retention period of the data backup. Value range: 7 to 730. The default value is the original value. Note When the BackupPolicyMode parameter is set to LogBackupPolicy, this parameter is required."
    },
    "Label": {
      "en": "BackupRetentionPeriod",
      "zh-cn": "备份保留天数"
    }
  }
  EOT
}

resource "alicloud_db_instance" "dbinstance" {
  resource_group_id        = var.resource_group_id
  port                     = var.port
  storage_threshold        = var.storage_threshold
  storage_auto_scale       = var.storage_auto_scale
  instance_storage         = var.dbinstance_storage
  connection_string_prefix = var.connection_string_prefix
  tags                     = var.tags
  engine                   = var.engine
  instance_name            = var.dbinstance_description
  engine_version           = var.engine_version
  instance_type            = var.dbinstance_class
  vswitch_id               = var.vswitch_id
  period                   = var.period
  instance_charge_type     = var.pay_type
  vpc_id                   = var.vpc_id
  storage_upper_bound      = var.storage_upper_bound
  category                 = var.category
  private_ip_address       = var.private_ip_address
  released_keep_policy     = var.released_keep_policy
  auto_renew               = var.auto_renew
  encryption_key           = var.encryption_key
  security_ips             = var.securityiplist
  maintain_time            = var.maintain_time
  zone_id                  = var.zone_id
  security_group_id        = var.security_group_id
  db_instance_storage_type = var.dbinstance_storage_type
}

output "inner_connection_string" {
  // Could not transform ROS Attribute InnerConnectionString to Terraform attribute.
  value       = null
  description = "DB instance connection url by Intranet."
}

output "dbinstance_id" {
  value       = alicloud_db_instance.dbinstance.id
  description = "The instance id of created database instance."
}

output "inneripaddress" {
  // Could not transform ROS Attribute InnerIPAddress to Terraform attribute.
  value       = null
  description = "IP Address for created DB instance of Intranet."
}

output "public_connection_string" {
  // Could not transform ROS Attribute PublicConnectionString to Terraform attribute.
  value       = null
  description = "DB instance connection url by Internet."
}

output "publicipaddress" {
  // Could not transform ROS Attribute PublicIPAddress to Terraform attribute.
  value       = null
  description = "IP Address for created DB instance of Internet."
}

output "public_port" {
  // Could not transform ROS Attribute PublicPort to Terraform attribute.
  value       = null
  description = "Internet port of created DB instance."
}

output "inner_port" {
  // Could not transform ROS Attribute InnerPort to Terraform attribute.
  value       = null
  description = "Intranet port of created DB instance."
}

