variable "dedicated_host_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the dedicated host on which you want to create an ECS instance. You cannot create preemptible instances on dedicated hosts. If you specify **DedicatedHostId**, **SpotStrategy** and **SpotPriceLimit** are ignored.\nYou can call the **DescribeDedicatedHosts** operation to query dedicated host IDs."
    },
    "Label": {
      "en": "Dedicated Host ID",
      "zh-cn": "专有宿主机ID"
    }
  }
  EOT
}

variable "scaling_configuration_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of created scaling configuration."
    },
    "Label": {
      "en": "ScalingConfigurationName",
      "zh-cn": "伸缩配置的名称"
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
      "zh-cn": "实例所在的资源组ID"
    }
  }
  EOT
}

variable "image_options_login_as_non_root" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether the ecs instance is logged in as ecs-user.Valid values:\n- **true**\n- **false**\nDefault value: **false**."
    },
    "Label": {
      "en": "Login as ecs-user",
      "zh-cn": "以ecs-user用户登录"
    }
  }
  EOT
}

variable "system_disk_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the system disk. The description must be 2 to 256 characters in length. The description can contain letters and cannot start with http:// or https://."
    },
    "Label": {
      "en": "System Disk Description",
      "zh-cn": "系统盘描述"
    }
  }
  EOT
}

variable "memory" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The memory size. Unit: GiB.\nYou can specify the number of vCPUs and the memory size to determine the range of instance types. For example, you can set Cpu to 2 and Memory to 16 to specify instance types that have 2 vCPUs and 16 GiB of memory. If you specify Cpu and Memory, Auto Scaling determines the available instance types based on factors such as I/O optimization requirements and zones. Then, Auto Scaling preferentially creates instances by using the lowest-priced instance type.\n**Note**: You can specify **Cpu** and **Memory** to determine the range of instance types only if you set Scaling Policy to Cost Optimization Policy and you do not specify instance types in the scaling configuration."
    },
    "Label": {
      "en": "Memory",
      "zh-cn": "内存"
    }
  }
  EOT
}

variable "system_disk_provisioned_iops" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The IOPS metric that is preconfigured for the system disk.\n**Note**: IOPS measures the number of read and write operations that an EBS device can process per second."
    },
    "Label": {
      "en": "System Disk Provisioned IOPS",
      "zh-cn": "系统盘预留IOPS"
    }
  }
  EOT
}

variable "cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of vCPUs.\nYou can specify the number of vCPUs and the memory size to determine the range of instance types. For example, you can set CPU to 2 and Memory to 16 to specify instance types that have 2 vCPUs and 16 GiB of memory. If you specify Cpu and Memory, Auto Scaling determines the available instance types based on factors such as I/O optimization requirements and zones. Then, Auto Scaling preferentially creates instances by using the lowest-priced instance type.\n**Note**: You can specify **Cpu** and **Memory** to determine the range of instance types only if you set Scaling Policy to Cost Optimization Policy and you do not specify instance types in the scaling configuration."
    },
    "Label": {
      "en": "Cpu",
      "zh-cn": "vCPU个数"
    }
  }
  EOT
}

variable "system_disk_encrypt_algorithm" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SystemDiskEncrypted}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "The encryption algorithm that you want to use to encrypt the system disk. Valid values:\n- **AES-256**\n- **SM4-128**\nDefault value: **AES-256**"
    },
    "AllowedValues": [
      "AES-256",
      "SM4-128"
    ],
    "Label": {
      "en": "System Disk Encrypt Algorithm",
      "zh-cn": "系统盘加密算法"
    }
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance RAM role name. The name is provided and maintained by Resource Access Management (RAM) and can be queried using ListRoles. For more information, see RAM API CreateRole and ListRoles."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "private_pool_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "MatchCriteria": {
          "AssociationPropertyMetadata": {
            "ValueLabelMapping": {
              "Target": {
                "en": "Target",
                "zh-cn": "指定模式"
              },
              "None": {
                "en": "None",
                "zh-cn": "不使用模式"
              },
              "Open": {
                "en": "Open",
                "zh-cn": "开放模式"
              }
            },
            "AutoChangeType": false
          },
          "Type": "String",
          "Description": {
            "en": "The type of the private pool that you want to use to start ECS instances. A private pool is generated when an elasticity assurance or a capacity reservation takes effect. You can select a private pool to create ECS instances. Valid values:\n- **Open**: open private pool. Auto Scaling selects a matching open private pool to start instances. If no matching open private pools are found, Auto Scaling uses the resources in the public pool to start instances. In this case, you do not need to specify PrivatePoolOptions.Id.\nTarget: specified private pool. Auto Scaling uses the resources in the specified private pool to start ECS instances. If the specified private pool is unavailable, Auto Scaling cannot start ECS instances. If you set this parameter to Target, you must specify PrivatePoolOptions.Id.\n- **None**: no private pool. Auto Scaling does not use the resources in private pools to start ECS instances."
          },
          "AllowedValues": [
            "Open",
            "Target",
            "None"
          ],
          "Required": false,
          "Label": {
            "en": "Private Pool Capacity",
            "zh-cn": "私有池容量"
          }
        },
        "Id": {
          "Type": "String",
          "Description": {
            "en": "The ID of the private pool. The ID of a private pool is the same as the ID of the elasticity assurance or capacity reservation for which the private pool is generated."
          },
          "Required": false,
          "Label": {
            "en": "Private Pool ID",
            "zh-cn": "私有池ID"
          }
        }
      }
    },
    "Description": {
      "en": "Option settings for private pools"
    },
    "Label": {
      "en": "Private Pool Options",
      "zh-cn": "私有池选项"
    }
  }
  EOT
}

variable "system_disk_performance_level" {
  type        = string
  default     = "PL1"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "DiskPerformanceLevel"
    },
    "Description": {
      "en": "The performance level of an ESSD.",
      "zh-cn": "创建ESSD云盘作为系统盘使用时，设置云盘的性能等级。"
    },
    "AllowedValues": [
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "en": "System Disk Performance Level",
      "zh-cn": "系统盘性能等级"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Image::ImageId",
    "Description": {
      "en": "Image ID to create ecs instance .",
      "zh-cn": "实例的镜像ID，包括公共镜像、自定义镜像和云市场镜像。"
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "实例的镜像ID"
    }
  }
  EOT
}

variable "system_disk_disk_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the system disk. The name must be 2 to 128 characters in length. The name can contain letters, digits, colons (:), underscores (_), and hyphens (-). The name must start with a letter but cannot start with http:// or https://."
    },
    "Label": {
      "en": "System Disk Name",
      "zh-cn": "系统盘名称"
    }
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The hostname of the ECS instance. The hostname cannot start or end with a period (.) or a hyphen (-). The hostname cannot contain consecutive periods (.) or hyphens (-). Naming conventions for different types of instances:\nWindows instances: The hostname must be 2 to 15 characters in length, and can contain letters, digits, and hyphens (-). The hostname cannot contain periods (.) or contain only digits.\nOther instances such as Linux instances: The hostname must be 2 to 64 characters in length. You can use periods (.) to separate a hostname into multiple segments. Each segment can contain letters, digits, and hyphens (-)."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "云服务器的主机名"
    }
  }
  EOT
}

variable "load_balancer_weight" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The weight of the ECS instance as a backend server. Valid values: 1 to 100.\nDefault value: 50."
    },
    "MinValue": 1,
    "Label": {
      "en": "LoadBalancerWeight",
      "zh-cn": "ECS实例作为负载均衡后端服务器时的权重"
    },
    "MaxValue": 100
  }
  EOT
}

variable "instance_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceId",
    "Description": {
      "en": "Source ECS instance to copy configuration, if the properties is setting, Which will copy the InstanceType, ImageId, InternetChargeType, IoOptimized,UserData, KeyPairName, RamRoleName, InternetMaxBandwidthIn,InternetMaxBandwidthOut, and first security group id from source instance, you can also specify the relative properties to overwrite the properties copy from source instance id."
    },
    "Label": {
      "en": "Source Instance ID",
      "zh-cn": "源实例ID"
    }
  }
  EOT
}

variable "system_diskkmskey_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the KMS key that you want to use to encrypt the system disk."
    },
    "Label": {
      "en": "System Disk KMS Key ID",
      "zh-cn": "系统盘KMS密钥ID"
    }
  }
  EOT
}

variable "scaling_group_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Scaling group id to create the scaling configuration."
    },
    "Label": {
      "en": "ScalingGroupId",
      "zh-cn": "伸缩配置所属的伸缩组ID"
    }
  }
  EOT
}

variable "image_family" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the image family. You can configure this parameter to obtain the latest available images within the specified image family. The images are used to create ECS instances. If you have set the ImageId parameter, you cannot set the ImageFamily parameter."
    },
    "Label": {
      "en": "ImageFamily",
      "zh-cn": "镜像族系名称"
    }
  }
  EOT
}

variable "security_group_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Description": {
          "en": "The ID of the security groups with which you want to associate the ECS instances that are created by using the scaling configuration.\n**Note**: If you specify **SecurityGroupId**, you cannot specify **SecurityGroupIds**."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of the security groups with which you want to associate the ECS instances that are created by using the scaling configuration.\n**Note**: If you specify **SecurityGroupId**, you cannot specify **SecurityGroupIds**."
    },
    "Label": {
      "en": "Add multiple security groups to ECS instance",
      "zh-cn": "将ECS实例同时加入多个安全组"
    },
    "MaxLength": 16
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "Instance internet access charge type.Support 'PayByBandwidth' and 'PayByTraffic' only."
    },
    "AllowedValues": [
      "paybytraffic",
      "paybybandwidth"
    ],
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "公网访问带宽计费方式"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the instance launched from the current scaling configuration."
    },
    "Label": {
      "en": "Instance Name",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "spot_interruption_behavior" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Equals": [
              "$${SpotStrategy}",
              "NoSpot"
            ]
          }
        }
      }
    },
    "Description": {
      "en": "The interruption mode of the preemptible instance. Default value: Terminate. Set the value to Terminate. This value specifies that the preemptible instance is to be released."
    },
    "AllowedValues": [
      "Terminate"
    ],
    "Label": {
      "en": "Spot Interruption Behavior",
      "zh-cn": "抢占实例中断模式"
    }
  }
  EOT
}

variable "deployment_set_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Deployment set ID."
    },
    "Label": {
      "en": "DeploymentSetId",
      "zh-cn": "部署集ID"
    }
  }
  EOT
}

variable "internet_max_bandwidth_out" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum outgoing bandwidth from the public network, measured in Mbps (Mega bit per second).\nThe value range for PayByBandwidth is [0,100]. If this parameter value is not specified, AliyunAPI automatically sets the value to 0 Mbps.\nThe value range for PayByTraffic is [0,100]. If this parameter value is not specified, an error is reported"
    },
    "MinValue": 0,
    "Label": {
      "en": "InternetMaxBandwidthOut",
      "zh-cn": "公网最大出网带宽"
    },
    "MaxValue": 100
  }
  EOT
}

variable "instance_pattern_infos" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "Cores": {
              "Type": "Number",
              "Description": {
                "en": "The number of vCPUs that you want to allocate to an instance type in intelligent configuration mode. This parameter is used to filter the available instance types that meet the specified criteria.\nTake note of the following items when you specify Cores:\n- InstancePatternInfos is available only for scaling groups that reside in VPCs.\n- If you specify InstancePatternInfos, you must specify Cores and Memory.\n- If you specify an instance type by using InstanceType or InstanceTypes, Auto Scaling preferentially uses the instance type that is specified by InstanceType or InstanceTypes for scale-outs. If the specified instance type does not have sufficient inventory, Auto Scaling creates instances by using the lowest-priced instance type that is specified by InstancePatternInfos."
              },
              "Required": false,
              "Label": {
                "en": "vCPU Cores",
                "zh-cn": "vCPU内核数目"
              }
            },
            "Memory": {
              "Type": "Number",
              "Description": {
                "en": "The memory size that you want to allocate to an instance type in intelligent configuration mode. Unit: GiB. This parameter is used to filter the available instance types that meet the specified criteria."
              },
              "Required": false,
              "Label": {
                "en": "Memory",
                "zh-cn": "内存大小"
              }
            },
            "InstanceFamilyLevel": {
              "Type": "String",
              "Description": {
                "en": "The level of the instance type, which is used to filter instance types that meet the specified criteria. This parameter takes effect only if you set **CostOptimization** to true. Valid values:\n- **EntryLevel**: entry level (shared instance type). Instance types of this level are the most cost-effective but may not provide stable computing performance in a consistent manner. Instance types of this level are suitable for business scenarios in which the CPU utilization is low.\n- **EnterpriseLevel**: enterprise level. Instance types of this level provide stable performance and dedicated resources and are suitable for business scenarios that require high stability.\n- **CreditEntryLevel**: credit entry level. This value is valid only for burstable instances. CPU credits are used to ensure computing performance. Instance types of this level are suitable for business scenarios in which the CPU utilization is low but may fluctuate in specific cases."
              },
              "Required": false,
              "Label": {
                "en": "Instance Family Level",
                "zh-cn": "实例规格族级别"
              }
            },
            "MaxPrice": {
              "Type": "Number",
              "Description": {
                "en": "The maximum hourly price of a pay-as-you-go or preemptible instance in intelligent configuration mode. This parameter is used to filter the available instance types that meet the specified criteria.\n**Note**: If you set **SpotStrategy** to **SpotWithPriceLimit**, you must specify **MaxPrice**. In other cases, **MaxPrice** is optional."
              },
              "Required": false,
              "Label": {
                "en": "Max Price per Hour",
                "zh-cn": "每小时最大价格"
              }
            },
            "BurstablePerformance": {
              "Type": "String",
              "Description": {
                "en": "Specifies whether to include burstable instance types. Valid values:\n- **Exclude**: does not include burstable instance types.\n- **Include**: includes burstable instance types.\n- **Required**: includes only burstable instance types.\nDefault value: **Include**"
              },
              "Required": false,
              "Label": {
                "en": "Burstable Performance",
                "zh-cn": "是否为突发性能实例"
              }
            },
            "ExcludedInstanceTypes": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "The instance type that you want to exclude. You can use wildcard characters, such as asterisks (*), to exclude an instance type or an instance family. Examples:\n- ecs.c6.large: excludes the ecs.c6.large instance type.\n- ecs.c6.*: excludes the c6 instance family."
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The instance types that you want to exclude. You can use wildcard characters, such as asterisks (*), to exclude an instance type or an instance family. Examples:\n- ecs.c6.large: excludes the ecs.c6.large instance type.\n- ecs.c6.*: excludes the c6 instance family."
              },
              "Required": false,
              "Label": {
                "en": "Excluded Instance Types",
                "zh-cn": "排除实例规格"
              },
              "MaxLength": 100
            },
            "Architectures": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "AssociationPropertyMetadata": {
                    "ValueLabelMapping": {
                      "Heterogeneous": {
                        "en": "Heterogeneous",
                        "zh-cn": "异构计算"
                      },
                      "BareMetal": {
                        "en": "BareMetal",
                        "zh-cn": "弹性裸金属服务器"
                      },
                      "X86": {
                        "en": "X86",
                        "zh-cn": "X86计算"
                      },
                      "SuperComputeCluster": {
                        "en": "SuperComputeCluster",
                        "zh-cn": "超级计算集群"
                      },
                      "Arm": {
                        "en": "Arm",
                        "zh-cn": "ARM计算"
                      }
                    },
                    "AutoChangeType": false
                  },
                  "Type": "String",
                  "Description": {
                    "en": "The architecture of the instance type. Valid values:\n- **X86**: x86 architecture.\n- **Heterogeneous**: heterogeneous architecture, such as GPUs and FPGAs.\n- **BareMetal**: ECS Bare Metal Instance architecture.\n- **Arm**: ARM architecture.\n- **SuperComputeCluster**: Super Computing Cluster architecture.\nBy default, all values are included."
                  },
                  "AllowedValues": [
                    "X86",
                    "Heterogeneous",
                    "BareMetal",
                    "Arm",
                    "SuperComputeCluster"
                  ],
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The architectures of the instance types. Valid values:\n- **X86**: x86 architecture.\n- **Heterogeneous**: heterogeneous architecture, such as GPUs and FPGAs.\n- **BareMetal**: ECS Bare Metal Instance architecture.\n- **Arm**: ARM architecture.\n- **SuperComputeCluster**: Super Computing Cluster architecture.\nBy default, all values are included."
              },
              "Required": false,
              "Label": {
                "en": "Architectures",
                "zh-cn": "实例架构"
              },
              "MaxLength": 10
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Details of the intelligent configuration settings that determine the range of instance types that meet the specified criteria."
    },
    "Label": {
      "en": "Instance Pattern",
      "zh-cn": "智能配置模式"
    }
  }
  EOT
}

variable "instance_type_overrides" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "WeightedCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The weight of instance type N. If you want to trigger scale-outs based on the weighted capacities of instances, you must specify **WeightedCapacity** after you specify **InstanceType**.\nThe weight of an instance type specifies the capacity of an instance of the instance type in the scaling group. A higher weight specifies that a smaller number of instances of the specified instance type is required to meet the expected capacity requirement.\nPerformance metrics, such as the number of vCPUs and the memory size of each instance type, may vary. You can specify different weights for different instance types based on your business requirements.\nExample:\n- Current capacity: 0\nExpected capacity: 6\nCapacity of ecs.c5.xlarge: 4\nTo meet the expected capacity requirement, Auto Scaling must create and add two ecs.c5.xlarge instances.\n**Note**: The capacity of the scaling group cannot exceed the sum of the maximum number of instances that is specified by MaxSize and the maximum weight of the instance types.\nValid values of WeightedCapacity: 1 to 500."
          },
          "Required": false,
          "MinValue": 1,
          "Label": {
            "en": "Weighted Capacity",
            "zh-cn": "权重"
          },
          "MaxValue": 500
        },
        "InstanceType": {
          "AssociationPropertyMetadata": {
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
          "Type": "String",
          "Description": {
            "en": "Instance type N that you want to use to override the instance type that is specified in the launch template.\nIf you want to trigger scale-outs based on the weighted capacities of instances, specify **InstanceType** and **WeightedCapacity** at the same time. You can specify N instance types by using the Extended Configurations feature. Valid values of N: 1 to 10.\n**Note**: This parameter takes effect only if you specify **LaunchTemplateId**. \nYou can specify an instance type that is available for purchase as the value of InstanceType."
          },
          "Required": false,
          "Label": {
            "en": "Instance Type",
            "zh-cn": "实例规格"
          }
        }
      },
      "ListMetadata": {
        "Order": [
          "InstanceType",
          "WeightedCapacity"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The instance types."
    },
    "Label": {
      "en": "Instance Type Overrides",
      "zh-cn": "带权重的多实例规格参数"
    },
    "MaxLength": 10
  }
  EOT
}

variable "affinity" {
  type        = string
  default     = "default"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "default": {
          "en": "Not Associated",
          "zh-cn": "不关联"
        },
        "host": {
          "en": "Associated",
          "zh-cn": "关联"
        }
      }
    },
    "Description": {
      "en": "Specifies whether to associate an ECS instance on a dedicated host with the dedicated host. Valid values:\n- **default**: does not associate the ECS instance with the dedicated host. If you start an ECS instance that was stopped in economical mode and the original dedicated host has insufficient resources, the ECS instance is automatically deployed to another dedicated host in the automatic deployment resource pool.\n- **host**: associates the ECS instance with the dedicated host. If you start an ECS instance that was stopped in economical mode, the instance remains on the original dedicated host. If the original dedicated host has insufficient resources, the ECS instance fails to start.\nDefault value: **default**"
    },
    "AllowedValues": [
      "default",
      "host"
    ],
    "Label": {
      "en": "Affinity",
      "zh-cn": "专有宿主机实例是否与专有宿主机关联"
    }
  }
  EOT
}

variable "security_enhancement_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Active": {
          "en": "Active",
          "zh-cn": "启用安全加固"
        },
        "Deactive": {
          "en": "Deactive",
          "zh-cn": "不启用安全加固"
        }
      }
    },
    "Description": {
      "en": "Specifies whether to enable security hardening. Valid values:\n- **Active**: enables security hardening. This value is applicable only to public images.\n- **Deactive**: disables security hardening. This value is applicable to all image types."
    },
    "AllowedValues": [
      "Active",
      "Deactive"
    ],
    "Label": {
      "en": "Security Enhancement Strategy",
      "zh-cn": "安全加固策略"
    }
  }
  EOT
}

variable "tenancy" {
  type        = string
  default     = "default"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "default": {
          "en": "Non-Dedicated Host",
          "zh-cn": "创建非专有宿主机实例"
        },
        "host": {
          "en": "Dedicated Host",
          "zh-cn": "创建专有宿主机实例"
        }
      }
    },
    "Description": {
      "en": "Specifies whether to create an ECS instance on a dedicated host. Valid values:\n- **default**: does not create an ECS instance on a dedicated host.\n- **host**: creates an ECS instance on a dedicated host. If you do not specify **DedicatedHostId**, Alibaba Cloud selects a dedicated host for the ECS instance.\nDefault value: **default**"
    },
    "AllowedValues": [
      "default",
      "host"
    ],
    "Label": {
      "default": {
        "en": "Tenancy",
        "zh-cn": "是否在专有宿主机上创建实例"
      }
    }
  }
  EOT
}

variable "disk_mappings" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "BurstingEnabled": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to enable the burst feature for the system disk. Valid values:\n- **true**\n- **false**\n**Note**: This parameter is available only if you set **SystemDisk.Category** to **cloud_auto**."
              },
              "Required": false,
              "Label": {
                "en": "Bursting Enabled",
                "zh-cn": "数据盘是否开启Burst（性能突发）"
              }
            },
            "Category": {
              "AssociationPropertyMetadata": {
                "AutoChangeType": false,
                "LocaleKey": "DiskCategory"
              },
              "Type": "String",
              "Description": {
                "en": "The category of the data disk. Valid values:\n- **cloud**: basic disk. The DeleteWithInstance attribute of a basic disk that is created together with the instance is set to true.\n- **cloud_efficiency**: ultra disk.\n- **cloud_ssd**: standard SSD.\n- **ephemeral_ssd**: local SSD.\n- **cloud_essd**: ESSD.\nIf you specify **Category**, you cannot specify **Categories**. If you do not specify **Category** or **Categories**, the default value of **Category** is used:\n- For I/O optimized instances, the default value is **cloud_efficiency**.\n- For non-I/O optimized instances, the default value is **cloud**."
              },
              "AllowedValues": [
                "cloud_essd",
                "cloud_efficiency",
                "cloud_ssd",
                "cloud",
                "ephemeral_ssd"
              ],
              "Required": false,
              "Label": {
                "zh-cn": "数据盘类型"
              }
            },
            "Description": {
              "AssociationProperty": "TextArea",
              "Type": "String",
              "Description": {
                "en": "Description of the disk, [2, 256] characters. Do not fill or empty, the default is empty."
              },
              "Required": false
            },
            "KMSKeyId": {
              "Type": "String",
              "Description": {
                "en": "The KMS key ID for the data disk."
              },
              "Required": false
            },
            "Categories": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "AssociationPropertyMetadata": {
                    "AutoChangeType": false,
                    "LocaleKey": "DiskCategory"
                  },
                  "Type": "String",
                  "Description": {
                    "en": "The category of the data disk. If Auto Scaling cannot create instances by using the disk category that has the highest priority, Auto Scaling creates instances by using the disk category that has the next highest priority. Valid values:\n- **cloud**: basic disk. For a basic disk that is created together with the instance, **DeleteWithInstance** is set to true.\n- **cloud_efficiency**: ultra disk.\n- **cloud_ssd**: standard SSD.\n- **cloud_essd**: ESSD.\n**Note**: If you specify **Categories**, you cannot specify **DataDisks.Category**."
                  },
                  "AllowedValues": [
                    "cloud_essd",
                    "cloud_efficiency",
                    "cloud_ssd",
                    "cloud",
                    "ephemeral_ssd"
                  ],
                  "Required": false,
                  "Label": {
                    "zh-cn": "数据盘类型"
                  }
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The categories of the data disks. If Auto Scaling cannot create instances by using the disk category that has the highest priority, Auto Scaling creates instances by using the disk category that has the next highest priority. Valid values:\n- **cloud**: basic disk. For a basic disk that is created together with the instance, **DeleteWithInstance** is set to true.\n- **cloud_efficiency**: ultra disk.\n- **cloud_ssd**: standard SSD.\n- **cloud_essd**: ESSD.\n**Note**: If you specify **Categories**, you cannot specify **DataDisks.Category**."
              },
              "Required": false,
              "Label": {
                "en": "Categories",
                "zh-cn": "数据盘的多磁盘类型"
              },
              "MaxLength": 10
            },
            "Encrypted": {
              "Type": "String",
              "Description": {
                "en": "Whether the data disk is encrypted or not. Valid values:\n- **true**: Encrypted.\n- **false**: Not encrypted.\nDefault value: false."
              },
              "AllowedValues": [
                "true",
                "false"
              ],
              "Required": false
            },
            "Device": {
              "Type": "String",
              "Description": {
                "en": "A device name where the volume will be attached in the system at /dev/xvd[id]. Range from '/dev/xvdb' to '/dev/xvdz'."
              },
              "Required": false
            },
            "PerformanceLevel": {
              "Type": "String",
              "Description": {
                "en": "The PL of the data disk that is an ESSD. Valid values:\n- **PL0**: An ESSD can provide up to 10,000 random read/write IOPS.\n- **PL1**: An ESSD can provide up to 50,000 random read/write IOPS.\n- **PL2**: An ESSD can provide up to 100,000 random read/write IOPS.\n- **PL3**: An ESSD can provide up to 1,000,000 random read/write IOPS."
              },
              "Required": false
            },
            "Size": {
              "Type": "String",
              "Description": {
                "en": "The size of the data disk. Unit: GiB. Valid values:\n- If you set Categories to cloud: 5 to 2000.\n- If you set Categories to cloud_efficiency: 20 to 32768.\n- If you set Categories to cloud_essd: 20 to 32768.\n- If you set Categories to ephemeral_ssd: 5 to 800.\nThe size of the data disk must be greater than or equal to the size of the snapshot that is specified by SnapshotId."
              },
              "Required": false
            },
            "DeleteWithInstance": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to release the data disk when the instance to which the data disk is attached is released. Valid values:\n- **true**\n- **false**\nThis parameter is available only for independent disks whose value of **Category** is set to **cloud**, **cloud_efficiency**, **cloud_ssd**, or **cloud_essd**. If you specify this parameter for other disks, an error is reported.\nDefault value: **true**"
              },
              "Required": false,
              "Label": {
                "en": "Delete With Instance",
                "zh-cn": "数据盘是否随实例释放"
              }
            },
            "AutoSnapshotPolicyId": {
              "AssociationProperty": "ALIYUN::ECS::Snapshot::AutoSnapshotPolicyId",
              "Type": "String",
              "Description": {
                "en": "The ID of the automatic snapshot policy that you want to apply to the data disk."
              },
              "Required": false
            },
            "DiskName": {
              "Type": "String",
              "Description": {
                "en": "Display name of the disk, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'."
              },
              "Required": false
            },
            "ProvisionedIops": {
              "Type": "Number",
              "Description": {
                "en": "The IOPS metric that is preconfigured for the data disk.\n**Note**: IOPS measures the number of read and write operations that an EBS device can process per second."
              },
              "Required": false,
              "Label": {
                "en": "Provisioned IOPS",
                "zh-cn": "数据盘的预设IOPS"
              }
            },
            "SnapshotId": {
              "Type": "String",
              "Description": {
                "en": "ID of the snapshot to create the volume."
              },
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Required": false
      },
      "ListMetadata": {
        "Order": [
          "DiskName",
          "Description",
          "Size",
          "Category",
          "Categories",
          "PerformanceLevel",
          "Device",
          "SnapshotId",
          "AutoSnapshotPolicyId",
          "Encrypted",
          "KMSKeyId",
          "ProvisionedIops",
          "BurstingEnabled",
          "DeleteWithInstance"
        ]
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Disk mappings to attach to instance."
    },
    "Label": {
      "en": "Data Disk Configuration",
      "zh-cn": "数据盘配置"
    },
    "MaxLength": 16
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Size of system disk. Unit is GB."
    },
    "MinValue": 20,
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "user_data" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "User data to pass to instance. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "创建实例时传递的用户数据"
    }
  }
  EOT
}

variable "spot_duration" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Not": {
            "Fn::Equals": [
              "$${SpotStrategy}",
              "NoSpot"
            ]
          }
        }
      }
    },
    "Description": {
      "en": "The retention period of the preemptible instance. Unit: hours. Valid values: 0, 1, 2, 3, 4, 5, and 6.\nThe following retention periods are available in invitational preview: 2, 3, 4, 5, and 6 hours. If you want to set this parameter to one of these values, submit a ticket.\nIf you set this parameter to 0, no protection period is specified for the preemptible instance.\nDefault value: 1"
    },
    "AllowedValues": [
      0,
      1
    ],
    "Label": {
      "en": "Spot Duration",
      "zh-cn": "抢占式实例的保留时长（小时）"
    }
  }
  EOT
}

variable "system_disk_encrypted" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to encrypt the system disk. Valid values:\n- **true**\n- **false**\nDefault value: **false**"
    },
    "Label": {
      "en": "System Disk Encrypted",
      "zh-cn": "系统盘是否加密"
    }
  }
  EOT
}

variable "system_disk_auto_snapshot_policy_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Snapshot::AutoSnapshotPolicyId",
    "Description": {
      "en": "Auto snapshot policy ID."
    },
    "Label": {
      "en": "SystemDiskAutoSnapshotPolicyId",
      "zh-cn": "系统盘使用的自动快照策略ID"
    }
  }
  EOT
}

variable "spot_price_limit_for_instance_type" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpotStrategy}",
            "SpotWithPriceLimit"
          ]
        }
      }
    },
    "Description": {
      "en": "Set the hourly maximum price for the instance of specified instance type.\nThe parameter takes effect only when the value of SpotStrategy is SpotWithPriceLimit.\nYou should input the information of the tag with the format of the Key-Value, such as {\"key1\":\"value1\",\"key2\":\"value2\", ... \"key5\":\"value5\"}.\nAt most 50 items can be specified.\nKey\n\tecs instance type\nValue\n\tSupports a maximum of 3 decimal places."
    },
    "Label": {
      "en": "SpotPriceLimitForInstanceType",
      "zh-cn": "抢占式实例的实例规格和对应的出价"
    }
  }
  EOT
}

variable "ipv6_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of randomly generated IPv6 addresses to be assigned to the elastic network interface (ENI)."
    },
    "MinValue": 0,
    "Label": {
      "en": "Ipv6AddressCount",
      "zh-cn": "为弹性网卡指定随机生成的IPv6地址数量"
    }
  }
  EOT
}

variable "system_disk_categories" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "AutoChangeType": false,
          "LocaleKey": "DiskCategory"
        },
        "Type": "String",
        "Description": {
          "en": "The category of the system disk. If Auto Scaling cannot create instances by using the disk category that has the highest priority, Auto Scaling creates instances by using the disk category that has the next highest priority. Valid values:\n- **cloud**: basic disk\n- **cloud_efficiency**: ultra disk\n- **cloud_ssd**: standard SSD\n- **cloud_essd**: ESSD\n**Note**: If you specify **SystemDiskCategories**, you cannot specify **SystemDiskCategory**."
        },
        "AllowedValues": [
          "cloud_essd",
          "cloud_efficiency",
          "cloud_ssd",
          "cloud",
          "ephemeral_ssd",
          "cloud_auto"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The categories of the system disks. If Auto Scaling cannot create instances by using the disk category that has the highest priority, Auto Scaling creates instances by using the disk category that has the next highest priority. Valid values:\n- **cloud**: basic disk\n- **cloud_efficiency**: ultra disk\n- **cloud_ssd**: standard SSD\n- **cloud_essd**: ESSD\n**Note**: If you specify **SystemDiskCategories**, you cannot specify **SystemDiskCategory**."
    },
    "Label": {
      "en": "System Disk Categories",
      "zh-cn": "系统盘的多磁盘类型"
    },
    "MaxLength": 10
  }
  EOT
}

variable "spot_price_limit" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SpotStrategy}",
            "SpotWithPriceLimit"
          ]
        }
      }
    },
    "Description": {
      "en": "Set the hourly maximum price for the instance. Supports a maximum of 3 decimal places, and the parameter takes effect only when the value of SpotStrategy is SpotWithPriceLimit.It is a default value for all instance types, and can be overwrite by SpotPriceLimitForInstanceType"
    },
    "Label": {
      "en": "Spot Price Limit",
      "zh-cn": "抢占式实例每小时的最高出价"
    }
  }
  EOT
}

variable "tag_list" {
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
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "The tags of an instance in list format.\nDo not use with Tags at the same time.\nYou should input the information of the tag with the format of Key-Value list, such as [{\"Key\":\"key1\",\"Value\":\"value1\"}, ...].\nAt most 20 tags can be specified.\nKey\nIt can be up to 64 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCannot be a null string.\nValue\nIt can be up to 128 characters in length.\nCannot begin with aliyun.\nCannot begin with http:// or https://.\nCan be a null string.If less then 20 tags are specified, ros will add a tag(Key: \"ros-aliyun-created\", Value:\"<resource_name>_stack_<stack_id>\") if possible."
    },
    "Label": {
      "en": "TagList",
      "zh-cn": "实例标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "instance_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "ZoneId": "$${ZoneId}"
        },
        "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "ecs supported instance types. Length [1,10]. If InstanceTypes is specified,the InstanceType will be ignored."
    },
    "Label": {
      "en": "InstanceTypes",
      "zh-cn": "多实例规格参数"
    },
    "MinLength": 1,
    "MaxLength": 10
  }
  EOT
}

variable "instance_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "Description": {
      "en": "ecs supported instance type."
    },
    "Label": {
      "en": "Instance Type",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "spot_strategy" {
  type        = string
  default     = "NoSpot"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Localekey": "InstanceSpotStrategy"
    },
    "Description": {
      "en": "Preemption strategy for post-paid instances. It takes effect when the parameter InstanceChargeType takes the value of PostPaid. Ranges:\nNoSpot: Normal pay-per-use instance\nSpotWithPriceLimit: Set a preemptive instance of the cap price\nSpotAsPriceGo: System automatic bidding, following the current market actual price\nDefault: NoSpot."
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "后付费实例的抢占策略"
    }
  }
  EOT
}

variable "password_inherit" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to use the password pre-configured in the image you select or not. When PasswordInherit is specified, the Password must be null. For a secure access, make sure that the selected image has password configured."
    },
    "Label": {
      "en": "PasswordInherit",
      "zh-cn": "是否使用镜像预设的密码"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Password of created ecs instance. Must contain at least 3 types of special character, lower character, upper character, number."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "ECS实例的密码"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SSH key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "实例绑定的密钥对名称"
    }
  }
  EOT
}

variable "io_optimized" {
  type        = string
  default     = "none"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "optimized": "I/O优化",
        "none": "非I/O优化"
      }
    },
    "Description": {
      "en": "The 'optimized' instance can provide better IO performance. Support 'none' and 'optimized' only, default is 'none'."
    },
    "AllowedValues": [
      "none",
      "optimized"
    ],
    "Label": {
      "en": "IoOptimized",
      "zh-cn": "是否创建I/O优化实例"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone ID of the ECS instance."
    },
    "Label": {
      "en": "Zone",
      "zh-cn": "可用区"
    }
  }
  EOT
}

variable "hpc_cluster_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::EHPC::Cluster::ClusterId",
    "Description": {
      "en": "The HPC cluster ID to which the instance belongs."
    },
    "Label": {
      "en": "HpcClusterId",
      "zh-cn": "实例所属的EHPC集群ID"
    }
  }
  EOT
}

variable "security_group_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
    "Description": {
      "en": "Security Group to create ecs instance."
    },
    "Label": {
      "en": "Security Group ID",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "system_disk_category" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "LocaleKey": "DiskCategory"
    },
    "Description": {
      "en": "Category of system disk. Default is cloud.support cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd|cloud_auto"
    },
    "AllowedValues": [
      "cloud_essd",
      "cloud_efficiency",
      "cloud_ssd",
      "cloud",
      "ephemeral_ssd",
      "cloud_auto"
    ],
    "Label": {
      "en": "SystemDiskCategory",
      "zh-cn": "系统盘类型"
    }
  }
  EOT
}

variable "system_disk_bursting_enabled" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the burst feature for the system disk. Valid values:\n- **true**\n- **false**\n**Note**: This parameter is available only if you set **SystemDiskCategory** to **cloud_auto**."
    },
    "Label": {
      "en": "Bursting Enabled",
      "zh-cn": "数据盘是否开启Burst（性能突发）"
    }
  }
  EOT
}

variable "image_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the image. Each image name must be unique in a region. If you specify **ImageId**, **ImageName** is ignored.\nYou cannot use **ImageName** to specify images that are purchased from Alibaba Cloud Marketplace."
    },
    "Label": {
      "en": "Image Name",
      "zh-cn": "镜像名称"
    }
  }
  EOT
}

variable "internet_max_bandwidth_in" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Maximum incoming bandwidth from the public network, measured in Mbps (Mega bit per second). The value range is [1,200]. If this parameter value is not specified, AliyunAPI automatically sets the value to 200 Mbps."
    },
    "MinValue": 1,
    "Label": {
      "en": "InternetMaxBandwidthIn",
      "zh-cn": "公网最大入网带宽"
    },
    "MaxValue": 200
  }
  EOT
}

variable "instance_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the ECS instance. The description must be 2 to 256 characters in length. The description can contain letters and cannot start with http:// or https://."
    },
    "Label": {
      "en": "Instance Description",
      "zh-cn": "实例描述"
    }
  }
  EOT
}

variable "credit_specification" {
  type        = string
  default     = "Unlimited"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "Unlimited": "无性能约束模式",
        "Standard": "标准模式"
      }
    },
    "Description": {
      "en": "The performance mode of the burstable instance. Valid values:\nStandard: the standard mode.\nUnlimited: the unlimited mode."
    },
    "AllowedValues": [
      "Unlimited",
      "Standard"
    ],
    "Label": {
      "en": "CreditSpecification",
      "zh-cn": "突发性能实例的运行模式"
    }
  }
  EOT
}

resource "alicloud_ess_scaling_configuration" "scaling_configuration" {
  scaling_configuration_name          = var.scaling_configuration_name
  resource_group_id                   = var.resource_group_id
  image_options_login_as_non_root     = var.image_options_login_as_non_root
  system_disk_description             = var.system_disk_description
  system_disk_provisioned_iops        = var.system_disk_provisioned_iops
  system_disk_encrypt_algorithm       = var.system_disk_encrypt_algorithm
  role_name                           = var.ram_role_name
  system_disk_performance_level       = var.system_disk_performance_level
  image_id                            = var.image_id
  host_name                           = var.host_name
  instance_ids                        = var.instance_id
  scaling_group_id                    = var.scaling_group_id
  security_group_ids                  = var.security_group_ids
  internet_charge_type                = var.internet_charge_type
  instance_name                       = var.instance_name
  internet_max_bandwidth_out          = var.internet_max_bandwidth_out
  security_enhancement_strategy       = var.security_enhancement_strategy
  data_disk                           = var.disk_mappings
  system_disk_size                    = var.system_disk_size
  user_data                           = var.user_data
  spot_duration                       = var.spot_duration
  system_disk_encrypted               = var.system_disk_encrypted
  system_disk_auto_snapshot_policy_id = var.system_disk_auto_snapshot_policy_id
  tags                                = var.tag_list
  instance_types                      = var.instance_types
  instance_type                       = var.instance_type
  spot_strategy                       = var.spot_strategy
  password_inherit                    = var.password_inherit
  password                            = var.password
  key_name                            = var.key_pair_name
  io_optimized                        = var.io_optimized
  security_group_id                   = var.security_group_id
  system_disk_category                = var.system_disk_category
  image_name                          = var.image_name
  internet_max_bandwidth_in           = var.internet_max_bandwidth_in
  instance_description                = var.instance_description
  credit_specification                = var.credit_specification
}

output "scaling_group_id" {
  value       = alicloud_ess_scaling_configuration.scaling_configuration.scaling_group_id
  description = "The id of the scaling group to which the scaling configuration belongs."
}

output "scaling_configuration_id" {
  value       = alicloud_ess_scaling_configuration.scaling_configuration.id
  description = "The scaling configuration id"
}

