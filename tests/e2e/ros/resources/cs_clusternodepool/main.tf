variable "tee_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "TeeEnable": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable confidential computing for the cluster."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The configurations of confidential computing."
    },
    "Label": {
      "en": "TeeConfig",
      "zh-cn": "加密计算集群配置"
    }
  }
  EOT
}

variable "cluster_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster ID."
    },
    "Label": {
      "en": "ClusterId",
      "zh-cn": "集群ID"
    }
  }
  EOT
}

variable "node_pool_info" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ResourceGroupId": {
          "AssociationProperty": "ALIYUN::ECS::ResourceGroup::ResourceGroupId",
          "Type": "String",
          "Description": {
            "en": "The ID of the resource group to which the node pool belongs."
          },
          "Required": false
        },
        "Name": {
          "Type": "String",
          "Description": {
            "en": "The name of the node pool."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The configurations of the node pool."
    },
    "Label": {
      "en": "NodePoolInfo",
      "zh-cn": "节点池配置"
    }
  }
  EOT
}

variable "kubernetes_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CpuPolicy": {
          "Type": "String",
          "Description": {
            "en": "The CPU policy. The following policies are supported if the Kubernetes version of the cluster is 1.12.6 or later. Valid values:\nstatic: This policy allows pods with specific resource characteristics on the node to be granted with enhanced CPU affinity and exclusivity.\nnone: This policy indicates that the default CPU affinity is used.\nDefault value: none."
          },
          "Required": false
        },
        "Runtime": {
          "Type": "String",
          "Description": {
            "en": "The name of the container runtime."
          },
          "Required": true
        },
        "CmsEnabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to install the CloudMonitor agent on ECS nodes. After the CloudMonitor agent is installed on ECS nodes, you can view monitoring information about the instances in the CloudMonitor console. We recommend that you install the CloudMonitor agent. Valid values:\ntrue: installs the CloudMonitor agent on ECS nodes.\nfalse: does not install the CloudMonitor agent on ECS nodes.\nDefault value: false."
          },
          "Required": false
        },
        "UserData": {
          "AssociationProperty": "TextArea",
          "Type": "String",
          "Description": {
            "en": "The user-defined data."
          },
          "Required": false
        },
        "NodeNameMode": {
          "Type": "String",
          "Description": {
            "en": "A custom node name consists of a prefix, an IP substring, and a suffix. The format iscustomized,{prefix},{ip_substring},{suffix}, for example: customized,aliyun.com,5,test.\n- The prefix and suffix can contain one or more parts that are separated by periods (.). Each part can contain lowercase letters, digits, and hyphens (-). The node name must start and end with a lowercase letter or digit.\n- The IP substring length specifies the number of digits to be truncated from the end of the node IP address. Valid values: 5 to 12. For example, if the node IP address is 192.168.0.55, the prefix is aliyun.com, the IP substring length is 5, and the suffix is test, the node name will be aliyun.com00055test."
          },
          "Required": false
        },
        "RuntimeVersion": {
          "Type": "String",
          "Description": {
            "en": "The version of the container runtime."
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
            "en": "You can add labels to nodes that are added to the cluster."
          },
          "Required": false,
          "MinLength": 1
        },
        "Unschedulable": {
          "Type": "Boolean",
          "Description": {
            "en": "Set new nodes to unschedulable. If true, newly added nodes become unschedulable after they are registered to the cluster. You can enable scheduling for the nodes on the Nodes page in the console."
          },
          "Required": false
        },
        "Taints": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Value": {
                "Type": "String",
                "Required": true
              },
              "Effect": {
                "Type": "String",
                "Description": {
                  "en": "The scheduling policy. Valid values:\nNoSchedule: Pods that do not tolerate this taint are not scheduled to nodes with this taint. This policy affects only the scheduling process and takes effect only for pods to be scheduled. Scheduled pods are not subject to this policy.\nNoExecute: Pods that do not tolerate this taint are evicted after this taint is added to the node.\nPreferNoSchedule: a preference policy on pods. Scheduled pods are not subject to this policy. If this taint is added to a node, the system tries to not schedule pods that do not tolerate this taint to the node.\nDefault value: NoSchedule."
                },
                "Required": false,
                "Default": "NoSchedule"
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
            "en": "The taints of the nodes."
          },
          "Required": false,
          "MinLength": 1
        }
      }
    },
    "Description": {
      "en": "The configurations of the ACK cluster."
    },
    "Label": {
      "en": "KubernetesConfig",
      "zh-cn": "集群相关配置"
    }
  }
  EOT
}

variable "count_1a0c53b9" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of nodes in the node pool."
    },
    "Label": {
      "en": "Count",
      "zh-cn": "节点池节点数量"
    }
  }
  EOT
}

variable "management" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "UpgradeConfig": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "AutoUpgrade": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to enable auto upgrading. Valid values:\ntrue: enables auto upgrading.\nfalse: disables auto upgrading."
                },
                "Required": false
              },
              "SurgePercentage": {
                "Type": "Number",
                "Description": {
                  "en": "The ratio of extra nodes to the nodes in the node pool. You must set this parameter or Surge."
                },
                "Required": false
              },
              "Surge": {
                "Type": "Number",
                "Description": {
                  "en": "The number of extra nodes that can be added to the node pool during an auto upgrade."
                },
                "Required": false
              },
              "MaxUnavailable": {
                "Type": "Number",
                "Description": {
                  "en": "The maximum number of nodes that can be in the unschedulable state.\nValid values: 1 to 1000.\nDefault value: 1."
                },
                "Required": false,
                "MinValue": 1,
                "MaxValue": 1000
              }
            }
          },
          "Type": "Json",
          "Description": {
            "en": "The configurations of auto upgrading. The configurations take effect only when Enable=true is specified."
          },
          "Required": false
        },
        "AutoRepair": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable auto repairing. This parameter takes effect only when Enable=true is specified.\ntrue: enables auto repairing.\nfalse: disables auto repairing."
          },
          "Required": false
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable managed node pools. Valid values:\ntrue: enables managed node pools.\nfalse: disables managed node pools. The other parameters in this section take effect only when Enable=true is specified."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The configurations of the managed node pool."
    },
    "Label": {
      "en": "Management",
      "zh-cn": "托管节点池配置"
    }
  }
  EOT
}

variable "auto_scaling" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "EipBandwidth": {
          "Type": "Number",
          "Description": {
            "en": "The peak bandwidth of the EIP. Unit: Mbps"
          },
          "Required": false,
          "MinValue": 1
        },
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The instance types that can be used for the auto scaling of the node pool. Valid values:\ncpu: regular instance.\ngpu: GPU-accelerated instance.\ngpushare: shared GPU-accelerated instance.\nspot: preemptible instance.\nDefault value: cpu."
          },
          "Required": false
        },
        "IsBondEip": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to associate an elastic IP address (EIP) with the node pool. Valid values:\ntrue: associates an EIP with the node pool.\nfalse: does not associate an EIP with the node pool.\nDefault value: false."
          },
          "Required": false
        },
        "MinInstances": {
          "Type": "Number",
          "Description": {
            "en": "The minimum number of Elastic Compute Service (ECS) instances in the scaling group."
          },
          "Required": false
        },
        "Enable": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable auto scaling. Valid values:\ntrue: enables auto scaling.\nfalse: disables auto scaling.\nIf you set this parameter to false, other parameters in the auto_scaling section do not take effect."
          },
          "Required": true
        },
        "MaxInstances": {
          "Type": "Number",
          "Description": {
            "en": "The maximum number of Elastic Compute Service (ECS) instances in the scaling group."
          },
          "Required": false
        },
        "EipInternetChargeType": {
          "Type": "String",
          "Description": {
            "en": "The billing method of the EIP. Valid values:\nPayByBandwidth: pay-by-bandwidth.\nPayByTraffic: pay-by-data-transfer.\nDefault value: PayByBandwidth."
          },
          "AllowedValues": [
            "PayByTraffic",
            "PayByBandwidth"
          ],
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configurations of auto scaling."
    },
    "Label": {
      "en": "AutoScaling",
      "zh-cn": "自动伸缩配置"
    }
  }
  EOT
}

variable "scaling_group" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "SpotInstanceRemedy": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to supplement preemptible instances. If this parameter is set to true, when the scaling group receives a system message that a preemptible instance is to be reclaimed, the scaling group attempts to create a new instance to replace this instance. Valid values:\ntrue: supplements preemptible instances.\nfalse: does not supplement preemptible instances."
          },
          "Required": false
        },
        "DataDisks": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "Category": {
                "Type": "String",
                "Description": {
                  "en": "The type of data disk. Valid values:\ncloud: basic disk.\ncloud_efficiency: ultra disk.\ncloud_ssd: standard SSD.\ncloud_essd: enhanced SSD.\nDefault value: cloud_efficiency."
                },
                "Required": false
              },
              "Encrypted": {
                "Type": "Boolean",
                "Description": {
                  "en": "Specifies whether to encrypt a data disk. Valid values:\ntrue: encrypts a data disk.\nfalse: does not encrypt a data disk.\nDefault value: false."
                },
                "Required": false
              },
              "PerformanceLevel": {
                "Type": "String",
                "Description": {
                  "en": "The performance level of the enhanced SSD used as the system disk. Default value: PL1. Valid values:\nPL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.\nPL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.\nPL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.\nPL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS."
                },
                "Required": false
              },
              "Size": {
                "Type": "Number",
                "Description": {
                  "en": "The size of a data disk. The size is measured in GiB.\nValid values: 40 to 32768."
                },
                "Required": false
              },
              "AutoSnapshotPolicyId": {
                "Type": "String",
                "Description": {
                  "en": "The ID of an automatic snapshot policy. Automatic backup is performed for a disk based on the specified automatic snapshot policy.\nBy default, this parameter is empty. This indicates that automatic backup is disabled."
                },
                "Required": false
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The configurations of data disks."
          },
          "Required": false,
          "MinLength": 1
        },
        "Platform": {
          "Type": "String",
          "Description": {
            "en": "The release version of the operating system. Valid values:\nCentOS, AliyunLinux, Windows, WindowsCore.\nDefault value: AliyunLinux."
          },
          "Required": false
        },
        "CompensateWithOnDemand": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to automatically create pay-as-you-go instances to meet the required number of ECS instances if preemptible instances cannot be created due to reasons such as the cost or insufficient inventory. This parameter takes effect when multi_az_policy is set to COST_OPTIMIZED. Valid values:\ntrue: automatically creates pay-as-you-go instances to meet the required number of ECS instances if preemptible instances cannot be created.\nfalse: does not create pay-as-you-go instances to meet the required number of ECS instances if preemptible instances cannot be created."
          },
          "Required": false
        },
        "SystemDiskSize": {
          "Type": "Number",
          "Description": {
            "en": "The system disk size of a node. Unit: GiB. Valid values: 40 to 500."
          },
          "Required": true
        },
        "InstanceChargeType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "InstanceChargeType"
          },
          "Type": "String",
          "Description": {
            "en": "The billing method of nodes in the node pool. Valid values:\nPrePaid: subscription.\nPostPaid: pay-as-you-go.\nDefault value: PostPaid."
          },
          "AllowedValues": [
            "PayAsYouGo",
            "Subscription"
          ],
          "Required": false
        },
        "OnDemandPercentageAboveBaseCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The percentage of pay-as-you-go instances among the extra instances that exceed the number specified by on_demand_base_capacity. Valid values: 0 to 100."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 100
        },
        "AutoRenew": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to enable auto-renewal for nodes in the node pool. This parameter takes effect only when instance_charge_type is set to PrePaid. Valid values:\ntrue: enables auto-renewal.\nfalse: disables auto-renewal.\nDefault value: true."
          },
          "Required": false
        },
        "OnDemandBaseCapacity": {
          "Type": "Number",
          "Description": {
            "en": "The minimum number of pay-as-you-go instances that must be kept in the scaling group. Valid values: 0 to 1000. When the number of pay-as-you-go instances is lower than this value, pay-as-you-go instances are preferably created to meet the required number."
          },
          "Required": false,
          "MinValue": 0,
          "MaxValue": 1000
        },
        "SystemDiskPerformanceLevel": {
          "Type": "String",
          "Description": {
            "en": "The performance level of the enhanced SSD used as the system disk. Default value: PL1. Valid values:\nPL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.\nPL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.\nPL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.\nPL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS."
          },
          "Required": false
        },
        "ImageId": {
          "Type": "String",
          "Description": {
            "en": "The ID of a custom image. By default, the image provided by ACK is used."
          },
          "Required": false
        },
        "SpotPriceLimit": {
          "AssociationPropertyMetadata": {
            "Parameters": {
              "PriceLimit": {
                "Type": "Number",
                "Description": {
                  "en": "The price limit of a preemptible instance."
                },
                "Required": true
              },
              "InstanceType": {
                "Type": "String",
                "Description": {
                  "en": "The instance type for preemptible instances."
                },
                "Required": true
              }
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "The instance type for preemptible instances and the price limit of the instance type."
          },
          "Required": false,
          "MinLength": 1
        },
        "InstanceTypes": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The ECS instance types of the nodes."
          },
          "Required": true,
          "MinLength": 1
        },
        "ZoneIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationProperty": "ZoneId",
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "Zone ids of virtual switches belongs to."
          },
          "Required": false
        },
        "Tags": {
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
            },
            "ListMetadata": {
              "Order": [
                "Key",
                "Value"
              ]
            }
          },
          "AssociationProperty": "List[Parameters]",
          "Type": "Json",
          "Description": {
            "en": "Adds labels only to ECS instances.\nA key must be unique and cannot exceed 128 characters in length. Neither keys nor values can start with aliyun or acs:. Neither keys nor values can contain https:// or http://."
          },
          "Required": false,
          "MinLength": 1
        },
        "SpotStrategy": {
          "Type": "String",
          "Description": {
            "en": "The type of preemptible instance. Valid values:\nNoSpot: non-preemptible instance.\nSpotWithPriceLimit: specifies the highest bid for a preemptible instance.\nSpotAsPriceGo: automatically submits bids based on the up-to-date market price."
          },
          "Required": false
        },
        "LoginPassword": {
          "Type": "String",
          "Description": {
            "en": "The password used to log on to the nodes by using SSH. You must set KeyPair or LoginPassword. The password must be 8 to 30 characters in length, and must contain at least three of the following character types: uppercase letters, lowercase letters, digits, and special characters."
          },
          "Required": false
        },
        "MultiAzPolicy": {
          "Type": "String",
          "Description": {
            "en": "The scaling policy of ECS instances in a multi-zone scaling group. Valid values:\nPRIORITY: the scaling group is scaled based on the VSwitchIds.N parameter. When ECS instances cannot be created in the zone where the vSwitch with the highest priority is deployed, the system attempts to create ECS instances in the zone where the vSwitch with the next highest priority is deployed.\nCOST_OPTIMIZED: ECS instances are created based on the unit price of vCPUs in ascending order. Preemptible instances are preferably created when multiple instance types are specified in the scaling configurations. You can set the CompensateWithOnDemand parameter to specify whether to automatically create pay-as-you-go instances when preemptible instances cannot be created due to insufficient inventory.\nBALANCE: ECS instances are evenly distributed across multiple zones specified by the scaling group. If ECS instances are not evenly distributed across multiple zones due to insufficient inventory, you can call the RebalanceInstances operation to balance the instance distribution among zones.\nDefault value: PRIORITY."
          },
          "Required": false
        },
        "AutoRenewPeriod": {
          "Type": "Number",
          "Description": {
            "en": "The auto-renewal period for nodes in the node pool. This parameter takes effect and is required only when instance_charge_type is set to PrePaid and auto_renew is set to true. If PeriodUnit=Month is configured, the valid values are: 1, 2, 3, 6, and 12.\nDefault value: 1"
          },
          "Required": false
        },
        "ScalingPolicy": {
          "Type": "String",
          "Description": {
            "en": "The scaling mode of the scaling group. Valid values:\nrelease: the standard mode. ECS instances are created and released based on the resource usage.\nrecycle: the swift mode. ECS instances are created, stopped, or started during scaling events. This reduces the time required for the next scale-out event. When the instance is stopped, you are charged only for the storage service. This does not apply to ECS instances attached with local disks.\nDefault value:release."
          },
          "Required": false
        },
        "KeyPair": {
          "Type": "String",
          "Description": {
            "en": "The name of the key pair used to log on to the nodes. You must set KeyPair or LoginPassword."
          },
          "Required": false
        },
        "VSwitchIds": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "AssociationPropertyMetadata": {
                "VpcId": "$${VpcId}",
                "ZoneId": "$${ZoneId}"
              },
              "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The IDs of vSwitches."
          },
          "Required": true,
          "MinLength": 1
        },
        "SecurityGroupId": {
          "AssociationPropertyMetadata": {
            "VpcId": "$${VpcId}"
          },
          "AssociationProperty": "ALIYUN::ECS::SecurityGroup::SecurityGroupId",
          "Type": "String",
          "Description": {
            "en": "The ID of the security group to which the nodes belong."
          },
          "Required": false
        },
        "SpotInstancePools": {
          "Type": "Number",
          "Description": {
            "en": "The number of available instance types. The scaling group creates preemptible instances of multiple instance types at the lowest cost. Valid values: 1 to 10."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 10
        },
        "Period": {
          "AssociationProperty": "PayPeriod",
          "Type": "Number",
          "Description": {
            "en": "The subscription period of nodes in the node pool. This parameter takes effect and is required only when InstanceChargeType is set to PrePaid. When PeriodUnit = Week, Period values are: {\"1\", \"2\", \"3\", \"4\"}\nWhen PeriodUnit = Month, Period values are: {\"1\", \"2\", \"3\", \"6\", \"12\", \"24\", \"36\"}\nWhen PeriodUnit = Year, Period values are: {\"1\", \"2\", \"3\"}\nDefault value: 1."
          },
          "Required": false,
          "MinValue": 1,
          "MaxValue": 36
        },
        "InternetChargeType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "InternetChargeType"
          },
          "Type": "String",
          "Description": {
            "en": "Bandwidth billing method. Valid values: PayByTraffic or PayByBandwidth."
          },
          "Required": false
        },
        "SystemDiskCategory": {
          "Type": "String",
          "Description": {
            "en": "The type of system disk. Valid values:\ncloud_efficiency: ultra disk.\ncloud_ssd: standard SSD.\ncloud_essd: enhanced SSD.\nDefault value: cloud_efficiency."
          },
          "Required": false
        },
        "InternetMaxBandwidthOut": {
          "Type": "Number",
          "Description": {
            "en": "The release version of the operating system. Valid values:\nCentOS, AliyunLinux, Windows, WindowsCore.\nDefault value: AliyunLinux."
          },
          "Required": false
        },
        "RdsInstances": {
          "AssociationPropertyMetadata": {
            "Parameter": {
              "Type": "String",
              "Required": false
            }
          },
          "AssociationProperty": "List[Parameter]",
          "Type": "Json",
          "Description": {
            "en": "The IDs of the ApsaraDB RDS instances."
          },
          "Required": false,
          "MinLength": 1
        },
        "PeriodUnit": {
          "AssociationProperty": "PayPeriodUnit",
          "Type": "String",
          "Description": {
            "en": "The unit of the subscription period of nodes in the node pool. This parameter is required if you set InstanceChargeType to PrePaid. The options are:\nWeek: Time is measured in weeks\nMonth: time in months\nYear: time in years\nDefault to Month"
          },
          "AllowedValues": [
            "Week",
            "Month",
            "Year"
          ],
          "Required": false
        }
      }
    },
    "Description": {
      "en": "The configurations of the scaling group used by the node pool."
    },
    "Label": {
      "en": "ScalingGroup",
      "zh-cn": "节点池扩容组配置"
    }
  }
  EOT
}

resource "alicloud_cs_kubernetes_node_pool" "cluster_node_pool" {
  cluster_id = var.cluster_id
}

output "node_pool_id" {
  value       = alicloud_cs_kubernetes_node_pool.cluster_node_pool.id
  description = "Cluster node pool ID."
}

