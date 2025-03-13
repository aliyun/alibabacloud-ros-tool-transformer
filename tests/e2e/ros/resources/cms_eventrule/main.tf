variable "event_pattern" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "SQLFilter": {
              "Type": "String",
              "Description": {
                "en": "SQL event filtering When the event content meets the SQL conditions, an alarm is triggered automatically."
              },
              "Required": false
            },
            "NameList": {
              "Type": "Json",
              "Description": {
                "en": "The name of the event. Please refer to the configuration of CMS."
              },
              "Required": false
            },
            "LevelList": {
              "Type": "Json",
              "Description": {
                "en": "The severity of the event alert. Valid values: CRITICAL, WARN, INFO, and * (all severity\nlevels)."
              },
              "Required": false
            },
            "StatusList": {
              "Type": "Json",
              "Description": {
                "en": "The status of the event. Please refer to the configuration of CMS."
              },
              "Required": false
            },
            "EventTypeList": {
              "Type": "Json",
              "Description": {
                "en": "The type of the event. A value of * indicates any type. Please refer to the configuration of CMS."
              },
              "Required": false
            },
            "Product": {
              "Type": "String",
              "Description": {
                "en": "The name of the service. Please refer to the configuration of CMS."
              },
              "Required": false
            },
            "CustomFilters": {
              "Type": "String",
              "Description": {
                "en": "Event filtering keywords. When the event content contains this keyword, an alarm is triggered automatically."
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
    "Description": {
      "en": "Event pattern configuration.A maximum of 20 event patterns."
    },
    "Label": {
      "en": "EventPattern",
      "zh-cn": "事件模式相关参数"
    },
    "MaxLength": 20
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the alert rule."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "报警规则描述信息"
    }
  }
  EOT
}

variable "event_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the event alert. Valid values:\nSYSTEM\nCUSTOM"
    },
    "Label": {
      "en": "EventType",
      "zh-cn": "事件报警类型"
    }
  }
  EOT
}

variable "state" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The status of the alert rule. Valid values:\nENABLED\nDISABLED"
    },
    "Label": {
      "en": "State",
      "zh-cn": "报警规则状态"
    }
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the alarm rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "报警规则名称"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the application group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "应用分组ID"
    }
  }
  EOT
}

resource "alicloud_cms_event_rule" "event_rule" {
  event_pattern = var.event_pattern
  description   = var.description
  rule_name     = var.rule_name
  group_id      = var.group_id
}

output "data" {
  // Could not transform ROS Attribute Data to Terraform attribute.
  value       = null
  description = "Number of rows affected."
}

