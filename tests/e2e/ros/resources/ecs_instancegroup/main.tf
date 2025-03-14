variable "dedicated_host_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "which dedicated host will be deployed"
    },
    "Label": {
      "zh-cn": "宿主机ID"
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

variable "system_disk_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Description of created system disk.Old instances will not be changed."
    },
    "Label": {
      "en": "SystemDiskDescription",
      "zh-cn": "系统盘描述信息"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  default     = "PostPaid"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PostPaid": {},
        "PrePaid": {
          "Month": [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            12,
            24,
            36,
            48,
            60
          ],
          "Week": [
            1,
            2,
            3,
            4
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Instance Charge type, allowed value: Prepaid and Postpaid. If specified Prepaid, please ensure you have sufficient balance in your account. Or instance creation will be failure. Default value is Postpaid.Old instances will not be changed."
    },
    "AllowedValues": [
      "PrePaid",
      "PostPaid"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例的付费方式"
    }
  }
  EOT
}

variable "system_disk_provisioned_iops" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Provisioning IOPS."
    },
    "Label": {
      "en": "SystemDiskProvisionedIops",
      "zh-cn": "系统盘预配的IOPS"
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
            "true"
          ]
        }
      }
    },
    "Description": {
      "en": "The algorithm to use to encrypt the system disk. Valid values:\n- aes-256\n- sm4-128\nDefault value: aes-256."
    },
    "AllowedValues": [
      "aes-256",
      "sm4-128"
    ],
    "Label": {
      "en": "SystemDiskEncryptAlgorithm",
      "zh-cn": "系统盘采用的加密算法"
    }
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::RAM::Role",
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

variable "system_disk_performance_level" {
  type        = string
  default     = "PL1"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SystemDiskCategory}",
            "cloud_essd"
          ]
        }
      }
    },
    "Description": {
      "en": "The performance level of the enhanced SSD used as the system disk.Default value: PL1. Valid values:PL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.PL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.PL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.PL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS.",
      "zh-cn": "创建ESSD云盘作为系统盘使用时，设置云盘的性能等级。"
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "zh-cn": "ESSD系统盘性能等级"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "DefaultFilter": {
        "ImageOwnerAlias": "system",
        "ImageName": "aliyun_3_**",
        "OSType": "linux"
      },
      "InstanceType": "$${InstanceType}",
      "SupportedImageOwnerAlias": [
        "system",
        "self",
        "others"
      ]
    },
    "AssociationProperty": "ALIYUN::ECS::Image::ImageId",
    "Description": {
      "en": "Image ID to create ecs instance.",
      "zh-cn": "用于启动ECS实例的镜像ID。包括公共镜像、自定义镜像和云市场镜像。"
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "用于启动ECS实例的镜像ID"
    }
  }
  EOT
}

variable "image_options" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "LoginAsNonRoot": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether the instance that uses the image supports logons of the ecs-user user. Valid values:\n- true\n- false"
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Image options."
    },
    "Label": {
      "en": "ImageOptions",
      "zh-cn": "镜像相关属性信息"
    }
  }
  EOT
}

variable "system_disk_disk_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of created system disk.Old instances will not be changed."
    },
    "Label": {
      "en": "SystemDiskDiskName",
      "zh-cn": "系统盘名称"
    }
  }
  EOT
}

variable "tags" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
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
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Host name of created ecs instance. at least 2 characters, and '.' '-' Is not the first and last characters as hostname, not continuous use. Windows platform can be up to 15 characters, allowing letters (without limiting case), numbers and '-', and does not support the number of points, not all is digital ('.').Other (Linux, etc.) platform up to 64 characters, allowing support number multiple points for the period between the points, each permit letters (without limiting case), numbers and '-' components. \nSupport to use the regular expression to set the different instance name for each ECS instance. HostName could be specified as 'name_prefix[begin_number,bits]name_suffix', such as 'host[123,4]tail'. If you creates 3 instances with hostname 'host[123,4]tail', all the host names of instances are host0123tail, host0124tail, host0125tail. The 'name_prefix[begin_number,bits]name_suffix' should follow those rules: \n1. 'name_prefix' is required. \n2. 'name_suffix' is optional. \n3. The name regular expression can't include any spaces. \n4. The 'bits' must be in range [1, 6]. \n5. The 'begin_number' must be in range [0, 999999]. \n6. You could only specify 'begin_number'. The 'bits' will be set as 6 by default. \n7. You also could only specify the [] or [,]. The 'begin_number' will be set as 0 by default, the 'bits' will be set as 6 by default. \n8. If the bits of 'begin_number' is less than the 'bits' you specified, like [1234,1], the 'bits' will be set as 6 by default. \nThe host name is specified by regular expression works after restart instance manually."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "主机名称"
    }
  }
  EOT
}

variable "system_disk_storage_cluster_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the dedicated block storage cluster. If you want to use disks in a dedicated block storage cluster as system disks when you create instances, you must specify this parameter. "
    },
    "Label": {
      "en": "SystemDiskStorageClusterId",
      "zh-cn": "系统盘专属块存储集群ID"
    }
  }
  EOT
}

variable "launch_template_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Name of launch template. Launch template id or name must be specified to use launch template"
    },
    "Label": {
      "en": "LaunchTemplateName",
      "zh-cn": "启动模板名称"
    }
  }
  EOT
}

variable "update_policy" {
  type        = string
  default     = "ForNewInstances"
  description = <<EOT
  {
    "Description": {
      "en": "Specify the policy at update. \nThe value can be 'ForNewInstances' or 'ForAllInstances'.\nIf UpdatePolicy is 'ForAllInstance', The updatable parameters are InstanceType, ImageId, SystemDiskSize, SystemDiskCategory, Password, UserData,InternetChargeType, InternetMaxBandwidthOut, InternetMaxBandwidthIn.\nThe default is 'ForNewInstances'"
    },
    "AllowedValues": [
      "ForNewInstances",
      "ForAllInstances"
    ],
    "Label": {
      "en": "UpdatePolicy",
      "zh-cn": "指定更新时的策略"
    }
  }
  EOT
}

variable "system_diskkmskey_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SystemDiskEncrypted}",
            "true"
          ]
        }
      }
    },
    "Description": {
      "en": "The ID of the KMS key to use for the system disk."
    },
    "Label": {
      "en": "SystemDiskKMSKeyId",
      "zh-cn": "系统盘使用的KMS密钥ID"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "vpc"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The vSwitch Id to create ecs instance."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "cpu_options" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ThreadsPerCore": {
          "Type": "Number",
          "Description": {
            "en": "The number of threads per CPU core. The following formula is used to calculate the number of vCPUs of the instance: CpuOptions.Core value × CpuOptions.ThreadsPerCore value.\n- If CpuOptionsThreadPerCore is set to 1, hyperthreading is disabled.\n- This parameter is applicable only to specific instance types."
          },
          "Required": false
        },
        "Core": {
          "Type": "Number",
          "Description": {
            "en": "The number of CPU cores. This parameter cannot be specified but only uses its default value."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Cpu options."
    },
    "Label": {
      "en": "CpuOptions",
      "zh-cn": "CPU相关属性参数"
    }
  }
  EOT
}

variable "period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period. Unit is month, it could be from 1 to 9 or 12, 24, 36, 48, 60. Default value is 1.Old instances will not be changed."
    },
    "AllowedValues": [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
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
      "en": "ID of launch template. Launch template id or name must be specified to use launch template"
    },
    "Label": {
      "en": "LaunchTemplateId",
      "zh-cn": "启动模板ID"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether an instance can be released manually through the console or API, deletion protection only support postPaid instance",
      "zh-cn": "实例释放保护属性，指定是否支持通过控制台或DeleteInstance接口释放实例。"
    },
    "AllowedValues": [
      true,
      false
    ],
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "实例释放保护属性"
    }
  }
  EOT
}

variable "security_group_ids" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Multiple": true,
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The IDs of security groups N to which the instance belongs. The valid values of N are based on the maximum number of security groups to which an instance can belong. For more information, see Security group limits.Note: You cannot specify both SecurityGroupId and SecurityGroupIds at the same time."
    },
    "Label": {
      "en": "SecurityGroupIds",
      "zh-cn": "新创建实例所属的安全组ID列表"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  default     = "paybytraffic"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AllocatePublicIP}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "Instance internet access charge type.Support 'PayByBandwidth' and 'PayByTraffic' only. Default is PayByTraffic"
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

variable "deployment_set_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::DeploymentSet::DeploymentSetId",
    "Description": {
      "en": "Deployment set ID. The change of the property does not affect existing instances."
    },
    "Label": {
      "en": "DeploymentSetId",
      "zh-cn": "部署集ID"
    }
  }
  EOT
}

variable "spot_interruption_behavior" {
  type        = string
  default     = "Terminate"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ECSSpotInstanceInterruptionBehavior",
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotWithPriceLimit"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotAsPriceGo"
                  ]
                }
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The interruption mode of the preemptible instance. Default value: Terminate. Set the value to Terminate, which specifies to release the instance."
    },
    "Label": {
      "en": "SpotInterruptionBehavior",
      "zh-cn": "抢占实例中断模式"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Display name of the instance, [2, 128] English or Chinese characters, must start with a letter or Chinese in size, can contain numbers, '_' or '.', '-'. \nSupport to use the regular expression to set the different instance name for each ECS instance. InstanceName could be specified as 'name_prefix[begin_number,bits]name_suffix', such as 'testinstance[123,4]tail'. If you creates 3 instances with the instance name 'testinstance[123,4]tail', all the instances' names are testinstance0123tail, testinstance0124tail, testinstance0125tail. \nThe 'name_prefix[begin_number,bits]name_suffix' should follow those rules: \n1. 'name_prefix' is required. \n2. 'name_suffix' is optional. \n3. The name regular expression can't include any spaces. \n4. The 'bits' must be in range [1, 6]. \n5. The 'begin_number' must be in range [0, 999999]. \n6. You could only specify 'begin_number'. The 'bits' will be set as 6 by default. \n7. You also could only specify the [] or [,]. The 'begin_number' will be set as 0 by default, the 'bits' will be set as 6 by default. \n8. If the bits of 'begin_number' is less than the 'bits' you specified, like [1234,1], the 'bits' will be set as 6 by default."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "internet_max_bandwidth_out" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${AllocatePublicIP}",
            true
          ]
        }
      }
    },
    "Description": {
      "en": "Set internet output bandwidth of instance. Unit is Mbps(Mega bit per second). Range is [0,200]. Default is 1.While the property is not 0, public ip will be assigned for instance."
    },
    "MinValue": 0,
    "Label": {
      "en": "InternetMaxBandwidthOut",
      "zh-cn": "公网出带宽最大值"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${NetworkType}",
            "vpc"
          ]
        }
      }
    },
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The VPC id to create ecs instance."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "unique_suffix" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically append incremental suffixes to the hostname specified by the **HostName** parameter and to the instance name specified by the **InstanceName** parameter when you batch create instances. The incremental suffixes can range from 001 to 999. Valid values:\n- **true**: appends incremental suffixes to the hostname and the instance name.\n- **false**: does not append incremental suffixes to the hostname or the instance name.\nDefault value: **false**.\nWhen the **HostName** or **InstanceName** value is set in the name_prefix[begin_number,bits] format without a suffix (name_suffix), the **UniqueSuffix** parameter does not take effect. The names are sorted in the specified sequence.",
      "zh-cn": "当创建多台实例时，是否为HostName和InstanceName自动添加有序后缀。"
    },
    "Label": {
      "en": "UniqueSuffix",
      "zh-cn": "当创建多台实例时"
    }
  }
  EOT
}

variable "security_options" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ConfidentialComputingMode": {
          "Type": "String",
          "Description": {
            "en": "The confidential computing mode. Set the value to Enclave.\nA value of Enclave indicates that an enclave-based confidential computing environment is built on the instance. When you call the RunInstances operation, you can set this parameter only for c7, g7, or r7 instances to use enclave-based confidential computing. Take note of the following items:\n- The confidential computing feature is in invitational preview.\n- When you use the ECS API to create instances that support enclave-based confidential computing, you can call only the RunInstances operation. The CreateInstance operation does not support the SecurityOptions.ConfidentialComputingMode parameter.\n- Enclave-based confidential computing is implemented based on Alibaba Cloud Trusted System (vTPM). When you build a confidential computing environment on an instance by using Enclave, Alibaba Cloud Trusted System is enabled for the instance. If you set SecurityOptions.ConfidentialComputingMode to Enclave when you call this operation, the created instances use enclave-based confidential computing and Alibaba Cloud Trusted System regardless of whether SecurityOptions.TrustedSystemMode is set to vTPM."
          },
          "Required": false
        },
        "TrustedSystemMode": {
          "Type": "String",
          "Description": {
            "en": "The trusted system mode. Set the value to vTPM.\nThe trusted system mode supports the following instance families:\n- g7, c7, and r7\n- Security-enhanced instance families: g7t, c7t, and r7t\nWhen you create instances of the preceding instance families, you must set this parameter. Take note of the following items:\n- To use Alibaba Cloud Trusted System, set this parameter to vTPM. Then, Alibaba Cloud Trusted System performs trust verifications when the instances start.\n- If you do not want to use Alibaba Cloud Trusted System, leave this parameter empty. Take note that if your created instances use an enclave-based confidential computing environment (with SecurityOptions.ConfidentialComputingMode set to Enclave), Alibaba Cloud Trusted System is enabled for the instances.\n- When you use the ECS API to create instances that use Alibaba Cloud Trusted System, you can call only the RunInstances operation. The CreateInstance operation does not support the SecurityOptions.TrustedSystemMode parameter.\n**Note**: If you have configured an instance as a trusted instance when you created the instance, you can use only an image that supports Alibaba Cloud Trusted System to replace the system disk of the instance."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Security options."
    },
    "Label": {
      "en": "SecurityOptions",
      "zh-cn": "可信系统相关属性信息"
    }
  }
  EOT
}

variable "launch_template_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Version of launch template. Default version is used if version is not specified."
    },
    "AllowedPattern": "^[1-9]\\d*$",
    "Label": {
      "en": "LaunchTemplateVersion",
      "zh-cn": "启动模板的版本"
    }
  }
  EOT
}

variable "security_enhancement_strategy" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ECSSecurityEnhancementStrategy"
    },
    "AllowedValues": [
      "Active",
      "Deactive"
    ],
    "Label": {
      "en": "SecurityEnhancementStrategy",
      "zh-cn": "是否启用安全加固"
    }
  }
  EOT
}

variable "auto_release_time" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Auto release time for created instance, Follow ISO8601 standard using UTC time. format is 'yyyy-MM-ddTHH:mm:ssZ'. Not bigger than 3 years from this day onwards"
    },
    "Label": {
      "en": "AutoReleaseTime",
      "zh-cn": "ECS实例自动释放的时间"
    }
  }
  EOT
}

variable "period_unit" {
  type        = string
  default     = "Month"
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of prepaid time period, it could be Week/Month/Year. Default value is Month.Old instances will not be changed."
    },
    "AllowedValues": [
      "Week",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "购买资源的时长周期"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Private IP for the instance created. Only works for VPC instance and cannot duplicated with existing instance."
    },
    "Label": {
      "zh-cn": "内网IP地址"
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
      "en": "Description of the instance, [2, 256] characters. Do not fill or empty, the default is empty. Old instances will not be changed."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "描述信息"
    }
  }
  EOT
}

variable "disk_mappings" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "BurstingEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether enable bursting."
          },
          "Required": false
        },
        "StorageClusterId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the dedicated block storage cluster to which data disk N belongs. If you want to use a disk in a dedicated block storage cluster as data disk N when you create the instance, you must specify this parameter."
          },
          "Required": false
        },
        "Category": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Disk::DataDiskCategory",
          "Type": "String",
          "Description": {
            "en": "The volume type.Now support: cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd|cloud_auto. Default is cloud_efficiency."
          },
          "AllowedValues": [
            "cloud_essd",
            "cloud_efficiency",
            "cloud_ssd",
            "cloud",
            "cloud_auto",
            "cloud_essd_entry",
            "ephemeral_ssd"
          ],
          "Required": false,
          "Label": {
            "zh-cn": "类型"
          },
          "Default": "cloud_essd"
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
        "PerformanceLevel": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.Category}",
                  "cloud_essd"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The performance level of the enhanced SSD used as the Nth data disk.Default value: PL1. Valid values:PL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.PL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.PL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.PL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS."
          },
          "AllowedValues": [
            "PL0",
            "PL1",
            "PL2",
            "PL3"
          ],
          "Required": false,
          "Label": {
            "zh-cn": "性能"
          },
          "Default": "PL1"
        },
        "Encrypted": {
          "Type": "String",
          "Description": {
            "en": "Whether the data disk is encrypted or not. Options:\ntrue: Encrypted.\nfalse: Not encrypted.\nDefault value: false."
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
            "en": "The device where the volume is exposed on the instance. could be /dev/xvd[a-z]. If not specification, will use default value."
          },
          "Required": false
        },
        "Size": {
          "Type": "String",
          "Description": {
            "en": "The size of the volume, unit in GB.Value range: cloud: [5,2000], cloud_efficiency: [20,32768], cloud_ssd: [20,32768], cloud_essd: [20,32768], ephemeral_ssd: [5,800].The value should be equal to or greater than the specific snapshot."
          },
          "Required": true,
          "Label": {
            "zh-cn": "容量"
          },
          "Default": 100
        },
        "AutoSnapshotPolicyId": {
          "Type": "String",
          "Description": {
            "en": "Auto snapshot policy ID."
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
            "en": "Provisioning IOPS."
          },
          "Required": false
        },
        "SnapshotId": {
          "AssociationPropertyMetadata": {
            "Category": "$${.Category}",
            "ZoneId": "$${ZoneId}"
          },
          "AssociationProperty": "ALIYUN::ECS::Snapshot::SnapshotId",
          "Type": "String",
          "Description": {
            "en": "ID of the snapshot to create the volume."
          },
          "Required": false
        }
      },
      "ListMetadata": {
        "Order": [
          "Category",
          "Size",
          "PerformanceLevel",
          "SnapshotId",
          "Device",
          "DiskName",
          "Description"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Disk mappings to attach to instance. Max support 16 disks.\nIf the image contains a data disk, you can specify other parameters of the data disk via the same value of parameter \"Device\". If parameter \"Category\" is not specified, it will be cloud_efficiency instead of \"Category\" of data disk in the image.Old instances will not be changed."
    },
    "Label": {
      "en": "DiskMappings",
      "zh-cn": "为ECS实例创建的数据盘"
    },
    "MaxLength": 16
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  default     = 40
  description = <<EOT
  {
    "Description": {
      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size. "
    },
    "MinValue": 2,
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
    "AssociationPropertyMetadata": {
      "Language": [
        "shell",
        "bat",
        "powershell"
      ]
    },
    "AssociationProperty": "Code",
    "Description": {
      "en": "User data to pass to instance. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "创建ECS实例时传递的用户数据"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = string
  default     = "False"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "PrePaid"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether renew the fee automatically? When the parameter InstanceChargeType is PrePaid, it will take effect. Range of value:True: automatic renewal.False: no automatic renewal. Default value is False.Old instances will not be changed."
    },
    "AllowedValues": [
      "True",
      "False"
    ],
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
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
          "Fn::And": [
            {
              "Fn::Or": [
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotWithPriceLimit"
                  ]
                },
                {
                  "Fn::Equals": [
                    "$${SpotStrategy}",
                    "SpotAsPriceGo"
                  ]
                }
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The protection period of the preemptible instance. Unit: hours. Valid values: 0, 1, 2, 3, 4, 5, and 6.\nProtection periods of 2, 3, 4, 5, and 6 hours are in invitational preview. If you want to set this parameter to one of these values, submit a ticket.\nIf this parameter is set to 0, no protection period is configured for the preemptible instance.\nDefault value: 1."
    },
    "Label": {
      "en": "SpotDuration",
      "zh-cn": "抢占式实例的保留时长"
    }
  }
  EOT
}

variable "ipv6_addresses" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Specify one or more IPv6 addresses for the elastic NIC. Currently, the maximum list size is 1. Example value: 2001:db8:1234:1a00::*** .\nNote You cannot specify the parameters Ipv6Addresses and Ipv6AddressCount at the same time.\nThe change of the property does not affect existing instances."
    },
    "Label": {
      "en": "Ipv6Addresses",
      "zh-cn": "为弹性网卡指定IPv6地址"
    },
    "MaxLength": 1
  }
  EOT
}

variable "system_disk_encrypted" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to encrypt the system disk. Valid values:\n- true: encrypts the system disk.\n- false: does not encrypt the system disk.\nDefault value: false."
    },
    "AllowedValues": [
      "true",
      "false"
    ],
    "Label": {
      "en": "SystemDiskEncrypted",
      "zh-cn": "系统盘是否加密"
    }
  }
  EOT
}

variable "max_amount" {
  type        = number
  default     = 1
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Max number of instances to create, should be bigger than 'MinAmount' and smaller than 1000."
    },
    "MinValue": 0,
    "Label": {
      "zh-cn": "实例数量"
    },
    "MaxValue": 1000
  }
  EOT
}

variable "system_disk_auto_snapshot_policy_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Auto snapshot policy ID."
    },
    "Label": {
      "en": "SystemDiskAutoSnapshotPolicyId",
      "zh-cn": "系统盘自动快照策略ID"
    }
  }
  EOT
}

variable "deletion_force" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether force delete the instance. Default value is false."
    },
    "Label": {
      "en": "DeletionForce",
      "zh-cn": "是否强制删除实例"
    }
  }
  EOT
}

variable "network_type" {
  type        = string
  default     = "vpc"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceNetworkType"
    },
    "Description": {
      "en": "Instance network type. Support 'vpc' and 'classic', for compatible reason, default is 'classic'. If vswitch id and vpc id is specified, the property will be forced to be set to 'vpc'  "
    },
    "AllowedValues": [
      "vpc",
      "classic"
    ],
    "Label": {
      "en": "NetworkType",
      "zh-cn": "ECS实例网络类型"
    }
  }
  EOT
}

variable "ipv6_address_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Specifies the number of randomly generated IPv6 addresses for the elastic NIC.\nNote You cannot specify the parameters Ipv6Addresses and Ipv6AddressCount at the same time.\nThe change of the property does not affect existing instances."
    },
    "MinValue": 0,
    "Label": {
      "en": "Ipv6AddressCount",
      "zh-cn": "为弹性网卡指定随机生成的IPv6地址数量"
    }
  }
  EOT
}

variable "scheduler_options" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ManagedPrivateSpaceId": {
          "Type": "String",
          "Description": {
            "en": "Managed private resource pool ID."
          },
          "Required": false
        },
        "DedicatedHostClusterId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the dedicated host cluster in which to create the instance. After this parameter is specified, the system selects one dedicated host from the specified cluster to create the instance.\n**Note**: This parameter is valid only when **Tenancy** is set to host.\nWhen you specify both **DedicatedHostId** and **SchedulerOptions.DedicatedHostClusterId**, take note of the following items:\n- If the specified dedicated host belongs to the specified dedicated host cluster, the instance is preferentially deployed on the specified dedicated host.\n- If the specified dedicated host does not belong to the specified dedicated host cluster, the instance cannot be created."
          },
          "Required": false
        }
      }
    },
    "Label": {
      "en": "SchedulerOptions",
      "zh-cn": "调度相关属性信息"
    }
  }
  EOT
}

variable "spot_price_limit" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${SpotStrategy}",
                "SpotWithPriceLimit"
              ]
            },
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PostPaid"
              ]
            }
          ]
        }
      }
    },
    "AssociationProperty": "Number",
    "Description": {
      "en": "The hourly price threshold of a instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Three decimals is allowed at most. "
    },
    "Label": {
      "en": "SpotPriceLimit",
      "zh-cn": "实例的每小时最高价格"
    }
  }
  EOT
}

variable "host_names" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The hostname of instance N. You can use this parameter to specify different hostnames for multiple instances. Take note of the following items:\n- The maximum value of N must be the same as the Amount value. For example, if you set Amount to 2, you can use HostNames.1 and HostNames.2 to specify hostnames for the individual instances. Examples: HostNames.1=test1 and HostNames.2=test2.\n- You cannot specify both HostName and HostNames.N.\n- The hostname cannot start or end with a period (.) or hyphen (-). The hostname cannot contain consecutive periods (.) or hyphens (-).\n- For Windows instances, the hostname must be 2 to 15 characters in length and cannot contain periods (.) or contain only digits. The hostname can contain letters, digits, and hyphens (-).\n- For instances that run other operating systems such as Linux, the hostname must be 2 to 64 characters in length. You can use periods (.) to separate a hostname into multiple segments. Each segment can contain letters, digits, and hyphens (-).",
      "zh-cn": "创建多台实例时，为每台实例指定不同的主机名。"
    },
    "Label": {
      "en": "HostNames",
      "zh-cn": "创建多台实例时"
    },
    "MaxLength": 1000
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}",
      "DefaultValueStrategy": "recent",
      "InstanceChargeType": "$${InstanceChargeType}",
      "SpotStrategy": "$${SpotStrategy}"
    },
    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
    "Description": {
      "en": "Ecs instance supported instance type, make sure it should be correct."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "ECS实例规格"
    }
  }
  EOT
}

variable "allocate_publicip" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "The public ip for ecs instance, if properties is true, will allocate public ip. If property InternetMaxBandwidthOut set to 0, it will not assign public ip."
    },
    "Label": {
      "en": "AllocatePublicIP",
      "zh-cn": "是否创建公网IP"
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
      "LocaleKey": "InstanceSpotStrategy",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${InstanceChargeType}",
            "PostPaid"
          ]
        }
      }
    },
    "Description": {
      "en": "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Value range: \"NoSpot: A regular Pay-As-You-Go instance\", \"SpotWithPriceLimit: A price threshold for a spot instance, \"\"SpotAsPriceGo: A price that is based on the highest Pay-As-You-Go instance. \"Default value: NoSpot."
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "SpotStrategy",
      "zh-cn": "后付费实例的竞价策略"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::Password",
    "Description": {
      "en": "Password of created ecs instance. Must contain at least 3 types of special character, lower character, upper character, number."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "ECS实例登录密码"
    }
  }
  EOT
}

variable "auto_renew_period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false,
      "Visible": {
        "Condition": {
          "Fn::And": [
            {
              "Fn::Equals": [
                "$${InstanceChargeType}",
                "PrePaid"
              ]
            },
            {
              "Fn::Equals": [
                "$${AutoRenew}",
                "True"
              ]
            }
          ]
        }
      }
    },
    "Description": {
      "en": "The time period of auto renew. When the parameter InstanceChargeType is PrePaid, it will take effect.It could be 1, 2, 3, 6, 12, 24, 36, 48, 60. Default value is 1.Old instances will not be changed."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "每次自动续费的时长"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::KeyPair::KeyPairName",
    "Description": {
      "en": "SSH key pair name.Old instances will not be changed."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "ECS实例绑定的密钥对名称"
    }
  }
  EOT
}

variable "io_optimized" {
  type        = string
  default     = "optimized"
  description = <<EOT
  {
    "Description": {
      "en": "The 'optimized' instance can provide better IO performance. Support 'none' and 'optimized' only, default is 'optimized'."
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
      "en": "The ID of the zone to which the instance belongs. For more information, \ncall the DescribeZones operation to query the most recent zone list. \nDefault value is empty, which means random selection."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
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
      "en": "The HPC cluster ID to which the instance belongs.The change of the property does not affect existing instances."
    },
    "Label": {
      "en": "HpcClusterId",
      "zh-cn": "实例所属的HPC集群ID"
    }
  }
  EOT
}

variable "system_disk_category" {
  type        = string
  default     = "cloud_essd"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoSelectFirst": true,
      "AutoChangeType": false,
      "ZoneId": "$${ZoneId}",
      "InstanceType": "$${InstanceType}"
    },
    "AssociationProperty": "ALIYUN::ECS::Disk::SystemDiskCategory",
    "Description": {
      "en": "Category of system disk. Default is cloud_efficiency. support cloud|cloud_efficiency|cloud_ssd|cloud_essd|ephemeral_ssd|cloud_auto|cloud_essd_entry.Old instances will not be changed."
    },
    "AllowedValues": [
      "cloud_essd",
      "cloud_efficiency",
      "cloud_ssd",
      "cloud",
      "cloud_auto",
      "cloud_essd_entry",
      "ephemeral_ssd"
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
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SystemDiskCategory}",
            "cloud_auto"
          ]
        }
      }
    },
    "Description": {
      "en": "Whether enable bursting."
    },
    "Label": {
      "en": "SystemDiskBurstingEnabled",
      "zh-cn": "系统盘是否启用突发"
    }
  }
  EOT
}

variable "eni_mappings" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "NetworkInterfaceTrafficMode": {
              "Type": "String",
              "Description": {
                "en": "The communication mode of the ENI. Valid values:\nStandard: uses the TCP communication mode.\nHighPerformance: enables the Elastic RDMA Interface (ERI) and uses the remote direct memory access (RDMA) communication mode."
              },
              "AllowedValues": [
                "Standard",
                "HighPerformance"
              ],
              "Required": false
            },
            "Description": {
              "AssociationProperty": "TextArea",
              "Type": "String",
              "Description": {
                "en": "Description of your ENI. It is a string of [2, 256] English or Chinese characters."
              },
              "Required": false
            },
            "DeleteOnRelease": {
              "Type": "Boolean",
              "Description": {
                "en": "Specifies whether to retain the ENI when the associated instance is released. Valid values:\n- **true**\n- **false**\nDefault value: **true**.\n**Note**: This parameter takes effect only for secondary ENIs."
              },
              "Required": false
            },
            "VSwitchId": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Description": {
                "en": "VSwitch ID of the specified VPC. Specifies the switch ID for the VPC."
              },
              "Required": false
            },
            "NetworkInterfaceName": {
              "Type": "String",
              "Description": {
                "en": "Name of your ENI. It is a string of [2, 128]  Chinese or English characters. It must begin with a letter and can contain numbers, underscores (_), colons (:), or hyphens (-)."
              },
              "Required": false
            },
            "PrimaryIpAddress": {
              "Type": "String",
              "Description": {
                "en": "The primary private IP address of the ENI.  The specified IP address must have the same Host ID as the VSwitch. If no IP addresses are specified, a random network ID is assigned for the ENI."
              },
              "Required": false
            },
            "Ipv6Addresses": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "The IPv6 address N to assign to the ENI."
              },
              "Required": false,
              "MaxLength": 10
            },
            "NetworkCardIndex": {
              "Type": "Number",
              "Description": {
                "en": "The index of the network card for ENI N.\nTake note of the following items:\n- You can specify network card indexes only for instances of specific instance types.\n- When NetworkInterface.N.InstanceType is set to **Primary**, you can set **NetworkInterface.N.NetworkCardIndex** only to 0 for instance types that support network cards.\n- When **NetworkInterface.N.InstanceType** is set to **Secondary** or left empty, you can set **NetworkInterface.N.NetworkCardIndex** based on instance types if the instance types support network cards."
              },
              "Required": false
            },
            "NetworkInterfaceId": {
              "Type": "String",
              "Description": {
                "en": "The ID of the ENI to attach to the instance.\n**Note**: This parameter takes effect only for secondary ENIs."
              },
              "Required": false
            },
            "SecurityGroupIds": {
              "Type": "Json",
              "Description": {
                "en": "The IDs of security groups to which to assign ENI\nNote: You cannot specify both SecurityGroupId and SecurityGroupIds at the same time."
              },
              "Required": false
            },
            "QueueNumber": {
              "Type": "Number",
              "Description": {
                "en": "The number of queues that are supported by the ENI. Valid values: 1 to 2048.\nWhen you attach the ENI to an instance, make sure that the value of this parameter is less than the maximum number of queues per ENI that is allowed for the instance type. To view the maximum number of queues per ENI allowed for an instance type, you can call DescribeInstanceTypes and then check the return value of MaximumQueueNumberPerEni.\nBy default, this parameter is empty. If you do not specify this parameter, the default number of queues per ENI for the instance type of an instance is used when you attach the ENI to the instance. To learn about the default number of queues per ENI for an instance type, you can call DescribeInstanceTypes and then check the return value of SecondaryEniQueueNumber."
              },
              "Required": false,
              "MinValue": 1,
              "MaxValue": 2048
            },
            "QueuePairNumber": {
              "Type": "Number",
              "Description": {
                "en": "The number of queues supported by the ERI."
              },
              "Required": false
            },
            "Ipv6AddressCount": {
              "Type": "Number",
              "Description": {
                "en": "The number of randomly generated IPv6 addresses that are assigned to the ENI."
              },
              "Required": false
            },
            "InstanceType": {
              "Type": "String",
              "Description": {
                "en": "The type of ENI. Default value: Secondary."
              },
              "AllowedValues": [
                "Primary",
                "Secondary"
              ],
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
      "en": "NetworkInterface to attach to instance. Max support 2 ENIs."
    },
    "Label": {
      "en": "EniMappings",
      "zh-cn": "附加到实例的弹性网卡"
    },
    "MaxLength": 2
  }
  EOT
}

variable "network_options" {
  // The params type Json is not supported, may be ignored when referenced by a resource.
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "EnableJumboFrame": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable the Jumbo Frame feature for the instance. Valid values:\n- **false**: does not enable the Jumbo Frame feature for the instance. The maximum transmission unit (MTU) value of all ENIs on the instance is set to 1500.\n- **true**: enables the Jumbo Frame feature for the instance. The MTU value of all ENIs on the instance is set to 8500.\nDefault value: true.\n**Note**: The Jumbo Frame feature is supported by only 8th-generation or later instance types. "
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Network options."
    },
    "Label": {
      "en": "NetworkOptions",
      "zh-cn": "网络相关属性参数"
    }
  }
  EOT
}

variable "network_interface_queue_number" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of queues supported by the primary ENI. Take note of the following items:\n- The value of this parameter cannot exceed the maximum number of queues per ENI allowed for the instance type.\n- The total number of queues for all ENIs on the instance cannot exceed the queue quota for the instance type.\n- If NetworkInterface.N.InstanceType is set to Primary, you cannot specify NetworkInterfaceQueueNumber but can specify NetworkInterface.N.QueueNumber"
    },
    "Label": {
      "en": "NetworkInterfaceQueueNumber",
      "zh-cn": "主网卡队列数"
    }
  }
  EOT
}

resource "alicloud_ecs_instance_set" "instance_group" {
  // The value var.disk_mappings of arguments data_disks is not block and will be ignore.
  // The value var.eni_mappings of arguments network_interfaces is not block and will be ignore.
  dedicated_host_id                   = var.dedicated_host_id
  resource_group_id                   = var.resource_group_id
  system_disk_description             = var.system_disk_description
  instance_charge_type                = var.instance_charge_type
  ram_role_name                       = var.ram_role_name
  system_disk_performance_level       = var.system_disk_performance_level
  image_id                            = var.image_id
  system_disk_name                    = var.system_disk_disk_name
  tags                                = var.tags
  host_name                           = var.host_name
  launch_template_name                = var.launch_template_name
  vswitch_id                          = var.vswitch_id
  period                              = var.period
  launch_template_id                  = var.launch_template_id
  deletion_protection                 = var.deletion_protection
  security_group_ids                  = var.security_group_ids
  internet_charge_type                = var.internet_charge_type
  deployment_set_id                   = var.deployment_set_id
  instance_name                       = var.instance_name
  internet_max_bandwidth_out          = var.internet_max_bandwidth_out
  unique_suffix                       = var.unique_suffix
  launch_template_version             = var.launch_template_version
  security_enhancement_strategy       = var.security_enhancement_strategy
  auto_release_time                   = var.auto_release_time
  period_unit                         = var.period_unit
  description                         = var.description
  system_disk_size                    = var.system_disk_size
  auto_renew                          = var.auto_renew
  amount                              = var.max_amount
  system_disk_auto_snapshot_policy_id = var.system_disk_auto_snapshot_policy_id
  spot_price_limit                    = var.spot_price_limit
  instance_type                       = var.instance_type
  spot_strategy                       = var.spot_strategy
  password                            = var.password
  auto_renew_period                   = var.auto_renew_period
  key_pair_name                       = var.key_pair_name
  zone_id                             = var.zone_id
  hpc_cluster_id                      = var.hpc_cluster_id
  system_disk_category                = var.system_disk_category
}

output "public_ips" {
  // Could not transform ROS Attribute PublicIps to Terraform attribute.
  value       = null
  description = "Public IP address list of created ecs instances."
}

output "related_order_ids" {
  // Could not transform ROS Attribute RelatedOrderIds to Terraform attribute.
  value       = null
  description = "The related order id list of created ecs instances"
}

output "private_ips" {
  // Could not transform ROS Attribute PrivateIps to Terraform attribute.
  value       = null
  description = "Private IP address list of created ecs instances. Only for VPC instance."
}

output "host_names" {
  // Could not transform ROS Attribute HostNames to Terraform attribute.
  value       = null
  description = "Host names of created instances."
}

output "inner_ips" {
  // Could not transform ROS Attribute InnerIps to Terraform attribute.
  value       = null
  description = "Inner IP address list of the specified instances. Only for classical instances."
}

output "ipv6_address_ids" {
  // Could not transform ROS Attribute Ipv6AddressIds to Terraform attribute.
  value       = null
  description = "IPv6 address IDs list of created ecs instances. Note: The return type is a two-tier list.If the instance does not have any IPv6 address, the element at the corresponding position in the list is null. If all instances does not have any IPv address, will return null."
}

output "zone_ids" {
  // Could not transform ROS Attribute ZoneIds to Terraform attribute.
  value       = null
  description = "Zone id of created instances."
}

output "ipv6_addresses" {
  // Could not transform ROS Attribute Ipv6Addresses to Terraform attribute.
  value       = null
  description = "IPv6 addresses list of created ecs instances. Note: The return type is a two-tier list. If the instance does not have any IPv6 address, the element at the corresponding position in the list is null. If all instances does not have any IPv address, will return null."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The order id list of created instance."
}

output "instance_ids" {
  value       = alicloud_ecs_instance_set.instance_group.instance_ids
  description = "The instance id list of created ecs instances"
}

