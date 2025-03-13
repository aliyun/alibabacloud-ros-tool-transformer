variable "index_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The index name."
    },
    "Label": {
      "en": "IndexName",
      "zh-cn": "多元索引名称"
    }
  }
  EOT
}

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
      "zh-cn": "数据表所属的实例名称"
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
      "zh-cn": "数据表名称"
    }
  }
  EOT
}

variable "field_schemas" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "IsArray": {
              "Type": "Boolean",
              "Description": {
                "en": "This parameter specifies whether the column is an array. \nA value of true indicates that the column is an array. Data written to the column must be a JSON array. \nExample: [\"a\",\"b\",\"c\"]. You do not need to explicitly specify this parameter for NESTED columns because they are arrays."
              },
              "Required": false
            },
            "EnableSortAndAgg": {
              "Type": "Boolean",
              "Description": {
                "en": "This parameter specifies whether to enable sorting and aggregation for the column."
              },
              "Required": false
            },
            "Store": {
              "Type": "Boolean",
              "Description": {
                "en": "This parameter specifies whether to store the values of the field in the search index. \nA value of true indicates that you can read the values of the field directly from the search index without the need to query the table. \nThis configuration optimizes query performance."
              },
              "Required": false
            },
            "Index": {
              "Type": "Boolean",
              "Description": {
                "en": "This parameter specifies whether to index the column. \nThe default is true, which means to build an inverted index or a spatial index for the column; if it is set to false, the column will not be indexed."
              },
              "Required": false
            },
            "Analyzer": {
              "Type": "String",
              "Description": {
                "en": "This parameter specifies the tokenizer. \nYou can specify this parameter if the column is a TEXT column. Type: AnalyzerType."
              },
              "Required": false
            },
            "SubFieldSchemas": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "IsArray": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "This parameter specifies whether the column is an array. \nA value of true indicates that the column is an array. Data written to the column must be a JSON array. \nExample: [\"a\",\"b\",\"c\"]. You do not need to explicitly specify this parameter for NESTED columns because they are arrays."
                    },
                    "Required": false
                  },
                  "EnableSortAndAgg": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "This parameter specifies whether to enable sorting and aggregation for the column."
                    },
                    "Required": false
                  },
                  "Store": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "This parameter specifies whether to store the values of the field in the search index. \nA value of true indicates that you can read the values of the field directly from the search index without the need to query the table. \nThis configuration optimizes query performance."
                    },
                    "Required": false
                  },
                  "Index": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "This parameter specifies whether to index the column. \nThe default is true, which means to build an inverted index or a spatial index for the column; if it is set to false, the column will not be indexed."
                    },
                    "Required": false
                  },
                  "Analyzer": {
                    "Type": "String",
                    "Description": {
                      "en": "This parameter specifies the tokenizer. \nYou can specify this parameter if the column is a TEXT column. Type: AnalyzerType."
                    },
                    "Required": false
                  },
                  "FieldName": {
                    "Type": "String",
                    "Description": {
                      "en": "This parameter specifies the name of the field (column) to index. \nThe field can be a primary key column or an attribute column."
                    },
                    "Required": true
                  },
                  "FieldType": {
                    "Type": "String",
                    "Description": {
                      "en": "This parameter specifies the type of the field. Type: FieldType. \nFor more information, see the description of field types for a search index."
                    },
                    "Required": true
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "This parameter specifies the list of field schemas for subfields. \nIf the column is a NESTED column, you must specify this parameter to configure the index types of subcolumns in the NESTED column."
              },
              "Required": false
            },
            "FieldName": {
              "Type": "String",
              "Description": {
                "en": "This parameter specifies the name of the field (column) to index. \nThe field can be a primary key column or an attribute column."
              },
              "Required": true
            },
            "FieldType": {
              "Type": "String",
              "Description": {
                "en": "This parameter specifies the type of the field. Type: FieldType. \nFor more information, see the description of field types for a search index."
              },
              "Required": true
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "list of field_schema."
    },
    "Label": {
      "en": "FieldSchemas",
      "zh-cn": "字段结构"
    }
  }
  EOT
}

variable "index_sort" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Sorters": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "FieldSort": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "SortMode": {
                          "Type": "String",
                          "Description": {
                            "en": "Sorting method when there are multiple values in the field."
                          },
                          "Required": false
                        },
                        "SortOrder": {
                          "Type": "String",
                          "Description": {
                            "en": "The sort order can be sorted in ascending or descending order, the default is ascending(SortOrder.ASC)."
                          },
                          "Required": false
                        },
                        "FieldName": {
                          "Type": "String",
                          "Description": {
                            "en": "Sorted field name."
                          },
                          "Required": true
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "Sort by field value. \nOnly fields that are indexed and have sorting and statistical aggregation functions enabled can be pre-sorted"
                    },
                    "Required": false
                  },
                  "PrimaryKeySort": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "SortOrder": {
                          "Type": "String",
                          "Description": {
                            "en": "The sort order can be sorted in ascending or descending order, the default is ascending(SortOrder.ASC)."
                          },
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "You can use PrimaryKeySort to sort the query result based on the order of primary key columns."
                    },
                    "Required": false
                  },
                  "ScoreSort": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "SortOrder": {
                          "Type": "String",
                          "Description": {
                            "en": "The sort order can be sorted in ascending or descending order"
                          },
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "You can use ScoreSort to sort the query result by keyword relevance score. \nScoreSort is applicable to scenarios such as full-text indexing. \nNote Note that you must set ScoreSort to sort the query result by keyword relevance score. Otherwise, the query result is sorted based on the value of the IndexSort field."
                    },
                    "Required": false
                  },
                  "GeoDistanceSort": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Points": {
                          "Type": "Json",
                          "Description": {
                            "en": "The parameter of GeoDistanceSort"
                          },
                          "Required": true
                        },
                        "SortMode": {
                          "Type": "String",
                          "Description": {
                            "en": "Sorting method when there are multiple values in the field."
                          },
                          "Required": false
                        },
                        "SortOrder": {
                          "Type": "String",
                          "Description": {
                            "en": "The sort order can be sorted in ascending or descending order"
                          },
                          "Required": false
                        },
                        "FieldName": {
                          "Type": "String",
                          "Description": {
                            "en": "Sorted field name."
                          },
                          "Required": true
                        }
                      }
                    },
                    "Type": "Json",
                    "Description": {
                      "en": "You can use GeoDistanceSort to sort the query result based on distances of geographical locations."
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
            "en": "This parameter specifies the sorting methods.  Valid values: \n- PrimaryKeySort: The index is sorted by primary key in ascending or descending order.\n- FieldSort: The index is sorted by a specified column in ascending or descending order."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "This parameter specifies how data is sorted. \nBy default, the data is sorted in the same way as the primary key of the table. \nIf the search index contains NESTED fields, data is not sorted by default.",
      "zh-cn": "索引预排序设置。默认按照主键排序。"
    },
    "Label": {
      "en": "IndexSort",
      "zh-cn": "索引预排序设置"
    }
  }
  EOT
}

variable "index_setting" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "RoutingFields": {
          "Type": "Json",
          "Description": {
            "en": "You can use this advanced feature to customize routing fields. \nYou can specify some primary key columns as routing fields. \nTablestore distributes data that is written to a search index to different partitions based on the specified routing fields. \nThe data with the same routing field values is distributed to the same data partition."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Index settings"
    },
    "Label": {
      "en": "IndexSetting",
      "zh-cn": "索引设置"
    }
  }
  EOT
}

resource "alicloud_ots_search_index" "search_index" {
  index_name    = var.index_name
  instance_name = var.instance_name
  table_name    = var.table_name
}

output "index_name" {
  // Could not transform ROS Attribute IndexName to Terraform attribute.
  value       = null
  description = "Index name."
}

