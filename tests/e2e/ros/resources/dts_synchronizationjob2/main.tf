variable "reserve" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "The reserved parameter of DTS. You can specify this parameter to add more configurations of the source or destination instance to the DTS task. For example, you can specify the data storage format of the destination Kafka database and the ID of the CEN instance. "
    },
    "Label": {
      "en": "Reserve",
      "zh-cn": "DTS的保留参数"
    }
  }
  EOT
}

variable "src_secondary_vsw_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secondary VSW ID at the source end of the VPC NAT."
    },
    "Label": {
      "en": "SrcSecondaryVswId",
      "zh-cn": "VPC NAT源端的辅VSW ID"
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
      "zh-cn": "资源组的ID"
    }
  }
  EOT
}

variable "data_synchronization" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to perform incremental data migration or incremental data synchronization. Default value: **false**. Valid values: **true** and **false**."
    },
    "Label": {
      "en": "DataSynchronization",
      "zh-cn": "是否进行增量数据迁移或增量数据同步"
    }
  }
  EOT
}

variable "delay_phone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The mobile numbers that receive latency-related alerts. Separate multiple mobile numbers with commas (,). You can specify up to 10 mobile numbers.\n**Note**: You can also configure alert rules for DTS tasks in the CloudMonitor console.This parameter is available only for users of the China site (aliyun.com). Only mobile numbers in the Chinese mainland are supported. Users of the international site (alibabacloud.com) cannot receive alerts by using mobile numbers."
    },
    "Label": {
      "en": "DelayPhone",
      "zh-cn": "延迟报警的联系人手机号码"
    }
  }
  EOT
}

variable "error_notice" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to monitor the task status. Valid values: **true** and **false**."
    },
    "Label": {
      "en": "ErrorNotice",
      "zh-cn": "是否监控异常状态"
    }
  }
  EOT
}

variable "dts_job_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the DTS instance."
    },
    "Label": {
      "en": "DtsJobName",
      "zh-cn": "同步任务名称"
    }
  }
  EOT
}

variable "delay_rule_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The threshold for latency alerts. Unit: seconds. You can set the threshold based on your business requirements. To prevent jitters caused by network and database overloads, we recommend that you set the threshold to more than 10 seconds."
    },
    "Label": {
      "en": "DelayRuleTime",
      "zh-cn": "触发延迟报警的阈值"
    }
  }
  EOT
}

variable "min_du" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The lower limit of DU. This parameter is supported only for serverless instances."
    },
    "AllowedValues": [
      1,
      2,
      4,
      8,
      16,
      32
    ],
    "Label": {
      "en": "MinDu",
      "zh-cn": "DU的下限"
    }
  }
  EOT
}

variable "db_list" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The objects that you want to migrate or synchronize."
    },
    "Label": {
      "en": "DbList",
      "zh-cn": "同步对象"
    }
  }
  EOT
}

variable "file_oss_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The URL of the Object Storage Service (OSS) bucket that stores the files related to the DTS task."
    },
    "Label": {
      "en": "FileOssUrl",
      "zh-cn": "任务文件的OSS地址"
    }
  }
  EOT
}

variable "dts_job_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the DTS task.",
      "zh-cn": "可以指定任务ID以复用已有的任务的配置。"
    },
    "Label": {
      "en": "DtsJobId",
      "zh-cn": "同步任务ID"
    }
  }
  EOT
}

variable "data_initialization" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to perform full data migration or full data synchronization. Default value: **true**. Valid values: **true** and **false**."
    },
    "Label": {
      "en": "DataInitialization",
      "zh-cn": "是否执行全量数据迁移或全量数据初始化"
    }
  }
  EOT
}

variable "error_phone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The mobile numbers that receive status-related alerts. Separate multiple mobile numbers with commas (,). You can specify up to 10 mobile numbers.\n**Note**: You can also configure alert rules for DTS tasks in the CloudMonitor console.This parameter is available only for users of the China site (aliyun.com). Only mobile numbers in the Chinese mainland are supported. Users of the international site (alibabacloud.com) cannot receive alerts by using mobile numbers."
    },
    "Label": {
      "en": "ErrorPhone",
      "zh-cn": "异常报警的联系人手机号码"
    }
  }
  EOT
}

variable "dest_secondary_vsw_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The secondary VSW ID at the destination end of the VPC NAT."
    },
    "Label": {
      "en": "DestSecondaryVswId",
      "zh-cn": "VPC NAT目标端的辅VSW ID"
    }
  }
  EOT
}

variable "max_du" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The upper limit of DU. This parameter is supported only for serverless instances."
    },
    "AllowedValues": [
      2,
      4,
      8,
      16,
      32
    ],
    "Label": {
      "en": "MaxDu",
      "zh-cn": "DU的上限"
    }
  }
  EOT
}

variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The status of the resource. Valid values:\n- **Synchronizing**: Start the task.\n- **Suspending**: Suspend the task.\n- **Stopping**: Stop the task.",
      "zh-cn": "创建完同步任务后希望它启动、停止、还是终止。"
    },
    "AllowedValues": [
      "Synchronizing",
      "Suspending",
      "Stopping"
    ],
    "Label": {
      "en": "Status",
      "zh-cn": "资源的状态"
    }
  }
  EOT
}

variable "src_primary_vsw_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The primary VSW ID at the source end of the VPC NAT."
    },
    "Label": {
      "en": "SrcPrimaryVswId",
      "zh-cn": "VPC NAT源端的主VSW ID"
    }
  }
  EOT
}

variable "dedicated_cluster_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the DTS dedicated cluster on which the task runs."
    },
    "Label": {
      "en": "DedicatedClusterId",
      "zh-cn": "DTS专属集群ID"
    }
  }
  EOT
}

variable "dest_primary_vsw_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The primary VSW ID at the destination end of the VPC NAT."
    },
    "Label": {
      "en": "DestPrimaryVswId",
      "zh-cn": "VPC NAT目的端的主VSW ID"
    }
  }
  EOT
}

variable "dts_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the DTS instance."
    },
    "Label": {
      "en": "DtsInstanceId",
      "zh-cn": "同步实例ID"
    }
  }
  EOT
}

variable "data_check_configure" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "fullCheckMaxReadRps": {
          "Type": "Number",
          "Description": {
            "en": "The maximum number of data rows that are read per second. Valid values: integers from 0 to 9007199254740991."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 9007199254740991
        },
        "dataCheckNoticePhone": {
          "Type": "String",
          "Description": {
            "en": "The mobile number of the alert contact for a full or incremental data verification task. If an alert is triggered for a verification task, a text message is sent to notify the alert contact."
          },
          "Required": false
        },
        "incrementalCheckDelayNotice": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to trigger an alert on the data latency of the incremental data verification task. Valid values: **true** and **false**.\n**Note**: For example, you set this parameter to **true**. If the cumulative latency of the incremental data verification task in several statistical periods is greater than or equal to the threshold that you specified, an alert is triggered."
          },
          "Required": false
        },
        "incrementalCheckDelayNoticeValue": {
          "Type": "Number",
          "Description": {
            "en": "The alert threshold for the data latency of the incremental data verification task. Unit: seconds.\n**Note**: This parameter is required if the **incrementalCheckDelayNotice** parameter is set to **true**."
          },
          "Required": false
        },
        "incrementalCheckDelayNoticePeriod": {
          "Type": "Number",
          "Description": {
            "en": "The statistical period of an alert on the data latency of the incremental data verification task. Valid values:\n- **1**: 1 minute\n- **2**: 5 minutes\n- **3**: 10 minutes\n- **4**: 30 minutes\n**Note**: This parameter is required if the **incrementalCheckDelayNotice** parameter is set to **true**."
          },
          "AllowedValues": [
            1,
            2,
            3,
            4
          ],
          "Required": false
        },
        "dataCheckDbList": {
          "Type": "String",
          "Description": {
            "en": "The objects whose data is to be verified. The value must be a JSON string."
          },
          "Required": false
        },
        "checkMaximumHourEnable": {
          "Type": "Number",
          "Description": {
            "en": "Specifies whether to configure a timeout period for the full data verification task.Valid values:\n- **0**: does not configure a timeout period for the full data verification task.\n- **1**: configures a timeout period for the full data verification task.\n**Note**: This parameter is required if the fullCheckModel parameter is set to 1."
          },
          "AllowedValues": [
            0,
            1
          ],
          "Required": false
        },
        "fullCheckRatio": {
          "Type": "Number",
          "Description": {
            "en": "The sampling ratio of the full data verification task. Valid values: integers from 10 to 100. Unit: percent.\n**Note**: This parameter is required if the **fullCheckModel** parameter is set to 1."
          },
          "Required": false,
          "MinValue": 10,
          "MaxValue": 100
        },
        "checkMaximumHour": {
          "Type": "Number",
          "Description": {
            "en": "The timeout period of the full data verification task. Valid values: integers from 1 to 72. Countdown begins the moment the full data verification task is started. If the task is not complete within the specified timeout period, the task is forcibly stopped."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 72
        },
        "fullCheckFixData": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to replace the inconsistent data. Valid values: **true** and **false**. Default value: false.\n**Note**: For example, you set this parameter to true. If the destination database has data that is inconsistent with the data in the source database, the data values of the destination database are replaced with those of the source database."
          },
          "Required": false
        },
        "fullCheckModel": {
          "Type": "Number",
          "Description": {
            "en": "The mode of the full data verification task. Valid values:\n- **1**: verifies the data by sampling ratio.\n- **2**: verifies the data by row."
          },
          "AllowedValues": [
            1,
            2
          ],
          "Required": false
        },
        "incrementalCheckValidFailNoticeValue": {
          "Type": "Number",
          "Description": {
            "en": "The alert threshold for inconsistent data entries detected by the incremental data verification task.\n**Note**: This parameter is required if the **incrementalCheckValidFailNotice** parameter is set to **true**."
          },
          "Required": false
        },
        "incrementalDataCheck": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to perform an incremental data verification task. Valid values: **true** and **false**."
          },
          "Required": false
        },
        "incrementalCheckValidFailNoticeTimes": {
          "Type": "Number",
          "Description": {
            "en": "The number of statistical periods of an alert on inconsistent data entries detected by the incremental data verification task.\n**Note**: This parameter is required if the **incrementalCheckValidFailNotice** parameter is set to **true**."
          },
          "Required": false
        },
        "fullCheckMaxReadBps": {
          "Type": "Number",
          "Description": {
            "en": "The maximum number of bytes that are read per second. Valid values: integers from 0 to 9007199254740991."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 9007199254740991
        },
        "fullCheckValidFailNotice": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to trigger an alert if inconsistent data is detected by the full data verification task. Valid values: **true** and **false**.\n**Note**: For example, you set this parameter to true. If the number of inconsistent data entries detected by the full data verification task is greater than or equal to the threshold that you specified, an alert is triggered."
          },
          "Required": false
        },
        "fullCheckErrorNotice": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to trigger an alert if the full data verification task fails. Valid values: **true** and **false**.\n**Note**: For example, you set this parameter to **true**. If the full data verification task fails, an alert is triggered."
          },
          "Required": false
        },
        "incrementalCheckValidFailNoticePeriod": {
          "Type": "Number",
          "Description": {
            "en": "The statistical period of an alert on inconsistent data entries detected by the incremental data verification task. Valid values:\n- **1**: 1 minute\n- **2**: 5 minutes\n- **3**: 10 minutes\n- **4**: 30 minutes\n**Note**: This parameter is required if the **incrementalCheckValidFailNotice** parameter is set to **true**."
          },
          "AllowedValues": [
            1,
            2,
            3,
            4
          ],
          "Required": false
        },
        "incrementalCheckDelayNoticeTimes": {
          "Type": "Number",
          "Description": {
            "en": "The number of statistical periods of an alert on the data latency of the incremental data verification task.\n**Note**: This parameter is required if the **incrementalCheckDelayNotice** parameter is set to **true**."
          },
          "Required": false
        },
        "fullCheckReferEndpoint": {
          "Type": "String",
          "Description": {
            "en": "The benchmark for full data verification. Valid values:\n- **all**: checks the data consistency between the source and destination databases based on the source and destination databases.\n- **src**: checks the data consistency between the source and destination databases based on the source database. Objects that exist in the destination database but do not exist in the source database are not checked.\n- **dest**: checks the data consistency between the source and destination databases based on the destination database. Objects that exist in the source database but do not exist in the destination database are not checked."
          },
          "Required": false
        },
        "fullDataCheck": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to perform a full data verification task. Valid values: **true** and **false**."
          },
          "Required": false
        },
        "incrementalCheckValidFailNotice": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to trigger an alert if inconsistent data is detected by the incremental data verification task. Valid values: **true** and **false**.\n**Note**: For example, you set this parameter to **true**. If the cumulative number of inconsistent data entries detected by the incremental data verification task in several statistical periods is greater than or equal to the threshold that you specified, an alert is triggered."
          },
          "Required": false
        },
        "fullCheckNoticeValue": {
          "Type": "Number",
          "Description": {
            "en": "The alert threshold for inconsistent data entries detected by the full data verification task.\n**Note**: This parameter is required if the **fullCheckValidFailNotice** parameter is set to **true**."
          },
          "Required": false
        },
        "incrementalCheckErrorNotice": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to trigger an alert if the incremental data verification task fails. Valid values: **true** and **false**.\nNote: For example, you set this parameter to **true**. If the incremental data verification task fails, an alert is triggered."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The data verification task for a data migration or synchronization instance."
    },
    "Label": {
      "en": "DataCheckConfigure",
      "zh-cn": "迁移或同步实例的数据校验任务"
    }
  }
  EOT
}

variable "dts_bis_label" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The environment tag of the DTS instance. Valid values: **normal** and **online**."
    },
    "Label": {
      "en": "DtsBisLabel",
      "zh-cn": "DTS实例的环境标签"
    }
  }
  EOT
}

variable "checkpoint" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The start offset of incremental data migration or synchronization. This value is a UNIX timestamp representing the number of seconds that have elapsed since January 1, 1970, 00:00:00 UTC."
    },
    "Label": {
      "en": "Checkpoint",
      "zh-cn": "增量数据迁移的启动位点或者同步位点"
    }
  }
  EOT
}

variable "disaster_recovery_job" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the instance is a disaster recovery instance. Valid values: **true** and **false**"
    },
    "Label": {
      "en": "DisasterRecoveryJob",
      "zh-cn": "是否为灾备实例"
    }
  }
  EOT
}

variable "delay_notice" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to monitor the task latency. Valid values: **true** and **false**"
    },
    "Label": {
      "en": "DelayNotice",
      "zh-cn": "是否监控延迟状态"
    }
  }
  EOT
}

variable "destination_endpoint" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Role": {
          "Type": "String",
          "Description": {
            "en": "The name of the Resource Access Management (RAM) role configured for the Alibaba Cloud account that owns the destination instance.\n**Note**: This parameter is required when you migrate or synchronize data across different Alibaba Cloud accounts."
          },
          "Required": false
        },
        "OracleSID": {
          "Type": "String",
          "Description": {
            "en": "The system ID (SID) of the Oracle database.\n**Note**: This parameter is required only when **EngineName** is set to **ORACLE** and the Oracle database is deployed in an architecture that is not a Real Application Cluster (RAC)."
          },
          "Required": false
        },
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "The database account of the destination database.\n**Note**: In most cases, this parameter is required. The permissions that are required for the database account vary with the migration or synchronization scenario."
          },
          "Required": false
        },
        "OwnerID": {
          "Type": "String",
          "Description": {
            "en": "The ID of the Alibaba Cloud account to which the destination database belongs.\n**Note**: You can specify this parameter to migrate or synchronize data across different Alibaba Cloud accounts. In this case, you must specify **Role**."
          },
          "Required": false
        },
        "InstanceID": {
          "Type": "String",
          "Description": {
            "en": "The ID of the destination instance. If the destination instance is an Alibaba Cloud database instance, you must specify the ID of the database instance. For example, \n- If the destination instance is an ApsaraDB RDS for MySQL instance, you must specify the ID of the ApsaraDB RDS for MySQL instance. \n- If the destination instance is a self-managed database, the value of this parameter varies with the value of SourceEndpointInstanceType.\n- If InstanceType is set to ECS, you must specify the ID of the ECS instance.\n- If InstanceType is set to DG, you must specify the ID of the database gateway.\n- If InstanceType is set to EXPRESS or CEN, you must specify the ID of the VPC that is connected to the destination instance.\n**Note**: If DestinationEndpointInstanceType is set to CEN, you must also specify the ID of the CEN instance in the Reserve parameter."
          },
          "Required": false
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the destination instance. \n**Note**: This parameter is required only when **InstanceType** is set to **OTHER**, **EXPRESS**, **DG**, or **CEN**."
          },
          "Required": false
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The port number of the destination instance.\n**Note**: This parameter is required only when the destination instance is a self-managed database."
          },
          "Required": false
        },
        "DatabaseName": {
          "Type": "String",
          "Description": {
            "en": "The name of the database which contains the objects to be migrated in the destination instance.\n**Note**: This parameter is required only when the destination instance is a PolarDB for PostgreSQL cluster (compatible with Oracle), a PostgreSQL database, or a MongoDB database."
          },
          "Required": false
        },
        "Region": {
          "Type": "String",
          "Description": {
            "en": "The ID of the region in which the destination instance resides.\n**Note**: If the source instance is an Alibaba Cloud database instance, this parameter is required."
          },
          "Required": false
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "The type of the destination instance. Valid values:\nAlibaba Cloud database instances\n- **RDS**: ApsaraDB RDS for MySQL instance, ApsaraDB RDS for SQL Server instance, ApsaraDB RDS for PostgreSQL instance, or ApsaraDB RDS for MariaDB TX instance\n- **PolarDB**: PolarDB for MySQL cluster\n- **DISTRIBUTED_POLARDBX10**: PolarDB-X 1.0 (formerly DRDS) instance\n- **POLARDBX20**: PolarDB-X 2.0 instance\n- **REDIS**: ApsaraDB for Redis instance\n- **ADS**: AnalyticDB for MySQL V2.0 cluster or AnalyticDB for MySQL V3.0 cluster\n- **MONGODB**: ApsaraDB for MongoDB instance\n- **GREENPLUM**: AnalyticDB for PostgreSQL instance\n- **DATAHUB**: DataHub project\n- **ELK**: Elasticsearch cluster\n- **Tablestore**: Tablestore instance\n- **ODPS**: MaxCompute project\nSelf-managed databases\n- **OTHER**: self-managed database with a public IP address\n- **ECS**: self-managed database hosted on an ECS instance\n- **EXPRESS**: self-managed database connected over Express Connect\n- **CEN**: self-managed database connected over CEN\n- **DG**: self-managed database connected over Database Gateway\n**Note**: If the destination instance is a PolarDB for PostgreSQL cluster (compatible with Oracle), you must set this parameter to OTHER or EXPRESS. Then, you can connect the PolarDB for PostgreSQL cluster (compatible with Oracle) to DTS as a self-managed database by using a public IP address or Express Connect.\nIf the destination instance is a Message Queue for Apache Kafka instance, you must set this parameter to ECS or EXPRESS. Then, you can connect the Message Queue for Apache Kafka instance to DTS as a self-managed database connected over ECS or Express Connect.\nIf the destination instance is a self-managed database, you must deploy the network environment for the database."
          },
          "Required": true
        },
        "EngineName": {
          "Type": "String",
          "Description": {
            "en": "The database engine of the destination instance. Valid values:\n- **MYSQL**: ApsaraDB RDS for MySQL instance or self-managed MySQL database\n- **MARIADB**: ApsaraDB RDS for MariaDB TX instance\n- **PolarDB**: PolarDB for MySQL cluster\n- **POLARDB_O**: PolarDB for PostgreSQL cluster (compatible with Oracle)\n- **POLARDBX10**: PolarDB-X 1.0 instance\n- **POLARDBX20**: PolarDB-X 2.0 instance\n- **ORACLE**: self-managed Oracle database\n- **POSTGRESQL**: ApsaraDB RDS for PostgreSQL instance or self-managed PostgreSQL database\n- **MSSQL**: ApsaraDB RDS for SQL Server instance or self-managed SQL Server database\n- **ADS**: AnalyticDB for MySQL V2.0 cluster\n- **ADB30**: AnalyticDB for MySQL V3.0 cluster- **MONGODB**: ApsaraDB for MongoDB instance or self-managed MongoDB database\n- **GREENPLUM**: AnalyticDB for PostgreSQL instance\n- **KAFKA**: Message Queue for Apache Kafka instance or self-managed Kafka cluster\n- **DATAHUB**: DataHub project- **DB2**: self-managed Db2 for LUW database\n- **AS400**: self-managed Db2 for i database\n- **ODPS**: MaxCompute project\n- **Tablestore**: Tablestore instance\n- **ELK**: Elasticsearch cluster\n- **REDIS**: ApsaraDB for Redis instance or self-managed Redis database\n**Note**: Default value: **MYSQL**.\nIf this parameter is set to **KAFKA**, **MONGODB**, or **PolarDB**, you must also specify the database information in the Reserve parameter."
          },
          "Required": false
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "The password of the destination database account."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Destination instance configuration."
    },
    "Label": {
      "en": "DestinationEndpoint",
      "zh-cn": "目标实例配置"
    }
  }
  EOT
}

variable "source_endpoint" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "OracleSID": {
          "Type": "String",
          "Description": {
            "en": "The system ID (SID) of the Oracle database.\n**Note**: This parameter is required only when **EngineName** is set to **ORACLE** and the Oracle database is deployed in an architecture that is not a Real Application Cluster (RAC)."
          },
          "Required": false
        },
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "The database account of the source database.\n**Note**: In most cases, this parameter is required. The permissions that are required for the database account vary with the migration or synchronization scenario."
          },
          "Required": false
        },
        "InstanceID": {
          "Type": "String",
          "Description": {
            "en": "The ID of the source instance. If the source instance is an Alibaba Cloud database instance, you must specify the ID of the database instance. For example, \n- If the source instance is an ApsaraDB RDS for MySQL instance, you must specify the ID of the ApsaraDB RDS for MySQL instance. \n- If the source instance is a self-managed database, the value of this parameter varies with the value of SourceEndpointInstanceType.\n- If InstanceType is set to ECS, you must specify the ID of the ECS instance.\n- If InstanceType is set to DG, you must specify the ID of the database gateway.\n- If InstanceType is set to EXPRESS or CEN, you must specify the ID of the VPC that is connected to the source instance.\n**Note**: If DestinationEndpointInstanceType is set to CEN, you must also specify the ID of the CEN instance in the Reserve parameter."
          },
          "Required": false
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The IP address of the source instance. \n**Note**: This parameter is required only when **InstanceType** is set to **OTHER**, **EXPRESS**, **DG**, or **CEN**."
          },
          "Required": false
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The port number of the source instance.\n**Note**: This parameter is required only when the source instance is a self-managed database."
          },
          "Required": false
        },
        "VSwitchID": {
          "Type": "String",
          "Description": {
            "en": "The ID of the vSwitch used for the data shipping link."
          },
          "Required": false
        },
        "DatabaseName": {
          "Type": "String",
          "Description": {
            "en": "The name of the database which contains the objects to be migrated in the source instance.\n**Note**: This parameter is required only when the source instance is a PolarDB for PostgreSQL cluster (compatible with Oracle), a PostgreSQL database, or a MongoDB database."
          },
          "Required": false
        },
        "EngineName": {
          "Type": "String",
          "Description": {
            "en": "The database engine of the source instance. Valid values:\n- **MYSQL**: ApsaraDB RDS for MySQL instance or self-managed MySQL database\n- **MARIADB**: ApsaraDB RDS for MariaDB TX instance\n- **PolarDB**: PolarDB for MySQL cluster\n- **POLARDB_O**: PolarDB for PostgreSQL cluster (compatible with Oracle)\n- **POLARDBX10**: PolarDB-X 1.0 instance\n- **POLARDBX20**: PolarDB-X 2.0 instance\n- **ORACLE**: self-managed Oracle database\n- **POSTGRESQL**: ApsaraDB RDS for PostgreSQL instance or self-managed PostgreSQL database\n- **MSSQL**: ApsaraDB RDS for SQL Server instance or self-managed SQL Server database\n- **MONGODB**: ApsaraDB for MongoDB instance or self-managed MongoDB database\n- **DB2**: self-managed Db2 for LUW database\n- **AS400**: self-managed Db2 for i database\n- **DMSPOLARDB**: DMS logical database\n- **HBASE**: self-managed HBase database\n- **TERADATA**: Teradata database\n- **TiDB**: TiDB database\n- **REDIS**: ApsaraDB for Redis instance or self-managed Redis database\n**Note**: Default value: **MYSQL**.\nIf EngineName is set to **MONGODB**, you must also specify the architecture type of the **MongoDB** database in the **Reserve** parameter."
          },
          "Required": false
        },
        "Role": {
          "Type": "String",
          "Description": {
            "en": "The name of the Resource Access Management (RAM) role configured for the Alibaba Cloud account that owns the source instance.\n**Note**: This parameter is required when you migrate or synchronize data across different Alibaba Cloud accounts."
          },
          "Required": false
        },
        "OwnerID": {
          "Type": "String",
          "Description": {
            "en": "The ID of the Alibaba Cloud account to which the source database belongs.\n**Note**: You can specify this parameter to migrate or synchronize data across different Alibaba Cloud accounts. In this case, you must specify **Role**."
          },
          "Required": false
        },
        "Region": {
          "Type": "String",
          "Description": {
            "en": "The ID of the region in which the source instance resides.\n**Note**: If the source instance is an Alibaba Cloud database instance, this parameter is required."
          },
          "Required": false
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "The type of the source instance. Valid values:\nAlibaba Cloud database instances:\n- **RDS**: ApsaraDB RDS for MySQL instance, ApsaraDB RDS for SQL Server instance, ApsaraDB RDS for PostgreSQL instance, or ApsaraDB RDS for MariaDB TX instance\n- **PolarDB**: PolarDB for MySQL cluster\n- **REDIS**: ApsaraDB for Redis instance\n- **DISTRIBUTED_POLARDBX10**: PolarDB-X 1.0 (formerly DRDS) instance\n- **POLARDBX20**: PolarDB-X 2.0 instance\n- **MONGODB**: ApsaraDB for MongoDB instance\n- **DISTRIBUTED_DMSLOGICDB**: Data Management (DMS) logical database\nSelf-managed databases:\n- **OTHER**: self-managed database with a public IP address\n- **ECS**: self-managed database hosted on an Elastic Compute Service (ECS) instance\n- **EXPRESS**: self-managed database connected over Express Connect\n- **CEN**: self-managed database connected over Cloud Enterprise Network (CEN)\n- **DG**: self-managed database connected over Database Gateway\n**Note**: If the source instance is a PolarDB for PostgreSQL cluster (compatible with Oracle), you must set this parameter to **OTHER** or **EXPRESS**. Then, you can connect the PolarDB for PostgreSQL cluster to DTS as a self-managed database by using a public IP address or Express Connect. If the source instance is a self-managed database, you must deploy the network environment for the database. "
          },
          "Required": true
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "The password of the source database account."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Source instance configuration."
    },
    "Label": {
      "en": "SourceEndpoint",
      "zh-cn": "源实例配置"
    }
  }
  EOT
}

variable "structure_initialization" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to perform schema migration or schema synchronization. Default value: true. Valid values: **true** and **false**."
    },
    "Label": {
      "en": "StructureInitialization",
      "zh-cn": "是否执行库表结构迁移或初始化"
    }
  }
  EOT
}

variable "synchronization_direction" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The synchronization direction. Default value: Forward. Valid values:\n- **Forward**: Data is synchronized from the source database to the destination database.\n- **Reverse**: Data is synchronized from the destination database to the source database.\n**Note**: The default value is **Forward**.\nThe value Reverse takes effect only if the topology of the data synchronization task is two-way synchronization."
    },
    "Label": {
      "en": "SynchronizationDirection",
      "zh-cn": "同步方向"
    }
  }
  EOT
}

resource "alicloud_dts_synchronization_job" "synchronization_job" {
  data_initialization      = var.data_initialization
  structure_initialization = var.structure_initialization
}

