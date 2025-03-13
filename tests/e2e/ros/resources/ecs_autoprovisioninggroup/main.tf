variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the auto provisioning group."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "弹性供应组的描述信息"
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
      "en": "The resource group ID."
    }
  }
  EOT
}

variable "check_execution_status" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether check execution status. If set true, ROS will check the state of AutoProvisioningGroup to be fulfilled. Otherwise ROS will regard AutoProvisioningGroup create failed."
    },
    "Label": {
      "en": "CheckExecutionStatus",
      "zh-cn": "是否检查执行状态"
    }
  }
  EOT
}

variable "auto_provisioning_group_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the auto provisioning group. Valid values:\nrequest: One-time delivery. After the auto provisioning group is started, it only attempts\nto create an instance cluster once. If the cluster fails to be created, the group\ndoes not try again.\nmaintain: The continuous delivery and maintain capacity type. After the auto provisioning group\nis started, it continuously attempts to create and maintain the instance cluster.\nThe auto provisioning group compares the real-time and target capacity of the cluster.\nIf the cluster does not meet the target capacity, the group will create instances\nuntil the cluster meets the target capacity.\nDefault value: maintain"
    },
    "AllowedValues": [
      "maintain",
      "request"
    ],
    "Label": {
      "en": "AutoProvisioningGroupType",
      "zh-cn": "弹性供应组的交付类型"
    }
  }
  EOT
}

variable "default_target_capacity_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of supplemental instances. When the total value of PayAsYouGoTargetCapacity and SpotTargetCapacity is smaller than the value of TotalTargetCapacity, the auto provisioning group will create instances of the specified type to meet\nthe capacity requirements. Valid values:\nPayAsYouGo: Pay-as-you-go instances.\nSpot: Preemptible instances.\nDefault value: Spot",
      "zh-cn": "PayAsYouGoTargetCapacity和SpotTargetCapacity之和小于TotalTargetCapacity时，指定差额容量的计费方式。"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Spot"
    ],
    "Label": {
      "en": "DefaultTargetCapacityType",
      "zh-cn": "PayAsYouGoTargetCapacity和SpotTargetCapacity之和小于TotalTargetCapacity时"
    }
  }
  EOT
}

variable "launch_configuration" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceGroupId": {
          "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
          "Type": "String",
          "Description": {
            "en": "The ID of the resource group to which to assign the instance."
          },
          "Required": false
        },
        "SystemDiskSize": {
          "Type": "Number",
          "Description": {
            "en": "The size of the system disk. Unit: GiB. Valid values: 20 to 500."
          },
          "Required": false
        },
        "UserData": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The user data of the instance."
          },
          "Required": false
        },
        "SystemDiskDescription": {
          "Type": "String",
          "Description": {
            "en": "The description of the system disk. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
          },
          "Required": false
        },
        "SystemDiskProvisionedIops": {
          "Type": "Number",
          "Description": {
            "en": "The provisioned IOPS."
          },
          "Required": false
        },
        "SystemDiskEncrypted": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the disk is encrypted."
          },
          "Required": false
        },
        "SystemDiskName": {
          "Type": "String",
          "Description": {
            "en": "The name of the system disk. The name must be 2 to 128 characters in length. It must start with a letter but cannot start with http:// or https://. It can contain letters, digits, periods (.), colons (:), underscores (_), and hyphens (-)."
          },
          "Required": false
        },
        "RamRoleName": {
          "Type": "String",
          "Description": {
            "en": "The name of the RAM role."
          },
          "Required": false
        },
        "SystemDiskPerformanceLevel": {
          "Type": "String",
          "Description": {
            "en": "The performance level of the ESSD used as the system disk. Default value: PL0. Valid values:\nPL0: A single ESSD can deliver up to 10,000 random read/write IOPS.\nPL1: A single ESSD can deliver up to 50,000 random read/write IOPS.\nPL2: A single ESSD can deliver up to 100,000 random read/write IOPS.\nPL3: A single ESSD can deliver up to 1,000,000 random read/write IOPS."
          },
          "Required": false
        },
        "ImageId": {
          "Type": "String",
          "Description": {
            "en": "Image ID."
          },
          "Required": true
        },
        "HostNames": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Specify different host names for one or more instances. The limitations are as follows:\nOnly create one-time synchronous delivery type elastic supply group (AutoProvisioningGroupType = instant), the parameters to take effect.\nN is the number of instances, ranging from 1 to 1000 and matching the TotalTargetCapacity parameter.\nHalf-angular period (.) The and dash (-) are not allowed to start or end characters, nor can they be used continuously.\nWindows example: Character length 2 to 15, does not support half-corner period (.) It can't be all numbers. Allows upper - and lowercase letters, numbers, and a dash (-).\nOther type instances (Linux, etc.) : Character lengths from 2 to 64, support multiple half-angular periods (.) Half-angular period (.) Each paragraph is allowed to contain upper - and lowercase letters, numbers, and a dash (-).\nDoes not support at the same time set up LaunchConfiguration. The HostName and LaunchConfiguration. HostNames. N, otherwise it will return an error message.\nWhen specifying both the launch template and the launch configuration information, the launch template is preferred."
          },
          "Required": false,
          "MaxLength": 1000
        },
        "HostName": {
          "Type": "String",
          "Description": {
            "en": "The hostname of the instance."
          },
          "Required": false
        },
        "PasswordInherit": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to use the password preset in the image."
          },
          "Required": false
        },
        "KeyPairName": {
          "Type": "String",
          "Description": {
            "en": "The name of the key pair to be bound to the instance."
          },
          "Required": false
        },
        "IoOptimized": {
          "Type": "String",
          "Description": {
            "en": "Specifies whether the instance is I/O optimized. Valid values:\nnone: The instance is not I/O optimized.\noptimized: The instance is I/O optimized."
          },
          "AllowedValues": [
            "optimized",
            "none"
          ],
          "Required": false
        },
        "SystemDiskKMSKeyId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the KMS key."
          },
          "Required": false
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "Security group ID."
          },
          "Required": true
        },
        "ImageFamily": {
          "Type": "String",
          "Description": {
            "en": "The image family."
          },
          "Required": false
        },
        "SecurityGroupIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}"
              },
              "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
              "Type": "String",
              "Description": {
                "en": "The security group ID to which the instance belongs. When specifying both the launch template and the launch configuration information, the launch template is preferred."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "A list of security groups to which the instance belongs."
          },
          "Required": false,
          "MaxLength": 16
        },
        "InternetChargeType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "InternetChargeType"
          },
          "Type": "String",
          "Description": {
            "en": "The billing method for network usage. Default value: PayByTraffic. Valid values:\nPayByBandwidth\nPayByTraffic"
          },
          "Required": false
        },
        "SystemDiskCategory": {
          "Type": "String",
          "Description": {
            "en": "The category of the system disk. Valid values:\ncloud_efficiency: ultra disk\ncloud_ssd: standard SSD\ncloud_essd: enhanced SSD (ESSD)\ncloud: basic disk"
          },
          "Required": false
        },
        "InstanceName": {
          "Type": "String",
          "Description": {
            "en": "The name of the instance."
          },
          "Required": false
        },
        "SystemDiskBurstingEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether bursting is enabled."
          },
          "Required": false
        },
        "DeploymentSetId": {
          "Type": "String",
          "Description": {
            "en": "The deployment set ID."
          },
          "Required": false
        },
        "DataDisk": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "BurstingEnabled": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to enable the bursting feature for the data disk."
                },
                "Required": false
              },
              "Category": {
                "Type": "String",
                "Description": {
                  "en": "The category of data disk. Valid values:\ncloud_efficiency: ultra disk\ncloud_ssd: standard SSD\ncloud_essd: ESSD\ncloud: basic disk"
                },
                "Required": false
              },
              "Description": {
                "AssociationProperty": "TextArea",
                "Type": "String",
                "Description": {
                  "en": "The description of data disk N. The description must be 2 to 256 characters in length and cannot start with http:// or https://."
                },
                "Required": false
              },
              "KmsKeyId": {
                "Type": "String",
                "Description": {
                  "en": "The ID of the KMS key to be used by data disk"
                },
                "Required": false
              },
              "Encrypted": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to encrypt data disk. Default value: false"
                },
                "Required": false
              },
              "Device": {
                "Type": "String",
                "Description": {
                  "en": "The mount point of the data disk. When specifying both the launch template and the launch configuration information, the launch template is preferred."
                },
                "Required": false
              },
              "PerformanceLevel": {
                "Type": "String",
                "Description": {
                  "en": "The performance level of the ESSD used as data disk. Default value: PL1. Valid values:\nPL0: A single ESSD can deliver up to 10,000 random read/write IOPS.\nPL1: A single ESSD can deliver up to 50,000 random read/write IOPS.\nPL2: A single ESSD can deliver up to 100,000 random read/write IOPS.\nPL3: A single ESSD can deliver up to 1,000,000 random read/write IOPS."
                },
                "Required": false
              },
              "Size": {
                "Type": "Number",
                "Description": {
                  "en": "The size of data disk"
                },
                "Required": false
              },
              "DeleteWithInstance": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to release data disk when the instance is released. Default value: true"
                },
                "Required": false
              },
              "ProvisionedIops": {
                "Type": "Number",
                "Description": {
                  "en": "ESSD AutoPL preconfigured read and write IOPS for cloud disk. Possible values: 0-min {50,000, 1000* capacity - baseline performance}.\nBaseline performance =min{1,800+50* capacity, 50000}."
                },
                "Required": false
              },
              "DiskName": {
                "Type": "String",
                "Description": {
                  "en": "The name of data disk N. The name must be 2 to 128 characters in length. It must start with a letter but cannot start with http:// or https://. It can contain letters, digits, periods (.), colons (:), underscores (_), and hyphens (-)."
                },
                "Required": false
              },
              "InternetChargeType": {
                "AssociationPropertyMetadata": {
                  "LocaleKey": "InternetChargeType"
                },
                "Type": "String",
                "Description": {
                  "en": "The billing method for network usage. Default value: PayByTraffic. Valid values:\nPayByBandwidth\nPayByTraffic"
                },
                "Required": false
              },
              "SnapshotId": {
                "Type": "String",
                "Description": {
                  "en": "The ID of the snapshot used to create data disk"
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "Data disk"
          },
          "Required": false,
          "MinLength": 1,
          "MaxLength": 16
        },
        "InternetMaxBandwidthOut": {
          "Type": "Number",
          "Description": {
            "en": "The maximum outbound public bandwidth. Unit: Mbit/s. Valid values: 0 to 100. Default value: 0."
          },
          "Required": false
        },
        "InternetMaxBandwidthIn": {
          "Type": "Number",
          "Description": {
            "en": "The maximum inbound public bandwidth."
          },
          "Required": false
        },
        "InstanceDescription": {
          "Type": "String",
          "Description": {
            "en": "The description of the instance."
          },
          "Required": false
        },
        "Tag": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Value": {
                "Type": "String",
                "Description": {
                  "en": "The tag value of the instance."
                },
                "Required": false
              },
              "Key": {
                "Type": "String",
                "Description": {
                  "en": "The tag key of the instance."
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Required": false,
          "MinLength": 1,
          "MaxLength": 20
        },
        "CreditSpecification": {
          "Type": "String",
          "Description": {
            "en": "The performance mode of the burstable instance. Valid values:\nStandard: the standard mode. For more information, see the \"Standard mode\" section of the Burstable instances topic.\nUnlimited: the unlimited mode. For more information, see the \"Unlimited mode\" section of the Burstable instances topic."
          },
          "Required": false
        },
        "SecurityEnhancementStrategy": {
          "Type": "String",
          "Description": {
            "en": "Specifies whether to enable security hardening. Valid values:\nActive: Security hardening is enabled. This value is applicable only to public images.\nDeactive: Security hardening is disabled. This value is applicable to all image types."
          },
          "Required": false
        },
        "AutoReleaseTime": {
          "Type": "String",
          "Description": {
            "en": "The auto release time of the instance."
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "LaunchConfiguration",
      "zh-cn": "启动配置信息"
    }
  }
  EOT
}

variable "spot_instance_pools_to_use_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "This parameter takes effect when the SpotAllocationStrategy parameter is set to lowest-price. The auto provisioning group selects instance types of the lowest cost to create\ninstances."
    },
    "Label": {
      "en": "SpotInstancePoolsToUseCount",
      "zh-cn": "弹性供应组选择价格最低的实例规格创建实例的数量"
    }
  }
  EOT
}

variable "valid_from" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the auto provisioning group is started. The period of time between this\npoint in time and the point in time specified by the ValidUntil parameter is the effective time period of the auto provisioning group.\nBy default, an auto provisioning group is immediately started after creation.",
      "zh-cn": "弹性供应组的启动时间，和ValidUntil共同确定有效时段。"
    },
    "Label": {
      "en": "ValidFrom",
      "zh-cn": "弹性供应组的启动时间"
    }
  }
  EOT
}

variable "max_spot_price" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The global maximum price for preemptible instances in the auto provisioning group.\nIf both the MaxSpotPrice and LaunchTemplateConfig.N.MaxPrice parameters are specified, the maximum price is the lower value of the two."
    },
    "Label": {
      "en": "MaxSpotPrice",
      "zh-cn": "弹性供应组内抢占式实例的最高价格"
    }
  }
  EOT
}

variable "spot_allocation_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The scale-out policy for preemptible instances. Valid values:\nlowest-price: The cost optimization policy the auto provisioning group follows to select instance\ntypes of the lowest cost to create instances.\ndiversified: The distribution balancing policy the auto provisioning group follows to evenly create\ninstances across zones specified in multiple extended template configurations.\nDefault value: lowest-price"
    },
    "AllowedValues": [
      "diversified",
      "lowest-price",
      "capacity-optimized"
    ],
    "Label": {
      "en": "SpotAllocationStrategy",
      "zh-cn": "创建抢占式实例的策略"
    }
  }
  EOT
}

variable "terminate_instances" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to release instances of the auto provisioning group. Valid values:\ntrue\nfalse\nDefault: false",
      "zh-cn": "删除弹性供应组时，是否释放组内实例。"
    },
    "Label": {
      "en": "TerminateInstances",
      "zh-cn": "删除弹性供应组时"
    }
  }
  EOT
}

variable "pay_as_you_go_allocation_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The scale-out policy for pay-as-you-go instances. Valid values:\nlowest-price: The cost optimization policy the auto provisioning group follows to select instance\ntypes of the lowest cost to create instances.\nprioritized: The priority-based policy the auto provisioning group follows to create instances.\nThe priority of an instance type is specified by the LaunchTemplateConfig.N.Priority parameter.\nDefault value: lowest-price"
    },
    "AllowedValues": [
      "lowest-price",
      "prioritized"
    ],
    "Label": {
      "en": "PayAsYouGoAllocationStrategy",
      "zh-cn": "创建按量付费实例的策略"
    }
  }
  EOT
}

variable "total_target_capacity" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The total target capacity of the auto provisioning group. The target capacity consists\nof the following three parts:\nThe target capacity of pay-as-you-go instances specified by the PayAsYouGoTargetCapacity parameter\nThe target capacity of preemptible instances specified by the SpotTargetCapacity parameter\nThe supplemental capacity besides PayAsYouGoTargetCapacity and SpotTargetCapacity"
    },
    "Label": {
      "en": "TotalTargetCapacity",
      "zh-cn": "弹性供应组的目标总容量"
    }
  }
  EOT
}

variable "resource_pool_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Strategy": {
          "Type": "String",
          "Description": {
            "en": "The resource pool includes the private pool and the public pool generated after the elastic guarantee service or capacity reservation service is in effect, which can be selected when the instance is started. Range:\nPrivatePoolFirst: Private pools take precedence Choosing this strategy, when specifying the ResourcePoolOptions. PrivatePoolIds, using the specified priority private pool. If the private pool is not specified or the designated private pool has insufficient capacity, the open type private pool will be matched automatically. If there is no eligible private pool, the instance is created using the public pool.\nPrivatePoolOnly: Private pools only Choosing this strategy, you must specify ResourcePoolOptions. PrivatePoolIds. If the specified private pool capacity is insufficient, the instance will fail to start.\nPublicPoolOnly: Creates instances using a public pool.\nDefault value: PublicPoolOnly"
          },
          "AllowedValues": [
            "PrivatePoolFirst",
            "PrivatePoolOnly",
            "PublicPoolOnly"
          ],
          "Required": false
        },
        "PrivatePoolIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Description": {
                "en": "Private pool ID. That is, elastic guarantee service ID or capacity reservation service ID. This parameter can only be passed to the Target mode private pool ID. The value of N ranges from 1 to 20."
              },
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Private pool ID. That is, elastic guarantee service ID or capacity reservation service ID. This parameter can only be passed to the Target mode private pool ID."
          },
          "Required": false,
          "MaxLength": 20
        }
      }
    },
    "Description": {
      "en": "Resource pooling policy to use when creating an instance. Once you have set this parameter, note that:\nThis parameter only applies if a pay-as-you-go instance is created.\nOnly create one-time synchronous delivery type elastic supply group (AutoProvisioningGroupType = instant), the parameters to take effect."
    }
  }
  EOT
}

variable "auto_provisioning_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the auto provisioning group to be created. It must be 2 to 128 characters\nin length. It must start with a letter but cannot start with http:// or https://.\nIt can contain letters, digits, colons (:), underscores (_), and hyphens (-)."
    },
    "Label": {
      "en": "AutoProvisioningGroupName",
      "zh-cn": "弹性供应组的名称"
    }
  }
  EOT
}

variable "excess_capacity_termination_policy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The shutdown policy for excess preemptible instances followed when the capacity of\nthe auto provisioning group exceeds the target capacity. Valid values:\nno-termination: Excess preemptible instances are not shut down.\ntermination: Excess preemptible instances are to be shut down. The action to be performed on these\nshutdown instances is specified by the SpotInstanceInterruptionBehavior parameter.\nDefault value: no-termination",
      "zh-cn": "弹性供应组超过目标总容量时，是否停止超额的抢占式实例。"
    },
    "AllowedValues": [
      "no-termination",
      "termination"
    ],
    "Label": {
      "en": "ExcessCapacityTerminationPolicy",
      "zh-cn": "弹性供应组超过目标总容量时"
    }
  }
  EOT
}

variable "data_disk_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DiskCategory": {
          "Type": "String",
          "Description": {
            "en": "The category of the data disk."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of instance data disk information."
    },
    "MaxLength": 10
  }
  EOT
}

variable "launch_template_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Cores": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "Number",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The cores."
              },
              "Required": false,
              "MaxLength": 5
            },
            "WeightedCapacity": {
              "Type": "Number",
              "Description": {
                "en": "The weight of the instance type specified in the Nth extended configurations of the\nlaunch template.\nThe weight is calculated based on the computing power of a specified instance type\nand the minimum computing power of a single node of the cluster. A greater weight\nindicates that the instance has more computing power, and as a result fewer instances\nare required.\nFor example, when the minimum computing power of a single node is 8 vCPUs and 60 GiB\nof memory, the weight of the instance type with 8 vCPUs and 60 GiB of memory is 1,\nand the weight of the instance type with 16 vCPUs and 120 GiB of memory is 2.",
                "zh-cn": "扩展启动模板中，实例规格的权重。"
              },
              "Required": false,
              "Label": {
                "en": "WeightedCapacity",
                "zh-cn": "扩展启动模板中"
              }
            },
            "Priority": {
              "Type": "Number",
              "Description": {
                "en": "The priority of the instance type specified in the Nth extended configurations of\nthe launch template. A value of 0 indicates the highest priority."
              },
              "Required": false,
              "Label": {
                "en": "Priority",
                "zh-cn": "扩展启动模板中实例规格的优先级"
              }
            },
            "VSwitchId": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Description": {
                "en": "The ID of the VSwitch in the Nth extended configurations of the launch template.",
                "zh-cn": "扩展启动模板中，ECS实例加入的交换机的ID。"
              },
              "Required": true,
              "Label": {
                "en": "VSwitchId",
                "zh-cn": "扩展启动模板中"
              }
            },
            "InstanceFamilyLevel": {
              "Type": "String",
              "Description": {
                "en": "Instance specification family level, used to filter the range of instance specifications that meet the requirements. Valid values:\n- EntryLevel: This is the shared instance specification. The cost is lower, but the performance of instance calculation cannot be guaranteed to be stable. It is suitable for business scenarios with low CPU usage at ordinary times.\n- EnterpriseLevel: Enterprise level. Stable performance, resource exclusive, suitable for high stability requirements of business scenarios.\n- CreditEntryLevel: Credit entry level, that is, burst performance instance. CPU credits are used to ensure the computing performance, which is suitable for the situation of low CPU utilization and occasional burst CPU utilization."
              },
              "AllowedValues": [
                "EntryLevel",
                "EnterpriseLevel",
                "CreditEntryLevel"
              ],
              "Required": false
            },
            "ImageId": {
              "Type": "String",
              "Description": {
                "en": "The image ID."
              },
              "Required": false
            },
            "BurstablePerformance": {
              "Type": "String",
              "Description": {
                "en": "Whether it is a performance burst instance specification. Valid values:\n- Exclude: The performance burst instance specification is not included.\n- Include: Contains the performance burst instance specification.\n- Required: Contains only the performance burst instance specification.\nDefault value: Include"
              },
              "AllowedValues": [
                "Exclude",
                "Include",
                "Required"
              ],
              "Required": false
            },
            "MaxPrice": {
              "Type": "Number",
              "Description": {
                "en": "The maximum price of the instance type specified in the Nth extended configurations\nof the launch template.",
                "zh-cn": "扩展启动模板中，抢占式实例的价格上限。"
              },
              "Required": false,
              "Label": {
                "en": "MaxPrice",
                "zh-cn": "扩展启动模板中"
              }
            },
            "ExcludedInstanceTypes": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The excluded instance types."
              },
              "Required": false,
              "MaxLength": 5
            },
            "InstanceType": {
              "Type": "String",
              "Description": {
                "en": "The instance type of the Nth extended configurations of the launch template."
              },
              "Required": false,
              "Label": {
                "en": "InstanceType",
                "zh-cn": "扩展启动模板对应的实例规格"
              }
            },
            "Memories": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "Number",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The memories."
              },
              "Required": false,
              "MaxLength": 5
            },
            "Architectures": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "The schema type to which the instance specification belongs. Valid values:\n- X86: X86 computing.\n- Heterogeneous: Heterogeneous computing, e.g. Gpus or FPgas, etc.\n- BareMental: Elastic bare metal server.\n- Arm: Arm calculation\n- SuperComputeCluster: Supercomputing cluster\nDefault: Contains all schema types."
                  },
                  "AllowedValues": [
                    "X86",
                    "Heterogeneous",
                    "BareMental",
                    "Arm",
                    "SuperComputeCluster"
                  ],
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The architectures."
              },
              "Required": false,
              "MaxLength": 5
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Label": {
      "en": "LaunchTemplateConfig",
      "zh-cn": "启动模板的扩展设置"
    },
    "MaxLength": 20
  }
  EOT
}

variable "launch_template_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance launch template associated with the auto provisioning group.\nYou can call the DescribeLaunchTemplates operation to query available instance launch templates.\nAn auto provisioning group can be associated with only one instance launch template.\nBut you can configure multiple extended configurations for the launch template through\nthe LaunchTemplateConfig parameter."
    },
    "Label": {
      "en": "LaunchTemplateId",
      "zh-cn": "弹性供应组关联的实例启动模板的ID"
    }
  }
  EOT
}

variable "pay_as_you_go_target_capacity" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The target capacity of pay-as-you-go instances in the auto provisioning group.",
      "zh-cn": "弹性供应组内，按量付费实例的目标容量。"
    },
    "Label": {
      "en": "PayAsYouGoTargetCapacity",
      "zh-cn": "弹性供应组内"
    }
  }
  EOT
}

variable "spot_instance_interruption_behavior" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The default behavior after preemptible instances are shut down. Value values:\nstop: stops preemptible instances.\nterminate: releases preemptible instances.\nDefault value: stop"
    },
    "AllowedValues": [
      "stop",
      "terminate"
    ],
    "Label": {
      "en": "SpotInstanceInterruptionBehavior",
      "zh-cn": "停止了超额抢占式实例后的下一步动作"
    }
  }
  EOT
}

variable "valid_until" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time when the auto provisioning group expires. The period of time between this\npoint in time and the point in time specified by the ValidFrom parameter is the effective time period of the auto provisioning group.\nBy default, an auto provisioning group never expires.",
      "zh-cn": "弹性供应组的到期时间，和ValidFrom共同确定有效时段。"
    },
    "Label": {
      "en": "ValidUntil",
      "zh-cn": "弹性供应组的到期时间"
    }
  }
  EOT
}

variable "terminate_instances_with_expiration" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "The shutdown policy for preemptible instances when the auto provisioning group expires.\nValid values:\ntrue: shuts down preemptible instances. The action to be performed on these shutdown instances\nis specified by the SpotInstanceInterruptionBehavior parameter.\nfalse: does not shut down preemptible instances.\nDefault: false",
      "zh-cn": "弹性供应组到期时，是否停止抢占式实例。"
    },
    "Label": {
      "en": "TerminateInstancesWithExpiration",
      "zh-cn": "弹性供应组到期时"
    }
  }
  EOT
}

variable "spot_target_capacity" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The target capacity of preemptible instances in the auto provisioning group.",
      "zh-cn": "弹性供应组内，抢占式实例的目标容量。"
    },
    "Label": {
      "en": "SpotTargetCapacity",
      "zh-cn": "弹性供应组内"
    }
  }
  EOT
}

variable "min_target_capacity" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The target minimum capacity of the elastic supply group. Value range: Positive integer.\nOnce you have set this parameter, note that:\nOnly create one-time synchronous delivery type elastic supply group (AutoProvisioningGroupType = instant), the parameters to take effect.\nIf the inventory of instances in the current domain is less than this value, the call to the interface will fail and no instance will be created.\nIf the instance inventory in the current domain is greater than the parameter value, the instance is created normally according to the other parameter values that have been set."
    }
  }
  EOT
}

variable "launch_template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of the instance launch template associated with the auto provisioning\ngroup. You can call the DescribeLaunchTemplateVersions operation to query the versions of available instance launch templates."
    },
    "Label": {
      "en": "LaunchTemplateVersion",
      "zh-cn": "弹性供应组关联实例启动模板的版本"
    }
  }
  EOT
}

variable "system_disk_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DiskCategory": {
          "Type": "String",
          "Description": {
            "en": "The category of the system disk."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of instance system disk information."
    },
    "MaxLength": 10
  }
  EOT
}

resource "alicloud_auto_provisioning_group" "auto_provisioning_group" {
  description                         = var.description
  auto_provisioning_group_type        = var.auto_provisioning_group_type
  default_target_capacity_type        = var.default_target_capacity_type
  spot_instance_pools_to_use_count    = var.spot_instance_pools_to_use_count
  valid_from                          = var.valid_from
  max_spot_price                      = var.max_spot_price
  spot_allocation_strategy            = var.spot_allocation_strategy
  terminate_instances                 = var.terminate_instances
  pay_as_you_go_allocation_strategy   = var.pay_as_you_go_allocation_strategy
  total_target_capacity               = var.total_target_capacity
  auto_provisioning_group_name        = var.auto_provisioning_group_name
  excess_capacity_termination_policy  = var.excess_capacity_termination_policy
  launch_template_config              = var.launch_template_config
  launch_template_id                  = var.launch_template_id
  pay_as_you_go_target_capacity       = var.pay_as_you_go_target_capacity
  spot_instance_interruption_behavior = var.spot_instance_interruption_behavior
  valid_until                         = var.valid_until
  terminate_instances_with_expiration = var.terminate_instances_with_expiration
  spot_target_capacity                = var.spot_target_capacity
  launch_template_version             = var.launch_template_version
}

output "auto_provisioning_group_name" {
  value       = alicloud_auto_provisioning_group.auto_provisioning_group.auto_provisioning_group_name
  description = "The name of the auto provisioning group."
}

output "auto_provisioning_group_id" {
  value       = alicloud_auto_provisioning_group.auto_provisioning_group.id
  description = "The ID of the auto provisioning group."
}

