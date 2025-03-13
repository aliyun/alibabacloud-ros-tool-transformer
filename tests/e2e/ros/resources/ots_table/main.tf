variable "instance_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the OTS instance in which table will locate."
    },
    "AllowedPattern": "[a-zA-Z][-a-zA-Z0-9]{1,14}[a-zA-Z0-9]",
    "Label": {
      "en": "InstanceName",
      "zh-cn": "表所在的OTS实例的名称"
    }
  }
  EOT
}

variable "table_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The table name of the OTS instance."
    },
    "AllowedPattern": "[_a-zA-Z][_a-zA-Z0-9]{0,254}",
    "Label": {
      "en": "TableName",
      "zh-cn": "表的名称"
    }
  }
  EOT
}

variable "time_to_live" {
  type        = number
  default     = -1
  description = <<EOT
  {
    "Description": {
      "en": "The retention time of data stored in this table (unit: second). The value maximum is 2147483647 and -1 means never expired. Default to -1."
    },
    "MinValue": -1,
    "Label": {
      "en": "TimeToLive",
      "zh-cn": "表中数据的保留时间"
    },
    "MaxValue": 2147483647
  }
  EOT
}

variable "max_versions" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of versions stored in this table. The valid value is 1-2147483647. Default to 1."
    },
    "MinValue": 1,
    "Label": {
      "en": "MaxVersions",
      "zh-cn": "表保留的最大版本数"
    },
    "MaxValue": 2147483647
  }
  EOT
}

variable "secondary_indices" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "IndexName": {
              "Type": "String",
              "Description": {
                "en": "The index name."
              },
              "Required": true
            },
            "Columns": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The columns of the index."
              },
              "Required": true
            },
            "PrimaryKeys": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The primary keys of the index."
              },
              "Required": true
            },
            "IndexType": {
              "Type": "String",
              "Description": {
                "en": "The index type"
              },
              "AllowedValues": [
                "Global",
                "Local"
              ],
              "Required": false,
              "Default": "Global"
            }
          }
        },
        "Type": "Json",
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The secondary indices of the table."
    },
    "Label": {
      "en": "SecondaryIndices",
      "zh-cn": "表的二级指标"
    }
  }
  EOT
}

variable "deviation_cell_version_in_sec" {
  type        = number
  default     = 86400
  description = <<EOT
  {
    "Description": {
      "en": "Maximum version deviation. The purpose is mainly to prohibit writing and expected large data, such as setting the deviation_cell_version_in_sec to 1000, and if the current timestamp is 10000, the timestamp range allowed to be written is [10000 - 1000, 10000 + 1000]. The valid value is 1-9223372036854775807. Defaults to 86400."
    },
    "MinValue": 1,
    "Label": {
      "en": "DeviationCellVersionInSec",
      "zh-cn": "最高版本偏差"
    },
    "MaxValue": 9223372036854775807
  }
  EOT
}

variable "primary_key" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "Type for primary key. Only INTEGER, STRING or BINARY is allowed."
          },
          "AllowedValues": [
            "INTEGER",
            "STRING",
            "BINARY"
          ],
          "Required": true
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Name for primary key."
          },
          "AllowedPattern": "[_a-zA-Z][_a-zA-Z0-9]{0,254}",
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "It describes the attribute value of primary key. The number of primary_key should not be less than one and not be more than four."
    },
    "Label": {
      "en": "PrimaryKey",
      "zh-cn": "表全部的主键列"
    },
    "MinLength": 1,
    "MaxLength": 4
  }
  EOT
}

variable "columns" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of the column."
          },
          "AllowedValues": [
            "INTEGER",
            "STRING",
            "BINARY",
            "BOOLEAN",
            "DOUBLE"
          ],
          "Required": true
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The column name of the column."
          },
          "AllowedPattern": "[_a-zA-Z][_a-zA-Z0-9]{0,254}",
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Attribute column for table store."
    },
    "Label": {
      "en": "Columns",
      "zh-cn": "表存储的属性列"
    }
  }
  EOT
}

variable "reserved_throughput" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Read": {
          "Type": "Number",
          "Description": {
            "en": "The read service capability unit consumed by this operation or the reserved read throughput of the table. Default to 0."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 5000,
          "Default": 0
        },
        "Write": {
          "Type": "Number",
          "Description": {
            "en": "The write service capability unit consumed by this operation or the reserved write throughput of the table. Default to 0."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 5000,
          "Default": 0
        }
      }
    },
    "Description": {
      "en": "The initial reserved read/write throughput setting of the table to be created, the reserved read throughput and reserved write throughput of any table cannot exceed 5000."
    },
    "Label": {
      "en": "ReservedThroughput",
      "zh-cn": "表的初始预留读或写吞吐量设定"
    }
  }
  EOT
}

resource "alicloud_ots_table" "table" {
  instance_name                 = var.instance_name
  table_name                    = var.table_name
  time_to_live                  = var.time_to_live
  max_version                   = var.max_versions
  deviation_cell_version_in_sec = var.deviation_cell_version_in_sec
  primary_key                   = var.primary_key
}

output "table_name" {
  value       = alicloud_ots_table.table.table_name
  description = "Table name"
}

