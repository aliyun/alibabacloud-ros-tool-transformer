variable "migration_object" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "TableIncludes": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "AssociationPropertyMetadata": {
                    "Parameters": {
                      "TableName": {
                        "Type": "String",
                        "Description": {
                          "en": "Table name to be migrated"
                        },
                        "Required": false
                      },
                      "FilterCondition": {
                        "Type": "String",
                        "Description": {
                          "en": "Where condition"
                        },
                        "Required": false
                      },
                      "ColumnExcludes": {
                        "AssociationPropertyMetadata": {
                          "Parameters": {
                            "ColumnName": {
                              "Type": "String",
                              "Description": {
                                "en": "Column names are not migrated in the table to be migrated"
                              },
                              "Required": false
                            }
                          }
                        },
                        "AssociationProperty": "List[Parameters]",
                        "Type": "Json",
                        "Description": {
                          "en": "Column excludes configuration"
                        },
                        "Required": false
                      },
                      "ColumnIncludes": {
                        "AssociationPropertyMetadata": {
                          "Parameters": {
                            "NewColumnName": {
                              "Type": "String",
                              "Description": {
                                "en": "The name of the column to be migrated to be mapped in the target instance"
                              },
                              "Required": false
                            },
                            "ColumnName": {
                              "Type": "String",
                              "Description": {
                                "en": "The column name to be migrated in the table to be migrated"
                              },
                              "Required": false
                            }
                          }
                        },
                        "AssociationProperty": "List[Parameters]",
                        "Type": "Json",
                        "Description": {
                          "en": "Column includes configuration"
                        },
                        "Required": false
                      },
                      "NewTableName": {
                        "Type": "String",
                        "Description": {
                          "en": "The name of the table to be migrated in the target instance mapping"
                        },
                        "Required": false
                      }
                    }
                  },
                  "Type": "Json",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "Table configuration"
              },
              "Required": false,
              "Label": {
                "en": "TableIncludes",
                "zh-cn": "待迁移库中需要迁移的表"
              }
            },
            "DBName": {
              "Type": "String",
              "Description": {
                "en": "db name to be migrated"
              },
              "Required": false,
              "Label": {
                "en": "DBName",
                "zh-cn": "待迁移库名称"
              }
            },
            "TableExcludes": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "TableName": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the table to be migrated does not require the table name of the migration table."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Table excludes configuration"
              },
              "Required": false,
              "Label": {
                "en": "TableExcludes",
                "zh-cn": "待迁移库中不需要迁移的表"
              }
            },
            "SchemaName": {
              "Type": "String",
              "Description": {
                "en": "Schema name to be migrated"
              },
              "Required": false,
              "Label": {
                "en": "SchemaName",
                "zh-cn": "待迁移Schema名称"
              }
            },
            "NewSchemaName": {
              "Type": "String",
              "Description": {
                "en": "Schema name to be migrated by Schema in the target instance"
              },
              "Required": false,
              "Label": {
                "en": "NewSchemaName",
                "zh-cn": "待迁移Schema在目标实例中映射的Schema名称"
              }
            },
            "NewDBName": {
              "Type": "String",
              "Description": {
                "en": "The name of the db to be migrated in the target instance."
              },
              "Required": false,
              "Label": {
                "en": "NewDBName",
                "zh-cn": "待迁移数据库在目标实例中映射的库名称"
              }
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Objects that need to be migrated"
    },
    "Label": {
      "en": "MigrationObject",
      "zh-cn": "需要迁移的对象"
    }
  }
  EOT
}

variable "destination_endpoint" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Role": {
          "Type": "String",
          "Description": {
            "en": "When the source instance is an RDS instance and the source instance is different from the Alibaba Cloud account to which the target instance belongs, this parameter is the authorization role of the Alibaba Cloud account to which the source instance belongs to the target instance Alibaba Cloud account. For details on the permissions and authorization methods required for this role, see Cross-Account Migration Synchronization.",
            "zh-cn": "当源实例为RDS实例且与目标实例所属的阿里云账号不同时，该参数为目标实例所属云账号中已授权的角色名称。"
          },
          "Required": false,
          "Label": {
            "en": "Role",
            "zh-cn": "当源实例为RDS实例且与目标实例所属的阿里云账号不同时"
          }
        },
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "Target instance access account"
          },
          "Required": true,
          "Label": {
            "en": "UserName",
            "zh-cn": "目标实例的访问账号"
          }
        },
        "InstanceID": {
          "Type": "String",
          "Description": {
            "en": "Target instance ID\nWhen the DestinationEndpoint.InstanceType value is RDS, this parameter needs to be passed to the RDS instance ID.\nWhen the DestinationEndpoint.InstanceType value is ECS, this parameter needs to be passed to the ECS instance ID.\nWhen the DestinationEndpoint.InstanceType value is MongoDB, this parameter needs to be passed to the MongoDB instance ID.\nWhen the DestinationEndpoint.InstanceType value is Redis, this parameter needs to be passed in the Redis instance ID.\nWhen the DestinationEndpoint.InstanceType value is DRDS, this parameter needs to be passed to the DRDS instance ID.\nWhen the DestinationEndpoint.InstanceType value is PetaData, this parameter needs to pass in the PetaData instance ID.\nWhen the DestinationEndpoint.InstanceType value is OceanBase, this parameter needs to be passed to the OceanBase instance ID.\nWhen the DestinationEndpoint.InstanceType value is POLARDB, this parameter needs to be passed to the POLARDB for MySQL cluster ID."
          },
          "Required": false,
          "Label": {
            "en": "InstanceID",
            "zh-cn": "目标实例ID"
          }
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The connection address of the target instance. Required when the source instance is a self-built database."
          },
          "Required": false,
          "Label": {
            "en": "IP",
            "zh-cn": "目标实例连接地址"
          }
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The listening port of the target instance, which is required when the source instance is a self-built database."
          },
          "Required": false,
          "Label": {
            "en": "Port",
            "zh-cn": "目标实例监听端口"
          }
        },
        "DatabaseName": {
          "Type": "String",
          "Description": {
            "en": "The connection database library name of the target instance, which is required if the target instance's database type is: PostgreSQL, PPAS, or MongoDB"
          },
          "Required": false,
          "Label": {
            "en": "DatabaseName",
            "zh-cn": "目标实例的连接数据库名"
          }
        },
        "Region": {
          "Type": "String",
          "Description": {
            "en": "The area where the target instance is located. If it is a self-built database, you can select the area closest to the physical distance of the self-built IDC."
          },
          "Required": true,
          "Label": {
            "en": "Region",
            "zh-cn": "目标实例所在地域ID"
          }
        },
        "InstanceType": {
          "Type": "String",
          "AllowedValues": [
            "RDS",
            "ECS",
            "LocalInstance",
            "MongoDB",
            "Redis",
            "DRDS",
            "PetaData",
            "OceanBase",
            "POLARDB"
          ],
          "Description": {
            "en": "The instance type of the target instance, including:\nRDS: Alibaba Cloud RDS instance\nECS: Self-built database on ECS\nLocalInstance: Self-built database of local IDC\nMongoDB: Alibaba Cloud MongoDB instance\nRedis: Alibaba Cloud Redis instance\nDRDS: Alibaba Cloud DRDS instance\nPetaData: Alibaba Cloud PetaData instance\nOceanBase: Alibaba Cloud OceanBase instance\nPOLARDB: Alibaba Cloud POLARDB for MySQL Cluster"
          },
          "Required": true,
          "Label": {
            "en": "InstanceType",
            "zh-cn": "目标实例的实例类型"
          }
        },
        "EngineName": {
          "Type": "String",
          "Description": {
            "en": "The data type of the target instance. It is required when the target instance is a self-built database. The values include:\nMySQL, SQLServer, PostgreSQL, PPAS, MongoDB, Redis"
          },
          "AllowedValues": [
            "MySQL",
            "SQLServer",
            "PostgreSQL",
            "PPAS",
            "MongoDB",
            "Redis"
          ],
          "Required": false,
          "Label": {
            "en": "EngineName",
            "zh-cn": "目标库的数据库类型"
          }
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "Target instance password"
          },
          "Required": true,
          "Label": {
            "en": "Password",
            "zh-cn": "目标实例的访问密码"
          }
        }
      }
    },
    "Description": {
      "en": "Migration target configuration"
    },
    "Label": {
      "en": "DestinationEndpoint",
      "zh-cn": "目标实例"
    }
  }
  EOT
}

variable "migration_job_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Migrating instance specifications, which can be:\nsmall, medium, large and so on.\nVarious specifications of the reference data migration test performance specifications"
    },
    "Label": {
      "en": "MigrationJobClass",
      "zh-cn": "迁移实例规格"
    }
  }
  EOT
}

variable "source_endpoint" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Role": {
          "Type": "String",
          "Description": {
            "en": "When the source instance is an RDS instance and the source instance is different from the Alibaba Cloud account to which the target instance belongs, this parameter is the authorization role of the Alibaba Cloud account to which the source instance belongs to the target instance Alibaba Cloud account. For details on the permissions and authorization methods required for this role, see Cross-Account Migration Synchronization.",
            "zh-cn": "当源实例为RDS实例且与目标实例所属的阿里云账号不同时，该参数为源实例所属云账号中已授权的角色名称。"
          },
          "Required": false,
          "Label": {
            "en": "Role",
            "zh-cn": "当源实例为RDS实例且与目标实例所属的阿里云账号不同时"
          }
        },
        "OracleSID": {
          "Type": "String",
          "Description": {
            "en": "When the source instance database type is Oracle, this parameter is Oracle SID",
            "zh-cn": "当源实例数据库类型为Oracle时，该参数为Oracle SID。"
          },
          "Required": false,
          "Label": {
            "en": "OracleSID",
            "zh-cn": "当源实例数据库类型为Oracle时"
          }
        },
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "Source instance access account"
          },
          "Required": true,
          "Label": {
            "en": "UserName",
            "zh-cn": "源实例的访问账号"
          }
        },
        "OwnerID": {
          "Type": "String",
          "Description": {
            "en": "When the source instance is an RDS instance and the source instance is different from the Alibaba Cloud account to which the target instance belongs, this parameter is the UID of the Alibaba Cloud account to which the source RDS instance belongs.",
            "zh-cn": "当源实例为RDS实例且与目标实例所属阿里云账号不同时，该参数为源实例所属阿里云账号的UID。"
          },
          "Required": false,
          "Label": {
            "en": "OwnerID",
            "zh-cn": "当源实例为RDS实例且与目标实例所属阿里云账号不同时"
          }
        },
        "InstanceID": {
          "Type": "String",
          "Description": {
            "en": "Source instance ID.\nWhen the value of SourceEndpoint.InstanceType is RDS, this parameter needs to be passed in the RDS instance ID.\nWhen the SourceEndpoint.InstanceType value is ECS, this parameter needs to be passed to the ECS instance ID.\nWhen the SourceEndpoint.InstanceType value is Express, this parameter needs to be passed in the VPC ID (ie, the proprietary network ID).\nWhen the SourceEndpoint.InstanceType value is MongoDB, this parameter needs to be passed to the MongoDB instance ID.\nWhen the SourceEndpoint.InstanceType value is POLARDB, this parameter needs to be passed to POLARDB for MySQL cluster ID."
          },
          "Required": false,
          "Label": {
            "en": "InstanceID",
            "zh-cn": "源实例ID"
          }
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The connection address of the source instance. Required when the source instance is a self-built database."
          },
          "Required": false,
          "Label": {
            "en": "IP",
            "zh-cn": "源实例连接地址"
          }
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "The listening port of the source instance, which is required when the source instance is a self-built database."
          },
          "Required": false,
          "Label": {
            "en": "Port",
            "zh-cn": "源实例的监听端口"
          }
        },
        "DatabaseName": {
          "Type": "String",
          "Description": {
            "en": "When the source instance database type is PostgreSQL or MongoDB, this parameter is the database library name used when creating the connection."
          },
          "Required": false,
          "Label": {
            "en": "DatabaseName",
            "zh-cn": "数据库名称"
          }
        },
        "Region": {
          "Type": "String",
          "Description": {
            "en": "The area where the source instance is located. If it is a self-built database, you can select the area closest to the physical distance of the self-built IDC."
          },
          "Required": true,
          "Label": {
            "en": "Region",
            "zh-cn": "源实例所在地域"
          }
        },
        "InstanceType": {
          "Type": "String",
          "AllowedValues": [
            "RDS",
            "ECS",
            "LocalInstance",
            "Express",
            "MongoDB",
            "POLARDB"
          ],
          "Description": {
            "en": "The instance type of the migration source instance, including:\nRDS: Alibaba Cloud RDS instance\nECS: Self-built database on ECS\nLocalInstance: Self-built database with public IP address\nExpress: self-built database accessed via dedicated line\nMongoDB: Ali cloud MongoDB instance\nPOLARDB: Alibaba Cloud POLARDB for MySQL Cluster\n"
          },
          "Required": true,
          "Label": {
            "en": "InstanceType",
            "zh-cn": "迁移源实例的实例类型"
          }
        },
        "EngineName": {
          "Type": "String",
          "Description": {
            "en": "The database type of the source instance, which is required when SourceEndpoint.InstanceType is not RDS. Values include:\nMySQL, SQLServer, PostgreSQL, Oracle, MongoDB, Redis"
          },
          "AllowedValues": [
            "MySQL",
            "SQLServer",
            "PostgreSQL",
            "Oracle",
            "MongoDB",
            "Redis"
          ],
          "Required": false,
          "Label": {
            "en": "EngineName",
            "zh-cn": "源实例的数据库类型"
          }
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "Source instance password"
          },
          "Required": true,
          "Label": {
            "en": "Password",
            "zh-cn": "源实例的访问密码"
          }
        }
      }
    },
    "Description": {
      "en": "Migration source configuration"
    },
    "Label": {
      "en": "SourceEndpoint",
      "zh-cn": "源实例"
    }
  }
  EOT
}

variable "migration_job_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Migrating job name"
    },
    "Label": {
      "en": "MigrationJobName",
      "zh-cn": "迁移任务名称"
    }
  }
  EOT
}

variable "migration_mode" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "StructureIntialization": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether the migration task performs structural migration, and the values include:\ntrue: indicates that a structure migration is required.\nfalse: indicates no structural migration"
          },
          "Required": false,
          "Label": {
            "en": "StructureIntialization",
            "zh-cn": "迁移任务是否进行结构迁移"
          },
          "Default": true
        },
        "DataSynchronization": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether the migration task synchronizes incremental data, including:\ntrue: Indicates that incremental data synchronization is required.\nfalse: Indicates that incremental data synchronization is not performed."
          },
          "Required": false,
          "Label": {
            "en": "DataSynchronization",
            "zh-cn": "迁移任务是否进行增量数据同步"
          },
          "Default": false
        },
        "DataIntialization": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether the migration task performs full data migration, and the values include:\ntrue: indicates that full data migration is required.\nfalse: indicates no structural migration"
          },
          "Required": false,
          "Label": {
            "en": "DataIntialization",
            "zh-cn": "迁移任务是否进行全量数据迁移"
          },
          "Default": true
        }
      }
    },
    "Description": {
      "en": "Migration mode"
    },
    "Label": {
      "en": "MigrationMode",
      "zh-cn": "迁移任务模式"
    }
  }
  EOT
}

resource "alicloud_dts_migration_job" "migration_job" {
  instance_class = var.migration_job_class
  dts_job_name   = var.migration_job_name
}

output "migration_job_id" {
  value       = alicloud_dts_migration_job.migration_job.id
  description = "Migration tasks task ID"
}

