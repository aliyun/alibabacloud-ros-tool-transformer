variable "project" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Project name:\n1. Only supports lowercase letters, numbers, hyphens (-) and underscores (_).\n2. Must start and end with lowercase letters and numbers.\n3. The name length is 3-63 characters."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "Label": {
      "en": "Project",
      "zh-cn": "日志项目名称"
    },
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "detail" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Required": false,
          "Default": "Alert"
        },
        "Description": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "Description of the alert."
          },
          "Required": false,
          "Default": ""
        },
        "Configuration": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Throttling": {
                "Type": "String",
                "Description": {
                  "en": "Notification interval, default is no interval."
                },
                "Required": false
              },
              "Condition": {
                "Type": "String",
                "Description": {
                  "en": "The condition that is required to trigger an alert. \nLog Service triggers an alert if the trigger condition is met. \nFor example, you can set the trigger condition to pv%100 > 0 && uv > 0."
                },
                "Required": false
              },
              "AutoAnnotation": {
                "Type": "Boolean",
                "Required": false
              },
              "SeverityConfigurations": {
                "AssociationPropertyMetadata": {
                  "Parameter": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Severity": {
                          "Type": "Number",
                          "Description": {
                            "en": "The alarm level when there is no data to trigger the alarm. Valid values:\n2: Report\n4: Low\n6: Medium\n8: High\n10: Critical."
                          },
                          "Required": true
                        },
                        "EvalCondition": {
                          "AssociationPropertyMetadata": {
                            "Parameters": {
                              "Condition": {
                                "Type": "String",
                                "Description": {
                                  "en": "It is triggered when any piece of data in the result of judging the Cartesian product satisfies the Condition. After grouping, it indicates the data trigger condition for each group, and an empty string indicates that any data row is satisfied."
                                },
                                "Required": false
                              },
                              "CountCondition": {
                                "Type": "String",
                                "Description": {
                                  "en": "Alarm expression, indicating how much data meets the alarm condition."
                                },
                                "Required": false
                              }
                            }
                          },
                          "Type": "Json",
                          "Required": false
                        }
                      }
                    },
                    "Type": "Json",
                    "Required": true
                  }
                },
                "AssociationProperty": "List[Parameter]",
                "Type": "Json",
                "Description": {
                  "en": "The list of severity configurations."
                },
                "Required": false
              },
              "NoDataFire": {
                "Type": "Boolean",
                "Description": {
                  "en": "Whether to trigger an alarm if there is no data, the default is false."
                },
                "Required": false
              },
              "NotificationList": {
                "AssociationPropertyMetadata": {
                  "Parameter": {
                    "AssociationPropertyMetadata": {
                      "Parameters": {
                        "Type": {
                          "Type": "String",
                          "Description": {
                            "en": "This topic describes how to configure a notification method. \nLog Service can send alert notifications by using one or more methods. \nAvailable notification methods include emails, DingTalk chatbot webhooks, \ncustom webhooks, and Alibaba Cloud Message Center."
                          },
                          "Required": true
                        },
                        "MobileList": {
                          "Type": "Json",
                          "Required": false
                        },
                        "ServiceUri": {
                          "Type": "String",
                          "Description": {
                            "en": "The webhook URL of the DingTalk chatbot."
                          },
                          "Required": false
                        },
                        "Content": {
                          "Type": "String",
                          "Description": {
                            "en": "The content of an alert notification"
                          },
                          "Required": false
                        },
                        "Headers": {
                          "Type": "Json",
                          "Required": false
                        },
                        "EmailList": {
                          "Type": "Json",
                          "Required": false
                        },
                        "Method": {
                          "Type": "String",
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
                "Required": false
              },
              "NotifyThreshold": {
                "Type": "Number",
                "Description": {
                  "en": "The notification threshold, \nwhich will not be notified until the number of triggers is reached."
                },
                "Required": false,
                "Default": 1
              },
              "MuteUntil": {
                "Type": "Number",
                "Required": false
              },
              "Dashboard": {
                "Type": "String",
                "Description": {
                  "en": "Alarm associated dashboard. "
                },
                "Required": true
              },
              "Labels": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": true
                    },
                    "Key": {
                      "Type": "String",
                      "Required": true
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Description": {
                  "en": "The list of tags."
                },
                "Required": false
              },
              "GroupConfiguration": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Type": {
                      "Type": "String",
                      "Description": {
                        "en": "Grouping type.\nno_group: no grouping\nlabels_auto: autocustom: custom."
                      },
                      "AllowedValues": [
                        "no_group",
                        "labels_auto",
                        "custom"
                      ],
                      "Required": true
                    },
                    "Fields": {
                      "AssociationPropertyMetadata": {
                        "Parameter": {
                          "Type": "String",
                          "Required": false
                        }
                      },
                      "AssociationProperty": "List[Parameter]",
                      "Type": "Json",
                      "Description": {
                        "en": "The fields of group. Fill in the empty list when not group. No fill when group automatically. Fill required when group in custom."
                      },
                      "Required": false
                    }
                  }
                },
                "Type": "Json",
                "Required": false
              },
              "NoDataSeverity": {
                "Type": "Number",
                "Description": {
                  "en": "The alarm level when there is no data to trigger the alarm. Valid values:\n2: Report\n4: Low\n6: Medium\n8: High\n10: Critical."
                },
                "AllowedValues": [
                  2,
                  4,
                  6,
                  8,
                  10
                ],
                "Required": false
              },
              "Type": {
                "Type": "String",
                "Description": {
                  "en": "Configuration type."
                },
                "Required": false
              },
              "Annotations": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Value": {
                      "Type": "String",
                      "Required": true
                    },
                    "Key": {
                      "Type": "String",
                      "Required": true
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Description": {
                  "en": "The list of annotations."
                },
                "Required": false
              },
              "Version": {
                "Type": "String",
                "Description": {
                  "en": "Configuration version."
                },
                "Required": false
              },
              "JoinConfigurations": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Condition": {
                      "Type": "String",
                      "Description": {
                        "en": "Condition for a set operation. Not required when using Cartesian product."
                      },
                      "Required": false
                    },
                    "Type": {
                      "Type": "String",
                      "Description": {
                        "en": "The type of set operation join."
                      },
                      "AllowedValues": [
                        "cross_join",
                        "inner_join",
                        "left_join",
                        "right_join",
                        "full_join",
                        "left_exclude",
                        "right_exclude",
                        "concat",
                        "no_join"
                      ],
                      "Required": true
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Description": {
                  "en": "The list of Join conditions when multiple tables are joined. For example, 3 tables join, and 2 joinConfigurations are passed in."
                },
                "Required": false
              },
              "PolicyConfiguration": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "AlertPolicyId": {
                      "Type": "String",
                      "Description": {
                        "en": "The ID of alert policy."
                      },
                      "Required": false
                    },
                    "ActionPolicyId": {
                      "Type": "String",
                      "Description": {
                        "en": "The ID of action policy. It is useful when an alert policy references a dynamic action policy."
                      },
                      "Required": false
                    },
                    "UseDefault": {
                      "Type": "Boolean",
                      "Required": false
                    },
                    "RepeatInterval": {
                      "Type": "String",
                      "Description": {
                        "en": "Repeat interval. The format is number with suffix s/m/h."
                      },
                      "Required": false
                    }
                  }
                },
                "Type": "Json",
                "Required": false
              },
              "QueryList": {
                "AssociationPropertyMetadata": {
                  "Parameters": {
                    "Query": {
                      "Type": "String",
                      "Required": true
                    },
                    "LogStore": {
                      "Type": "String",
                      "Required": false
                    },
                    "Start": {
                      "Type": "String",
                      "Required": true
                    },
                    "TimeSpanType": {
                      "Type": "String",
                      "Required": true
                    },
                    "PowerSqlMode": {
                      "Type": "String",
                      "Required": false
                    },
                    "Store": {
                      "Type": "String",
                      "Description": {
                        "en": "When StoreType is log or metric, it indicates the LogStore to be queried.\nWhen StoreType is meta, it indicates the ResourceName to be queried."
                      },
                      "Required": false
                    },
                    "DashboardId": {
                      "Type": "String",
                      "Description": {
                        "en": "The ID of associated dashboard."
                      },
                      "Required": false
                    },
                    "RoleArn": {
                      "Type": "String",
                      "Description": {
                        "en": "ARN used by role access."
                      },
                      "Required": false
                    },
                    "StoreType": {
                      "Type": "String",
                      "Description": {
                        "en": "Log store type. Valid values:\nlog: sls query analysis statement\nmetric: sls time series data\nmeta: query metastore."
                      },
                      "AllowedValues": [
                        "log",
                        "metric",
                        "meta"
                      ],
                      "Required": false
                    },
                    "Project": {
                      "Type": "String",
                      "Required": false
                    },
                    "Region": {
                      "Type": "String",
                      "Required": false
                    },
                    "End": {
                      "Type": "String",
                      "Required": true
                    },
                    "ChartTitle": {
                      "Type": "String",
                      "Required": false
                    }
                  }
                },
                "AssociationProperty": "List[Parameters]",
                "Type": "Json",
                "Required": true
              },
              "SendResolved": {
                "Type": "Boolean",
                "Description": {
                  "en": "Whether to notify when the alarm is restored, the default is false."
                },
                "Required": false
              },
              "Threshold": {
                "Type": "Number",
                "Description": {
                  "en": "Trigger threshold."
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Required": true
        },
        "State": {
          "Type": "String",
          "Required": false,
          "Default": "Enabled"
        },
        "Schedule": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "DayOfWeek": {
                "Type": "Number",
                "Required": false
              },
              "Type": {
                "Type": "String",
                "Required": true
              },
              "RunImmediately": {
                "Type": "Boolean",
                "Required": false
              },
              "Hour": {
                "Type": "Number",
                "Required": false
              },
              "CronExpression": {
                "Type": "String",
                "Required": false
              },
              "Delay": {
                "Type": "Number",
                "Required": false
              },
              "Interval": {
                "Type": "String",
                "Description": {
                  "en": "Execution interval"
                },
                "Required": false
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The interval at which Log Service evaluates the alert rule. \nNote During an alert rule evaluation, if a query returns more than 100 log entries, \n Log Service checks only the first 100 log entries."
          },
          "Required": true
        },
        "DisplayName": {
          "Type": "String",
          "Description": {
            "en": "Alert name display in console. The name length is 1-64 characters."
          },
          "Required": true,
          "MinLength": 1,
          "MaxLength": 64
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Alert name."
          },
          "Required": true
        }
      }
    },
    "Label": {
      "en": "Detail",
      "zh-cn": "告警详情"
    }
  }
  EOT
}

resource "alicloud_log_alert" "alert" {
  project_name = var.project
}

output "name" {
  value       = alicloud_log_alert.alert.alert_name
  description = "Alert name."
}

