variable "bootstrap_action" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Path": {
          "Type": "String",
          "Description": {
            "en": "The path where the bootstrap action script is stored."
          },
          "Required": false
        },
        "Arg": {
          "Type": "String",
          "Description": {
            "en": "The argument that you pass into the bootstrap action."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the bootstrap action."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "BootstrapAction",
      "zh-cn": "引导操作"
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

variable "security_group_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the security group to create. If the ID of the security group is not specified,\nthis name is used to create a new security group. After the cluster is created, you\ncan view the ID of the security group on the Cluster Management page. The default\nsecurity group policy is applied to this security group: Only port 22 is open at the\ninbound and all ports are open at the outbound. You need to specify either SecurityGroupId\nor SecurityGroupName."
    },
    "Label": {
      "en": "SecurityGroupName",
      "zh-cn": "安全组名称"
    }
  }
  EOT
}

variable "config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Replace": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter."
          },
          "Required": false
        },
        "ConfigValue": {
          "Type": "String",
          "Description": {
            "en": "The value of the custom configuration item."
          },
          "Required": false
        },
        "ConfigKey": {
          "Type": "String",
          "Description": {
            "en": "The key of the custom configuration item."
          },
          "Required": false
        },
        "ServiceName": {
          "Type": "String",
          "Description": {
            "en": "The name (capitalized) of the service that is configured by using the custom configuration\nitem."
          },
          "Required": false
        },
        "FileName": {
          "Type": "String",
          "Description": {
            "en": "The name of the file that contains the configuration item."
          },
          "Required": false
        },
        "Encrypt": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "Config",
      "zh-cn": "自定义配置项"
    }
  }
  EOT
}

variable "click_house_conf" {
  type        = any
  description = <<EOT
  {
    "Label": {
      "en": "ClickHouseConf",
      "zh-cn": "ClickHouse集群配置"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the subscription cluster is auto-renewed."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "包年包月集群是否自动续费"
    }
  }
  EOT
}

variable "host_group" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "HostGroupType": {
          "Type": "String",
          "Description": {
            "en": "The type of the instance group. Valid values: MASTER, CORE, and TASK. Currently, you\ncan only create a maximum of one master instance group and core instance group."
          },
          "AllowedValues": [
            "MASTER",
            "CORE",
            "TASK"
          ],
          "Required": true
        },
        "Comment": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter. Not required."
          },
          "Required": false
        },
        "DiskCount": {
          "Type": "Number",
          "Description": {
            "en": "The data disk number of the instance group."
          },
          "Required": true,
          "MinValue": 1
        },
        "NodeCount": {
          "Type": "Number",
          "Description": {
            "en": "The number of nodes in the node group."
          },
          "Required": true
        },
        "SysDiskType": {
          "Type": "String",
          "Description": {
            "en": "The system disk type of the instance group."
          },
          "Required": true
        },
        "ClusterId": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter. Not required."
          },
          "Required": false
        },
        "AutoRenew": {
          "Type": "Boolean",
          "Description": {
            "en": "Indicates whether the instance group is auto-renewed."
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
            "en": "The ID of the VSwitch. A value is required when NetType=vpc."
          },
          "Required": false
        },
        "HostPassword": {
          "Type": "String",
          "Description": {
            "en": "The password of the host. Currently, only gateways are supported."
          },
          "Required": false
        },
        "Period": {
          "AssociationProperty": "PayPeriod",
          "Type": "Number",
          "Description": {
            "en": "The length of the subscription. Unit: months. Valid values: 1, 2, 3, 4, 5, 6, 7, 8,\n9, 12, 24, and 36. A value is required when HostGroup.n.ChargeType=PrePaid."
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
            36
          ],
          "Required": false
        },
        "HostGroupName": {
          "Type": "String",
          "Description": {
            "en": "The name of the instance group."
          },
          "Required": false
        },
        "GpuDriver": {
          "Type": "String",
          "Description": {
            "en": "The GPU driver."
          },
          "Required": false
        },
        "DiskType": {
          "Type": "String",
          "Description": {
            "en": "The data disk type of the instance group. Valid values: CLOUD, CLOUD_EFFICIENCY, CLOUD_SSD, CLOUD_ESSD etc."
          },
          "Required": true
        },
        "DiskCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The data disk capacity of the instance group."
          },
          "Required": true
        },
        "HostGroupId": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter."
          },
          "Required": false
        },
        "ChargeType": {
          "Type": "String",
          "Description": {
            "en": "The billing method for the instance group."
          },
          "AllowedValues": [
            "PayAsYouGo",
            "Subscription"
          ],
          "Required": true
        },
        "CreateType": {
          "Type": "String",
          "Description": {
            "en": "A reserved parameter. Not required."
          },
          "Required": false
        },
        "HostKeyPairName": {
          "Type": "String",
          "Description": {
            "en": "The key pair name of the host group. Currently, only gateways are supported."
          },
          "Required": false
        },
        "SysDiskCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The system disk capacity of the instance group."
          },
          "Required": true
        },
        "InstanceType": {
          "Type": "String",
          "Description": {
            "en": "The instance type of the instance group."
          },
          "Required": true
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "HostGroup",
      "zh-cn": "机器组"
    }
  }
  EOT
}

variable "user_info" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UserName": {
          "Type": "String",
          "Description": {
            "en": "The username for Knox."
          },
          "Required": false
        },
        "UserId": {
          "Type": "String",
          "Description": {
            "en": "The ID of the Alibaba Cloud account for Knox."
          },
          "Required": false
        },
        "Password": {
          "Type": "String",
          "Description": {
            "en": "The password of the cluster."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Label": {
      "en": "UserInfo",
      "zh-cn": "用户信息"
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
      "en": "The name of the cluster. The name can be 1 to 64 characters in length and only contain\nChinese characters, letters, numbers, hyphens (-), and underscores (_)."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "high_availability_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the cluster is a high-availability cluster. A value of true indicates\nthat two master nodes are required."
    },
    "Label": {
      "en": "HighAvailabilityEnable",
      "zh-cn": "是否开启高可用集群"
    }
  }
  EOT
}

variable "option_soft_ware_list" {
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
      "en": "The list of optional services."
    },
    "Label": {
      "en": "OptionSoftWareList",
      "zh-cn": "可选软件列表"
    }
  }
  EOT
}

variable "master_pwd" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The SSH password for the master node. The password must meet the following requirements.\nLength constraints: Minimum length of 8 characters. Maximum length of 30 characters.\nIt must contain three types of characters (uppercase letters, lowercase letters, numbers,\nand special symbols)."
    },
    "Label": {
      "en": "MasterPwd",
      "zh-cn": "Master节点SSH访问密码"
    },
    "MinLength": 8,
    "MaxLength": 30
  }
  EOT
}

variable "ssh_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether SSH is enabled."
    },
    "Label": {
      "en": "SshEnable",
      "zh-cn": "是否开启SSH"
    }
  }
  EOT
}

variable "use_custom_hive_metadb" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "A reserved parameter. Not required."
    },
    "Label": {
      "en": "UseCustomHiveMetaDB",
      "zh-cn": "保留字段，无需填写"
    }
  }
  EOT
}

variable "is_open_public_ip" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether a public IP address is assigned. A value of true indicates that\na bandwidth of 8 MB is set by default."
    },
    "Label": {
      "en": "IsOpenPublicIp",
      "zh-cn": "是否开启公网IP地址"
    }
  }
  EOT
}

variable "authorize_content" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Not required."
    },
    "Label": {
      "en": "AuthorizeContent",
      "zh-cn": "保留字段，无需填写"
    }
  }
  EOT
}

variable "configurations" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Not required."
    },
    "Label": {
      "en": "Configurations",
      "zh-cn": "保留字段，无需填写"
    }
  }
  EOT
}

variable "net_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "NetType"
    },
    "Description": {
      "en": "The type of the network."
    },
    "Label": {
      "en": "NetType",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "user_defined_emr_ecs_role" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The role that is assigned to EMR for calling ECS resources.",
      "zh-cn": "授权给ECS的角色，用于ECS内部访问OSS等其他阿里云服务。"
    },
    "Label": {
      "en": "UserDefinedEmrEcsRole",
      "zh-cn": "授权给ECS的角色"
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
      "zh-cn": "用户自定义标签"
    },
    "MaxLength": 20
  }
  EOT
}

variable "use_local_meta_db" {
  type        = bool
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the local Hive metadatabase is used."
    },
    "Label": {
      "en": "UseLocalMetaDb",
      "zh-cn": "是否使用集群内置MySQL作为Hive元数据库"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the key pair."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对名称"
    }
  }
  EOT
}

variable "io_optimized" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Indicates wether I/O optimization is enabled. Default value: true."
    },
    "Label": {
      "en": "IoOptimized",
      "zh-cn": "是否开启IO优化"
    }
  }
  EOT
}

variable "zone_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone ID."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
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
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of the Vswitch. A value is required when NetType=vpc."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
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
      "en": "The ID of the security group. You can create a security group in the ECS console and\nuse it. Note: If you use an existing security group, the default security group policy\nis applied to this security group: Only port 22 is open at the inbound and all ports\nare open at the outbound. You need to specify either SecurityGroupId or SecurityGroupName."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "安全组ID"
    }
  }
  EOT
}

variable "deposit_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The hosting type."
    },
    "Label": {
      "en": "DepositType",
      "zh-cn": "集群的托管类型"
    }
  }
  EOT
}

variable "machine_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The type of the machine."
    },
    "Label": {
      "en": "MachineType",
      "zh-cn": "机器类型"
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
      "en": "The length of the subscription. Unit: months. Valid values: 1, 2, 3, 4, 5, 6, 7, 8,\n9, 12, 24, and 36. A value is required when ChargeType=PrePaid."
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
      36
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "包年包月时长"
    }
  }
  EOT
}

variable "meta_store_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Meta store type. Allow types:\nlocal: Local cluster\nunified: Unified meta data\nuser_rds: User's RDS"
    },
    "Label": {
      "en": "MetaStoreType",
      "zh-cn": "元数据类型"
    }
  }
  EOT
}

variable "emr_ver" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The version of EMR."
    },
    "Label": {
      "en": "EmrVer",
      "zh-cn": "EMR版本"
    }
  }
  EOT
}

variable "cluster_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the cluster. Allowd values: HADOOP, KAFKA, DRUID, ZOOKEEPER, DATA_SCIENCE, GATEWAY etc."
    },
    "Label": {
      "en": "ClusterType",
      "zh-cn": "集群类型"
    }
  }
  EOT
}

variable "eas_enable" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Indicates whether the cluster is a high-security cluster."
    },
    "Label": {
      "en": "EasEnable",
      "zh-cn": "是否为高安全集群"
    }
  }
  EOT
}

variable "related_cluster_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the primary cluster (when the cluster that you create is a Gateway cluster)."
    },
    "Label": {
      "en": "RelatedClusterId",
      "zh-cn": "Gateway集群关联的主集群ID"
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
      "en": "The ID of the VPC. A value is required when NetType=vpc."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "charge_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Description": {
      "en": "The billing method. Valid values: PostPaid and PrePaid. PostPaid: pay-as-you-go. PrePaid:\nsubscription."
    },
    "Label": {
      "en": "ChargeType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "white_list_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Not required."
    },
    "Label": {
      "en": "WhiteListType",
      "zh-cn": "白名单类型"
    }
  }
  EOT
}

variable "meta_store_conf" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Meta store conf of specific meta store type. If MetaStoreType=user_rds, MetaStoreConf should be like {\"dbUrl\":\"jdbc:mysql://xxxxxx\", \"dbUserName\":\"username\", \"dbPassword\":\"password\"}"
    },
    "Label": {
      "en": "MetaStoreConf",
      "zh-cn": "元数据配置"
    }
  }
  EOT
}

variable "instance_generation" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The generation of the ECS instances."
    },
    "Label": {
      "en": "InstanceGeneration",
      "zh-cn": "ECS实例规格族"
    }
  }
  EOT
}

variable "log_path" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The log path in OSS."
    },
    "Label": {
      "en": "LogPath",
      "zh-cn": "OSS日志路径"
    }
  }
  EOT
}

variable "init_custom_hive_metadb" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "A reserved parameter. Not required."
    },
    "Label": {
      "en": "InitCustomHiveMetaDB",
      "zh-cn": "保留字段，无需填写"
    }
  }
  EOT
}

resource "alicloud_emr_cluster" "cluster" {
  bootstrap_action          = var.bootstrap_action
  resource_group_id         = var.resource_group_id
  host_group                = var.host_group
  name                      = var.name
  high_availability_enable  = var.high_availability_enable
  option_software_list      = var.option_soft_ware_list
  master_pwd                = var.master_pwd
  ssh_enable                = var.ssh_enable
  is_open_public_ip         = var.is_open_public_ip
  user_defined_emr_ecs_role = var.user_defined_emr_ecs_role
  tags                      = var.tags
  use_local_metadb          = var.use_local_meta_db
  key_pair_name             = var.key_pair_name
  zone_id                   = var.zone_id
  vswitch_id                = var.vswitch_id
  security_group_id         = var.security_group_id
  deposit_type              = var.deposit_type
  period                    = var.period
  meta_store_type           = var.meta_store_type
  emr_ver                   = var.emr_ver
  cluster_type              = var.cluster_type
  eas_enable                = var.eas_enable
  related_cluster_id        = var.related_cluster_id
  charge_type               = var.charge_type
}

output "cluster_id" {
  value       = alicloud_emr_cluster.cluster.id
  description = "The ID of the cluster."
}

output "master_node_pub_ips" {
  // Could not transform ROS Attribute MasterNodePubIps to Terraform attribute.
  value       = null
  description = "The public ip list of the cluster master nodes."
}

output "master_node_inner_ips" {
  // Could not transform ROS Attribute MasterNodeInnerIps to Terraform attribute.
  value       = null
  description = "The inner ip list of the cluster master nodes."
}

output "host_groups" {
  // Could not transform ROS Attribute HostGroups to Terraform attribute.
  value       = null
  description = "The host group list of the cluster."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

