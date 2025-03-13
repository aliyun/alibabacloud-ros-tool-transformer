variable "alert_templates" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "MetricName": {
              "Type": "String",
              "Description": {
                "en": "The name of the metric.\nNote For more information, see DescribeMetricMetaList or Appendix 1: Metrics."
              },
              "Required": true
            },
            "Category": {
              "Type": "String",
              "Description": {
                "en": "The abbreviation of the service name.Value including but not limited to:\necs: Elastic Compute Service (ECS) instances provided by Alibaba Cloud and hosts not\nprovided by Alibaba Cloud\nrds: ApsaraDB for RDS\nads: AnalyticDB\nslb: Server Load Balancer (SLB)\nvpc: Virtual Private Cloud (VPC)\napigateway: API Gateway\ncdn: CDN: Alibaba Cloud Content Delivery Network (CDN)\ncs: Container Service for Swarm\ndcdn: Dynamic Route for CDN\nddos: Anti-DDoS Pro\neip: Elastic IP Address (EIP)\nelasticsearch: Elasticsearch\nemr: E-MapReduce\ness: Auto Scaling\nhbase: ApsaraDB for Hbase\niot_edge: IoT Edge\nk8s_pod: pods in Container Service for Kubernetes\nkvstore_sharding: ApsaraDB for Redis of the cluster architecture\nkvstore_splitrw: ApsaraDB for Redis of the read/write splitting architecture\nkvstore_standard: ApsaraDB for Redis of the standard architecture\nmemcache: ApsaraDB for Memcache\nmns: Message Service (MNS)\nmongodb: ApsaraDB for MongoDB of the replica set architecture\nmongodb_cluster: ApsaraDB for MongoDB of the cluster architecture\nmongodb_sharding: ApsaraDB for MongoDB of the sharded cluster architecture\nmq_topic: MNS topics\nocs: ApsaraDB for Memcache of earlier versions\nopensearch: Open Search\noss: Object Storage Service (OSS)\npolardb: PolarDB\npetadata: HybridDB for MySQL\nscdn: Secure Content Delivery Network (SCDN)\nsharebandwidthpackages: EIP Bandwidth Plan\nsls: Log Service\nvpn: VPN Gateway"
              },
              "Required": true
            },
            "Escalations": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Critical": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ComparisonOperator": {
                          "Type": "String",
                          "Description": {
                            "en": "The comparison operator of the threshold for alerts. Valid values:\nGreaterThanOrEqualToThreshold: greater than or equal to the threshold\nGreaterThanThreshold: greater than the threshold\nLessThanOrEqualToThreshold: less than or equal to the threshold\nLessThanThreshold: less than the threshold\nNotEqualToThreshold: not equal to the threshold\nGreaterThanYesterday: greater than the metric value at the same time yesterday\nLessThanYesterday: less than the metric value at the same time yesterday\nGreaterThanLastWeek: greater than the metric value at the same time last week\nLessThanLastWeek: less than the metric value at the same time last week\nGreaterThanLastPeriod: greater than the metric value in the last monitoring cycle\nLessThanLastPeriod: less than the metric value in the last monitoring cycle"
                          },
                          "AllowedValues": [
                            "GreaterThanOrEqualToThreshold",
                            "GreaterThanThreshold",
                            "LessThanOrEqualToThreshold",
                            "LessThanThreshold",
                            "NotEqualToThreshold",
                            "GreaterThanYesterday",
                            "LessThanYesterday",
                            "GreaterThanLastWeek",
                            "LessThanLastWeek",
                            "GreaterThanLastPeriod",
                            "LessThanLastPeriod"
                          ],
                          "Required": true
                        },
                        "Times": {
                          "Type": "Number",
                          "Description": {
                            "en": "The consecutive number of times for which the metric value is measured before a alert is triggered. "
                          },
                          "Required": true
                        },
                        "Statistics": {
                          "Type": "String",
                          "Description": {
                            "en": "The statistical method for alerts. "
                          },
                          "Required": true
                        },
                        "Threshold": {
                          "Type": "String",
                          "Description": {
                            "en": "The threshold for alerts."
                          },
                          "Required": true
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": true
                  },
                  "Info": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "ComparisonOperator": {
                          "Type": "String",
                          "Description": {
                            "en": "The comparison operator of the threshold for alerts. Valid values:\nGreaterThanOrEqualToThreshold: greater than or equal to the threshold\nGreaterThanThreshold: greater than the threshold\nLessThanOrEqualToThreshold: less than or equal to the threshold\nLessThanThreshold: less than the threshold\nNotEqualToThreshold: not equal to the threshold\nGreaterThanYesterday: greater than the metric value at the same time yesterday\nLessThanYesterday: less than the metric value at the same time yesterday\nGreaterThanLastWeek: greater than the metric value at the same time last week\nLessThanLastWeek: less than the metric value at the same time last week\nGreaterThanLastPeriod: greater than the metric value in the last monitoring cycle\nLessThanLastPeriod: less than the metric value in the last monitoring cycle"
                          },
                          "AllowedValues": [
                            "GreaterThanOrEqualToThreshold",
                            "GreaterThanThreshold",
                            "LessThanOrEqualToThreshold",
                            "LessThanThreshold",
                            "NotEqualToThreshold",
                            "GreaterThanYesterday",
                            "LessThanYesterday",
                            "GreaterThanLastWeek",
                            "LessThanLastWeek",
                            "GreaterThanLastPeriod",
                            "LessThanLastPeriod"
                          ],
                          "Required": true
                        },
                        "Times": {
                          "Type": "Number",
                          "Description": {
                            "en": "The consecutive number of times for which the metric value is measured before a alert is triggered. "
                          },
                          "Required": true
                        },
                        "Statistics": {
                          "Type": "String",
                          "Description": {
                            "en": "The statistical method for alerts. "
                          },
                          "Required": true
                        },
                        "Threshold": {
                          "Type": "String",
                          "Description": {
                            "en": "The threshold for alerts."
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
                            "en": "The comparison operator of the threshold for alerts. Valid values:\nGreaterThanOrEqualToThreshold: greater than or equal to the threshold\nGreaterThanThreshold: greater than the threshold\nLessThanOrEqualToThreshold: less than or equal to the threshold\nLessThanThreshold: less than the threshold\nNotEqualToThreshold: not equal to the threshold\nGreaterThanYesterday: greater than the metric value at the same time yesterday\nLessThanYesterday: less than the metric value at the same time yesterday\nGreaterThanLastWeek: greater than the metric value at the same time last week\nLessThanLastWeek: less than the metric value at the same time last week\nGreaterThanLastPeriod: greater than the metric value in the last monitoring cycle\nLessThanLastPeriod: less than the metric value in the last monitoring cycle"
                          },
                          "AllowedValues": [
                            "GreaterThanOrEqualToThreshold",
                            "GreaterThanThreshold",
                            "LessThanOrEqualToThreshold",
                            "LessThanThreshold",
                            "NotEqualToThreshold",
                            "GreaterThanYesterday",
                            "LessThanYesterday",
                            "GreaterThanLastWeek",
                            "LessThanLastWeek",
                            "GreaterThanLastPeriod",
                            "LessThanLastPeriod"
                          ],
                          "Required": true
                        },
                        "Times": {
                          "Type": "Number",
                          "Description": {
                            "en": "The consecutive number of times for which the metric value is measured before a alert is triggered. "
                          },
                          "Required": true
                        },
                        "Statistics": {
                          "Type": "String",
                          "Description": {
                            "en": "The statistical method for alerts. "
                          },
                          "Required": true
                        },
                        "Threshold": {
                          "Type": "String",
                          "Description": {
                            "en": "The threshold for alerts."
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
              "Type": "Json",
              "Required": false
            },
            "Period": {
              "AssociationProperty": "PayPeriod",
              "Type": "Number",
              "Description": {
                "en": "The aggregation period of the monitoring data. Unit: seconds.\nThe default value is the lowest frequency at which the metric is polled. Typically,\nyou do not need to specify the aggregation period. "
              },
              "Required": false
            },
            "Webhook": {
              "Type": "String",
              "Description": {
                "en": "The callback URL to which a POST request is sent when an alert is triggered based\non the alert rule."
              },
              "Required": false
            },
            "Namespace": {
              "Type": "String",
              "Description": {
                "en": "The namespace of the service. \nNote For more information, see DescribeMetricMetaList or Appendix 1: Metrics."
              },
              "Required": true
            },
            "RuleName": {
              "Type": "String",
              "Description": {
                "en": "The name of the alert rule."
              },
              "Required": true
            },
            "Selector": {
              "Type": "String",
              "Description": {
                "en": "The dimension of the alert. It is an extended field. "
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
      "en": "Valid values of N: 0 to 200."
    },
    "Label": {
      "en": "AlertTemplates",
      "zh-cn": "报警模板"
    },
    "MinLength": 0,
    "MaxLength": 200
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the alert template."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "报警模板描述信息"
    }
  }
  EOT
}

variable "rest_version" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The version of the alert template. Call DescribeMetricRuleTemplateList or DescribeMetricRuleTemplateAttribute\nto obtain information about the alert templates. The combination of version and ID\nuniquely identifies an alert template."
    },
    "Label": {
      "en": "RestVersion",
      "zh-cn": "报警模板版本"
    }
  }
  EOT
}

variable "template_id" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the alert template."
    },
    "Label": {
      "en": "TemplateId",
      "zh-cn": "克隆模板ID"
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
      "en": "The name of the alert template."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "报警模板名称"
    }
  }
  EOT
}

resource "alicloud_cms_metric_rule_template" "metric_rule_template" {
  alert_templates = var.alert_templates
  description     = var.description
  rest_version    = var.rest_version
}

output "id" {
  value       = alicloud_cms_metric_rule_template.metric_rule_template.id
  description = "Alarm template ID."
}

