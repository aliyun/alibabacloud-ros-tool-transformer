variable "comment" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The comments of project."
    },
    "Label": {
      "en": "Comment",
      "zh-cn": "备注"
    }
  }
  EOT
}

variable "default_quota" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Default Computing Resource Group."
    },
    "Label": {
      "en": "DefaultQuota",
      "zh-cn": "默认计算quota"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Quota payment type, support PayAsYouGo, Subscription."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "ip_white_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VpcIpList": {
          "Type": "String",
          "Description": {
            "en": "VPC network whitelist. Separate multiple items with commas."
          },
          "Required": false
        },
        "IpList": {
          "Type": "String",
          "Description": {
            "en": "Classic network IP white list. Separate multiple items with commas."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "IP whitelist."
    },
    "Label": {
      "en": "IpWhiteList",
      "zh-cn": "IP白名单"
    }
  }
  EOT
}

variable "properties" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SqlMeteringMax": {
          "Type": "Number",
          "Description": {
            "en": "SQL charge limit."
          },
          "Required": false
        },
        "TypeSystem": {
          "Type": "String",
          "Description": {
            "en": "Type system."
          },
          "AllowedValues": [
            "1",
            "2",
            "hive"
          ],
          "Required": false
        },
        "RetentionDays": {
          "Type": "Number",
          "Description": {
            "en": "Job default retention time."
          },
          "Required": false
        },
        "Encryption": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Enable": {
                "Type": "Boolean",
                "Description": {
                  "en": "Whether to open encryption."
                },
                "Required": false
              },
              "Algorithm": {
                "Type": "String",
                "Description": {
                  "en": "Encryption Algorithm."
                },
                "Required": false
              },
              "Key": {
                "Type": "String",
                "Description": {
                  "en": "Encryption algorithm key."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "Whether encryption is turned on."
          },
          "Required": false
        },
        "AllowFullScan": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to allow full table scan."
          },
          "Required": false
        },
        "EnableDecimal2": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to turn on Decimal2.0."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Project base attributes."
    },
    "Label": {
      "en": "Properties",
      "zh-cn": "项目属性"
    }
  }
  EOT
}

variable "name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the project.\nIt must start with a lower-case letter and contain lower-case letters, digits, and underscores (_). The value must contain 3 to 28 characters"
    },
    "AllowedPattern": "^[a-z][a-z0-9_]{2,27}$",
    "Label": {
      "en": "Name",
      "zh-cn": "项目名称"
    }
  }
  EOT
}

resource "alicloud_maxcompute_project" "project" {
  comment       = var.comment
  default_quota = var.default_quota
}

output "name" {
  // Could not transform ROS Attribute Name to Terraform attribute.
  value       = null
  description = "The name of the project."
}

