variable "logstore_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Logstore name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "LogstoreName",
      "zh-cn": "日志库名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "project_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "ProjectName",
      "zh-cn": "日志项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "key_indices" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Type": {
              "AssociationPropertyMetadata": {
                "AutoChangeType": false
              },
              "Type": "String",
              "Description": {
                "en": "Key type. Allowed types: text, long, double, json. Default to text."
              },
              "AllowedValues": [
                "text",
                "long",
                "double",
                "json"
              ],
              "Required": true,
              "Label": {
                "zh-cn": "字段类型"
              },
              "Default": "text"
            },
            "JsonKeyIndices": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Type": {
                    "Type": "String",
                    "Description": {
                      "en": "Json key type. Allowed types: text, long, double. Default to text."
                    },
                    "AllowedValues": [
                      "text",
                      "long",
                      "double"
                    ],
                    "Required": true,
                    "Default": "text"
                  },
                  "Alias": {
                    "Type": "String",
                    "Description": {
                      "en": "Json key alias."
                    },
                    "Required": false
                  },
                  "EnableAnalytics": {
                    "Type": "Boolean",
                    "Description": {
                      "en": "Whether this json key is enabled for statistics. Default to true."
                    },
                    "Required": false,
                    "Default": true
                  },
                  "Name": {
                    "Type": "String",
                    "Description": {
                      "en": "Json key name. It can be nested by dot(.), such as k1.k2.k3."
                    },
                    "Required": true
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Json key index configurations."
              },
              "Required": false
            },
            "Delimiter": {
              "Type": "String",
              "Description": {
                "en": "Delimiter. It takes effect when Type is text or json. Default to (( , '\";=()[]{}?@&<>/:\\n\\t\\r ))."
              },
              "Required": false,
              "Label": {
                "zh-cn": "分词符"
              },
              "Default": ", '\";=()[]{}?@&<>/:\n\t\r"
            },
            "IncludeChinese": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "Whether it contains Chinese. It takes effect when Type is text or json. Default to false."
              },
              "Required": false,
              "Label": {
                "zh-cn": "是否区分大小写"
              },
              "Default": false
            },
            "Alias": {
              "Type": "String",
              "Description": {
                "en": "Key alias."
              },
              "Required": false,
              "Label": {
                "zh-cn": "字段别名"
              }
            },
            "EnableAnalytics": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "Whether this key is enabled for statistics. Default to false for json type, else true."
              },
              "Required": false,
              "Label": {
                "zh-cn": "该字段是否开启统计"
              },
              "Default": true
            },
            "CaseSensitive": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "Whether it is case sensitive. It takes effect when Type is text or json. Default to false."
              },
              "Required": false,
              "Label": {
                "zh-cn": "是否区分大小写"
              },
              "Default": false
            },
            "Name": {
              "Type": "String",
              "Description": {
                "en": "Key name."
              },
              "Required": true,
              "Label": {
                "zh-cn": "字段名"
              }
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "Key index configuration."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Key index configurations.\nFull-text indexing and key indexing must have at least one enabled."
    },
    "Label": {
      "zh-cn": "字段索引配置"
    }
  }
  EOT
}

variable "full_text_index" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Delimiter": {
          "Type": "String",
          "Description": {
            "en": "Delimiter. Default to (( , '\";=()[]{}?@&<>/:\\n\\t\\r ))."
          },
          "Required": false,
          "Label": {
            "zh-cn": "分词符"
          },
          "Default": ", '\";=()[]{}?@&<>/:\n\t\r"
        },
        "IncludeChinese": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Whether it contains Chinese. Default to false."
          },
          "Required": false,
          "Label": {
            "zh-cn": "是否包含中文"
          },
          "Default": false
        },
        "CaseSensitive": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Whether it is case sensitive. Default to false."
          },
          "Required": false,
          "Label": {
            "zh-cn": "是否区分大小写"
          },
          "Default": false
        },
        "Enable": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable full-text indexing. Default to true."
          },
          "Required": true,
          "Label": {
            "zh-cn": "是否启用全文索引"
          },
          "Default": false
        }
      }
    },
    "Description": {
      "en": "Full-text indexing configuration.\nFull-text indexing and key indexing must have at least one enabled."
    },
    "Label": {
      "en": "FullTextIndex",
      "zh-cn": "全文索引配置"
    }
  }
  EOT
}

variable "log_reduce" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable log reduce. Default to false."
    },
    "Label": {
      "zh-cn": "是否启用日志分割"
    }
  }
  EOT
}

resource "alicloud_log_store_index" "index" {
  logstore     = var.logstore_name
  project      = var.project_name
  field_search = var.key_indices
  full_text    = var.full_text_index
}

