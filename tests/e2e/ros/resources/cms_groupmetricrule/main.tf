variable "no_effective_interval" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The period when the alert rule is ineffective."
    },
    "Label": {
      "en": "NoEffectiveInterval",
      "zh-cn": "报警规则非生效时间范围"
    }
  }
  EOT
}

variable "silence_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The duration of the mute period during which new alerts are not sent even if the trigger\nconditions are met. Unit: second. Default value: 86400. Minimum value: 60."
    },
    "MinValue": 60,
    "Label": {
      "en": "SilenceTime",
      "zh-cn": "一直处于报警状态的通知沉默周期"
    }
  }
  EOT
}

variable "category" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The abbreviation of the service name. Valid values:\nECS (including Alibaba Cloud and non-Alibaba Cloud hosts)\nRDS (ApsaraDB for RDS)\nADS (AnalyticDB)\nSLB (Server Load Balancer)\nVPC (Virtual Private Cloud)\nAPIGATEWAY (API Gateway)\nCDN\nCS (Container Service for Swarm)\nDCDN (Dynamic Route for CDN)\nDDoS (distributed denial of service)\nEIP (Elastic IP)\nELASTICSEARCH (Elasticsearch)\nEMR (E-MapReduce)\nESS (Auto Scaling)\nHBASE (ApsaraDB for HBase)\nIOT_EDGE (IoT Edge)\nK8S_POD (k8s pod)\nKVSTORE_SHARDING (ApsaraDB for Redis cluster version)\nKVSTORE_SPLITRW (ApsaraDB for Redis read/write splitting version)\nKVSTORE_STANDARD (ApsaraDB for Redis standard version)\nMEMCACHE (ApsaraDB for Memcache)\nMNS (Message Service)\nMONGODB (ApsaraDB for MongoDB replica set instances)\nMONGODB_CLUSTER (ApsaraDB for MongoDB cluster version)\nMONGODB_SHARDING (ApsaraDB for MongoDB sharded clusters)\nMQ_TOPIC (Message Service topic)\nOCS (original version of ApsaraDB for Memcache)\nOPENSEARCH (Open Search)\nOSS (Object Storage Service)\nPOLARDB (ApsaraDB for POLARDB)\nPETADATA (HybridDB for MySQL)\nSCDN (Secure Content Delivery Network)\nSHAREBANDWIDTHPACKAGES (shared bandwidth package)\nSLS (Log Service)\nVPN (VPN Gateway)"
    },
    "Label": {
      "en": "Category",
      "zh-cn": "产品名称或产品规格缩写"
    }
  }
  EOT
}

variable "rule_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the alert rule. The IDs of alert rules are generated by callers to ensure\nuniqueness."
    },
    "Label": {
      "en": "RuleId",
      "zh-cn": "报警规则ID"
    }
  }
  EOT
}

variable "dimensions" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The expended resource dimensions."
    },
    "Label": {
      "en": "Dimensions",
      "zh-cn": "扩展资源维度"
    }
  }
  EOT
}

variable "period" {
  type        = number
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The aggregation period. Unite: second."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "监控数据的聚合周期"
    }
  }
  EOT
}

variable "effective_interval" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The period when the alert rule is effective."
    },
    "Label": {
      "en": "EffectiveInterval",
      "zh-cn": "报警规则的生效时间范围"
    }
  }
  EOT
}

variable "namespace" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The data namespace of the service. For more information, call DescribeMetricMetaList\nor see Preset metrics reference.",
      "zh-cn": "产品的数据命名空间。更多信息，请参见DescribeMetricMetaList或云服务主要监控项。"
    },
    "Label": {
      "en": "Namespace",
      "zh-cn": "产品的数据命名空间"
    }
  }
  EOT
}

variable "group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of application group."
    },
    "Label": {
      "en": "GroupId",
      "zh-cn": "应用分组的ID"
    }
  }
  EOT
}

variable "metric_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the metric. For more information, call DescribeMetricMetaList or see Preset metrics reference.",
      "zh-cn": "监控项名称。更多信息，请参见DescribeMetricMetaList或云服务主要监控项。"
    },
    "Label": {
      "en": "MetricName",
      "zh-cn": "监控项名称"
    }
  }
  EOT
}

variable "escalations" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Critical": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ComparisonOperator": {
                "Type": "String",
                "Description": {
                  "en": "The comparison operator of the threshold for critical-level alerts. Valid values:\nGreaterThanOrEqualToThreshold\nGreaterThanThreshold\nLessThanOrEqualToThreshold\nLessThanThreshold\nNotEqualToThreshold\nGreaterThanYesterday\nLessThanYesterday\nGreaterThanLastWeek\nLessThanLastWeek\nGreaterThanLastPeriod\nLessThanLastPeriod"
                },
                "Required": true
              },
              "Times": {
                "Type": "Number",
                "Description": {
                  "en": "The consecutive number of times for which the metric value exceeds the threshold for\ncritical-level alerts before an alert is triggered."
                },
                "Required": true
              },
              "Statistics": {
                "Type": "String",
                "Description": {
                  "en": "The statistical method for critical-level alerts. The statistical method varies with\nmetric."
                },
                "Required": true
              },
              "Threshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for critical-level alerts."
                },
                "Required": true
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "Info": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ComparisonOperator": {
                "Type": "String",
                "Description": {
                  "en": "The comparison operator of the threshold for info-level alerts. Valid values:\nGreaterThanOrEqualToThreshold\nGreaterThanThreshold\nLessThanOrEqualToThreshold\nLessThanThreshold\nNotEqualToThreshold\nGreaterThanYesterday\nLessThanYesterday\nGreaterThanLastWeek\nLessThanLastWeek\nGreaterThanLastPeriod\nLessThanLastPeriod"
                },
                "Required": true
              },
              "Times": {
                "Type": "Number",
                "Description": {
                  "en": "The consecutive number of times for which the metric value exceeds the threshold for\ninfo-level alerts before an alert is triggered."
                },
                "Required": true
              },
              "Statistics": {
                "Type": "String",
                "Description": {
                  "en": "The statistical method for info-level alerts."
                },
                "Required": true
              },
              "Threshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for info-level alerts."
                },
                "Required": true
              }
            }
          },
          "Type": "Json",
          "Required": false
        },
        "Warn": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "ComparisonOperator": {
                "Type": "String",
                "Description": {
                  "en": "The comparison operator of the threshold for warn-level alerts. Valid values:\nGreaterThanOrEqualToThreshold\nGreaterThanThreshold\nLessThanOrEqualToThreshold\nLessThanThreshold\nNotEqualToThreshold\nGreaterThanYesterday\nLessThanYesterday\nGreaterThanLastWeek\nLessThanLastWeek\nGreaterThanLastPeriod\nLessThanLastPeriod"
                },
                "Required": true
              },
              "Times": {
                "Type": "Number",
                "Description": {
                  "en": "The consecutive number of times for which the metric value exceeds the threshold for\nwarn-level alerts before an alert is triggered."
                },
                "Required": true
              },
              "Statistics": {
                "Type": "String",
                "Description": {
                  "en": "The statistical method for warn-level alerts."
                },
                "Required": true
              },
              "Threshold": {
                "Type": "Number",
                "Description": {
                  "en": "The threshold for warn-level alerts."
                },
                "Required": true
              }
            }
          },
          "Type": "Json",
          "Required": false
        }
      }
    },
    "Label": {
      "en": "Escalations",
      "zh-cn": "报警配置"
    }
  }
  EOT
}

variable "email_subject" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The subject of the alert notification email."
    },
    "Label": {
      "en": "EmailSubject",
      "zh-cn": "报警邮件主题"
    }
  }
  EOT
}

variable "webhook" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The URL of the callback triggered when an alert occurs."
    },
    "Label": {
      "en": "Webhook",
      "zh-cn": "出现报警时触发的回调地址"
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
      "en": "The name of the alert rule."
    },
    "Label": {
      "en": "RuleName",
      "zh-cn": "报警规则名称"
    }
  }
  EOT
}

variable "interval" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The detection period of alerts.",
      "zh-cn": "报警规则的探测周期，即报警系统多长时间检查一次是否要触发报警规则，默认为监控项的最小频率。"
    },
    "Label": {
      "en": "Interval",
      "zh-cn": "报警规则的探测周期"
    }
  }
  EOT
}

resource "alicloud_cms_group_metric_rule" "group_metric_rule" {
  no_effective_interval = var.no_effective_interval
  silence_time          = var.silence_time
  category              = var.category
  rule_id               = var.rule_id
  dimensions            = var.dimensions
  period                = var.period
  effective_interval    = var.effective_interval
  namespace             = var.namespace
  group_id              = var.group_id
  metric_name           = var.metric_name
  email_subject         = var.email_subject
  webhook               = var.webhook
  interval              = var.interval
}

output "rule_id" {
  value       = alicloud_cms_group_metric_rule.group_metric_rule.id
  description = "Rule ID."
}

