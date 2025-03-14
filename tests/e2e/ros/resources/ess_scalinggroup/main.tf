variable "spot_instance_remedy" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to supplement preemptible instances. If this parameter is set to true, Auto Scaling attempts to create an instance to replace a preemptible instance when Auto Scaling receives a system message which indicates that the preemptible instance is to be reclaimed."
    },
    "Label": {
      "en": "SpotInstanceRemedy",
      "zh-cn": "是否开启补齐抢占式实例"
    }
  }
  EOT
}

variable "resource_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
    "Description": {
      "en": "Resource group id."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "compensate_with_on_demand" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically create pay-as-you-go instances to meet the requirements on the number of instances when the expected capacity of preemptible instances cannot be fulfilled due to reasons such as high prices or insufficient resources. This parameter takes effect only when MultiAZPolicy is set to COST_OPTIMIZED.\nDefault value: true."
    },
    "Label": {
      "en": "CompensateWithOnDemand",
      "zh-cn": "是否允许自动尝试创建满足ECS实例数要求的按量实例"
    }
  }
  EOT
}

variable "server_groups" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The type of the server group."
          },
          "AllowedValues": [
            "ALB",
            "NLB"
          ],
          "Required": true
        },
        "Port": {
          "Type": "Number",
          "Description": {
            "en": "The port of server group."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 65535
        },
        "ServerGroupId": {
          "Type": "String",
          "Description": {
            "en": "The id of the server group."
          },
          "Required": true
        },
        "Weight": {
          "Type": "Number",
          "Description": {
            "en": "The weight of server group."
          },
          "Required": true,
          "MinValue": 0,
          "MaxValue": 100
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The config of server group."
    },
    "Label": {
      "en": "ServerGroups",
      "zh-cn": "负载均衡服务器组的配置"
    },
    "MaxLength": 10
  }
  EOT
}

variable "notification_configurations" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "NotificationArn": {
              "Type": "String",
              "Description": {
                "en": "The format of the parameter value is acs:ess:{region}:{account-id}:{resource-relative-id}.\nregion: the region to which the scaling group locates\naccount-id: Alibaba Cloud ID\nFor example:\nMNS queue: acs:ess:{region}:{account-id}:queue/{queuename}\nMNS topic: acs:ess:{region}:{account-id}:topic/{topicname}\nCloud Monitor: acs:ess:{region}:{account-id}:/cloudmonitor"
              },
              "AllowedPattern": "^acs:ess:([a-zA-Z0-9-]+):(\\d+):(((queue|topic)/([a-zA-Z0-9][a-zA-Z0-9-]{0,255}))|cloudmonitor)$",
              "Required": true,
              "MaxLength": 300
            },
            "NotificationTypes": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "Ess events and resource change notification types. Possible values:\nAUTOSCALING:SCALE_OUT_SUCCESS\nAUTOSCALING:SCALE_IN_SUCCESS\nAUTOSCALING:SCALE_OUT_ERROR\nAUTOSCALING:SCALE_IN_ERROR\nAUTOSCALING:SCALE_REJECT\nAUTOSCALING:SCALE_OUT_START\nAUTOSCALING:SCALE_IN_START\nAUTOSCALING:SCHEDULE_TASK_EXPIRING"
              },
              "Required": true,
              "MinLength": 1,
              "MaxLength": 8
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "Notification Configurations"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "When a scaling event occurs in a scaling group, ESS will send a notification to Cloud Monitor or MNS."
    },
    "Label": {
      "en": "NotificationConfigurations",
      "zh-cn": "事件及资源变化通知的配置列表"
    }
  }
  EOT
}

variable "on_demand_percentage_above_base_capacity" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The percentage of pay-as-you-go instances that can be created when instances are added to the scaling group. This parameter takes effect when the number of pay-as-you-go instances reaches the value for the OnDemandBaseCapacity parameter. Valid values: 0 to 100.\nIf you set MultiAZPolicy to COMPOSABLE, the default value of this parameter is 100."
    },
    "MinValue": 0,
    "Label": {
      "en": "OnDemandPercentageAboveBaseCapacity",
      "zh-cn": "超出的实例中按量实例应占的比例"
    },
    "MaxValue": 100
  }
  EOT
}

variable "desired_capacity" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The expected number of ECS instances in a scaling group. The scaling group automatically keeps the number of ECS instances as expected. The number of ECS instances cannot be greater than the value of MaxSize and cannot be less than the value of MinSize.",
      "zh-cn": "伸缩组内ECS实例的期望数量，伸缩组会自动将ECS实例数量维持在期望实例数。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Expected Number of Instances",
      "zh-cn": "组内期望实例数"
    }
  }
  EOT
}

variable "allocation_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "AllocationStrategy"
    },
    "Description": {
      "en": "The allocation policy of instances. Auto Scaling selects instance types based on the allocation policy to create the required number of instances. The policy can be applied to pay-as-you-go instances and preemptible instances. This parameter takes effect only if you set MultiAZPolicy to COMPOSABLE. Valid values:\n- priority: Auto Scaling selects instance types based on the specified order to create the required number of instances.\n- lowestPrice: Auto Scaling selects instance types that have the lowest unit price of vCPUs to create the required number of instances.\nDefault value: priority."
    },
    "AllowedValues": [
      "priority",
      "lowestPrice"
    ],
    "Label": {
      "en": "AllocationStrategy",
      "zh-cn": "容量分配策略"
    }
  }
  EOT
}

variable "on_demand_base_capacity" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The minimum number of pay-as-you-go instances required in the scaling group. Valid values: 0 to 1000. If the number of pay-as-you-go instances is less than the value of this parameter, Auto Scaling preferentially creates pay-as-you-go instances.\nIf you set MultiAZPolicy to COMPOSABLE Policy, the default value of this parameter is 0."
    },
    "MinValue": 0,
    "Label": {
      "en": "OnDemandBaseCapacity",
      "zh-cn": "伸缩组所需要按量实例个数的最小值"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "launch_template_overrides" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "WeightedCapacity": {
          "Type": "Number",
          "Description": {
            "en": "If you want to scale instances in the scaling group based on the weights of the specified instance types, you must specify WeightedCapacity after you specify InstanceType."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 500
        },
        "SpotPriceLimit": {
          "Type": "Number",
          "Description": {
            "en": "The maximum bid price of instance type that is specified by InstanceType."
          },
          "Required": false
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "Specify this to override the instance type that is specified in the launch template."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "You can specify up to 10 overrides.\nNote: This parameter takes effect only if you specify LaunchTemplateId."
    },
    "Label": {
      "en": "LaunchTemplateOverrides",
      "zh-cn": "扩展启动模板的实例规格信息"
    },
    "MaxLength": 10
  }
  EOT
}

variable "removal_policys" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
      "Parameter": {
        "AssociationPropertyMetadata": {
          "AutoChangeType": false,
          "LocaleKey": "ESSRemovalPolicys"
        },
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Policy for removing ECS instances from the scaling group.\nOptional values:\n- OldestInstance: removes the first ECS instance attached to the scaling group.\n- NewestInstance: removes the first ECS instance attached to the scaling group.\n- OldestScalingConfiguration: removes the ECS instance with the oldest scaling configuration.\n- CustomPolicy: removes ECS instances based on the custom scale-in policy (Function).\nYou can enter up to three removal policies.\nYou cannot set any item of RemovalPolicys to the same value.\nThe scaling configuration source specified by the OldestScalingConfiguration setting can be a scaling configuration or a launch template. You can specify CustomPolicy only as the value of first item of RemovalPolicys. If you set first item of RemovalPolicys to CustomPolicy, you must also specify CustomPolicyARN.\nNote: The removal of ECS instances from a scaling group is also affected by the value of MultiAZPolicy."
    },
    "Label": {
      "en": "Removal Policies",
      "zh-cn": "实例移出策略"
    },
    "MaxLength": 3
  }
  EOT
}

variable "spot_allocation_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "AllocationStrategy"
    },
    "Description": {
      "en": "The allocation policy of preemptible instances. You can use this parameter to individually specify the allocation policy of preemptible instances. This parameter takes effect only if you set MultiAZPolicy to COMPOSABLE. Valid values:\n- priority: Auto Scaling selects instance types based on the specified order to create the required number of preemptible instances.\n- lowestPrice: Auto Scaling selects instance types that have the lowest unit price of vCPUs to create the required number of preemptible instances.\nDefault value: priority."
    },
    "AllowedValues": [
      "priority",
      "lowestPrice"
    ],
    "Label": {
      "en": "SpotAllocationStrategy",
      "zh-cn": "抢占式容量分布策略"
    }
  }
  EOT
}

variable "tags" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Value": {
          "Type": "String",
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Key",
          "Value"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Tags to attach to instance. Max support 20 tags to add during create instance. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "scaling_policy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ScalingPolicy"
    },
    "Description": {
      "en": "The reclaim mode of the scaling group. Valid values:\nrecycle\nrelease\nforcerelease\nScalingPolicy specifies the reclaim modes of scaling groups, but the policy that is used to remove ECS instances from scaling groups is determined by the RemovePolicy parameter of the RemoveInstances operation."
    },
    "AllowedValues": [
      "recycle",
      "release",
      "forcerelease"
    ],
    "Label": {
      "en": "ScalingPolicy",
      "zh-cn": "指定伸缩组的回收模式"
    }
  }
  EOT
}

variable "vswitch_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
      "Parameter": {
        "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Parameter VSwitchIds.N is used to create instance in multiple zones. Parameter VSwitchIds.N has a priority over parameter VSwitchId.\nThe valid range of N is [1, 8], and you can specify at most 5 VSwitches in a VPC.\nThe priority of VSwitches descends from 1 to 8, and 1 indicates the highest priority.\nWhen you fail to create an instance in the zone to which a specified VSwitch belongs, another VSwitch with less priority replaces the specified one automatically."
    },
    "Label": {
      "en": "VSwitchIds",
      "zh-cn": "多个交换机ID"
    },
    "MinLength": 0,
    "MaxLength": 8
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${GroupType}",
            "ECS"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "The ID of the ECS instance from which the scaling group obtains configuration information of the specified instance.",
      "zh-cn": "ECS实例的ID。创建伸缩组时，将从指定的实例获取所需的配置信息，并自动创建伸缩配置。"
    },
    "Label": {
      "en": "ECS Instance Id",
      "zh-cn": "ECS实例ID"
    }
  }
  EOT
}

variable "load_balancer_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
      "Parameter": {
        "AssociationProperty": "ALIYUN::SLB::LoadBalancer::LoadBalancerId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "ID list of a Server Load Balancer instance. A Json Array with format: [ \"lb-id0\", \"lb-id1\", ... \"lb-idz\" ], support up to 100 Load Balancer instance."
    },
    "Label": {
      "en": "Associated CLB(formerly SLB)",
      "zh-cn": "关联传统型负载均衡CLB（原SLB）"
    },
    "MaxLength": 100
  }
  EOT
}

variable "spot_instance_pools" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of instance types that are available. The system creates preemptible instances of multiple instance types that are available at the lowest cost in the scaling group. Valid values: 1 to 10.\nIf you set MultiAZPolicy to COMPOSABLE, the default value of this parameter is 2."
    },
    "MinValue": 1,
    "Label": {
      "en": "SpotInstancePools",
      "zh-cn": "指定可用实例规格的个数"
    },
    "MaxValue": 10
  }
  EOT
}

variable "group_deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable deletion protection for scaling group.\nDefault to False."
    },
    "Label": {
      "en": "GroupDeletionProtection",
      "zh-cn": "是否开启伸缩组删除保护"
    }
  }
  EOT
}

variable "launch_template_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::LaunchTemplate::LaunchTemplateId",
    "Description": {
      "en": "The ID of the instance launch template from which the scaling group obtains launch configurations.",
      "zh-cn": "实例启动模板ID，用于指定伸缩组从实例启动模板获取启动配置信息。"
    },
    "Label": {
      "en": "LaunchTemplateId",
      "zh-cn": "实例启动模板ID"
    }
  }
  EOT
}

variable "custom_policyarn" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The Alibaba Cloud Resource Name (ARN) of the custom scale-in policy (Function). This parameter takes effect only if you specify CustomPolicy as the value of first item of RemovalPolicys."
    },
    "Label": {
      "en": "CustomPolicyARN",
      "zh-cn": "自定义缩容策略Function函数ARN"
    }
  }
  EOT
}

variable "max_size" {
  type        = number
  default     = 1
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Maximum number of ECS instances in the scaling group. Value range: [0, 2000]."
    },
    "MinValue": 0,
    "Label": {
      "en": "Maximum Number of Instances",
      "zh-cn": "组内最大实例数"
    },
    "MaxValue": 2000
  }
  EOT
}

variable "scaling_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name shown for the scaling group, which must contain 2-40 characters (English or Chinese). The name must begin with a number, an upper/lower-case letter or a Chinese character and may contain numbers, \"_\", \"-\" or \".\". The account name is unique in the same region.\nIf this parameter is not specified, the default value is ScalingGroupId."
    },
    "AllowedPattern": "^[a-zA-Z0-9\\u4e00-\\u9fa5][-_.a-zA-Z0-9\\u4e00-\\u9fa5]{1,63}$",
    "Label": {
      "en": "Scaling Group Name",
      "zh-cn": "伸缩组名称"
    }
  }
  EOT
}

variable "min_size" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Minimum number of ECS instances in the scaling group. Value range: [0, 2000]."
    },
    "MinValue": 0,
    "Label": {
      "en": "Minimum Number of Instances",
      "zh-cn": "组内最小实例数"
    },
    "MaxValue": 2000
  }
  EOT
}

variable "default_cooldown" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "During a cooling down period after a scaling activity (adding or removing instances) is completed, the scaling group does not perform other scaling activities. It is currently only valid for scaling activities triggered by alarm tasks (cloud monitoring).",
      "zh-cn": "一个伸缩活动（添加或移出实例）执行完成后的一段冷却时间内，该伸缩组不执行其他的伸缩活动。目前仅针对报警任务（云监控）触发的伸缩活动有效。"
    },
    "MinValue": 0,
    "Label": {
      "en": "Default Cooldown Period",
      "zh-cn": "默认冷却时间"
    },
    "MaxValue": 86400
  }
  EOT
}

variable "az_balance" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to evenly distribute instances in the scaling group across multiple zones. This parameter takes effect only if you set MultiAZPolicy to COMPOSABLE. Valid values:\n- true\n- false\nDefault value: false."
    },
    "Label": {
      "en": "AzBalance",
      "zh-cn": "伸缩组的容量是否在多个可用区间均衡分布"
    }
  }
  EOT
}

variable "group_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of instances that are managed by the scaling group. Valid values:\nECS\nECI\nDefault value: ECS."
    },
    "AllowedValues": [
      "ECS",
      "ECI"
    ],
    "Label": {
      "en": "GroupType",
      "zh-cn": "伸缩组管理的实例类型"
    }
  }
  EOT
}

variable "launch_template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of the instance launch template. Valid values:\nA fixed template version numbe.\nDefault: The default template version is always used.\nLatest: The latest template version is always used."
    },
    "Label": {
      "en": "Launch Template Version",
      "zh-cn": "实例启动模板版本"
    }
  }
  EOT
}

variable "multiazpolicy" {
  type        = string
  default     = "PRIORITY"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "ESSMultiAZPolicy"
    },
    "Description": {
      "en": "ECS scaling strategy for multi availability zone. Allow value:\n1. PRIORITY: scaling the capacity according to the virtual switch (VSwitchIds.N) you define. ECS instances are automatically created using the next priority virtual switch when the higher priority virtual switch cannot be created in the available zone.\n2. BALANCE: evenly allocate ECS instances between the multiple available zone specified by the scaling group.\n3. COST_OPTIMIZED: During a scale-out activity, Auto Scaling attempts to create ECS instances that have vCPUs provided at the lowest price. During a scale-in activity, Auto Scaling attempts to remove ECS instances that have vCPUs provided at the highest price. Preemptible instances are preferentially created when preemptible instance types are specified in the active scaling configuration. You can configure the CompensateWithOnDemand parameter to specify whether to automatically create pay-as-you-go instances when preemptible instances cannot be created due to insufficient resources.\nNote COST_OPTIMIZED is valid when multiple instance types are specified or at least one preemptible instance type is specified.\n4. COMPOSABLE: You can flexibly combine the preceding policies based on your business requirements."
    },
    "AllowedValues": [
      "PRIORITY",
      "BALANCE",
      "COST_OPTIMIZED",
      "COMPOSABLE"
    ],
    "Label": {
      "en": "Scaling Strategies",
      "zh-cn": "扩缩容策略"
    }
  }
  EOT
}

variable "container_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${GroupType}",
            "ECI"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECI::ContainerGroup::ContainerGroupId",
    "Description": {
      "en": "The ID of the elastic container instance."
    },
    "Label": {
      "en": "ContainerGroupId",
      "zh-cn": "ECI实例ID"
    }
  }
  EOT
}

variable "dbinstance_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
      "Parameter": {
        "AssociationProperty": "ALIYUN::RDS::Instance::InstanceId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "ID list of an RDS instance. A Json Array with format: [ \"rm-id0\", \"rm-id1\", ... \"rm-idz\" ], support up to 100 RDS instance."
    },
    "Label": {
      "en": "Associated RDS Instance",
      "zh-cn": "关联RDS数据库实例"
    },
    "MaxLength": 100
  }
  EOT
}

variable "health_check_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The health check type. Allow values is \"ECS\" and \"NONE\", default to \"ECS\"."
    },
    "AllowedValues": [
      "ECS",
      "NONE"
    ],
    "Label": {
      "en": "HealthCheckType",
      "zh-cn": "健康检查类型"
    }
  }
  EOT
}

variable "max_instance_lifetime" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The maximum life span of an ECS instance in the scaling group. Unit: seconds.\nValid values: 86400 to the value of Integer.maxValue.\nDefault value: null.\nNote: This parameter is unavailable for scaling groups of the ECI type or scaling groups whose ScalingPolicy is set to recycle."
    },
    "MinValue": 86400,
    "Label": {
      "en": "MaxInstanceLifetime",
      "zh-cn": "实例在伸缩组中存活的最大时间"
    }
  }
  EOT
}

resource "alicloud_ess_scaling_group" "scaling_group" {
  spot_instance_remedy                     = var.spot_instance_remedy
  resource_group_id                        = var.resource_group_id
  on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
  desired_capacity                         = var.desired_capacity
  allocation_strategy                      = var.allocation_strategy
  on_demand_base_capacity                  = var.on_demand_base_capacity
  removal_policies                         = var.removal_policys
  spot_allocation_strategy                 = var.spot_allocation_strategy
  tags                                     = var.tags
  scaling_policy                           = var.scaling_policy
  vswitch_ids                              = var.vswitch_ids
  instance_id                              = var.instance_id
  loadbalancer_ids                         = var.load_balancer_ids
  spot_instance_pools                      = var.spot_instance_pools
  group_deletion_protection                = var.group_deletion_protection
  launch_template_id                       = var.launch_template_id
  max_size                                 = var.max_size
  scaling_group_name                       = var.scaling_group_name
  min_size                                 = var.min_size
  default_cooldown                         = var.default_cooldown
  az_balance                               = var.az_balance
  group_type                               = var.group_type
  launch_template_version                  = var.launch_template_version
  multi_az_policy                          = var.multiazpolicy
  db_instance_ids                          = var.dbinstance_ids
  health_check_type                        = var.health_check_type
  max_instance_lifetime                    = var.max_instance_lifetime
}

output "scaling_group_id" {
  value       = alicloud_ess_scaling_group.scaling_group.id
  description = "Scaling group Id"
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "scaling_group_name" {
  value       = alicloud_ess_scaling_group.scaling_group.scaling_group_name
  description = "Scaling group name"
}

