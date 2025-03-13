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

variable "fee_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing type for a change tracking instance. Valid values: ONLY_CONFIGURATION_FEE and CONFIGURATION_FEE_AND_DATA_FEE. \n- **ONLY_CONFIGURATION_FEE**: charges only configuration fees. \n- **CONFIGURATION_FEE_AND_DATA_FEE**: charges configuration fees and data traffic fees."
    },
    "Label": {
      "en": "FeeType",
      "zh-cn": "订阅计费类型"
    }
  }
  EOT
}

variable "compute_unit" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The specifications of the extract, transform, and load (ETL) instance. The unit is compute unit (CU). One CU is equal to 1 vCPU and 4 GB of memory. The value of this parameter must be an integer greater than or equal to 2."
    },
    "Label": {
      "en": "ComputeUnit",
      "zh-cn": "ETL的规格"
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The unit of the subscription duration. Valid values: **Year** and **Month**.\n**Note**: You must specify this parameter only if the **PayType** parameter is set to **PrePaid**."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费实例的计费方式"
    }
  }
  EOT
}

variable "destination_region" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region in which the destination instance resides.\n**Note**: You must specify one of this parameter and the **JobId** parameter."
    },
    "Label": {
      "en": "DestinationRegion",
      "zh-cn": "目标实例区域"
    }
  }
  EOT
}

variable "instance_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "xxlarge",
      "xlarge",
      "large",
      "medium",
      "small",
      "micro"
    ],
    "Description": {
      "en": "The instance class.\n- DTS supports the following instance classes for a data migration instance: **xxlarge**, **xlarge**, **large**, **medium**, and **small**.\n- DTS supports the following instance classes for a data synchronization instance: **large**, **medium**, **small**, and **micro**.\n**Note**: Although the instance specification supports modification after creation, the downgrade instance feature is currently in canary release and available only for specific users."
    },
    "Label": {
      "en": "InstanceClass",
      "zh-cn": "迁移或同步实例的规格"
    }
  }
  EOT
}

variable "source_endpoint_engine_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The database engine of the source instance. Valid values:\n- **MySQL**: ApsaraDB RDS for MySQL instance or self-managed MySQL database\n- **PolarDB**: PolarDB for MySQL cluster\n- **polardb_o**: PolarDB for Oracle cluster\n- **polardb_pg**: PolarDB for PostgreSQL cluster\n- **Redis**: ApsaraDB for Redis instance or self-managed Redis database\n- **DRDS**: PolarDB-X 1.0 or PolarDB-X 2.0 instance\n- **PostgreSQL**: self-managed PostgreSQL database\n- **odps**: MaxCompute project\n- **oracle**: self-managed Oracle database\n- **mongodb**: ApsaraDB for MongoDB instance or self-managed MongoDB database\n- **tidb**: TiDB database\n- **ADS**: AnalyticDB for MySQL V2.0 cluster\n- **ADB30**: AnalyticDB for MySQL V3.0 cluster\n- **Greenplum**: AnalyticDB for PostgreSQL instance\n- **MSSQL**: ApsaraDB RDS for SQL Server instance or self-managed SQL Server database\n- **kafka**: Message Queue for Apache Kafka instance or self-managed Kafka cluster\n- **DataHub**: DataHub project\n- **DB2**: self-managed Db2 for LUW database\n- **as400**: AS/400\n- **Tablestore**: Tablestore instance\n**Note**: The default value is **MySQL**. You must specify one of this parameter and the **JobId** parameter."
    },
    "Label": {
      "en": "SourceEndpointEngineName",
      "zh-cn": "源实例数据库引擎类型"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically renew the DTS instance when it expires. Valid values:\n- **false**: does not automatically renew the DTS instance when it expires. This is the default value.\n- **true**: automatically renews the DTS instance when it expires."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "到期是否自动续费"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Description": {
      "en": "The billing method. Valid values:\n- **PrePaid**: subscription\n- **PostPaid**: pay-as-you-go"
    },
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "destination_endpoint_engine_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The database engine of the destination instance. Valid values:\n- **MySQL**: ApsaraDB RDS for MySQL instance or self-managed MySQL database\n- **PolarDB**: PolarDB for MySQL cluster\n- **polardb_o**: PolarDB for Oracle cluster\n- **polardb_pg**: PolarDB for PostgreSQL cluster\n- **Redis**: ApsaraDB for Redis instance or self-managed Redis database\n- **DRDS**: PolarDB-X 1.0 or PolarDB-X 2.0 instance\n- **PostgreSQL**: self-managed PostgreSQL database\n- **odps**: MaxCompute project\n- **oracle**: self-managed Oracle database\n- **mongodb**: ApsaraDB for MongoDB instance or self-managed MongoDB database\n- **tidb**: TiDB database\n- **ADS**: AnalyticDB for MySQL V2.0 cluster\n- **ADB30**: AnalyticDB for MySQL V3.0 cluster\n- **Greenplum**: AnalyticDB for PostgreSQL instance\n- **MSSQL**: ApsaraDB RDS for SQL Server instance or self-managed SQL Server database\n- **kafka**: Message Queue for Apache Kafka instance or self-managed Kafka cluster\n- **DataHub**: DataHub project\n- **DB2**: self-managed Db2 for LUW database\n- **as400**: AS/400\n- **Tablestore**: Tablestore instance\n**Note**: The default value is **MySQL**. You must specify one of this parameter and the **JobId** parameter."
    },
    "Label": {
      "en": "DestinationEndpointEngineName",
      "zh-cn": "目标数据库引擎类型"
    }
  }
  EOT
}

variable "source_region" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the region in which the source instance resides.\n**Note**: You must specify one of this parameter and the **JobId** parameter."
    },
    "Label": {
      "en": "SourceRegion",
      "zh-cn": "源实例区域"
    }
  }
  EOT
}

variable "du" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of DTS units (DUs) that are assigned to a DTS task that is run on a DTS dedicated cluster. Valid values: **1** to **100**.\n**Note**: The value of this parameter must be within the range of the number of DUs available for the DTS dedicated cluster."
    },
    "MinValue": 1,
    "Label": {
      "en": "Du",
      "zh-cn": "分配指定数量的DU资源给DTS专属集群上的DTS任务"
    },
    "MaxValue": 100
  }
  EOT
}

variable "type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "MIGRATION",
      "SYNC",
      "SUBSCRIBE"
    ],
    "Description": {
      "en": "The type of the DTS instance. Valid values:\n- **MIGRATION*: data migration instance\n- **SYNC**: data synchronization instance\n- **SUBSCRIBE**: change tracking instance"
    },
    "Label": {
      "en": "Type",
      "zh-cn": "实例类型"
    }
  }
  EOT
}

variable "database_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of private custom ApsaraDB RDS instances in a PolarDB-X instance. Default value: **1**.\n**Note**: You must specify this parameter only if the **SourceEndpointEngineName** parameter is set to **drds**."
    },
    "Label": {
      "en": "DatabaseCount",
      "zh-cn": "PolarDB-X下的私有定制RDS实例的数量"
    }
  }
  EOT
}

variable "used_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The subscription duration.\n- Valid values if the **Period** parameter is set to **Month**: 1, 2, 3, 4, 5, 6, 7, 8, and 9.\n- Valid values if the **Period** parameter is set to **Year**: 1, 2, 3, and 5.\n**Note**: You must specify this parameter only if the **PayType** parameter is set to **PrePaid**. You can set the **Period** parameter to specify the unit of the subscription duration."
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
      9
    ],
    "Label": {
      "en": "UsedTime",
      "zh-cn": "预付费实例购买时长"
    }
  }
  EOT
}

variable "auto_start" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically start the task after the DTS instance is purchased. Valid values:\n- **false**: does not automatically start the task after the DTS instance is purchased. This is the default value.\n- **true**: automatically starts the task after the DTS instance is purchased."
    },
    "Label": {
      "en": "AutoStart",
      "zh-cn": "购买完成后是否自动启动任务"
    }
  }
  EOT
}

variable "job_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the task.\n**Note**: If this parameter is specified, you do not need to specify the SourceRegion, DestinationRegion, SourceEndpointEngineName, or DestinationEndpointEngineName parameter. Even if these parameters are specified, the value of the JobId parameter takes precedence."
    },
    "Label": {
      "en": "JobId",
      "zh-cn": "任务ID"
    }
  }
  EOT
}

variable "sync_architecture" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The synchronization topology. Valid values:\n- **oneway**: one-way synchronization. This is the default value.\n- **bidirectional**: two-way synchronization."
    },
    "AllowedValues": [
      "oneway",
      "bidirectional"
    ],
    "Label": {
      "en": "SyncArchitecture",
      "zh-cn": "同步拓扑"
    }
  }
  EOT
}

resource "alicloud_dts_instance" "instance" {
  resource_group_id                = var.resource_group_id
  fee_type                         = var.fee_type
  compute_unit                     = var.compute_unit
  period                           = var.period
  destination_region               = var.destination_region
  instance_class                   = var.instance_class
  source_endpoint_engine_name      = var.source_endpoint_engine_name
  auto_pay                         = var.auto_pay
  destination_endpoint_engine_name = var.destination_endpoint_engine_name
  source_region                    = var.source_region
  du                               = var.du
  type                             = var.type
  database_count                   = var.database_count
  used_time                        = var.used_time
  auto_start                       = var.auto_start
  job_id                           = var.job_id
  sync_architecture                = var.sync_architecture
}

output "instance_id" {
  value       = alicloud_dts_instance.instance.id
  description = "The ID of the DTS instance."
}

output "job_id" {
  // Could not transform ROS Attribute JobId to Terraform attribute.
  value       = null
  description = "The ID of the task."
}

