variable "applications" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ApplicationName": {
          "Type": "String",
          "Description": {
            "en": "Application name"
          },
          "Required": true
        },
        "ApplicationVersion": {
          "Type": "String",
          "Description": {
            "en": "Application version"
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Application List.The value range of the number n of the number N group: 1 ~ 100."
    },
    "Label": {
      "en": "Applications",
      "zh-cn": "应用列表"
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
      "en": "Resource group ID."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
    }
  }
  EOT
}

variable "application_configs" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "ConfigFileName": {
          "Type": "String",
          "Description": {
            "en": "Configuration file name."
          },
          "Required": false
        },
        "ApplicationName": {
          "Type": "String",
          "Description": {
            "en": "Application name"
          },
          "Required": true
        },
        "ConfigItemKey": {
          "Type": "String",
          "Description": {
            "en": "Configuration key."
          },
          "Required": false
        },
        "NodeGroupName": {
          "Type": "String",
          "Description": {
            "en": "Node group name. \nThis parameter takes effect when the ConfigScope \nvalue is NODE_GROUP and the parameter NodeGroupId is empty."
          },
          "Required": false
        },
        "NodeGroupId": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${ConfigScope}",
                  "NODE_GROUP"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "Node group ID. This parameter takes effect when ConfigScope takes the value NODE_GROUP.\nThe NodeGroupId parameter takes precedence over the NodeGroupName."
          },
          "Required": false
        },
        "ConfigScope": {
          "Type": "String",
          "Description": {
            "en": "Configuration scope. Ranges: \nCLUSTER: Cluster level.\nNODE_GROUP: Node group level.\nDefault: CLUSTER."
          },
          "Required": false,
          "Default": "CLUSTER"
        },
        "ConfigItemValue": {
          "Type": "String",
          "Description": {
            "en": "Configuration value."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "Application configuration.The value range of the number n of the array element n: 1 ~ 1000."
    },
    "Label": {
      "en": "ApplicationConfigs",
      "zh-cn": "应用配置"
    },
    "MinLength": 1,
    "MaxLength": 1000
  }
  EOT
}

variable "cluster_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster type.Ranges:\nDATALAKE: The new version of the data lake.\nOLAP: Data analysis.\nDATAFLOW: Real -time data stream.\nDATASERVING: Data service.\nHADOOP: The old version of the data lake (not recommended, it is recommended to use the new version of the data lake)."
    },
    "Label": {
      "en": "ClusterType",
      "zh-cn": "集群类型"
    }
  }
  EOT
}

variable "node_groups" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "WithPublicIp": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "Whether to open the public IP. Default is false."
              },
              "Required": false,
              "Default": false
            },
            "SpotInstanceRemedy": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "After it is enabled, when it receives a system message that the preemptible \ninstance will be recycled, the scaling group will try to create a new \ninstance to replace the preemptible instance that will be recycled. Ranges: \ntrue: Enable fill-in preemptive instances. \nfalse: Do not enable fill-up preemptive instances. \nDefault: false."
              },
              "Required": false,
              "Default": false
            },
            "NodeCount": {
              "Type": "Number",
              "Description": {
                "en": "number of nodes. Value range: 1~1000."
              },
              "Required": false,
              "MinValue": 1,
              "MaxValue": 1000
            },
            "NodeGroupName": {
              "Type": "String",
              "Description": {
                "en": "Node group name. The maximum length is 128 characters. \nNode group names are required to be unique within the cluster."
              },
              "Required": false
            },
            "ZoneId": {
              "AssociationProperty": "ZoneId",
              "Type": "String",
              "Description": {
                "en": "Zone id"
              },
              "Required": false
            },
            "DataDisks": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Category": {
                    "AssociationProperty": "ALIYUN::ECS::Disk::DataDiskCategory",
                    "Type": "String",
                    "Description": {
                      "en": "Category of system disk."
                    },
                    "Required": true
                  },
                  "PerformanceLevel": {
                    "Type": "String",
                    "Description": {
                      "en": "The performance level of the enhanced SSD.Default value: PL1. Valid values:\nPL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.\nPL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.\nPL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.\nPL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS.\nDefault is PL1."
                    },
                    "Required": false
                  },
                  "Size": {
                    "Type": "Number",
                    "Description": {
                      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size."
                    },
                    "Required": true,
                    "MinValue": 20
                  },
                  "Count": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of system disks per node, the default value is 1."
                    },
                    "Required": false
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "data disk. The current data disk supports only one disk type."
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
                  "Description": {
                    "en": "Virtual machine switch id."
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "List of virtual machine switch IDs. \nThe value range of the number of array elements N: 1~20."
              },
              "Required": false,
              "MinLength": 1,
              "MaxLength": 20
            },
            "SpotBidPrices": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "BidPrice": {
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
                    "Type": "Number",
                    "Description": {
                      "en": "The maximum hourly bid for the instance. A maximum of 3 decimal \nplaces are supported. This parameter takes effect when \nthe parameter SpotStrategy=SpotWithPriceLimit."
                    },
                    "Required": false
                  },
                  "InstanceType": {
                    "AssociationProperty": "ALIYUN::ECS::Instance::InstanceType",
                    "Type": "String",
                    "Description": {
                      "en": "ECS instance type."
                    },
                    "Required": false
                  }
                },
                "Visible": {
                  "Condition": {
                    "Fn::Equals": [
                      "$${SpotStrategy}",
                      "SpotWithPriceLimit"
                    ]
                  }
                }
              },
              "AssociationProperty": "List[Parameters]",
              "Type": "Json",
              "Description": {
                "en": "Preemptible Spot Instance bid price. \nThe parameter SpotStrategy takes effect when the value is SpotWithPriceLimit. \nThe value range of the number of array elements N: 0~100."
              },
              "Required": false,
              "MinLength": 1,
              "MaxLength": 100
            },
            "NodeResizeStrategy": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "NodeGroups_NodeResizeStrategy"
              },
              "Type": "String",
              "Description": {
                "en": "Node expansion strategy. Ranges:\nCOST_OPTIMIZED: Cost optimization strategy. \nPRIORITY: Priority policy. \nDefault: PRIORITY."
              },
              "AllowedValues": [
                "COST_OPTIMIZED",
                "PRIORITY"
              ],
              "Required": false
            },
            "SystemDisk": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "Category": {
                    "AssociationProperty": "ALIYUN::ECS::Disk::DataDiskCategory",
                    "Type": "String",
                    "Description": {
                      "en": "Category of system disk."
                    },
                    "Required": true
                  },
                  "PerformanceLevel": {
                    "Type": "String",
                    "Description": {
                      "en": "The performance level of the enhanced SSD.Default value: PL1. Valid values:\nPL0: A single enhanced SSD delivers up to 10,000 random read/write IOPS.\nPL1: A single enhanced SSD delivers up to 50,000 random read/write IOPS.\nPL2: A single enhanced SSD delivers up to 100,000 random read/write IOPS.\nPL3: A single enhanced SSD delivers up to 1,000,000 random read/write IOPS.\nDefault is PL1."
                    },
                    "Required": false
                  },
                  "Size": {
                    "Type": "Number",
                    "Description": {
                      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size."
                    },
                    "Required": true,
                    "MinValue": 20
                  },
                  "Count": {
                    "Type": "Number",
                    "Description": {
                      "en": "The number of system disks per node, the default value is 1."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Disk config."
              },
              "Required": false
            },
            "NodeGroupType": {
              "Type": "String",
              "Description": {
                "en": "Node group type. Ranges: \nMASTER: Master node group type. \nCORE: Core node group type. \nTASK: Compute order node group type."
              },
              "Required": true
            },
            "InstanceTypes": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "Instance type"
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "A list of node instance types. The value range of the number of array elements N: 1~100."
              },
              "Required": true,
              "MinLength": 1,
              "MaxLength": 100
            },
            "AdditionalSecurityGroupIds": {
              "AssociationPropertyMetadata": {
                "Parameter": {
                  "Type": "String",
                  "Description": {
                    "en": "security group id."
                  },
                  "Required": false
                }
              },
              "AssociationProperty": "List[Parameter]",
              "Type": "Json",
              "Description": {
                "en": "Additional security groups. Additional security groups set \nindividually for node groups in addition to the security \ngroups set by the cluster. \nThe value range of the number of array elements N: 0~2."
              },
              "Required": false,
              "MinLength": 0,
              "MaxLength": 2
            },
            "CostOptimizedConfig": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "OnDemandBaseCapacity": {
                    "Type": "Number",
                    "Description": {
                      "en": "The minimum number of instances by quantity. \nThe minimum number of instance counts required by the node group, \nthe value range: 0~1000. When the number of metered instances is \nless than this value, the metered instance will be created first."
                    },
                    "Required": true,
                    "MinValue": 0,
                    "MaxValue": 1000
                  },
                  "OnDemandPercentageAboveBaseCapacity": {
                    "Type": "Number",
                    "Description": {
                      "en": "After the node group satisfies the OnDemandBaseCapacity requirement \nof the minimum on-demand instance, the proportion of the \non-demand instances in the excess instances, ranging from 0 to 100."
                    },
                    "Required": true,
                    "MinValue": 0,
                    "MaxValue": 100
                  },
                  "SpotInstancePools": {
                    "Type": "Number",
                    "Description": {
                      "en": "Specify the number of available instance types, \nand the scaling group will create preemptible instances \nin a balanced manner according to the multiple types with \nthe lowest cost. Value range: 0~10."
                    },
                    "Required": true,
                    "MinValue": 0,
                    "MaxValue": 10
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Cost-optimized mode configuration."
              },
              "Required": false
            },
            "GracefulShutdown": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "ParameterBoolean"
              },
              "Type": "Boolean",
              "Description": {
                "en": "Whether the components deployed on the node group enable graceful offline. Ranges: \ntrue: Enable graceful logout. \nfalse: Graceful logout is not enabled. \nDefault: false."
              },
              "Required": false,
              "Default": false
            },
            "DeploymentSetStrategy": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "NodeGroups_DeploymentSetStrategy"
              },
              "Type": "String",
              "Description": {
                "en": "Deployment set policy. Ranges:\nNONE: Does not apply to deployment sets.\nCLUSTER: Use cluster-level deployment sets.\nNODE_GROUP: Use node group level deployment sets.\nDefault: NONE."
              },
              "AllowedValues": [
                "NONE",
                "CLUSTER",
                "NODE_GROUP"
              ],
              "Required": false
            },
            "SpotStrategy": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "NodeGroups_SpotStrategy"
              },
              "Type": "String",
              "Description": {
                "en": "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter InstanceChargeType is PostPaid. Value range: \"NoSpot: A regular Pay-As-You-Go instance\", \"SpotWithPriceLimit: A price threshold for a spot instance, \"\"SpotAsPriceGo: A price that is based on the highest Pay-As-You-Go instance. \"Default value: NoSpot."
              },
              "AllowedValues": [
                "NoSpot",
                "SpotWithPriceLimit",
                "SpotAsPriceGo"
              ],
              "Required": false
            }
          }
        },
        "Type": "Json",
        "Description": {
          "en": "Node group configuration"
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The node group configuration array.The value range of the number n of the number N group: 1 ~ 100."
    },
    "Label": {
      "en": "NodeGroups",
      "zh-cn": "节点组配置数组"
    },
    "MinLength": 1,
    "MaxLength": 100
  }
  EOT
}

variable "release_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "EMR release version.View EMR distribution versions can be viewed through the EMR cluster."
    },
    "Label": {
      "en": "ReleaseVersion",
      "zh-cn": "EMR发行版"
    }
  }
  EOT
}

variable "bootstrap_scripts" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "AssociationPropertyMetadata": {
          "Parameters": {
            "ScriptPath": {
              "Type": "String",
              "Description": {
                "en": "The OSS path where the script is located. Required. Start with oss://."
              },
              "Required": true
            },
            "ScriptArgs": {
              "Type": "String",
              "Description": {
                "en": "Script execution parameters. Optional parameter."
              },
              "Required": false
            },
            "ExecutionFailStrategy": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "BootstrapScripts_ExecutionFailStrategy"
              },
              "Type": "String",
              "Description": {
                "en": "Execute failure strategy. Allowed values:FAILED_CONTINUE: Does not block cluster creation or cluster expansion after failure.FAILED_BLOCK: Blocks cluster creation or cluster expansion after failure."
              },
              "AllowedValues": [
                "FAILED_CONTINUE",
                "FAILED_BLOCK"
              ],
              "Required": false
            },
            "Priority": {
              "Type": "Number",
              "Description": {
                "en": "Script execution priority. Value range: 1~100."
              },
              "Required": false,
              "MinValue": 1,
              "MaxValue": 100
            },
            "ScriptName": {
              "Type": "String",
              "Description": {
                "en": "script name. Required. \nThe length is 1~64 characters. \nIt must start with a big or small letter or Chinese. \nIt cannot start with http:// and https://. \nIt can contain Chinese, English, numbers, underscores (_), or dashes (-)"
              },
              "Required": true
            },
            "ExecutionMoment": {
              "AssociationPropertyMetadata": {
                "LocaleKey": "BootstrapScripts_ExecutionMoment"
              },
              "Type": "String",
              "Description": {
                "en": "When the script is executed. Allowed values: \nBEFORE_INSTALL: Before the app is installed. \nAFTER_STARTED: After the app starts."
              },
              "AllowedValues": [
                "BEFORE_INSTALL",
                "AFTER_STARTED"
              ],
              "Required": false
            },
            "NodeSelector": {
              "AssociationPropertyMetadata": {
                "Parameters": {
                  "NodeGroupTypes": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Node group type. Ranges: \nMASTER: Master node group type. \nCORE: Core node group type. \nTASK: Compute order node group type."
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "Node group type. It takes effect when NodeSelectType is NodeGroup \nand the parameter NodeGroupId is empty. \nThe number of array elements, N, ranges from 0 to 10."
                    },
                    "Required": false
                  },
                  "NodeGroupName": {
                    "Type": "String",
                    "Description": {
                      "en": "Node group name. This parameter takes effect when \nNodeSelectType is NodeGroup and the parameter NodeGroupId is empty."
                    },
                    "Required": false
                  },
                  "NodeGroupId": {
                    "Type": "String",
                    "Description": {
                      "en": "Node group ID. This parameter takes effect when NodeSelectType is NodeGroup."
                    },
                    "Required": false
                  },
                  "NodeSelectType": {
                    "Type": "String",
                    "Description": {
                      "en": "Node selection type.  Allowed values:\nCLUSTER: Cluster.\nNODE_GROUP: Node group.\nNODE: Node."
                    },
                    "AllowedValues": [
                      "CLUSTER",
                      "NODE_GROUP",
                      "NODE"
                    ],
                    "Required": true
                  },
                  "NodeNames": {
                    "AssociationPropertyMetadata": {
                      "Parameter": {
                        "Type": "String",
                        "Description": {
                          "en": "Node names"
                        },
                        "Required": false
                      }
                    },
                    "AssociationProperty": "List[Parameter]",
                    "Type": "Json",
                    "Description": {
                      "en": "List of node names. When the NodeSelectType value is Node, \nthis parameter takes effect."
                    },
                    "Required": false
                  }
                }
              },
              "Type": "Json",
              "Description": {
                "en": "Node selector."
              },
              "Required": true
            }
          }
        },
        "Type": "Json",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "Guide the script group.The value range of the number n of the number N group: 1 ~ 10."
    },
    "Label": {
      "en": "BootstrapScripts",
      "zh-cn": "引导脚本数组"
    }
  }
  EOT
}

variable "subscription_config" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "AutoRenewDurationUnit": {
          "Type": "String",
          "Description": {
            "en": "Automatic renewal time unit, Month"
          },
          "AllowedValues": [
            "Month"
          ],
          "Required": false
        },
        "AutoRenew": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "ParameterBoolean"
          },
          "Type": "Boolean",
          "Description": {
            "en": "Automatic renewal. Ranges: \ntrue: Enable startup renewal. \nfalse: Automatic renewal is not enabled. \nDefault: false."
          },
          "Required": false,
          "Default": false
        },
        "PaymentDurationUnit": {
          "Type": "String",
          "Description": {
            "en": "Payment time unit, Month"
          },
          "AllowedValues": [
            "Month"
          ],
          "Required": false,
          "Default": "Month"
        },
        "PaymentDuration": {
          "Type": "Number",
          "Description": {
            "en": "Payment time. When the value of PaymentDurationUnit is Month, \nthe values are: 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36, 48, 60."
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
          "Required": false,
          "Default": 1
        },
        "AutoRenewDuration": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${AutoRenew}",
                  true
                ]
              }
            }
          },
          "Type": "Number",
          "Description": {
            "en": "Auto-renewal duration. It takes effect when AutoRenew is true. \nWhen the AutoRenewDurationUnit value is Month, the values are: \n1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 24, 36, 48, 60."
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
          "Required": false
        }
      },
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${PaymentType}",
            "Subscription"
          ]
        }
      }
    },
    "Description": {
      "en": "Pre -paid allocation.When the value of PaymentType is Subscripting, it must be filled."
    },
    "Label": {
      "en": "SubscriptionConfig",
      "zh-cn": "预付费配置"
    }
  }
  EOT
}

variable "deploy_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "DeployMode"
    },
    "Description": {
      "en": "Application deployment mode in the cluster.Ranges:\nNormal: non -high available deployment.Cluster 1 master node.\nHA: High availability deployment.High availability deployment requires at least 3 master nodes."
    },
    "AllowedValues": [
      "HA",
      "NORMAL"
    ],
    "Label": {
      "en": "DeployMode",
      "zh-cn": "集群中的应用部署模式"
    }
  }
  EOT
}

variable "security_mode" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "SecurityMode"
    },
    "Description": {
      "en": "Cluster Kerberos security mode.Ranges:\nNormal: General mode, does not open the Kerberos mode.\nKerberos: Open the Kerberos mode."
    },
    "AllowedValues": [
      "KERBEROS",
      "NORMAL"
    ],
    "Label": {
      "en": "SecurityMode",
      "zh-cn": "集群Kerberos安全模式"
    }
  }
  EOT
}

variable "node_attributes" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "KeyPairName": {
          "AssociationProperty": "ALIYUN::ECS::KeyPair::KeyPairName",
          "Type": "String",
          "Description": {
            "en": "ECS ssh login key."
          },
          "Required": false
        },
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "Vpc id"
          },
          "Required": true
        },
        "ZoneId": {
          "AssociationProperty": "ZoneId",
          "Type": "String",
          "Description": {
            "en": "Zone id"
          },
          "Required": true
        },
        "DiskKMSKeyId": {
          "Type": "String",
          "Description": {
            "en": "KMS encryption key ID."
          },
          "Required": false
        },
        "MasterRootPassword": {
          "Type": "String",
          "Description": {
            "en": "MASTER node root password."
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
            "en": "Security group ID. EMR only supports common security groups, not enterprise security groups."
          },
          "Required": true
        },
        "RamRole": {
          "Type": "String",
          "Description": {
            "en": "The role of the ECS access resource binding. Default value: AliyunECSInstanceForEMRRole."
          },
          "Required": false
        },
        "DiskEncrypted": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable cloud disk encryption."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "Node attributes.All ECS nodes basic attributes of the cluster."
    },
    "Label": {
      "en": "NodeAttributes",
      "zh-cn": "节点属性"
    }
  }
  EOT
}

variable "cluster_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster name.The length is 1 ~ 128 characters, and the alphabet or Chinese must be started. It cannot start with http:// and https: //.It can include Chinese, English, numbers, half-horn colons (:), down line (_), half-angle period (.) Or short lines (-)"
    },
    "Label": {
      "en": "ClusterName",
      "zh-cn": "集群名称"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Payment type. Ranges: \nPayAsYouGo: Post-paid, pay-as-you-go.\nSubscription: Prepaid, yearly and monthly.\nDefault: PayAsYouGo."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费类型"
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
      "en": "Tags to attach to cluster. Max support 20 tags to add during create cluster. Each tag with two properties Key and Value, and Key is required."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_emrv2_cluster" "cluster" {
  resource_group_id   = var.resource_group_id
  application_configs = var.application_configs
  cluster_type        = var.cluster_type
  node_groups         = var.node_groups
  release_version     = var.release_version
  bootstrap_scripts   = var.bootstrap_scripts
  deploy_mode         = var.deploy_mode
  security_mode       = var.security_mode
  cluster_name        = var.cluster_name
  payment_type        = var.payment_type
  tags                = var.tags
}

output "cluster_id" {
  value       = alicloud_emrv2_cluster.cluster.id
  description = "Cluster ID."
}

output "application_links" {
  // Could not transform ROS Attribute ApplicationLinks to Terraform attribute.
  value       = null
  description = "ApplicationLinks of cluster."
}

