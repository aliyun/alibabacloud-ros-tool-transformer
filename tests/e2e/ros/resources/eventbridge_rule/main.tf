variable "status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The status of the event rule. Valid values:\nENABLE: The event rule is enabled. It is the default state of the event rule.\nDISABLE: The event rule is disabled."
    },
    "Label": {
      "en": "Status",
      "zh-cn": "规则的状态"
    }
  }
  EOT
}

variable "event_bus_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the event bus."
    },
    "Label": {
      "en": "EventBusName",
      "zh-cn": "事件总线的名称"
    }
  }
  EOT
}

variable "filter_pattern" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The event pattern, in the JSON format."
    },
    "Label": {
      "en": "FilterPattern",
      "zh-cn": "事件模式"
    }
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the event rule."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "规则说明"
    }
  }
  EOT
}

variable "targets" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "PushRetryStrategy": {
              "Type": "String",
              "Description": {
                "en": "The retry policy that is used to push the event. Valid values: BACKOFF_RETRY: backoff retry. The request can be retried up to three times. The interval between two consecutive retries is a random value between 10 and 20 seconds. EXPONENTIAL_DECAY_RETRY: exponential decay retry. The request can be retried up to 176 times. The interval between two consecutive retries exponentially increases to 512 seconds, and the total retry time is one day. The specific retry intervals are 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 512, ..., and 512 seconds, including a maximum of one hundred and sixty-seven 512 seconds in total."
              },
              "Required": false
            },
            "Type": {
              "Type": "String",
              "Description": {
                "en": "The type of the event target."
              },
              "Required": true
            },
            "Endpoint": {
              "Type": "String",
              "Description": {
                "en": "The endpoint of the event target."
              },
              "Required": true
            },
            "Id": {
              "Type": "String",
              "Description": {
                "en": "The custom ID of the event target."
              },
              "Required": true
            },
            "ParamList": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Form": {
                    "Type": "String",
                    "Description": {
                      "en": "The transformation method.For more information, see Event target parameters."
                    },
                    "Required": true
                  },
                  "Value": {
                    "Type": "String",
                    "Description": {
                      "en": "The event value to be transformed."
                    },
                    "Required": true
                  },
                  "ResourceKey": {
                    "Type": "String",
                    "Description": {
                      "en": "The resource key of the transformed event.For more information, see Event target parameters."
                    },
                    "Required": true
                  },
                  "Template": {
                    "Type": "String",
                    "Description": {
                      "en": "The format of the template."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "The parameters that the event passes."
              },
              "Required": true,
              "MinLength": 1
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The event target to which events are delivered."
    },
    "Label": {
      "en": "Targets",
      "zh-cn": "事件的投递目标"
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "rule_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the event rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "事件规则的名称"
    }
  }
  EOT
}

resource "alicloud_event_bridge_rule" "rule" {
  status         = var.status
  event_bus_name = var.event_bus_name
  description    = var.description
  targets        = var.targets
  rule_name      = var.rule_name
}

output "event_bus_name" {
  value       = alicloud_event_bridge_rule.rule.event_bus_name
  description = "The name of the event bus."
}

output "rulearn" {
  // Could not transform ROS Attribute RuleARN to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN) of the event rule. The ARN is used for authorization."
}

output "rule_name" {
  value       = alicloud_event_bridge_rule.rule.rule_name
  description = "The name of the event rule."
}

