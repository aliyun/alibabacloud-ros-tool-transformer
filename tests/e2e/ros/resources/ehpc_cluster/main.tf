variable "volume_protocol" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the protocol that is used by the file system. Valid values:\nnfs\nsmb\nDefault value: nfs"
    },
    "Label": {
      "en": "VolumeProtocol",
      "zh-cn": "共享存储的协议类型"
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
      "en": "The ID of the resource group.\nYou can call the ListResourceGroups operation to obtain the ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "compute_enable_ht" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the compute nodes support hyper-threading. Valid values:\ntrue: Hyper-threading is supported.\nfalse: Hyper-threading is not supported.\nDefault value: true"
    },
    "Label": {
      "en": "ComputeEnableHt",
      "zh-cn": "计算节点是否支持超线程"
    }
  }
  EOT
}

variable "without_elastic_ip" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether the logon node uses an elastic IP address (EIP). Default value: false"
    },
    "Label": {
      "en": "WithoutElasticIp",
      "zh-cn": "登录节点是否使用弹性公网IP"
    }
  }
  EOT
}

variable "system_disk_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the system disk. Valid values:\ncloud_efficiency: ultra disk.\ncloud_ssd: SSD.\ncloud_essd: ESSD.\nDefault value: cloud_ssd"
    },
    "Label": {
      "en": "SystemDiskType",
      "zh-cn": "系统盘的类型"
    }
  }
  EOT
}

variable "remote_vis_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable Virtual Network Computing (VNC). Valid values:\ntrue: enables VNC\nfalse: disables VNC\nDefault value: false"
    },
    "Label": {
      "en": "RemoteVisEnable",
      "zh-cn": "是否开启远程可视化"
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
      "en": "Cluster name. 2-64 characters in length, allowing only include Chinese, letters, numbers, dashes (-) and underscore (_), must begin with a letter or Chinese."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "volume_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the file system. If you leave the parameter empty, a Performance NAS file system is created by default."
    },
    "Label": {
      "en": "VolumeId",
      "zh-cn": "阿里云NAS实例ID"
    }
  }
  EOT
}

variable "ram_role_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Resource Access Management (RAM) role.\nYou can call the ListRoles operation provided by RAM to query the created RAM roles."
    },
    "Label": {
      "en": "RamRoleName",
      "zh-cn": "实例RAM角色名称"
    }
  }
  EOT
}

variable "deploy_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The mode in which the cluster is deployed. Valid values:\nStandard: An account node, a scheduling node, a logon node, and multiple compute nodes are separately deployed.\nSimple: A management node, a logon node, and multiple compute nodes are deployed. The management node consists of an account node and a scheduling node. The logon node and compute nodes are separately deployed.\nTiny: A management node and multiple compute nodes are deployed. The management node consists of an account node, a scheduling node, and a logon node. The compute nodes are separately deployed.\nDefault value: Standard"
    },
    "Label": {
      "en": "DeployMode",
      "zh-cn": "部署模式"
    }
  }
  EOT
}

variable "post_install_script" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Args": {
          "Type": "String",
          "Description": {
            "en": "N-th (n numbered starting from 1, you can have multiple, maximum 16) execution parameters after the installation script."
          },
          "Required": false
        },
        "Url": {
          "Type": "String",
          "Description": {
            "en": "N-th (n numbered starting with 1, can have multiple, maximum 16) after installation script Download."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "PostInstallScript",
      "zh-cn": "脚本的下载地址和执行参数"
    },
    "MaxLength": 16
  }
  EOT
}

variable "image_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mirror Id, if ImageType a system, based on the image ID is determined only according OsTag; if self, others, or marketplace, ImageId is mandatory."
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像ID"
    }
  }
  EOT
}

variable "is_compute_ess" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable auto scaling. Valid values:\ntrue: enables auto scaling\nfalse: disables auto scaling\nDefault value: false"
    },
    "Label": {
      "en": "IsComputeEss",
      "zh-cn": "是否启用自动伸缩"
    }
  }
  EOT
}

variable "ecs_order_login_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Log cluster node instance specifications."
    },
    "Label": {
      "en": "EcsOrderLoginInstanceType",
      "zh-cn": "集群登录节点实例规格"
    }
  }
  EOT
}

variable "job_queue" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "\tThe queue to which the compute nodes are added."
    },
    "Label": {
      "en": "JobQueue",
      "zh-cn": "计算节点加入的队列"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}",
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "VPC in switch ID. Products currently only supports VPC network."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
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
      "en": "The purchase of long resources, units: week / month / year. When the value of the parameter EcsChargeType when PrePaid take effect and for the selected value will be."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "购买集群节点的时长"
    }
  }
  EOT
}

variable "compute_spot_strategy" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Compute nodes bidding strategy, value NoSpot, SpotWithPriceLimit or SpotAsPriceGo"
    },
    "AllowedValues": [
      "NoSpot",
      "SpotWithPriceLimit",
      "SpotAsPriceGo"
    ],
    "Label": {
      "en": "ComputeSpotStrategy",
      "zh-cn": "计算节点的竞价策略"
    }
  }
  EOT
}

variable "ehpc_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of E-HPC. By default, the parameter is set to the latest version number."
    },
    "Label": {
      "en": "EhpcVersion",
      "zh-cn": "E-HPC产品版本"
    }
  }
  EOT
}

variable "ecs_order_manager_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster control node instance specifications."
    },
    "Label": {
      "en": "EcsOrderManagerInstanceType",
      "zh-cn": "集群管控节点的实例规格"
    }
  }
  EOT
}

variable "volume_mountpoint" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The mount target of the file system. Take note of the following information:\nIf you do not specify the VolumeId parameter, you can leave the VolumeMountpoint parameter empty. A mount target is created by default.\nIf you specify the VolumeId parameter, the VolumeMountpoint parameter is required."
    },
    "Label": {
      "en": "VolumeMountpoint",
      "zh-cn": "NAS的VPC挂载点"
    }
  }
  EOT
}

variable "ecs_order_manager_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Control node number can be 1, 2"
    },
    "Label": {
      "en": "EcsOrderManagerCount",
      "zh-cn": "集群管控节点的实例数量"
    }
  }
  EOT
}

variable "ecs_order_compute_instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster computing node instance specifications."
    },
    "Label": {
      "en": "EcsOrderComputeInstanceType",
      "zh-cn": "集群计算节点的实例规格"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "The ID of the virtual private cloud (VPC) to which the E-HPC cluster belongs."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "集群所属的VPC ID"
    }
  }
  EOT
}

variable "application" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Tag": {
          "Type": "String",
          "Description": {
            "en": "Application software tag (SoftwareTag), for example OpenMPI_11.1."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Application software tag (SoftwareTag) list, You can call ListSoftwares API to query."
    },
    "Label": {
      "en": "Application",
      "zh-cn": "应用软件"
    },
    "MaxLength": 10
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The purchase of long-resources unit. Alternatively value Week / Month / year."
    },
    "AllowedValues": [
      "Week",
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "购买集群节点的时长单位"
    }
  }
  EOT
}

variable "image_owner_alias" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mirror type: system, self, others or marketplace"
    },
    "AllowedValues": [
      "system",
      "self",
      "others",
      "marketplace"
    ],
    "Label": {
      "en": "ImageOwnerAlias",
      "zh-cn": "镜像类型"
    }
  }
  EOT
}

variable "ecs_order_compute_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Computing node number, which ranges from: 0-99."
    },
    "MinValue": 0,
    "Label": {
      "en": "EcsOrderComputeCount",
      "zh-cn": "集群计算节点数量"
    },
    "MaxValue": 99
  }
  EOT
}

variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "Cluster description, 2 to 128 characters."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "集群的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

variable "security_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "If you do not use an existing security group (SecurityGroupId is empty), then use this name to create a new security group, the default policy. Format Requirements Reference ECS security group name."
    },
    "Label": {
      "en": "SecurityGroupName",
      "zh-cn": "安全组名称"
    }
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The size of the system disk. Unit: GB\nValid values: 40 to 500\nDefault value: 40"
    },
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "additional_volumes" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "VolumeProtocol": {
          "Type": "String",
          "Description": {
            "en": "The type of the protocol that is used by the additional file system. Valid values:\nnfs\nsmb\nDefault value: nfs"
          },
          "Required": false,
          "Default": "nfs"
        },
        "LocalDirectory": {
          "Type": "String",
          "Description": {
            "en": "The local directory to which the additional file system is mounted."
          },
          "Required": true
        },
        "VolumeId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the additional file system."
          },
          "Required": true
        },
        "RemoteDirectory": {
          "Type": "String",
          "Description": {
            "en": "The remote directory to which the additional file system is mounted."
          },
          "Required": false
        },
        "VolumeType": {
          "Type": "String",
          "Description": {
            "en": "The type of the additional shared storage. Only nas file systems are supported."
          },
          "Required": false,
          "Default": "nas"
        },
        "JobQueue": {
          "Type": "String",
          "Description": {
            "en": "The queue of the nodes to which the additional file system is attached."
          },
          "Required": false
        },
        "VolumeMountpoint": {
          "Type": "String",
          "Description": {
            "en": "The mount target of the additional file system."
          },
          "Required": true
        },
        "Location": {
          "Type": "String",
          "Description": {
            "en": "The type of the cluster. Valid value: PublicCloud."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "AdditionalVolumes",
      "zh-cn": "挂载的共享存储"
    },
    "MaxLength": 10
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "true: automatic renewals; false: no automatic renewals."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否自动续费"
    }
  }
  EOT
}

variable "compute_spot_price_limit" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Set an example of the highest price per hour, are floating-point values, in the range of the current price range."
    },
    "Label": {
      "en": "ComputeSpotPriceLimit",
      "zh-cn": "计算节点的每小时最高价格"
    }
  }
  EOT
}

variable "ram_node_types" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "AllowedValues": [
          "scheduler",
          "account",
          "login",
          "manager",
          "compute"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "When authorizing instance configuration, the node type to which the RAM role is bound.\nWhen the value of DeployMode is Standard, the value range: scheduler, account, login, compute.\nWhen the value of DeployMode is Simple, the value range: manager, login, compute.\nWhen the value of DeployMode is Tiny, the value range: manager, compute."
    },
    "Label": {
      "en": "RamNodeTypes",
      "zh-cn": "授权实例角色的节点名称详情"
    },
    "MaxLength": 4
  }
  EOT
}

variable "client_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The version of the E-HPC client. By default, the parameter is set to the latest version number.\nYou can call the ListCurrentClientVersion operation to query the current version of the E-HPC client."
    },
    "Label": {
      "en": "ClientVersion",
      "zh-cn": "集群客户端版本"
    }
  }
  EOT
}

variable "volume_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the shared storage. Only Apsara File Storage nas file systems are supported."
    },
    "Label": {
      "en": "VolumeType",
      "zh-cn": "共享存储类型"
    }
  }
  EOT
}

variable "input_file_url" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The URL of the job files that are uploaded to an Object Storage Service (OSS) bucket."
    },
    "Label": {
      "en": "InputFileUrl",
      "zh-cn": "上传到OSS的作业文件的URL地址"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Root password of jump server (login node). 8 to 30 characters, must contain three (upper and lower case letters, numbers and special symbols). ! Supports the following special characters :() `~ @ # $% ^ & * - + = | {} []:; '<>, / Be sure to use the HTTPS protocol API call to avoid password leaks that may occur.?."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "登录节点的root密码"
    },
    "MinLength": 8,
    "MaxLength": 30
  }
  EOT
}

variable "auto_renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Duration of each automatic renewals, AutoRenew take effect when AutoRenew is True."
    },
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
    "Description": {
      "en": "Key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对"
    }
  }
  EOT
}

variable "remote_directory" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Mount shared storage remote directory. The final path to the mount point and mount the remote directory composition: NasMountpoint: / RemoteDirectory"
    },
    "Label": {
      "en": "RemoteDirectory",
      "zh-cn": "挂载共享存储的远程目录"
    }
  }
  EOT
}

variable "network_interface_traffic_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Communication mode of an elastic NIC. Value values:\n- **Standard**: The TCP communication mode is used.\n- **HighPerformance**: Enables the Elastic RDMA Interface (ERI) and uses the RDMA communication mode."
    },
    "Label": {
      "en": "NetworkInterfaceTrafficMode",
      "zh-cn": "弹性网卡的通信方式"
    }
  }
  EOT
}

variable "scc_cluster_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "When SCC models, if you pass this field, then the specified SccCluster create Scc instance, otherwise it will create an instance for the user."
    },
    "Label": {
      "en": "SccClusterId",
      "zh-cn": "SCC实例ID"
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
      "en": "Available area ID."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "system_disk_level" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The performance level of the ESSD that is created as the system disk. Valid values:\nPL0: A single ESSD can deliver up to 10,000 input/output operations per second (IOPS) of random read/write.\nPL1: A single ESSD can deliver up to 50,000 IOPS of random read/write.\nPL2: A single ESSD can deliver up to 100,000 IOPS of random read/write.\nPL3: A single ESSD can deliver up to 1,000,000 IOPS of random read/write.\nDefault value: PL1",
      "zh-cn": "创建ESSD云盘作为系统盘使用时，设置云盘的性能等级。"
    },
    "Label": {
      "en": "SystemDiskLevel",
      "zh-cn": "创建ESSD云盘作为系统盘使用时"
    }
  }
  EOT
}

variable "ecs_order_login_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Login node number can only be 1."
    },
    "MinValue": 1,
    "Label": {
      "en": "EcsOrderLoginCount",
      "zh-cn": "集群登录节点数量"
    },
    "MaxValue": 1
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
      "en": "Security group ID."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "scheduler_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the scheduler. Valid values:\npbs\nslurm\nopengridscheduler\ndeadline\nDefault value: pbs"
    },
    "Label": {
      "en": "SchedulerType",
      "zh-cn": "调度器类型"
    }
  }
  EOT
}

variable "account_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The service type of the domain account. Valid values:\nnis\nldap\nDefault value: nis"
    },
    "Label": {
      "en": "AccountType",
      "zh-cn": "域账号服务类型"
    }
  }
  EOT
}

variable "ha_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the high availability feature. Valid values:\ntrue: enables the high availability feature\nfalse: disables the high availability feature\nDefault value: false\nNote If high availability is enabled, primary management nodes and secondary management nodes are used."
    },
    "Label": {
      "en": "HaEnable",
      "zh-cn": "是否开启高可用"
    }
  }
  EOT
}

variable "os_tag" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Operating system image tag. You can call ListImages API to query."
    },
    "Label": {
      "en": "OsTag",
      "zh-cn": "操作系统镜像标签"
    }
  }
  EOT
}

variable "ecs_charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "ECS instance payment type, PostPaid: Pay-As-You-Go.PrePaid: Subscription.If you choose PrePaid, automatic renewal will be enabled by default, and closed when node is released."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "EcsChargeType",
      "zh-cn": "集群使用ECS实例的付费类型"
    }
  }
  EOT
}

resource "alicloud_ehpc_cluster" "cluster" {
  volume_protocol          = var.volume_protocol
  resource_group_id        = var.resource_group_id
  compute_enable_ht        = var.compute_enable_ht
  without_elastic_ip       = var.without_elastic_ip
  system_disk_type         = var.system_disk_type
  remote_vis_enable        = var.remote_vis_enable
  volume_id                = var.volume_id
  ram_role_name            = var.ram_role_name
  deploy_mode              = var.deploy_mode
  post_install_script      = var.post_install_script
  image_id                 = var.image_id
  is_compute_ess           = var.is_compute_ess
  job_queue                = var.job_queue
  vswitch_id               = var.vswitch_id
  period                   = var.period
  compute_spot_strategy    = var.compute_spot_strategy
  ehpc_version             = var.ehpc_version
  volume_mountpoint        = var.volume_mountpoint
  vpc_id                   = var.vpc_id
  application              = var.application
  period_unit              = var.period_unit
  image_owner_alias        = var.image_owner_alias
  description              = var.description
  security_group_name      = var.security_group_name
  system_disk_size         = var.system_disk_size
  additional_volumes       = var.additional_volumes
  auto_renew               = var.auto_renew
  compute_spot_price_limit = var.compute_spot_price_limit
  ram_node_types           = var.ram_node_types
  client_version           = var.client_version
  volume_type              = var.volume_type
  input_file_url           = var.input_file_url
  password                 = var.password
  auto_renew_period        = var.auto_renew_period
  key_pair_name            = var.key_pair_name
  remote_directory         = var.remote_directory
  scc_cluster_id           = var.scc_cluster_id
  zone_id                  = var.zone_id
  system_disk_level        = var.system_disk_level
  security_group_id        = var.security_group_id
  scheduler_type           = var.scheduler_type
  account_type             = var.account_type
  ha_enable                = var.ha_enable
  os_tag                   = var.os_tag
  ecs_charge_type          = var.ecs_charge_type
}

output "cluster_id" {
  value       = alicloud_ehpc_cluster.cluster.id
  description = "Cluster Id."
}

output "ecs_info" {
  // Could not transform ROS Attribute EcsInfo to Terraform attribute.
  value       = null
  description = <<EOT
  "A data structure describing the number and specifications of ECS for various components of the cluster.\nYou will get results similar to the following: EcsInfo: {\"Manager\": {\"Count\": 2, \"InstanceType\": \"ecs.n1.large\"}, \"Compute\": {\"Count\": 8, \"InstanceType\": \"ecs.n1.large\"}, \"Login\": {\"Count\": 1, \"InstanceType\": \"ecs.n1.large\"}}"
  EOT
}

output "security_group_id" {
  value       = alicloud_ehpc_cluster.cluster.security_group_id
  description = "Security group ID."
}

output "name" {
  value       = alicloud_ehpc_cluster.cluster.cluster_name
  description = "Cluster name."
}

