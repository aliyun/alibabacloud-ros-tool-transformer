variable "instance_source" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The source of the database instance. Valid values:\nPUBLIC_OWN: an on-premises database built on the public network.\nRDS: an ApsaraDB for RDS (RDS) instance.\nECS_OWN: an on-premises database built on an Elastic Compute Service (ECS) instance.\nVPC_IDC: an on-premises database built in an Internet data center (IDC) in Virtual Private\nCloud (VPC)."
    },
    "Label": {
      "en": "InstanceSource",
      "zh-cn": "数据库实例来源"
    }
  }
  EOT
}

variable "database_password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The logon password of the database instance."
    },
    "Label": {
      "en": "DatabasePassword",
      "zh-cn": "数据库访问密码"
    }
  }
  EOT
}

variable "port" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The connection port of the database instance."
    },
    "Label": {
      "en": "Port",
      "zh-cn": "目标数据库的访问端口"
    }
  }
  EOT
}

variable "host" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The endpoint of the database instance."
    },
    "Label": {
      "en": "Host",
      "zh-cn": "目标数据库的主机地址"
    }
  }
  EOT
}

variable "export_timeout" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period for exporting the database instance. Unit: seconds."
    },
    "Label": {
      "en": "ExportTimeout",
      "zh-cn": "导出超时时间"
    }
  }
  EOT
}

variable "safe_rule" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The security rule of the database instance. Enter the name of the security rule for\nyour enterprise.\nNote To query a specified security rule, log on to the DMS Enterprise console and choose\nSystem Management > Security Rules. The security rule appears in the security rule\nlist.",
      "zh-cn": "实例的安全规则，传入企业内的安全规则名称。"
    },
    "Label": {
      "en": "SafeRule",
      "zh-cn": "实例的安全规则"
    }
  }
  EOT
}

variable "ddl_online" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "[Important] Specifies whether to enable the online data description language (DDL)\nservice. Currently, this service is available only for the MySQL and PolarDB databases.\n0: The service is disabled.\n1: The native online DDL service prevails.\n2: Data change without table locking provided by DMS prevails."
    },
    "Label": {
      "en": "DdlOnline",
      "zh-cn": "是否使用online服务"
    }
  }
  EOT
}

variable "env_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the environment to which the database instance belongs. Valid values:\nproduct: the production environment.\ndev: the test environment."
    },
    "Label": {
      "en": "EnvType",
      "zh-cn": "环境类型"
    }
  }
  EOT
}

variable "tid" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the tenant.\nNote To query the ID, log on to the DMS Enterprise console and choose System Management\n> Instance Management or System Management > User Management. The ID of the tenant\nappears in the Service Specification section."
    },
    "Label": {
      "en": "Tid",
      "zh-cn": "租户ID"
    }
  }
  EOT
}

variable "use_dsql" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable cross-database query for the database instance. Valid\nvalues:\n0: disabled\n1: enabled"
    },
    "AllowedValues": [
      0,
      1
    ],
    "Label": {
      "en": "UseDsql",
      "zh-cn": "是否开启跨实例查询"
    }
  }
  EOT
}

variable "sid" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The system ID (SID) of the database instance.\nNote You must specify this parameter if the InstanceType parameter is set to PostgreSQL or Oracle."
    },
    "Label": {
      "en": "Sid",
      "zh-cn": "数据库SID"
    }
  }
  EOT
}

variable "ecs_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the ECS instance to which the database instance belongs.\nNote You must specify this parameter if the InstanceSource parameter is set to ECS_OWN."
    },
    "Label": {
      "en": "EcsInstanceId",
      "zh-cn": "ECS实例ID"
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
      "en": "The ID of the VPC to which the database instance belongs.\nNote You must specify this parameter if the InstanceSource parameter is set to VPC_IDC."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "instance_alias" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The alias of the database instance. The alias helps you quickly find the required\ninstance."
    },
    "Label": {
      "en": "InstanceAlias",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "ecs_region" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The region where the database instance resides.\nNote You must specify this parameter if the InstanceSource parameter is set to ECS_OWN or VPC_IDC."
    },
    "Label": {
      "en": "EcsRegion",
      "zh-cn": "实例所在地域"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "CLASSIC",
      "VPC"
    ],
    "Description": {
      "en": "The network type of the database instance. Valid values:\nCLASSIC\nVPC"
    },
    "Label": {
      "en": "NetworkType",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "dba_uid" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The Alibaba Cloud unique ID (UID) of the database administrator (DBA) of the database\ninstance.\nNote To query the UID, log on to the DMS Enterprise console and choose System Management\n> User Management."
    },
    "Label": {
      "en": "DbaUid",
      "zh-cn": "数据库所属阿里云账号的UID"
    }
  }
  EOT
}

variable "database_user" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The logon username of the database instance."
    },
    "Label": {
      "en": "DatabaseUser",
      "zh-cn": "数据库访问账号"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the database instance. Valid values: MySQL, SQLServer, PostgreSQL, Oracle, DRDS, OceanBase, Mongo, Redis"
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "数据库类型"
    }
  }
  EOT
}

variable "data_link_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the data link for cross-database query."
    },
    "Label": {
      "en": "DataLinkName",
      "zh-cn": "跨库查询datalink名称"
    }
  }
  EOT
}

variable "query_timeout" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The timeout period for querying the database instance. Unit: seconds."
    },
    "Label": {
      "en": "QueryTimeout",
      "zh-cn": "查询超时时间"
    }
  }
  EOT
}

resource "alicloud_dms_enterprise_instance" "instance" {
  instance_source   = var.instance_source
  database_password = var.database_password
  port              = var.port
  host              = var.host
  export_timeout    = var.export_timeout
  safe_rule         = var.safe_rule
  ddl_online        = var.ddl_online
  env_type          = var.env_type
  tid               = var.tid
  use_dsql          = var.use_dsql
  sid               = var.sid
  ecs_instance_id   = var.ecs_instance_id
  vpc_id            = var.vpc_id
  instance_alias    = var.instance_alias
  ecs_region        = var.ecs_region
  network_type      = var.network_type
  dba_uid           = var.dba_uid
  database_user     = var.database_user
  instance_type     = var.instance_type
  data_link_name    = var.data_link_name
  query_timeout     = var.query_timeout
}

output "instance_id" {
  value       = alicloud_dms_enterprise_instance.instance.id
  description = "The ID of the database instance."
}

output "port" {
  value       = alicloud_dms_enterprise_instance.instance.port
  description = "The connection port of the database instance."
}

output "host" {
  value       = alicloud_dms_enterprise_instance.instance.host
  description = "The endpoint of the database instance."
}

