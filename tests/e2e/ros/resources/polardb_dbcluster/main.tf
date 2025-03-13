variable "default_time_zone" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "Set up a time zone (UTC), the value range is as follows:\nSystem:  The default time zone is the same as the time zone where the region is located. This is default value.\nOther pickable value range is from -12:00 to +13:00, for example, 00:00.\nNote: This parameter takes effect only when DBType is MySQL."
    },
    "Label": {
      "en": "DefaultTimeZone",
      "zh-cn": "集群时区（UTC）"
    }
  }
  EOT
}

variable "gdnid" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Required": {
        "Condition": {
          "Fn::Equals": [
            "$${CreationOption}",
            "CreateGdnStandby"
          ]
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${CreationOption}",
            "CreateGdnStandby"
          ]
        }
      }
    },
    "Description": {
      "en": "The ID of the Global Database Network (GDN).\nNote: This parameter is required when the CreationOption is CreateGdnStandby."
    },
    "Label": {
      "en": "GDNId",
      "zh-cn": "全球数据库网络ID"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "storage_pay_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType",
      "Value": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${CreationCategory}",
              "SENormal"
            ]
          },
          "Value": "Prepaid"
        },
        {
          "Condition": {
            "Fn::Not": {
              "Fn::Equals": [
                "$${CreationCategory}",
                "SENormal"
              ]
            }
          },
          "Value": "PostPaid"
        }
      ]
    },
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The storage pay type."
    },
    "AllowedValues": [
      "Prepaid",
      "PostPaid"
    ],
    "Label": {
      "en": "StoragePayType",
      "zh-cn": "存储计费类型"
    }
  }
  EOT
}

variable "backup_retention_policy_on_cluster_deletion" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "The backup set retention policy when deleting a cluster, the value range is as follows:\nALL: Keep all backups permanently.\nLATEST: Permanently keep the last backup (automatic backup before deletion).\nNONE: The backup set is not retained when the cluster is deleted.\nWhen creating a cluster, the default value is NONE, that is, the backup set is not retained when the cluster is deleted.\nNote: This parameter takes effect only when the value of DBType is MySQL."
    },
    "AllowedValues": [
      "ALL",
      "LATEST",
      "NONE"
    ],
    "Label": {
      "en": "BackupRetentionPolicyOnClusterDeletion",
      "zh-cn": "删除集群时备份集保留策略"
    }
  }
  EOT
}

variable "loosexengine" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Not": {
                "Fn::Equals": [
                  "$${CreationOption}",
                  "CreateGdnStandby"
                ]
              }
            },
            {
              "Fn::Equals": [
                "$${DBType}",
                "MySQL"
              ]
            },
            {
              "Fn::Equals": [
                "$${DBVersion}",
                "8.0"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Enable the X-Engine storage engine function, the value range is as follows:\nON: The cluster starts the X-Engine enginen\nOFF: The cluster shuts down the X-Engine engine\nThis parameter takes effect only when the parameter CreationOption is not equal to CreateGdnStandby, DBType is MySQL and DBVersion is 8.0. The memory specification of the node with X-Engine enabled must be greater than or equal to 16 GB."
    },
    "AllowedValues": [
      "ON",
      "OFF"
    ],
    "Label": {
      "en": "LooseXEngine",
      "zh-cn": "开启X-Engine存储引擎功能"
    }
  }
  EOT
}

variable "dbtype" {
  type        = string
  default     = "MySQL"
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Database type, value:\nMySQL\nPostgreSQL\nOracle"
    },
    "AllowedValues": [
      "MySQL",
      "Oracle",
      "PostgreSQL"
    ],
    "Label": {
      "en": "DBType",
      "zh-cn": "数据库引擎类型"
    }
  }
  EOT
}

variable "storage_auto_scale" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${StoragePayType}",
            "Prepaid"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether to enable automatic storage scale for standard version clusters. The value range is as follows:\nEnable: Enable automatic storage scale.\nDisable: Disable automatic storage scale."
    },
    "AllowedValues": [
      "Enable",
      "Disable"
    ],
    "Label": {
      "en": "StorageAutoScale",
      "zh-cn": "标准版集群是否开启存储自动扩容"
    }
  }
  EOT
}

variable "proxy_class" {
  type        = string
  default     = "polar.maxscale.g2.medium.c"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The specifications of the Standard Edition PolarProxy. Valid values:\npolar.maxscale.g2.medium.c: 2 cores\npolar.maxscale.g2.large.c: 4 cores\npolar.maxscale.g2.xlarge.c: 8 cores\npolar.maxscale.g2.2xlarge.c: 16 cores\npolar.maxscale.g2.3xlarge.c: 24 cores\npolar.maxscale.g2.4xlarge.c: 32 cores\npolar.maxscale.g2.8xlarge.c: 64 cores"
    },
    "AllowedValues": [
      "polar.maxscale.g2.medium.c",
      "polar.maxscale.g2.large.c",
      "polar.maxscale.g2.xlarge.c",
      "polar.maxscale.g2.2xlarge.c",
      "polar.maxscale.g2.3xlarge.c",
      "polar.maxscale.g2.4xlarge.c",
      "polar.maxscale.g2.8xlarge.c"
    ],
    "Label": {
      "en": "ProxyClass",
      "zh-cn": "标准版数据库代理规格"
    }
  }
  EOT
}

variable "dbversion" {
  type        = string
  default     = "8.0"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${DBType}",
              "MySQL"
            ]
          },
          "Value": [
            "5.6",
            "5.7",
            "8.0"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${DBType}",
              "PostgreSQL"
            ]
          },
          "Value": [
            "11",
            "14"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${DBType}",
              "Oracle"
            ]
          },
          "Value": [
            "11",
            "14"
          ]
        }
      ]
    },
    "Description": {
      "en": "The version of the database. Valid values:\nMySQL: 5.6, 5.7 or 8.0\nPostgreSQL: 11, 14, 15\nOracle: 11, 14"
    },
    "AllowedValues": [],
    "Label": {
      "en": "DBVersion",
      "zh-cn": "数据库版本号"
    }
  }
  EOT
}

variable "sslenabled" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Modifies the SSL status. Valid values:\nDisable: disables SSL encryption.\nEnable: enables SSL encryption.\nUpdate: updates the SSL certificate."
    },
    "AllowedValues": [
      "Disable",
      "Enable",
      "Update"
    ]
  }
  EOT
}

variable "dbminor_version" {
  type        = string
  default     = "8.0.1"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Required": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${DBType}",
                "MySQL"
              ]
            },
            {
              "Fn::Equals": [
                "$${DBVersion}",
                "8.0"
              ]
            }
          ]
        }
      },
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${DBType}",
                "MySQL"
              ]
            },
            {
              "Fn::Equals": [
                "$${DBVersion}",
                "8.0"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The minor version of the cluster. Valid values:\n8.0.2\n8.0.1\nThis parameter is valid only when the DBType parameter is set to MySQL and the DBVersion parameter is set to 8.0."
    },
    "AllowedValues": [
      "8.0.2",
      "8.0.1"
    ],
    "Label": {
      "en": "DBMinorVersion",
      "zh-cn": "数据库引擎小版本号"
    }
  }
  EOT
}

variable "dbcluster_parameters" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Parameters": {
          "Type": "String",
          "Description": {
            "en": "The JSON string that consists of parameters and values. \nThe parameter values are strings, for example, \n{\"auto_increment_increment\":\"1\",\"character_set_filesystem\":\"utf8\"}.\nYou can call the DescribeDBClusterParameters operation to \nview the parameters of the PolarDB cluster. "
          },
          "Required": false,
          "Label": {
            "en": "Parameters",
            "zh-cn": "参数及其值的JSON字符串"
          }
        },
        "EffectiveTime": {
          "Type": "String",
          "Description": {
            "en": "The time when the modified values of parameters take effect. Valid values: \n- Auto: The system automatically determines how the modified values of parameters take effect.\nIf all the modified values of parameters can take effect without a cluster restart, \nthey immediately take effect. If a cluster restart is required to make the modified values  \nof some parameters take effect, all of them take effect after a cluster restart \nis performed within the maintenance window. \n- Immediately: If all the modified values of parameters can take effect without a \ncluster restart, the modifications immediately take effect. If a cluster restart is \nrequired to make the modified values of some parameters take effect, \nthe cluster is immediately restarted for the modifications to take effect. \n- MaintainTime: The modified values of parameters take effect within the maintenance window. \nAll the modified values of parameters take effect within the maintenance window.\nDefault value: Auto."
          },
          "AllowedValues": [
            "Auto",
            "Immediately",
            "MaintainTime"
          ],
          "Required": false,
          "Label": {
            "en": "EffectiveTime",
            "zh-cn": "参数的生效时间"
          }
        }
      }
    },
    "Description": {
      "en": "Modifies the parameters of a the PolarDB cluster."
    },
    "Label": {
      "en": "DBClusterParameters",
      "zh-cn": "PolarDB集群的参数"
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
          "Required": false,
          "Label": {
            "en": "Value",
            "zh-cn": "标签值"
          }
        },
        "Key": {
          "Type": "String",
          "Required": true,
          "Label": {
            "en": "Key",
            "zh-cn": "标签键"
          }
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
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "tdestatus" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable Transparent Data Encryption (TDE). Valid values:\ntrue: enable TDE\nfalse: disable TDE (default)\nNote: The parameter takes effect only when DBType is PostgreSQL or Oracle. You cannot disable TDE after it is enabled."
    },
    "Label": {
      "en": "TDEStatus",
      "zh-cn": "是否开启透明数据加密（TDE）"
    }
  }
  EOT
}

variable "storage_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${CreationCategory}",
              "SENormal"
            ]
          },
          "Value": [
            "ESSDPL1",
            "ESSDPL2",
            "ESSDPL3",
            "ESSDAUTOPL"
          ]
        },
        {
          "Condition": {
            "Fn::Not": {
              "Fn::Equals": [
                "$${CreationCategory}",
                "SENormal"
              ]
            }
          },
          "Value": [
            "PSL5",
            "PSL4"
          ]
        }
      ],
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Equals": [
              "$${PayType}",
              "Serverless"
            ]
          }
        }
      }
    },
    "Description": {
      "en": "The storage type. Valid values for Enterprise Edition:\nPSL5\nPSL4\nValid values for Standard Edition:\nESSDPL0\nESSDPL1\nESSDPL2\nESSDPL3\nESSDAUTOPL\nThis parameter is invalid for serverless clusters."
    },
    "AllowedValues": [],
    "Label": {
      "en": "StorageType",
      "zh-cn": "存储类型"
    }
  }
  EOT
}

variable "architecture" {
  type        = string
  default     = "X86"
  description = <<EOT
  {
    "Description": {
      "en": "The architecture of CPU. Valid values:\nX86\nARM"
    },
    "AllowedValues": [
      "X86",
      "ARM"
    ],
    "Label": {
      "en": "Architecture",
      "zh-cn": "CPU 架构"
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
      "en": "The ID of the VSwitch to connect to."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "renewal_status" {
  type        = string
  default     = "Normal"
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
      "en": "The auto renewal status of the cluster Valid values:\nAutoRenewal: automatically renews the cluster.\nNormal: manually renews the cluster.\nNotRenewal: does not renew the cluster.\nDefault value: Normal.\nNote If this parameter is set to NotRenewal, the system does not send a reminder for expiration,\nbut only sends an SMS message three days before the cluster expires to remind you\nthat the cluster is not renewed."
    },
    "AllowedValues": [
      "AutoRenewal",
      "Normal",
      "NotRenewal"
    ],
    "Label": {
      "en": "RenewalStatus",
      "zh-cn": "自动续费状态"
    }
  }
  EOT
}

variable "dbcluster_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the cluster. The description must comply with the following rules:\nIt must start with a Chinese character or an English letter.\nIt can contain Chinese and English characters, digits, underscores (_), and hyphens (-).\nIt cannot start with http:// or https://.\nIt must be 2 to 256 characters in length."
    },
    "Label": {
      "en": "DBClusterDescription",
      "zh-cn": "集群描述"
    },
    "MinLength": 2,
    "MaxLength": 256
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
      "en": "The subscription period of the clusterIf PeriodUnit is month, the valid range is 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36\nIf periodUnit is year, the valid range is 1, 2, 3"
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
      12,
      24,
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费类型（即PayType为Prepaid时）实例的时长"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the cluster. Default is false."
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "PayAsYouGo"
  nullable    = false
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
      "en": "The billing method of the cluster. Valid values:\nPostpaid: pay-as-you-go\nPrepaid: subscription"
    },
    "AllowedValues": [
      "Serverless",
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

variable "provisioned_iops" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "ESSD AutoPL preconfigured read and write IOPS for cloud disk. Possible values: 0-min {50,000, 1000* capacity - baseline performance}.\nBaseline performance =min{1,800+50* capacity, 50000}."
    },
    "MinValue": 0,
    "Label": {
      "en": "ProvisionedIops",
      "zh-cn": "ESSD AutoPL 云盘预配置的读写 IOPS"
    },
    "MaxValue": 50000
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Description": {
          "en": "The ID of the security group."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The ID of the security group. \nYou can add up to three security groups to a cluster.\n"
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "安全组ID列表"
    }
  }
  EOT
}

variable "allow_shut_down" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "Whether to turn on No activity pause. The default is false."
    },
    "Label": {
      "en": "AllowShutDown",
      "zh-cn": "是否开启无活动暂停"
    }
  }
  EOT
}

variable "loose_polar_log_bin" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "Enable the Binlog function, the value range is as follows:\nON: The cluster enables the Binlog function\nOFF: The cluster disables the Binlog function\nThis parameter takes effect only when the parameter DBType is MySQL."
    },
    "Label": {
      "en": "LoosePolarLogBin",
      "zh-cn": "开启Binlog功能"
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
      "en": "The ID of the VPC to connect to."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "proxy_type" {
  type        = string
  default     = "GENERAL"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The type of PolarProxy. Default value: OFF. Valid values:\nOFF: disables PolarProxy.\nEXCLUSIVE: Dedicated Enterprise Edition\nGENERAL: Standard Enterprise Edition"
    },
    "AllowedValues": [
      "OFF",
      "EXCLUSIVE",
      "GENERAL"
    ],
    "Label": {
      "en": "ProxyType",
      "zh-cn": "数据库代理类型"
    }
  }
  EOT
}

variable "dbnode_num" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of Standard Edition nodes. Default value: 1. Valid values:\n1: only one primary node.\n2: one read-only node and one primary node.",
      "zh-cn": "1（默认）：表示只有 1 个读写节点。\n2：表示有 1 个只读节点和 1 个读写节点。"
    },
    "AllowedValues": [
      1,
      2
    ],
    "Label": {
      "en": "DBNodeNum",
      "zh-cn": "标准版节点个数"
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
      "en": "The unit of the subscription duration. Valid values:\nMonth\nYear\nDefault value: Month."
    },
    "AllowedValues": [
      "month",
      "year",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "时长单位"
    }
  }
  EOT
}

variable "storage_upper_bound" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
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
      "en": "Set the upper limit of automatic scale of standard cluster storage, unit: GB.\nThe maximum value is 32000."
    },
    "Label": {
      "en": "StorageUpperBound",
      "zh-cn": "设置标准版集群存储自动扩容上限"
    }
  }
  EOT
}

variable "clone_data_point" {
  type        = string
  default     = "LATEST"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${DBType}",
                "MySQL"
              ]
            },
            {
              "Fn::Equals": [
                "$${DBVersion}",
                "5.6"
              ]
            },
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${CreationOption}",
                    "CloneFromRDS"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${CreationOption}",
                    "CloneFromPolarDB"
                  ]
                }
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The time point of data to be cloned. Valid values:\nLATEST: clones data of the latest time point.\n<BackupID>: clones historical backup data. Specify the ID of the specific backup set.\n<Timestamp>: clones data of a historical time point. Specify the specific time in\nthe yyyy-MM-ddTHH:mm:ssZ format. The time must be in UTC.\nDefault value: LATEST.\nNote\nThis parameter takes effect only when the DBType parameter is set to MySQL, the DBVersion parameter is set to 5.6, and the CreationOption parameter is set to CloneFromRDS or CloneFromPolarDB.\nIf the CreationOption parameter is set to CloneFromRDS, the value of this parameter must be LATEST."
    },
    "Label": {
      "en": "CloneDataPoint",
      "zh-cn": "克隆数据的时间节点"
    }
  }
  EOT
}

variable "hot_standby_cluster" {
  type        = string
  default     = "OFF"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "Specifies whether to enable the hot standby storage cluster feature. Default value: ON. Valid values:\nON: enables the hot standby storage cluster feature.\nOFF: disables the hot standby storage cluster feature\nSTANDBY: enables the hot standby storage cluster feature only for Standard Edition clusters.\nThe default value for Standard Edition clusters is STANDBY."
    },
    "AllowedValues": [
      "ON",
      "OFF",
      "STANDBY"
    ],
    "Label": {
      "en": "HotStandbyCluster",
      "zh-cn": "是否开启热备集群"
    }
  }
  EOT
}

variable "source_resource_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Required": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "CloneFromPolarDB"
              ]
            },
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "CloneFromRDS"
              ]
            },
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "MigrationFromRDS"
              ]
            }
          ]
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "CloneFromPolarDB"
              ]
            },
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "CloneFromRDS"
              ]
            },
            {
              "Fn::Equals": [
                "$${CreationOption}",
                "MigrationFromRDS"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The ID of the source RDS instance or source POLARDB cluster.\nNote\nThis parameter takes effect only when the DBType parameter is set to MySQL and the DBVersion parameter is set to 5.6.\nThis parameter is required if the CreationOption parameter is not set to Normal."
    },
    "Label": {
      "en": "SourceResourceId",
      "zh-cn": "源RDS实例ID或源PolarDB集群ID"
    }
  }
  EOT
}

variable "scale_ro_num_min" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "The minimum scaling limit for the number of read-only nodes."
    },
    "MinValue": 0,
    "Label": {
      "en": "ScaleRoNumMin",
      "zh-cn": "只读节点数的最小扩容和缩容限制"
    },
    "MaxValue": 15
  }
  EOT
}

variable "cluster_network_type" {
  type        = string
  default     = "VPC"
  description = <<EOT
  {
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The network type of the cluster. Currently, only VPC is supported. Default value: VPC."
    },
    "AllowedValues": [
      "VPC"
    ],
    "Label": {
      "en": "ClusterNetworkType",
      "zh-cn": "集群网络类型"
    }
  }
  EOT
}

variable "securityiplist" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The whitelist of the Apsara PolarDB cluster."
    },
    "Label": {
      "en": "SecurityIPList",
      "zh-cn": "PolarDB集群白名单"
    }
  }
  EOT
}

variable "maintain_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The maintainable time of the cluster:\nFormat: HH: mmZ- HH: mmZ.\nExample: 16:00Z-17:00Z, which means 0 to 1 (UTC+08:00) for routine maintenance."
    },
    "Label": {
      "en": "MaintainTime",
      "zh-cn": "集群的可维护时间"
    }
  }
  EOT
}

variable "standbyaz" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${HotStandbyCluster}",
                "ON"
              ]
            },
            {
              "Fn::Equals": [
                "$${HotStandbyCluster}",
                "STANDBY"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The zone where the hot standby storage cluster is stored. This is valid for Standard Edition clusters of Multi-zone Edition.\nThis parameter takes effect only when the multi-zone data consistency feature is enabled."
    },
    "Label": {
      "en": "StandbyAZ",
      "zh-cn": "存储热备集群的可用区"
    }
  }
  EOT
}

variable "lower_case_table_names" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBType}",
            "MySQL"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether the table name is case sensitive, the value range is as follows:\n1: Not case sensitive0: case sensitive\nThe default value is 1.\nNote: This parameter takes effect only when the value of DBType is MySQL."
    },
    "AllowedValues": [
      0,
      1
    ],
    "Label": {
      "en": "LowerCaseTableNames",
      "zh-cn": "表名是否区分大小写"
    }
  }
  EOT
}

variable "auto_renew_period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${PayType}",
                "Subscription"
              ]
            },
            {
              "Fn::Equals": [
                "$${RenewalStatus}",
                "AutoRenewal"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Set the cluster auto renewal time. Valid values: 1, 2, 3, 6, 12, 24, 36. Default to 1."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36
    ],
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "实例自动续费时长"
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
      "en": "The zone ID of the cluster. You can call the DescribeRegions operation to query available zones."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "cold_storage_option" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The description of the cold storage instance. If the description is set, it means a cold storage instance is created.\nThe length is no more than 256 characters."
          },
          "Required": false,
          "Label": {
            "en": "Description",
            "zh-cn": "描述信息"
          },
          "MaxLength": 256
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to create the cold storage instance."
          },
          "Required": false,
          "Label": {
            "en": "Enable",
            "zh-cn": "开启冷数据归档功能"
          }
        }
      }
    },
    "Description": {
      "en": "The option of cold storage."
    },
    "Label": {
      "en": "ColdStorageOption",
      "zh-cn": "冷数据归档选项"
    }
  }
  EOT
}

variable "scale_ro_num_max" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "The maximum scaling limit for the number of read-only nodes."
    },
    "MinValue": 0,
    "Label": {
      "en": "ScaleRoNumMax",
      "zh-cn": "只读节点数的最大扩容和缩容限制"
    },
    "MaxValue": 15
  }
  EOT
}

variable "loosexengine_use_memory_pct" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${LooseXEngine}",
            "ON"
          ]
        }
      }
    },
    "Description": {
      "en": "Set the ratio of enabling the X-Engine storage engine, an integer ranging from 10 to 90.\nThis parameter takes effect only when the parameter LooseXEngine is ON."
    },
    "Label": {
      "en": "LooseXEngineUseMemoryPct",
      "zh-cn": "设置开启X-Engine存储引擎比例"
    }
  }
  EOT
}

variable "scale_max" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "Maximum limit of single-node scaling."
    },
    "MinValue": 1,
    "Label": {
      "en": "ScaleMax",
      "zh-cn": "单节点扩容和缩容的最大限制"
    },
    "MaxValue": 32
  }
  EOT
}

variable "creation_category" {
  type        = string
  default     = "SENormal"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AllowedValues": [
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Equals": [
                  "$${DBType}",
                  "MySQL"
                ]
              },
              {
                "Fn::Or": [
                  {
                    "Fn::Equals": [
                      "$${DBVersion}",
                      "5.6"
                    ]
                  },
                  {
                    "Fn::Equals": [
                      "$${DBVersion}",
                      "5.7"
                    ]
                  }
                ]
              }
            ]
          },
          "Value": [
            "Normal",
            "Basic"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Equals": [
                  "$${DBType}",
                  "MySQL"
                ]
              },
              {
                "Fn::Equals": [
                  "$${DBVersion}",
                  "8.0"
                ]
              },
              {
                "Fn::Not": {
                  "Fn::Equals": [
                    "$${DBMinorVersion}",
                    "8.0.1"
                  ]
                }
              }
            ]
          },
          "Value": [
            "Normal",
            "Basic",
            "ArchiveNormal",
            "NormalMultimaster"
          ]
        },
        {
          "Condition": {
            "Fn::And": [
              {
                "Fn::Equals": [
                  "$${DBType}",
                  "MySQL"
                ]
              },
              {
                "Fn::Equals": [
                  "$${DBVersion}",
                  "8.0"
                ]
              },
              {
                "Fn::Equals": [
                  "$${DBMinorVersion}",
                  "8.0.1"
                ]
              }
            ]
          },
          "Value": [
            "Normal",
            "Basic",
            "ArchiveNormal",
            "NormalMultimaster",
            "SENormal"
          ]
        }
      ]
    },
    "Description": {
      "en": "Cluster series. The value could be Normal (standard version), Basic, ArchiveNormal, NormalMultimaster and SENormal."
    },
    "AllowedValues": [
      "Normal",
      "Basic",
      "ArchiveNormal",
      "NormalMultimaster",
      "SENormal"
    ],
    "Label": {
      "en": "CreationCategory",
      "zh-cn": "集群系列"
    }
  }
  EOT
}

variable "strict_consistency" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to enable the multi-zone data consistency feature. Valid values:\nON: enables the multi-zone data consistency feature, which is valid for Standard Edition clusters of Multi-zone Edition.\nOFF: disables the multi-zone data consistency feature."
    },
    "AllowedValues": [
      "ON",
      "OFF"
    ],
    "Label": {
      "en": "StrictConsistency",
      "zh-cn": "集群是否开启了多可用区数据强一致"
    }
  }
  EOT
}

variable "dbnode_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Value": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${PayType}",
              "Serverless"
            ]
          },
          "Value": "polar.mysql.sl.small"
        }
      ]
    },
    "AssociationProperty": "ALIYUN::POLARDB::DBCluster::DBNodeClass",
    "Description": {
      "en": "The node specifications of the cluster. For more information, see Specifications and pricing."
    },
    "Label": {
      "en": "DBNodeClass",
      "zh-cn": "节点规格"
    }
  }
  EOT
}

variable "creation_option" {
  type        = string
  default     = "Normal"
  description = <<EOT
  {
    "Description": {
      "en": "The method for creating an ApsaraDB for POLARDB cluster. Valid values:\nNormal: creates an ApsaraDB for POLARDB cluster.\nCloneFromPolarDB: clones data from an existing ApsaraDB for POLARDB cluster to a new ApsaraDB for POLARDB cluster.\nCloneFromRDS: clones data from an existing ApsaraDB for RDS instance to a new ApsaraDB\nfor POLARDB cluster.\nMigrationFromRDS: migrates data from an existing ApsaraDB for RDS instance to a new ApsaraDB for POLARDB cluster. The created ApsaraDB for POLARDB cluster is in read-only mode and has binary logs enabled by default.\nCreateGdnStandby: Create a secondary cluster.\nRecoverFromRecyclebin: Recovers data from the freed PolarDB cluster to the new PolarDB cluster.\nUpgradeFromPolarDB: Upgrade migration from PolarDB.\nDefault value: Normal.\nNote:\nWhen DBType is MySQL and DBVersion is 5.6, this parameter can be specified as CloneFromRDS or MigrationFromRDS.\nWhen DBType is MySQL and DBVersion is 8.0, this parameter can be specified as CreateGdnStandby."
    },
    "AllowedValues": [
      "CloneFromPolarDB",
      "CloneFromRDS",
      "MigrationFromRDS",
      "Normal",
      "CreateGdnStandby",
      "RecoverFromRecyclebin",
      "UpgradeFromPolarDB"
    ],
    "Label": {
      "en": "CreationOption",
      "zh-cn": "创建方式"
    }
  }
  EOT
}

variable "parameter_group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the parameter template.\nYou can call the DescribeParameterGroups operation to query the details of all parameter templates of a specified region, such as the ID of a parameter template."
    },
    "Label": {
      "en": "ParameterGroupId",
      "zh-cn": "参数模板ID"
    }
  }
  EOT
}

variable "storage_space" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${StoragePayType}",
            "Prepaid"
          ]
        }
      }
    },
    "Description": {
      "en": "The storage space that uses the subscription billing method. Unit: GB.\nValid values for PolarDB for MySQL Standard Edition: 20 to 32000."
    },
    "Label": {
      "en": "StorageSpace",
      "zh-cn": "按空间计费（包年包月）的存储空间"
    }
  }
  EOT
}

variable "serverless_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "Serverless type."
    },
    "AllowedValues": [
      "AgileServerless"
    ],
    "Label": {
      "en": "ServerlessType",
      "zh-cn": "Serverless服务类型"
    }
  }
  EOT
}

variable "restart_master_node" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to restart the master node."
    },
    "Label": {
      "en": "RestartMasterNode",
      "zh-cn": "是否重启主节点"
    }
  }
  EOT
}

variable "scale_min" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
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
      "en": "Minimum limit of single-node scaling."
    },
    "MinValue": 1,
    "Label": {
      "en": "ScaleMin",
      "zh-cn": "单节点扩容和缩容的最小限制"
    },
    "MaxValue": 31
  }
  EOT
}

resource "alicloud_polardb_cluster" "dbcluster" {
  default_time_zone                           = var.default_time_zone
  resource_group_id                           = var.resource_group_id
  storage_pay_type                            = var.storage_pay_type
  backup_retention_policy_on_cluster_deletion = var.backup_retention_policy_on_cluster_deletion
  db_type                                     = var.dbtype
  proxy_class                                 = var.proxy_class
  db_version                                  = var.dbversion
  tags                                        = var.tags
  storage_type                                = var.storage_type
  vswitch_id                                  = var.vswitch_id
  renewal_status                              = var.renewal_status
  description                                 = var.dbcluster_description
  period                                      = var.period
  pay_type                                    = var.pay_type
  provisioned_iops                            = var.provisioned_iops
  security_group_ids                          = var.security_group_ids
  loose_polar_log_bin                         = var.loose_polar_log_bin
  vpc_id                                      = var.vpc_id
  proxy_type                                  = var.proxy_type
  clone_data_point                            = var.clone_data_point
  hot_standby_cluster                         = var.hot_standby_cluster
  source_resource_id                          = var.source_resource_id
  scale_ro_num_min                            = var.scale_ro_num_min
  maintain_time                               = var.maintain_time
  lower_case_table_names                      = var.lower_case_table_names
  auto_renew_period                           = var.auto_renew_period
  zone_id                                     = var.zone_id
  scale_ro_num_max                            = var.scale_ro_num_max
  scale_max                                   = var.scale_max
  creation_category                           = var.creation_category
  db_node_class                               = var.dbnode_class
  creation_option                             = var.creation_option
  parameter_group_id                          = var.parameter_group_id
  storage_space                               = var.storage_space
  serverless_type                             = var.serverless_type
  scale_min                                   = var.scale_min
}

output "dbnode_ids" {
  // Could not transform ROS Attribute DBNodeIds to Terraform attribute.
  value       = null
  description = "The ID list of cluster nodes."
}

output "primary_connection_string" {
  // Could not transform ROS Attribute PrimaryConnectionString to Terraform attribute.
  value       = null
  description = "The primary connection string of the db cluster."
}

output "dbcluster_id" {
  // Could not transform ROS Attribute DBClusterId to Terraform attribute.
  value       = null
  description = "The ID of the ApsaraDB for POLARDB cluster."
}

output "dbcluster_description" {
  // Could not transform ROS Attribute DBClusterDescription to Terraform attribute.
  value       = null
  description = "The description of the db cluster."
}

output "primary_endpoint_ids" {
  // Could not transform ROS Attribute PrimaryEndpointIds to Terraform attribute.
  value       = null
  description = "The primary endpoint IDs of the db cluster."
}

output "custom_endpoint_ids" {
  // Could not transform ROS Attribute CustomEndpointIds to Terraform attribute.
  value       = null
  description = "The custom endpoint IDs of the db cluster."
}

output "primary_endpoint_id" {
  // Could not transform ROS Attribute PrimaryEndpointId to Terraform attribute.
  value       = null
  description = "The primary endpoint ID of the db cluster."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The Order ID."
}

output "cold_storage_instance_id" {
  // Could not transform ROS Attribute ColdStorageInstanceId to Terraform attribute.
  value       = null
  description = "The ID of the cold storage instance."
}

output "cluster_connection_string" {
  // Could not transform ROS Attribute ClusterConnectionString to Terraform attribute.
  value       = null
  description = "The cluster connection string of the db cluster."
}

output "cluster_endpoint_id" {
  // Could not transform ROS Attribute ClusterEndpointId to Terraform attribute.
  value       = null
  description = "The cluster endpoint ID of the db cluster."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "primary_connection_strings" {
  // Could not transform ROS Attribute PrimaryConnectionStrings to Terraform attribute.
  value       = null
  description = "The primary connection strings of the db cluster."
}

output "custom_connection_strings" {
  // Could not transform ROS Attribute CustomConnectionStrings to Terraform attribute.
  value       = null
  description = "The custom connection strings of the db cluster."
}

