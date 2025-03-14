variable "synchronization_objects" {
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
                          "en": "Table name to be synchronized"
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
                                "en": "Column names are not synchronized in the table to be synchronized"
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
                                "en": "The name of the column to be synchronized to be mapped in the target instance"
                              },
                              "Required": false
                            },
                            "ColumnName": {
                              "Type": "String",
                              "Description": {
                                "en": "The column name to be synchronized in the table to be synchronized"
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
                          "en": "The name of the table to be synchronized in the target instance mapping"
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
                "zh-cn": "待同步表"
              }
            },
            "DBName": {
              "Type": "String",
              "Description": {
                "en": "db name to be synchronized"
              },
              "Required": false,
              "Label": {
                "en": "DBName",
                "zh-cn": "待同步数据库名"
              }
            },
            "TableExcludes": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "TableName": {
                    "Type": "String",
                    "Description": {
                      "en": "The name of the table to be synchronized does not require the table name of the synchronization table."
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
                "zh-cn": "待同步数据库不需要同步的表名"
              }
            },
            "SchemaName": {
              "Type": "String",
              "Description": {
                "en": "Schema name to be synchronized"
              },
              "Required": false,
              "Label": {
                "en": "SchemaName",
                "zh-cn": "待同步Schema名"
              }
            },
            "NewSchemaName": {
              "Type": "String",
              "Description": {
                "en": "Schema name to be synchronized by Schema in the target instance"
              },
              "Required": false,
              "Label": {
                "en": "NewSchemaName",
                "zh-cn": "待同步Schema在目标实例中映射的Schema名"
              }
            },
            "NewDBName": {
              "Type": "String",
              "Description": {
                "en": "The name of the db to be synchronized in the target instance."
              },
              "Required": false,
              "Label": {
                "en": "NewDBName",
                "zh-cn": "待同步数据库在目标实例中映射的库名"
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
      "en": "Objects that need to be synchronized"
    },
    "Label": {
      "en": "SynchronizationObjects",
      "zh-cn": "同步对象"
    }
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If prepaid payment type, then the parameters specified in the purchase package instance or instances as examples of a monthly subscription, which can be:\nYear: Annual, Month: monthly"
    },
    "AllowedValues": [
      "Year",
      "Month"
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费周期"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Payment type, which include:\nPostpaid: postpaid type, Prepaid: Prepaid type. Default is Postpaid"
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

variable "topology" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Synchronous topology, the value includes: oneway, bidirectional.the default value is: oneway, only MySQL-> MySQL synchronization, this parameter can receive the value bidirectional"
    },
    "Label": {
      "en": "Topology",
      "zh-cn": "同步拓扑"
    }
  }
  EOT
}

variable "source_region" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Region where the synchronization source instance is located."
    },
    "Label": {
      "en": "SourceRegion",
      "zh-cn": "源实例所在的地域"
    }
  }
  EOT
}

variable "data_initialization" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to perform full data initialization before synchronization. The values include:true: means full data initialization\nfalse: no full data initialization\nThe default value is: true"
    },
    "Label": {
      "en": "DataInitialization",
      "zh-cn": "同步之前是否进行全量数据初始化"
    }
  }
  EOT
}

variable "destination_endpoint" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "Target instance access account"
          },
          "Required": false,
          "Label": {
            "en": "UserName",
            "zh-cn": "目标实例的访问账号"
          }
        },
        "InstanceId": {
          "Type": "String",
          "Description": {
            "en": "Target instance ID."
          },
          "Required": false,
          "Label": {
            "en": "InstanceId",
            "zh-cn": "目标实例的ID"
          }
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The connection address of the target instance. Required if the target instance is a local DB accessed through a dedicated line."
          },
          "Required": false,
          "Label": {
            "en": "IP",
            "zh-cn": "目标实例IP地址"
          }
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "Listening port of the target instance. Required when the target instance is ECS or a local DB accessed through a dedicated line."
          },
          "Required": false,
          "Label": {
            "en": "Port",
            "zh-cn": "目标实例监听端口"
          }
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the synchronization target instance for configuration, including:\nRedis: Alibaba Cloud Redis instance\nRDS: Alibaba Cloud RDS instance\nPOLARDB: Alibaba Cloud POLARDB for MySQL Cluster\nECS: Self-built database on ECS\nExpress: self-built database accessed via dedicated line\nMaxCompute: Alibaba Cloud MaxCompute instance\nDataHub: Alibaba Cloud DataHub instance\nAnalyticDB: Alibaba Cloud Analytic Database MySQL Version (2.0)\nAnalyticDB30: Alibaba Cloud Analytic Database MySQL Version (3.0)\nGreenplum: Cloud-native data warehouse ADB PostgreSQL version (formerly analytical database PostgreSQL version).\nThe default value is RDS"
          },
          "Required": true,
          "Label": {
            "en": "InstanceType",
            "zh-cn": "目标实例的类型"
          }
        },
        "InstanceTypeForCreation": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the synchronization target instance for creation, including:\nMySQL: Alibaba Cloud MySQL instance\nPolarDB: Alibaba Cloud POLARDB for MySQL Cluster\nMaxCompute: Alibaba Cloud MaxCompute instance.\nIf this property is not specified, it will be same with InstanceType"
          },
          "Required": false,
          "Label": {
            "en": "InstanceTypeForCreation",
            "zh-cn": "同步链路的目标实例类型"
          }
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "Target instance password"
          },
          "Required": false,
          "Label": {
            "en": "Password",
            "zh-cn": "目标实例的访问密码"
          }
        }
      }
    },
    "Description": {
      "en": "Synchronization target configuration"
    },
    "Label": {
      "en": "DestinationEndpoint",
      "zh-cn": "目标实例配置"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "When synchronization geographies, the type of data transmission network used. Value include: Internet, Intranet. The default value is: Internet",
      "zh-cn": "当进行跨地域同步时，使用的数据传输网络类型。"
    },
    "AllowedValues": [
      "Internet",
      "Intranet"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "当进行跨地域同步时"
    }
  }
  EOT
}

variable "source_endpoint" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Role": {
          "Type": "String",
          "Description": {
            "en": "When the synchronization source instance and the target instance do not belong to the same Alibaba Cloud account, this parameter is the authorized role of the account to which the source instance belongs to the Alibaba Cloud account to which the target instance belongs, and the relevant permissions and authorization steps of the reference.",
            "zh-cn": "当源实例与目标实例不属于同一个阿里云账号时，此参数为源实例所属账号对目标实例所属账号的授权角色。角色的相关权限及授权步骤，请参见跨阿里云账号任务如何配置RAM授权。"
          },
          "Required": false,
          "Label": {
            "en": "Role",
            "zh-cn": "当源实例与目标实例不属于同一个阿里云账号时"
          }
        },
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "Source instance access account"
          },
          "Required": false,
          "Label": {
            "en": "UserName",
            "zh-cn": "源实例的访问账号"
          }
        },
        "OwnerID": {
          "Type": "String",
          "Description": {
            "en": "When the source instance and the target instance do not belong to the same Alibaba Cloud account, this parameter is the UID of the Alibaba Cloud account to which the source instance belongs.",
            "zh-cn": "当源实例与目标实例不属于同一个阿里云账号时，此参数为源实例所属阿里云账号的UID。"
          },
          "Required": false,
          "Label": {
            "en": "OwnerID",
            "zh-cn": "当源实例与目标实例不属于同一个阿里云账号时"
          }
        },
        "InstanceId": {
          "Type": "String",
          "Description": {
            "en": "Source instance ID."
          },
          "Required": false,
          "Label": {
            "en": "InstanceId",
            "zh-cn": "源实例的ID"
          }
        },
        "IP": {
          "Type": "String",
          "Description": {
            "en": "The connection address of the source instance. Required if the source instance is a local DB accessed through a dedicated line."
          },
          "Required": false,
          "Label": {
            "en": "IP",
            "zh-cn": "源实例的IP地址"
          }
        },
        "Port": {
          "Type": "String",
          "Description": {
            "en": "Listening port of the source instance. Required when the source instance is ECS or a local DB accessed through a dedicated line."
          },
          "Required": false,
          "Label": {
            "en": "Port",
            "zh-cn": "源实例的监听端口"
          }
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the synchronization source instance for configuration, including:\nRedis: Alibaba Cloud Redis instance\nRDS: Alibaba Cloud RDS instance\nPOLARDB: Alibaba Cloud POLARDB for MySQL Cluster\nECS: Self-built database on ECS\nExpress: Self-built database accessed via dedicated line\ndg: Self-built database accessed via the database gateway DG\ncen: Self-built database accessed via the cloud enterprise network CEN.\nThe default value is RDS."
          },
          "Required": true,
          "Label": {
            "en": "InstanceType",
            "zh-cn": "源实例的类型"
          }
        },
        "InstanceTypeForCreation": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the synchronization source instance for creation, including:\nMySQL: Alibaba Cloud MySQL instance\nPolarDB: Alibaba Cloud POLARDB for MySQL Cluster\nRedis: Alibaba Cloud Redis instance.\nIf this property is not specified, it will be same with InstanceType."
          },
          "Required": false,
          "Label": {
            "en": "InstanceTypeForCreation",
            "zh-cn": "同步链路的源实例类型"
          }
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "Source instance password"
          },
          "Required": false,
          "Label": {
            "en": "Password",
            "zh-cn": "源实例的访问密码"
          }
        }
      }
    },
    "Description": {
      "en": "Synchronization source configuration"
    },
    "Label": {
      "en": "SourceEndpoint",
      "zh-cn": "源实例配置"
    }
  }
  EOT
}

variable "used_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "f the payment type is prepaid, then this parameter is the length of the purchase, and parameters such as 1, 2, 3 can be passed in as needed"
    },
    "Label": {
      "en": "UsedTime",
      "zh-cn": "预付费类型实例订购时长"
    }
  }
  EOT
}

variable "structure_initialization" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to initialize the structure object before synchronization. The values include:true: indicates that the structure object is initialized\nfalse: no result object initialization\nThe default value is: true"
    },
    "Label": {
      "en": "StructureInitialization",
      "zh-cn": "同步之前是否进行结构对象初始化"
    }
  }
  EOT
}

variable "synchronization_job_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Synchronous instance specifications, which can be:\nmicro, small, medium, large and so on. The default value is: small"
    },
    "Label": {
      "en": "SynchronizationJobClass",
      "zh-cn": "同步实例规格"
    }
  }
  EOT
}

variable "dest_region" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Region where the synchronization target instance is located."
    },
    "Label": {
      "en": "DestRegion",
      "zh-cn": "目标实例所在的地域"
    }
  }
  EOT
}

resource "alicloud_dts_synchronization_job" "synchronization_job" {
  data_initialization      = var.data_initialization
  structure_initialization = var.structure_initialization
  instance_class           = var.synchronization_job_class
}

output "synchronization_job_id" {
  value       = alicloud_dts_synchronization_job.synchronization_job.id
  description = "Synchronization instance ID"
}

