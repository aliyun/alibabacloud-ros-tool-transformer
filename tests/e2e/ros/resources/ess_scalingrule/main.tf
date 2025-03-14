variable "target_value" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "TargetTrackingScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "PredictiveScalingRule"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The target value of a metric. This parameter is required and applicable only to target tracking scaling rules and predictive scaling rules. The value of TargetValue must be greater than 0 and can have a maximum of three decimal places.",
      "zh-cn": "目标值，适用于目标追踪规则和预测规则。"
    },
    "Label": {
      "en": "Target Value",
      "zh-cn": "目标值"
    }
  }
  EOT
}

variable "cooldown" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "SimpleScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "Cool-down time of a scaling rule. Value range: [0, 86,400], in seconds. The default value is empty.",
      "zh-cn": "伸缩规则的冷却时间，仅适用于简单规则。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Cooldown (Seconds)",
      "zh-cn": "冷却时间（秒）"
    },
    "MaxValue": 86400
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ESS::AutoScalingGroup::AutoScalingGroupId",
    "Description": {
      "en": "ID of the scaling group of a scaling rule."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩规则所属的伸缩组ID"
    }
  }
  EOT
}

variable "predictive_value_behavior" {
  type        = string
  default     = "MaxOverridePredictiveValue"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "PredictiveValueOverrideMax": {
          "en": "Predictive Value Override Max",
          "zh-cn": "以预测值为准"
        },
        "PredictiveValueOverrideMaxWithBuffer": {
          "en": "Predictive Value Override Max With Buffer",
          "zh-cn": "以按比例增加后的预测值为准"
        },
        "MaxOverridePredictiveValue": {
          "en": "Max Override Predictive Value",
          "zh-cn": "以伸缩组实例数上限为准"
        }
      },
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "PredictiveScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The action taken on the predicted maximum value. Valid values:\n- MaxOverridePredictiveValue: uses the initial maximum capacity as the maximum value for forecast tasks when the predicted value is greater than the initial maximum capacity.\n - PredictiveValueOverrideMax: uses the predicted value as the maximum value for forecast tasks when the predicted value is greater than the initial maximum capacity.\n - PredictiveValueOverrideMaxWithBuffer: increases the predicted value with a ratio, which is specified by PredictiveValueBuffer. If the value after the increase is greater than the initial maximum capacity, the value after the increase is used as the maximum value for forecast tasks.\n Default value: MaxOverridePredictiveValue"
    },
    "AllowedValues": [
      "MaxOverridePredictiveValue",
      "PredictiveValueOverrideMax",
      "PredictiveValueOverrideMaxWithBuffer"
    ],
    "Label": {
      "en": "PredictiveValueBehavior",
      "zh-cn": "预测规则最大值处理方式"
    }
  }
  EOT
}

variable "min_adjustment_magnitude" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${ScalingRuleType}",
                    "SimpleScalingRule"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${ScalingRuleType}",
                    "StepScalingRule"
                  ]
                }
              ]
            },
            {
              "Fn::Equals": [
                "$${AdjustmentType}",
                "PercentChangeInCapacity"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The minimum number of ECS instances to be adjusted in a scaling rule. This parameter takes effect only when the scaling rule type is SimpleScalingRule or StepScalingRule and AdjustmentType is PercentChangeInCapacity."
    },
    "MinValue": 0,
    "Label": {
      "en": "MinAdjustmentMagnitude",
      "zh-cn": "伸缩规则最小调整实例数"
    },
    "MaxValue": 20
  }
  EOT
}

variable "disable_scale_in" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "TargetTrackingScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to disable scale-in. This parameter is applicable only to target tracking scaling rules.\n Default value: false",
      "zh-cn": "是否禁用缩容，仅适用于目标追踪规则。"
    },
    "Label": {
      "en": "Disable Scale In",
      "zh-cn": "是否禁止缩容"
    }
  }
  EOT
}

variable "step_adjustment" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MetricIntervalUpperBound": {
          "Type": "Number",
          "Description": {
            "en": "The upper limit value specified in step adjustment N.\nValid values: -9.999999E18 to 9.999999E18."
          },
          "Required": false,
          "MinValue": -9.999999e+18,
          "MaxValue": 9.999999e+18
        },
        "MetricIntervalLowerBound": {
          "Type": "Number",
          "Description": {
            "en": "The lower limit value specified in step adjustment N.\nValid values: -9.999999E18 to 9.999999E18."
          },
          "Required": false,
          "MinValue": -9.999999e+18,
          "MaxValue": 9.999999e+18
        },
        "ScalingAdjustment": {
          "Type": "Number",
          "Description": {
            "en": "The specified number of ECS instances to be adjusted in step adjustment."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 1000
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "StepScalingRule"
          ]
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "StepAdjustment",
      "zh-cn": "分步步骤"
    }
  }
  EOT
}

variable "adjustment_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "QuantityChangeInCapacity": {
          "en": "Quantity Change",
          "zh-cn": "增加或减少指定数量的ECS实例"
        },
        "TotalCapacity": {
          "en": "Total Capacity",
          "zh-cn": "将当前伸缩组的ECS实例数量调整到指定数量"
        },
        "PercentChangeInCapacity": {
          "en": "Percent Change",
          "zh-cn": "增加或减少指定比例的ECS实例"
        }
      },
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "SimpleScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "StepScalingRule"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Adjustment mode of a scaling rule. Optional values:\n- QuantityChangeInCapacity: It is used to increase or decrease a specified number of ECS instances.\n- PercentChangeInCapacity: It is used to increase or decrease a specified proportion of ECS instances.\n- TotalCapacity: It is used to adjust the quantity of ECS instances in the current scaling group to a specified value.",
      "zh-cn": "伸缩规则的调整方式，适用于简单规则和步进规则。"
    },
    "AllowedValues": [
      "QuantityChangeInCapacity",
      "PercentChangeInCapacity",
      "TotalCapacity"
    ],
    "Label": {
      "en": "Adjustment Type",
      "zh-cn": "调整方式"
    }
  }
  EOT
}

variable "metric_name" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "ClassicInternetRx": {
          "en": "Classic Internet Rx",
          "zh-cn": "经典网络公网入流量平均值"
        },
        "VpcInternetTx": {
          "en": "Vpc Internet Tx",
          "zh-cn": "专有网络公网出流量平均值"
        },
        "IntranetTx": {
          "en": "Intranet Tx",
          "zh-cn": "内网出流量平均值"
        },
        "VpcInternetRx": {
          "en": "Vpc Internet Rx",
          "zh-cn": "专有网络公网入流量平均值"
        },
        "CpuUtilization": {
          "en": "CPU Utilization",
          "zh-cn": "平均CPU使用率"
        },
        "ClassicInternetTx": {
          "en": "Classic Internet Tx",
          "zh-cn": "经典网络公网出流量平均值"
        },
        "IntranetRx": {
          "en": "Intranet Rx",
          "zh-cn": "内网入流量平均值"
        }
      },
      "AllowedValues": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${ScalingRuleType}",
              "TargetTrackingScalingRule"
            ]
          },
          "Value": [
            "CpuUtilization",
            "ClassicInternetRx",
            "ClassicInternetTx",
            "VpcInternetRx",
            "VpcInternetTx",
            "IntranetRx",
            "IntranetTx"
          ]
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${ScalingRuleType}",
              "PredictiveScalingRule"
            ]
          },
          "Value": [
            "CpuUtilization",
            "IntranetRx",
            "IntranetTx"
          ]
        }
      ],
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "TargetTrackingScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "PredictiveScalingRule"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The predefined metric to monitor. This parameter is required and applicable only to target tracking scaling rules and predictive scaling rules.\nValid values of a target tracking scaling rule:\n- CpuUtilization: the average CPU utilization- ClassicInternetRx: the average public network inbound traffic over the classic network\n- ClassicInternetTx: the average public network outbound traffic over the classic network\n- VpcInternetRx: the average public network inbound traffic over the VPC\n- VpcInternetTx: the average public network outbound traffic over the VPC\n- IntranetRx: the average internal network inbound traffic\n- IntranetTx: the average internal network outbound traffic\nValid values of a predictive scaling rule:\n- CpuUtilization: the average CPU utilization\n- IntranetRx: the average internal network inbound traffic\n- IntranetTx: the average internal network outbound traffic",
      "zh-cn": "预定义监控项，适用于目标追踪规则和预测规则。"
    },
    "AllowedValues": [
      "CpuUtilization",
      "ClassicInternetRx",
      "ClassicInternetTx",
      "VpcInternetRx",
      "VpcInternetTx",
      "IntranetRx",
      "IntranetTx"
    ],
    "Label": {
      "en": "Predefined Metric",
      "zh-cn": "预定义监控项"
    }
  }
  EOT
}

variable "scaling_rule_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name shown for the scaling group, which is a string containing 2 to 40 English or Chinese characters. It must begin with a number, a letter (case-insensitive) or a Chinese character and can contain numbers, \"_\", \"-\" or \".\". The account name in the same scaling group is unique in the same region. If this parameter value is not specified, the default value is ScalingRuleId."
    },
    "AllowedPattern": "^[a-zA-Z0-9\\u4e00-\\u9fa5][-_.a-zA-Z0-9\\u4e00-\\u9fa5]{1,63}$",
    "Label": {
      "en": "ScalingRuleName",
      "zh-cn": "伸缩规则的名称"
    }
  }
  EOT
}

variable "adjustment_value" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "SimpleScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "StepScalingRule"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "Adjusted value of a scaling rule. Value range:\n- QuantityChangeInCapacity: [-500, 500]\n- PercentChangeInCapacity: [-100, 10000]\n- TotalCapacity: [0, 1000]",
      "zh-cn": "伸缩规则的调整值，适用于简单规则和步进规则。"
    },
    "MinValue": -500,
    "Label": {
      "en": "Adjustment Value",
      "zh-cn": "调整值"
    },
    "MaxValue": 10000
  }
  EOT
}

variable "scale_out_evaluation_count" {
  type        = number
  default     = 3
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "TargetTrackingScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of consecutive times that the event-triggered task created for scale-out activities meets the threshold conditions before an alert is triggered. After a target tracking scaling rule is created, an event-triggered task is automatically created and then associated with the target tracking scaling rule.\nDefault value: 3.",
      "zh-cn": "指定对应的扩容报警任务触发报警时，需要连续满足阈值条件的次数。"
    },
    "Label": {
      "en": "Scale Out Evaluation Count",
      "zh-cn": "连续扩容报警阈值"
    }
  }
  EOT
}

variable "initial_max_size" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "PredictiveScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The maximum number of ECS instances in the scaling group, which is used together with PredictiveValueBehavior.\n Default value: the same as the value of MaxSize",
      "zh-cn": "伸缩组实例数上限，和PredictiveValueBehavior结合使用。"
    },
    "MinValue": 0,
    "Label": {
      "en": "InitialMaxSize",
      "zh-cn": "伸缩组实例数上限"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "scaling_rule_type" {
  type        = string
  default     = "SimpleScalingRule"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "TargetTrackingScalingRule": {
          "en": "Target Tracking Scaling Rule",
          "zh-cn": "目标追踪伸缩规则"
        },
        "PredictiveScalingRule": {
          "en": "Predictive Scaling Rule",
          "zh-cn": "预测伸缩规则"
        },
        "SimpleScalingRule": {
          "en": "Simple Scaling Rule",
          "zh-cn": "简单伸缩规则"
        },
        "StepScalingRule": {
          "en": "Step Scaling Rule",
          "zh-cn": "步进伸缩规则"
        }
      },
      "AutoChangeType": false
    },
    "Description": {
      "en": "The type of the scaling rule. Valid values:\n- SimpleScalingRule: scales ECS instances based on the values of AdjustmentType and AdjustmentValue.\n- TargetTrackingScalingRule: dynamically calculates the number of ECS instances to be adjusted and tries to keep the value of a predefined monitoring metric close to TargetValue.\n- StepScalingRule: scales ECS instances in steps based on specified thresholds and metric values.\n- PredictiveScalingRule: uses machine learning to analyze historical monitoring data of the scaling group and then predicts the future values of monitored metrics, the rule then automatically creates scheduled tasks to set the boundary values for the scaling group.\n If this parameter value is not specified, the default value is SimpleScalingRule."
    },
    "AllowedValues": [
      "SimpleScalingRule",
      "TargetTrackingScalingRule",
      "StepScalingRule",
      "PredictiveScalingRule"
    ],
    "Label": {
      "en": "Scaling Rule Type",
      "zh-cn": "伸缩规则类型"
    }
  }
  EOT
}

variable "estimated_instance_warmup" {
  type        = number
  default     = 300
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Or": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "TargetTrackingScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "StepScalingRule"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The warm-up period of the ECS instances. This parameter is applicable to target tracking scaling rules and step scaling rules. The system adds ECS instances that are in the warm-up state to the scaling group, but does not report monitoring data during the warm-up period to CloudMonitor.\nNote: When calculating the number of ECS instances to be adjusted, the system does not count ECS instances in the warm-up state as part of the current capacity of the scaling group.\nValid values: 0 to 86400. Unit: seconds. Default value: 300.",
      "zh-cn": "实例预热时间，适用于目标追踪规则和步进规则。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Estimated Instance Warmup (Seconds)",
      "zh-cn": "预热时间（秒）"
    },
    "MaxValue": 86400
  }
  EOT
}

variable "predictive_scaling_mode" {
  type        = string
  default     = "PredictAndScale"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "PredictOnly": {
          "en": "Predict Only",
          "zh-cn": "产生预测结果，但不会创建预测任务。"
        },
        "PredictAndScale": {
          "en": "Predict and Scale",
          "zh-cn": "产生预测结果并创建预测任务"
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "PredictiveScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The mode of the predictive scaling rule. Valid values:\n- PredictAndScale: generates forecasts and creates forecast tasks.\n- PredictOnly: generates forecasts but does not create forecast tasks.\nDefault value: PredictAndScale"
    },
    "AllowedValues": [
      "PredictAndScale",
      "PredictOnly"
    ],
    "Label": {
      "en": "Predictive Scaling Mode",
      "zh-cn": "预测模式"
    }
  }
  EOT
}

variable "predictive_task_buffer_time" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "PredictiveScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The amount of buffer time ahead of the forecast task execution time. By default, all scheduled tasks that are automatically created for a predictive scaling rule are executed at the beginning of each hour. You can set a buffer time to execute forecast tasks ahead of schedule, so that resources can be prepared in advance. Valid values: 0 to 60. Unit: minutes.\n Default value: 0",
      "zh-cn": "预测规则自动创建的预测任务，默认在整点执行。您可以设置预启动时间提前执行预测任务，预先准备资源。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Predictive Task Buffer Time",
      "zh-cn": "预启动时间"
    },
    "MaxValue": 60
  }
  EOT
}

variable "predictive_value_buffer" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${ScalingRuleType}",
                "PredictiveScalingRule"
              ]
            },
            {
              "Fn::Equals": [
                "$${PredictiveValueBehavior}",
                "PredictiveValueOverrideMaxWithBuffer"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The ratio of the increment to the predicted value when PredictiveValueBehavior is set to PredictiveValueOverrideMaxWithBuffer. When the value after the increase is greater than the initial maximum capacity, the value after the increase is used for forecast tasks. Valid values: 0 to 100\n Default value: 0",
      "zh-cn": "PredictiveValueBehavior为PredictiveValueOverrideMaxWithBuffer时生效，预测值会按照该比例增加，当增加后的值大于初始最大值时，会采用增加后的值。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Predictive Value Buffer",
      "zh-cn": "预测值增加比例"
    },
    "MaxValue": 100
  }
  EOT
}

variable "scale_in_evaluation_count" {
  type        = number
  default     = 15
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${ScalingRuleType}",
            "TargetTrackingScalingRule"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of consecutive times that the event-triggered task created for scale-in activities meets the threshold conditions before an alert is triggered. After a target tracking scaling rule is created, an event-triggered task is automatically created and then associated with the target tracking scaling rule.\nDefault value: 15.",
      "zh-cn": "指定对应的缩容报警任务触发报警时，需要连续满足阈值条件的次数。"
    },
    "Label": {
      "en": "Scale In Evaluation Count",
      "zh-cn": "连续缩容报警阈值"
    }
  }
  EOT
}

resource "alicloud_ess_scaling_rule" "scaling_rule" {
  target_value                = var.target_value
  cooldown                    = var.cooldown
  scaling_group_id            = var.scaling_group_id
  predictive_value_behavior   = var.predictive_value_behavior
  min_adjustment_magnitude    = var.min_adjustment_magnitude
  disable_scale_in            = var.disable_scale_in
  step_adjustment             = var.step_adjustment
  adjustment_type             = var.adjustment_type
  metric_name                 = var.metric_name
  scaling_rule_name           = var.scaling_rule_name
  adjustment_value            = var.adjustment_value
  scale_out_evaluation_count  = var.scale_out_evaluation_count
  initial_max_size            = var.initial_max_size
  scaling_rule_type           = var.scaling_rule_type
  estimated_instance_warmup   = var.estimated_instance_warmup
  predictive_scaling_mode     = var.predictive_scaling_mode
  predictive_task_buffer_time = var.predictive_task_buffer_time
  predictive_value_buffer     = var.predictive_value_buffer
  scale_in_evaluation_count   = var.scale_in_evaluation_count
}

output "scaling_rule_ari" {
  // Could not transform ROS Attribute ScalingRuleAri to Terraform attribute.
  value       = null
  description = "Unique identifier of a scaling rule."
}

output "scaling_rule_id" {
  value       = alicloud_ess_scaling_rule.scaling_rule.id
  description = "ID of a scaling rule, generated by the system and globally unique."
}

