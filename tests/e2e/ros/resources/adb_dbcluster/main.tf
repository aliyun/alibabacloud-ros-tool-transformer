variable "dbnode_storage" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "Cluster"
          ]
        }
      }
    },
    "Description": {
      "en": "The storage space of the node. This parameter is required in reserved mode. Unit: GB. Valid values:\nT8: 100 to 500\nT16 and T32: 100 to 2000\nT52: 100 to 4000\nC8: 100 to 1000\nC32: 100 to 8000\nNote The storage space less than 1,000 GB increases in increments of 100 GB. The storage space greater than 1,000 GB increases in increments of 1,000 GB."
    },
    "MinValue": 100,
    "Label": {
      "en": "DBNodeStorage",
      "zh-cn": "节点存储空间"
    },
    "MaxValue": 8000
  }
  EOT
}

variable "period_type" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The subscription period for the cluster. This parameter is required if the PayType parameter is set to Prepaid. Valid values:\nYear: subscription on a yearly basis\nMonth: subscription on a monthly basis"
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodType",
      "zh-cn": "指定预付费集群为包年或包月类型"
    }
  }
  EOT
}

variable "dbcluster_category" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ValueLabelMapping": {
        "MixedStorage": {
          "en": "Mixed Storage Cluster",
          "zh-cn": "弹性模式集群版"
        },
        "Cluster": {
          "en": "Reserved Mode Cluster",
          "zh-cn": "预留模式集群版"
        }
      }
    },
    "Description": {
      "en": "The edition of the cluster.\nValid values when the cluster is in reserved mode:\nBasic\nCluster\nWhen the cluster is in elastic mode, set the value to MixedStorage."
    },
    "AllowedValues": [
      "Cluster",
      "MixedStorage"
    ],
    "Label": {
      "en": "DBClusterCategory",
      "zh-cn": "系列"
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
      "en": "The ID of the resource group."
    },
    "Label": {
      "en": "ResourceGroupId",
      "zh-cn": "资源组ID"
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
      "en": "The zone ID of the cluster. You can call the DescribeRegions operation to query the most recent zone list."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "vpcid" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the VPC.\n"
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "专有网络ID"
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
      "en": "The ID of the vSwitch."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "mode" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Value": [
        {
          "Condition": {
            "Fn::Equals": [
              "$${DBClusterCategory}",
              "Cluster"
            ]
          },
          "Value": "Reserver"
        },
        {
          "Condition": {
            "Fn::Equals": [
              "$${DBClusterCategory}",
              "MixedStorage"
            ]
          },
          "Value": "Flexible"
        }
      ]
    },
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The mode of the cluster. Valid values:\nReserver: the reserved mode\nFlexible: the elastic mode"
    },
    "Label": {
      "en": "Mode",
      "zh-cn": "模式"
    }
  }
  EOT
}

variable "dbcluster_description" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The description of the cluster."
    },
    "Label": {
      "en": "DBClusterDescription",
      "zh-cn": "备注信息"
    }
  }
  EOT
}

variable "compute_resource" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "MixedStorage"
          ]
        }
      }
    },
    "Description": {
      "en": "The computing resource of the cluster. This parameter is required in elastic mode."
    },
    "Label": {
      "en": "ComputeResource",
      "zh-cn": "计算资源"
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
      "en": "Valid values when the Period parameter is set to Month: 1, 2, 3, 4, 5, 6, 7, 8, and 9.\nValid values when the Period parameter is set to Year: 1, 2, and 3."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "包年包月时长"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  default     = "Postpaid"
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "Prepaid": {
          "Month": [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9
          ],
          "Year": [
            1,
            2,
            3
          ]
        },
        "Postpaid": {}
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "The billing method of the cluster. Valid values:\nPostpaid: pay-as-you-go\nPrepaid: subscription"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "elasticioresource" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "MixedStorage"
          ]
        }
      }
    },
    "Description": {
      "en": "Elastic IO Unit\nNote the flexible mode cluster will use this parameter.",
      "zh-cn": "弹性IO资源（Elastic IO Unit，简称EIU）。"
    },
    "Label": {
      "en": "ElasticIOResource",
      "zh-cn": "弹性IO资源（Elastic IO Unit"
    }
  }
  EOT
}

variable "dbcluster_version" {
  type        = string
  default     = "3.0"
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ReadOnly",
    "Description": {
      "en": "The version of the cluster. Set the value to 3.0."
    },
    "Label": {
      "en": "DBClusterVersion",
      "zh-cn": "AnalyticDB MySQL集群版本"
    }
  }
  EOT
}

variable "dbnode_group_count" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "Cluster"
          ]
        }
      }
    },
    "Description": {
      "en": "The number of node groups. This parameter is required in reserved mode. Valid values:\nT8, T16, T32, and T52: 1\nC8 and C32: 1 to 128"
    },
    "MinValue": 1,
    "Label": {
      "en": "DBNodeGroupCount",
      "zh-cn": "节点组数量"
    },
    "MaxValue": 128
  }
  EOT
}

variable "executor_count" {
  type        = number
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "MixedStorage"
          ]
        }
      }
    },
    "Description": {
      "en": "ExecutorCount"
    },
    "Label": {
      "en": "ExecutorCount",
      "zh-cn": "弹性模式下集群使用的计算节点数量"
    }
  }
  EOT
}

variable "dbcluster_class" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Visible": {
        "Condition": {
          "Fn::Equals": [
            "$${DBClusterCategory}",
            "Cluster"
          ]
        }
      }
    },
    "Description": {
      "en": "The specification of the cluster. This parameter is required in reserved mode. Valid values:\nBasic Edition: T8, T16, T32, and T52\nCluster Edition: C8 and C32"
    },
    "Label": {
      "en": "DBClusterClass",
      "zh-cn": "规格"
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

resource "alicloud_adb_db_cluster" "dbcluster" {
  db_node_storage     = var.dbnode_storage
  db_cluster_category = var.dbcluster_category
  resource_group_id   = var.resource_group_id
  zone_id             = var.zone_id
  vpc_id              = var.vpcid
  vswitch_id          = var.vswitch_id
  mode                = var.mode
  description         = var.dbcluster_description
  compute_resource    = var.compute_resource
  period              = var.period
  pay_type            = var.pay_type
  db_cluster_version  = var.dbcluster_version
  db_node_count       = var.dbnode_group_count
  db_cluster_class    = var.dbcluster_class
  tags                = var.tags
}

output "dbcluster_id" {
  value       = alicloud_adb_db_cluster.dbcluster.id
  description = "The ID of the cluster."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "The ID of the order."
}

output "connection_string" {
  value       = alicloud_adb_db_cluster.dbcluster.connection_string
  description = "Vpc connection string."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

