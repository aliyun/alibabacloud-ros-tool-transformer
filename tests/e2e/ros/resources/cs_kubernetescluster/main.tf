variable "endpoint_public_access" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable the public network API Server:\ntrue: which means that the public network API Server is open.\nfalse: If set to false, the API server on the public network will not be created, only the API server on the private network will be created.Default to false.",
      "zh-cn": "是否开启公网APIServer"
    },
    "Label": {
      "en": "EndpointPublicAccess",
      "zh-cn": "是否开启公网APIServer"
    }
  }
  EOT
}

variable "soc_enabled" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Valid values:\ntrue: enables reinforcement based on classified protection.\nfalse: disables reinforcement based on classified protection.\nDefault value: false.",
      "zh-cn": "是否启用基于分级保护的加固"
    },
    "Label": {
      "en": "SocEnabled",
      "zh-cn": "是否启用基于分级保护的加固"
    }
  }
  EOT
}

variable "platform" {
  type        = string
  default     = "CentOS"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The release version of the operating system. Valid values:\nCentOS\nAliyunLinux\nQbootAliyunLinux\nQboot\nWindows\nWindowsCore\nDefault value: CentOS.",
      "zh-cn": "操作系统发布版本"
    },
    "AllowedValues": [
      "CentOS",
      "QbootAliyunLinux",
      "Qboot",
      "Windows",
      "WindowsCore",
      "AliyunLinux"
    ],
    "Label": {
      "en": "Platform",
      "zh-cn": "操作系统的发布版本"
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
      "en": "The ID of resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "master_system_disk_category" {
  type        = string
  default     = "cloud_ssd"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "DiskCategory"
    },
    "Description": {
      "en": "Master disk system disk type. The value includes:\ncloud_efficiency: efficient cloud disk\ncloud_ssd: SSD cloud disk\ncloud_essd: ESSD cloud diskDefault to cloud_ssd."
    },
    "AllowedValues": [
      "cloud_essd",
      "cloud_efficiency",
      "cloud_ssd"
    ],
    "Label": {
      "zh-cn": "Master节点系统盘类型"
    }
  }
  EOT
}

variable "master_count" {
  type        = number
  default     = 3
  description = <<EOT
  {
    "Description": {
      "en": "Number of master instances. The value can be 3 or 5. The default value is 3."
    },
    "AllowedValues": [
      3,
      5
    ],
    "Label": {
      "en": "MasterCount",
      "zh-cn": "Master实例个数"
    }
  }
  EOT
}

variable "ssh_flags" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to enable public network SSH login:\ntrue: open\nfalse: not open",
      "zh-cn": "是否开放公网SSH登录"
    },
    "Label": {
      "en": "SshFlags",
      "zh-cn": "是否开放公网SSH登录"
    }
  }
  EOT
}

variable "load_balancer_spec" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "AutoChangeType": false
    },
    "Description": {
      "en": "The specification of the Server Load Balancer instance. Allowed value: slb.s1.small|slb.s2.small|slb.s2.medium|slb.s3.small|slb.s3.medium|slb.s3.large",
      "zh-cn": "负载均衡实例规格"
    },
    "AllowedValues": [
      "slb.s1.small",
      "slb.s2.small",
      "slb.s2.medium",
      "slb.s3.small",
      "slb.s3.medium",
      "slb.s3.large"
    ],
    "Label": {
      "en": "LoadBalancerSpec",
      "zh-cn": "负载均衡实例规格"
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
      "en": "The name of the cluster. The cluster name can use uppercase and lowercase letters, Chinese characters, numbers, and dashes."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "master_data_disks" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Category": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "DiskCategory"
          },
          "Type": "String",
          "Description": {
            "en": "Data disk type. Value includes:\ncloud: ordinary cloud disk\ncloud_efficiency: efficient cloud disk\ncloud_ssd: SSD cloud disk"
          },
          "AllowedValues": [
            "cloud_essd",
            "cloud_efficiency",
            "cloud_ssd",
            "cloud"
          ],
          "Required": true,
          "Label": {
            "zh-cn": "类型"
          },
          "Default": "cloud_efficiency"
        },
        "Size": {
          "Type": "Number",
          "Description": {
            "en": "Data disk size in GiB."
          },
          "Required": true,
          "MinValue": 1,
          "Label": {
            "zh-cn": "容量"
          },
          "Default": 100
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${MasterDataDisk}",
            true
          ]
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Master data disk type, size and other configuration combinations. This parameter is valid only when the master node data disk is mounted."
    },
    "Label": {
      "en": "MasterDataDisks",
      "zh-cn": "Master数据盘类型、大小等配置"
    }
  }
  EOT
}

variable "is_enterprise_security_group" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean",
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${SecurityGroupId}"
          ]
        }
      }
    },
    "Description": {
      "en": "Specifies whether to create an advanced security group. \nThis parameter takes effect only if security_group_id is left empty.\nNote You must specify an advanced security group for a cluster that has Terway installed.\ntrue: creates an advanced security group.\nfalse: does not create an advanced security group.\nDefault value: false.",
      "zh-cn": "是否创建高级安全组"
    },
    "Label": {
      "en": "IsEnterpriseSecurityGroup",
      "zh-cn": "是否创建高级安全组"
    }
  }
  EOT
}

variable "master_zone_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ZoneId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Zone ids of master node virtual switches belongs to."
    },
    "Label": {
      "zh-cn": "Master节点的交换机可用区"
    }
  }
  EOT
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = <<EOT
  {
    "Description": {
      "en": "The type of operating system. Valid values:\nWindows\nLinux\nDefault value: Linux.",
      "zh-cn": "操作系统类型"
    },
    "AllowedValues": [
      "Windows",
      "Linux"
    ],
    "Label": {
      "en": "OsType",
      "zh-cn": "操作系统的类型"
    }
  }
  EOT
}

variable "node_name_mode" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "A custom node name consists of a prefix, an IP substring, and a suffix. The format iscustomized,{prefix},{ip_substring},{suffix}, for example: customized,aliyun.com,5,test.\n- The prefix and suffix can contain one or more parts that are separated by periods (.). Each part can contain lowercase letters, digits, and hyphens (-). The node name must start and end with a lowercase letter or digit.\n- The IP substring length specifies the number of digits to be truncated from the end of the node IP address. Valid values: 5 to 12. For example, if the node IP address is 192.168.0.55, the prefix is aliyun.com, the IP substring length is 5, and the suffix is test, the node name will be aliyun.com00055test."
    },
    "Label": {
      "en": "NodeNameMode",
      "zh-cn": "自定义节点名"
    }
  }
  EOT
}

variable "worker_zone_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationProperty": "ZoneId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Zone ids of worker node virtual switches belongs to."
    },
    "Label": {
      "en": "WorkerZoneIds",
      "zh-cn": "Worker节点的交换机可用区信息"
    }
  }
  EOT
}

variable "proxy_mode" {
  type        = string
  default     = "iptables"
  description = <<EOT
  {
    "Description": {
      "en": "kube-proxy proxy mode, supports both iptables and ipvs modes. The default is iptables."
    },
    "Label": {
      "en": "ProxyMode",
      "zh-cn": "kube-proxy代理模式"
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
          "Description": {
            "en": "Tag value."
          },
          "Required": false
        },
        "Key": {
          "Type": "String",
          "Description": {
            "en": "Tag key."
          },
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
      "en": "Tag the cluster."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "集群标签"
    }
  }
  EOT
}

variable "master_instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Master node payment type. The optional values are:\nPrePaid: prepaid\nPostPaid: Pay as you go\nDefault to PostPaid."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ]
  }
  EOT
}

variable "container_cidr" {
  type        = string
  default     = "172.16.0.0/16"
  description = <<EOT
  {
    "Description": {
      "en": "The container network segment cannot conflict with the VPC network segment. When the sytem is selected to automatically create a VPC, the network segment 172.16.0.0/16 is used by default."
    },
    "Label": {
      "en": "ContainerCidr",
      "zh-cn": "Pod网络地址段"
    }
  }
  EOT
}

variable "delete_options" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DeleteMode": {
          "Type": "String",
          "Description": {
            "en": "Deletion policy of this type of resource. The value can be:\n- delete: delete the resource.\n- retain: retain the resource."
          },
          "AllowedValues": [
            "delete",
            "retain"
          ],
          "Required": false
        },
        "ResourceType": {
          "Type": "String",
          "Description": {
            "en": "Resource type. The value can be:\n- SLB: SLB resource created by service. It is deleted by default but can be retained\n- ALB: ALB Ingress Controller Created ALB resource. It is reserved by default and can be deleted\n- SLS_Data: log service Project used by the cluster log function. This service is reserved by default and can be deleted\n- SLS_ControlPlane: Project log service used for logs of the managed cluster control plane. This service is reserved by default and can be deleted\n- PrivateZone: ACK Serverless PrivateZone resource created in the cluster. It is reserved by default and can be deleted\n"
          },
          "AllowedValues": [
            "SLB",
            "ALB",
            "SLS_Data",
            "SLS_ControlPlane",
            "PrivateZone"
          ],
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Delete options, only work for deleting resource."
    },
    "Label": {
      "en": "DeleteOptions",
      "zh-cn": "集群关联资源的删除选项"
    }
  }
  EOT
}

variable "cpu_policy" {
  type        = string
  default     = "none"
  description = <<EOT
  {
    "Description": {
      "en": "CPU policy. The cluster version is 1.12.6 and above supports both static and none strategies.",
      "zh-cn": "当集群版本为1.12.6及以上版本时该参数有效"
    },
    "AllowedValues": [
      "static",
      "none"
    ],
    "Label": {
      "en": "CpuPolicy",
      "zh-cn": "CPU策略"
    }
  }
  EOT
}

variable "key_pair" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::KeyPair::KeyPairName",
    "Description": {
      "en": "Key pair name. Specify one of KeyPair or LoginPassword."
    },
    "Label": {
      "en": "KeyPair",
      "zh-cn": "密钥对名称"
    }
  }
  EOT
}

variable "node_cidr_mask" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The maximum number of IP addresses that can be assigned to nodes. \nThis number is determined by the specified pod CIDR block. \nThis parameter takes effect only if the cluster uses the Flannel plug-in.Default value: 25."
    },
    "Label": {
      "en": "NodeCidrMask",
      "zh-cn": "可分配给节点的最大IP地址数量"
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
      "en": "Specifies whether to enable deletion protection for the cluster. \nAfter deletion protection is enabled, the cluster cannot be deleted \nin the ACK console or by calling API operations. Valid values:true: enables deletion protection for the cluster.\nfalse: disables deletion protection for the cluster.\nDefault value: false.",
      "zh-cn": "是否启用删除保护功能"
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否启用删除保护功能"
    }
  }
  EOT
}

variable "master_auto_renew_period" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal cycle, which takes effect when prepaid and automatic renewal are selected, and is required:\nWhen PeriodUnit = Week, the values are: {\"1\", \"2\", \"3\"}\nWhen PeriodUnit = Month, the value is {\"1\", \"2\", \"3\", \"6\", \"12\"}\nDefault to 1."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12
    ]
  }
  EOT
}

variable "time_zone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The time zone of the cluster."
    },
    "Label": {
      "en": "TimeZone",
      "zh-cn": "集群的时区"
    }
  }
  EOT
}

variable "vpc_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
    "Description": {
      "en": "VPC ID."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "master_auto_renew" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether the master node automatically renews. It takes effect when the value of MasterInstanceChargeType is PrePaid. The optional values are:\ntrue: automatic renewal\nfalse: do not renew automatically\nDefault to true."
    }
  }
  EOT
}

variable "user_ca" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The CA of cluster"
    },
    "Label": {
      "en": "UserCa",
      "zh-cn": "集群的CA"
    }
  }
  EOT
}

variable "snat_entry" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "Description": {
      "en": "Whether to configure SNAT for the network.\nWhen a VPC can access the public network environment, set it to false.\nWhen an existing VPC cannot access the public network environment:\nWhen set to True, SNAT is configured and the public network environment can be accessed at this time.\nIf set to false, it means that SNAT is not configured and the public network environment cannot be accessed at this time.\nDefault to true."
    },
    "Label": {
      "en": "SnatEntry",
      "zh-cn": "是否为网络配置SNAT"
    }
  }
  EOT
}

variable "master_data_disk" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether the master node mounts data disks can be selected as:\ntrue: mount the data disk\nfalse: no data disk is mounted, default is false",
      "zh-cn": "Master节点是否挂载数据盘"
    },
    "Label": {
      "en": "MasterDataDisk",
      "zh-cn": "Master节点是否挂载数据盘"
    }
  }
  EOT
}

variable "maintenance_window" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Recurrence": {
          "Type": "String",
          "Description": {
            "en": "The RFC5545 Recurrence Rule currently only supports FREQ=WEEKLY and does not support specifying COUNT or UNTIL"
          },
          "Required": false
        },
        "MaintenanceTime": {
          "Type": "String",
          "Description": {
            "en": "Maintenance start time. RFC3339 standard format."
          },
          "Required": false
        },
        "WeeklyPeriod": {
          "Type": "String",
          "Description": {
            "en": "Maintenance cycle. Multiple values are separated by a half-comma (,). Values: {Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday}"
          },
          "Required": false
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to open the maintenance window. Value:\n- true: Opens the maintenance window.\n- false: The maintenance window is not opened.\nDefault value: false"
          },
          "Required": false
        },
        "Duration": {
          "Type": "String",
          "Description": {
            "en": "Maintenance time. Value range [1,24] in hours.\nDefault value: 3h"
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Cluster maintenance window."
    }
  }
  EOT
}

variable "master_system_disk_snapshot_policy_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the policy that is used to back up the data disk of the master node."
    },
    "Label": {
      "en": "MasterSystemDiskSnapshotPolicyId",
      "zh-cn": "备份主节点数据盘的策略ID"
    }
  }
  EOT
}

variable "format_disk" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to mount a data disk to nodes that are created \non existing Elastic Compute Service (ECS) instances. Valid values:\ntrue: stores the data of containers and images on a data disk. \nThe original data on the disk will be overwritten. \nBack up data before you mount the disk.\nfalse: does not store the data of containers and images on a data disk.\nDefault value: false.\nHow to mount a data disk:\nIf the ECS instances have data disks mounted and the file system of the last \ndata disk is not initialized, the system automatically formats the data disk to ext4. \nThen, the system mounts the data disk to /var/lib/docker and /var/lib/kubelet.\nThe system does not create or mount a new data disk if no data disk has been \nmounted to the ECS instances.",
      "zh-cn": "是否将数据磁盘挂载到已创建的节点上，在已有的ECS实例中创建"
    },
    "Label": {
      "en": "FormatDisk",
      "zh-cn": "是否将数据磁盘挂载到已创建的节点上"
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
      "en": "The user-defined data. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "创建ECS实例时传递的用户数据"
    }
  }
  EOT
}

variable "addons" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Version": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, the latest version is selected by default."
          },
          "Required": false
        },
        "Config": {
          "Type": "String",
          "Description": {
            "en": "When the value is empty, no configuration is required."
          },
          "Required": false
        },
        "Disabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to disable default installation."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "Addon plugin name"
          },
          "Required": true
        }
      },
      "ListMetadata": {
        "Order": [
          "Name",
          "Disabled",
          "Version",
          "Config"
        ]
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "A combination of addon plugins for Kubernetes clusters.\nNetwork plug-in: including Flannel and Terway network plug-ins\nLog service: Optional. If the log service is not enabled, the cluster audit function cannot be used.\nIngress: The installation of the Ingress component is enabled by default."
    },
    "Label": {
      "en": "Addons",
      "zh-cn": "Kubernetes集群安装的组件列表"
    }
  }
  EOT
}

variable "master_system_disk_size" {
  type        = number
  default     = 120
  description = <<EOT
  {
    "Description": {
      "en": "Master disk system disk size in GiB.\nDefault to 120."
    },
    "MinValue": 1,
    "Label": {
      "en": "MasterSystemDiskSize",
      "zh-cn": "Master节点系统盘大小"
    }
  }
  EOT
}

variable "node_port_range" {
  type        = string
  default     = "30000-65535"
  description = <<EOT
  {
    "Description": {
      "en": "Node service port. The value range is [30000, 65535].\nDefault to 30000-65535."
    },
    "Label": {
      "en": "NodePortRange",
      "zh-cn": "节点服务端口"
    }
  }
  EOT
}

variable "mastervswitch_ids" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
        "Type": "String",
        "Description": {
          "en": "Master node switch ID. To ensure high availability of the cluster, it is recommended that you select 3 switches and distribute them in different Availability Zones."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Master node switch ID. To ensure high availability of the cluster, it is recommended that you select 3 switches and distribute them in different Availability Zones.",
      "zh-cn": "<b>注：<font color='red'>所选交换机必须在Master节点的交换机可用区范围内</font></b>"
    },
    "Label": {
      "en": "MasterVSwitchIds",
      "zh-cn": "Master节点交换机ID"
    },
    "MinLength": 1,
    "MaxLength": 3
  }
  EOT
}

variable "control_plane_log_components" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "AllowedValues": [
          "apiserver",
          "kcm",
          "scheduler",
          "ccm",
          "controlplane-events"
        ],
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "List of target components for which logs need to be collected. Supports apiserver, kcm, scheduler, ccm and controlplane-events."
    },
    "MinLength": 1,
    "MaxLength": 5
  }
  EOT
}

variable "cloud_monitor_flags" {
  type        = bool
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Whether to install the cloud monitoring plugin:\ntrue: indicates installation\nfalse: Do not install\nDefault to false",
      "zh-cn": "是否安装云监控插件"
    },
    "Label": {
      "en": "CloudMonitorFlags",
      "zh-cn": "是否安装云监控插件"
    }
  }
  EOT
}

variable "security_hardening_os" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Alibaba Cloud OS security hardening. Value:\ntrue: enables security hardening OS.\nfalse: disables security hardening OS.\nDefault value: false."
    },
    "Label": {
      "en": "SecurityHardeningOs",
      "zh-cn": "阿里云操作系统安全加固"
    }
  }
  EOT
}

variable "service_cidr" {
  type        = string
  default     = "172.19.0.0/20"
  description = <<EOT
  {
    "Description": {
      "en": "The service network segment cannot conflict with the VPC network segment and the container network segment. When the system is selected to automatically create a VPC, the network segment 172.19.0.0/20 is used by default."
    },
    "Label": {
      "zh-cn": "Service Cidr"
    }
  }
  EOT
}

variable "pod_vswitch_ids" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "VpcId": "$${VpcId}"
        },
        "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
        "Type": "String",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The list of pod vSwitches. For each vSwitch that is allocated to nodes, \n you must specify at least one pod vSwitch in the same zone. \n The pod vSwitches cannot be the same as the node vSwitches. \n We recommend that you set the mask length of the CIDR block to a value no \ngreater than 19 for the pod vSwitches.\nThe pod_vswitch_ids parameter is required when the Terway network \nplug-in is selected for the cluster.",
      "zh-cn": "<b>注：<font color='red'>所选交换机必须在Worker节点所属交换机可用区范围内</font></b>"
    },
    "Label": {
      "en": "PodVswitchIds",
      "zh-cn": "Pod交换机列表"
    }
  }
  EOT
}

variable "control_plane_log_project" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Control plane log project. If this field is not set, a log service project named k8s-log-{ClusterID} will be automatically created."
    },
    "AllowedPattern": "^[a-zA-Z0-9_-]+$",
    "MinLength": 3,
    "MaxLength": 63
  }
  EOT
}

variable "login_password" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::ECS::Instance::Password",
    "Description": {
      "en": "SSH login password. Password rules are 8-30 characters and contain three items (upper and lower case letters, numbers, and special symbols). Specify one of KeyPair or LoginPassword."
    },
    "Label": {
      "en": "LoginPassword",
      "zh-cn": "SSH登录密码"
    }
  }
  EOT
}

variable "kubernetes_version" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ALIYUN::CS::Cluster::KubernetesVersion",
    "Description": {
      "en": "The version of the Kubernetes cluster.",
      "zh-cn": "集群版本，与Kubernetes社区基线版本保持一致。建议选择最新版本。"
    },
    "Label": {
      "en": "KubernetesVersion",
      "zh-cn": "集群版本"
    }
  }
  EOT
}

variable "master_instance_types" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "DefaultValueStrategy": "recent",
          "InstanceChargeType": "$${ChargeType}"
        },
        "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
        "Type": "String",
        "Description": {
          "en": "Master node ECS specification type code. For more details, see Instance Type Family."
        },
        "Required": true
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Master node ECS specification type code. For more details, see Instance Type Family. Each item correspond to MasterVSwitchIds.\nList size must be 3, Instance Type can be repeated."
    },
    "Label": {
      "en": "MasterInstanceTypes",
      "zh-cn": "Master节点ECS实例规格"
    },
    "MinLength": 3,
    "MaxLength": 3
  }
  EOT
}

variable "master_system_disk_performance_level" {
  type        = string
  default     = "PL0"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${MasterSystemDiskCategory}",
            "cloud_essd"
          ]
        }
      }
    },
    "Description": {
      "en": "The performance level of the enhanced SSD used as the Master node.\nValid values: PL0|PL1|PL2|PL3"
    },
    "AllowedValues": [
      "PL0",
      "PL1",
      "PL2",
      "PL3"
    ],
    "Label": {
      "zh-cn": "主节点ESSD系统盘性能等级"
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
      "en": "Specifies the ID of the security group to which the cluster ECS instance belongs."
    },
    "Label": {
      "en": "SecurityGroupId",
      "zh-cn": "集群ECS实例所属于的安全组ID"
    }
  }
  EOT
}

variable "timeout_mins" {
  type        = number
  default     = 60
  description = <<EOT
  {
    "Description": {
      "en": "Cluster resource stack creation timeout, in minutes. The default value is 60."
    },
    "Label": {
      "en": "TimeoutMins",
      "zh-cn": "集群资源栈创建超时时间"
    }
  }
  EOT
}

variable "control_plane_log_ttl" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Control plane log retention duration (unit: day). Default 30."
    },
    "MinValue": 1,
    "MaxValue": 3650
  }
  EOT
}

variable "keep_instance_name" {
  type        = bool
  default     = true
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ParameterBoolean"
    },
    "Description": {
      "en": "Specifies whether to retain the names of existing ECS instances that are used in the cluster.\ntrue: retains the names.\nfalse: does not retain the names. The new names are assigned by the system.\nDefault value: true.",
      "zh-cn": "指定是否保留集群中使用的现有ECS实例的名称"
    },
    "Label": {
      "en": "KeepInstanceName",
      "zh-cn": "是否保留集群中使用的现有ECS实例的名称"
    }
  }
  EOT
}

variable "worker_system_disk_snapshot_policy_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the policy that is used to back up the data disk of the worker node."
    },
    "Label": {
      "en": "WorkerSystemDiskSnapshotPolicyId",
      "zh-cn": "用于备份工作节点数据盘的策略ID"
    }
  }
  EOT
}

resource "alicloud_cs_kubernetes" "private_kubernetes_cluster" {
  platform                     = var.platform
  resource_group_id            = var.resource_group_id
  enable_ssh                   = var.ssh_flags
  load_balancer_spec           = var.load_balancer_spec
  name                         = var.name
  is_enterprise_security_group = var.is_enterprise_security_group
  os_type                      = var.os_type
  node_name_mode               = var.node_name_mode
  proxy_mode                   = var.proxy_mode
  master_instance_charge_type  = var.master_instance_charge_type
  delete_options               = var.delete_options
  cpu_policy                   = var.cpu_policy
  key_name                     = var.key_pair
  node_cidr_mask               = var.node_cidr_mask
  deletion_protection          = var.deletion_protection
  master_auto_renew_period     = var.master_auto_renew_period
  vpc_id                       = var.vpc_id
  master_auto_renew            = var.master_auto_renew
  user_ca                      = var.user_ca
  user_data                    = var.user_data
  addons                       = var.addons
  node_port_range              = var.node_port_range
  master_vswitch_ids           = var.mastervswitch_ids
  install_cloud_monitor        = var.cloud_monitor_flags
  service_cidr                 = var.service_cidr
  pod_vswitch_ids              = var.pod_vswitch_ids
  password                     = var.login_password
  version                      = var.kubernetes_version
  master_instance_types        = var.master_instance_types
  security_group_id            = var.security_group_id
}

output "task_id" {
  // Could not transform ROS Attribute TaskId to Terraform attribute.
  value       = null
  description = "Task ID. Automatically assigned by the system, the user queries the task status."
}

output "cluster_id" {
  value       = alicloud_cs_kubernetes.private_kubernetes_cluster.id
  description = "Cluster instance ID."
}

output "apiserverslbid" {
  // Could not transform ROS Attribute APIServerSLBId to Terraform attribute.
  value       = null
  description = "The id of API server SLB"
}

output "scaling_group_id" {
  // Could not transform ROS Attribute ScalingGroupId to Terraform attribute.
  value       = null
  description = "Scaling group id"
}

output "ingressslbid" {
  // Could not transform ROS Attribute IngressSLBId to Terraform attribute.
  value       = null
  description = "The id of ingress SLB"
}

output "scaling_rule_id" {
  // Could not transform ROS Attribute ScalingRuleId to Terraform attribute.
  value       = null
  description = "Scaling rule id"
}

output "default_user_kube_config" {
  // Could not transform ROS Attribute DefaultUserKubeConfig to Terraform attribute.
  value       = null
  description = "Default user kubernetes config which is used for configuring cluster credentials."
}

output "worker_ram_role_name" {
  value       = alicloud_cs_kubernetes.private_kubernetes_cluster.worker_ram_role_name
  description = "Worker ram role name."
}

output "scaling_configuration_id" {
  // Could not transform ROS Attribute ScalingConfigurationId to Terraform attribute.
  value       = null
  description = "Scaling configuration id"
}

output "private_user_kub_config" {
  // Could not transform ROS Attribute PrivateUserKubConfig to Terraform attribute.
  value       = null
  description = "Private user kubernetes config which is used for configuring cluster credentials."
}

output "nodes" {
  // Could not transform ROS Attribute Nodes to Terraform attribute.
  value       = null
  description = "The list of cluster nodes."
}

