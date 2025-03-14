variable "parameters" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Description": {
            "en": "Value to update for instance property."
          },
          "Required": true
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Key to update for instance property."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Parameters to update for selected database instance."
    },
    "Label": {
      "en": "Parameters",
      "zh-cn": "实例的参数"
    }
  }
  EOT
}

variable "dbinstance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Database InstanceId to update properties."
    },
    "Label": {
      "en": "DBInstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "forcerestart" {
  type        = string
  default     = "false"
  description = <<EOT
  {
    "Description": {
      "en": "whether restart database instance."
    },
    "AllowedValues": [
      "true",
      "false"
    ],
    "Label": {
      "en": "Forcerestart",
      "zh-cn": "是否强制重启实例"
    }
  }
  EOT
}

resource "alicloud_rds_parameter_group" "dbinstance_parameter_group" {}

