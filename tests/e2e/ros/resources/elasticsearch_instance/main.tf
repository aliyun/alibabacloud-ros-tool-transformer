variable "master_node" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DiskType": {
          "AssociationPropertyMetadata": {
            "LocaleKey": "DiskCategory"
          },
          "Type": "String",
          "Description": {
            "en": "The dedicated master node disk type."
          },
          "AllowedValues": [
            "cloud_essd",
            "cloud_ssd"
          ],
          "Required": false,
          "Default": "cloud_essd"
        },
        "Amount": {
          "Type": "Number",
          "Description": {
            "en": "The dedicated master node quantity. Default to 3."
          },
          "AllowedValues": [
            3
          ],
          "Required": false,
          "Default": 3
        },
        "DiskSize": {
          "Type": "Number",
          "Description": {
            "en": "The dedicated master node storage space. Default to 20."
          },
          "AllowedValues": [
            20
          ],
          "Required": false,
          "Default": 20
        },
        "Spec": {
          "AssociationPropertyMetadata": {
            "ZoneId": "$${ZoneId}",
            "NodeType": "MasterNodeSpec"
          },
          "AssociationProperty": "ALIYUN::Elasticsearch::Instance::Spec",
          "Type": "String",
          "Description": {
            "en": "The dedicated master node spec."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The dedicated master node setting. If specified, dedicated master node will be created."
    },
    "Label": {
      "en": "MasterNode",
      "zh-cn": "主节点设置"
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
      "en": "The description of instance. It a string of 0 to 128 characters. It can contain numbers, letters, underscores, (_) and hyphens (-). It must start with a letter, a number or Chinese character."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "实例的描述"
    },
    "MaxLength": 128
  }
  EOT
}

variable "kibana_node" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Spec": {
          "AssociationPropertyMetadata": {
            "ZoneId": "$${ZoneId}",
            "NodeType": "KibanaNodeSpec"
          },
          "AssociationProperty": "ALIYUN::Elasticsearch::Instance::Spec",
          "Type": "String",
          "Description": {
            "en": "The dedicated kibana node spec."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The dedicated kibana node setting."
    },
    "Label": {
      "en": "KibanaNode",
      "zh-cn": "Kibana专用节点设置"
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

variable "enable_kibana_private" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enables or disables intranet access to Kibana."
    },
    "Label": {
      "en": "EnableKibanaPrivate",
      "zh-cn": "是否开启Kibana私网访问"
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
      "en": "The zone id of elasticsearch."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "public_whitelist" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Set the instance's IP whitelist in Internet. The AllocatePublicAddress should be true."
    },
    "Label": {
      "en": "PublicWhitelist",
      "zh-cn": "实例的公网IP白名单列表"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  default     = "PayAsYouGo"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "PaymentDefinition": {
        "PayAsYouGo": {},
        "Subscription": {
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
            36
          ],
          "Year": [
            1,
            2,
            3
          ]
        }
      }
    },
    "AssociationProperty": "ChargeType",
    "Description": {
      "en": "Valid values are PrePaid, PostPaid, Default to PostPaid."
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例付费类型"
    }
  }
  EOT
}

variable "enable_kibana_public" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Enables or disables Internet access to Kibana."
    },
    "Label": {
      "en": "EnableKibanaPublic",
      "zh-cn": "是否开启Kibana公网访问"
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
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "The ID of VSwitch."
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
  default     = 1
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "The duration that you will buy Elasticsearch instance. It is valid when instance_charge_type is PrePaid. Unit is Month, it could be from 1 to 9 or 12, 24, 36, 48, 60. Unit is Year, it could be from 1 to 3. Default value is 1."
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
      "zh-cn": "购买Elasticsearch实例的持续时间"
    }
  }
  EOT
}

variable "instance_category" {
  type        = string
  default     = "x-pack"
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "ElasticSearchInstanceCategory"
    },
    "Description": {
      "en": "Version Type:\n- x-pack: Create a commercial instance or a kernel-enhanced instance without Indexing Service and OpenStore enabled.\n- IS: Creates a kernel-enhanced instance with Indexing Service or OpenStore enabled"
    },
    "AllowedValues": [
      "x-pack",
      "IS"
    ],
    "Label": {
      "zh-cn": "实例类型"
    }
  }
  EOT
}

variable "enable_public" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether enable public access. If properties is true, will allocate public address.Default: false."
    },
    "Label": {
      "en": "EnablePublic",
      "zh-cn": "是否开启实例的公网地址"
    }
  }
  EOT
}

variable "private_whitelist" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Set the instance's IP whitelist in VPC network."
    },
    "Label": {
      "en": "PrivateWhitelist",
      "zh-cn": "在专有网络中设置实例的IP白名单列表"
    }
  }
  EOT
}

variable "version_937085a4" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "ZoneId": "$${ZoneId}"
    },
    "AssociationProperty": "ALIYUN::ElasticSearch::Instance::Version",
    "Description": {
      "en": "Elasticsearch version. Supported values: 5.5.3_with_X-Pack, 6.3_with_X-Pack, 6.7_with_X-Pack, 7.4_with_X-Pack, 6.8, 7.4, 7.7 and so on."
    },
    "Label": {
      "en": "Version",
      "zh-cn": "Elasticsearch版本"
    }
  }
  EOT
}

variable "data_node" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "DiskType": {
          "AssociationPropertyMetadata": {
            "AutoChangeType": false,
            "LocaleKey": "DiskCategory"
          },
          "Type": "String",
          "Description": {
            "en": "The data node disk type. Supported values: cloud_ssd, cloud_efficiency, cloud_essd"
          },
          "AllowedValues": [
            "cloud_essd",
            "cloud_ssd",
            "cloud_efficiency"
          ],
          "Required": true,
          "Default": "cloud_efficiency"
        },
        "DiskEncryption": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to enable cloud disk encryption."
          },
          "Required": false
        },
        "PerformanceLevel": {
          "AssociationPropertyMetadata": {
            "Visible": {
              "Condition": {
                "Fn::Equals": [
                  "$${.DiskType}",
                  "cloud_essd"
                ]
              }
            }
          },
          "Type": "String",
          "Description": {
            "en": "The performance level of the ESSD. When the storage type is cloud_essd, \nthis parameter is required and supports PL1, PL2, and PL3."
          },
          "AllowedValues": [
            "PL1",
            "PL2",
            "PL3"
          ],
          "Required": false
        },
        "Amount": {
          "Type": "Number",
          "Description": {
            "en": "The Elasticsearch cluster's data node quantity, between 2 and 50."
          },
          "Required": true,
          "MinValue": 2,
          "Label": {
            "zh-cn": "数据节点数量"
          },
          "MaxValue": 50,
          "Default": 4
        },
        "DiskSize": {
          "Type": "Number",
          "Description": {
            "en": "When the DiskType is cloud_ssd, the value can range from 20 to 6144.\nWhen the DiskType is cloud_efficiency, the value can range from 20 to 20480. If the data to be stored is larger than 2048 GB, cloud_efficiency can only support the following data sizes: 2560, 3072, 3584, 4096, 4608, 5120, 5632, 6144, 8192, 10240, 12288, 14336, 16384, 18432, 20480. If we want to store more than 5,120 GB of data, the Elasticsearch version must be 6.7, 7.X, or log-enhanced.\nWhen the DiskType is cloud_essd, the value can range from 20 to 6144.",
            "zh-cn": "当磁盘类型为SSD云盘时时，可取值范围为20~6144。\n当磁盘类型为高效云盘时，可取值范围为20~20480。如果要存储的数据大于2048 GB，cloud_efficiency只能支持以下数据大小：2560、3072、3584、4096、4608、5120、5632、6144、8192、10240、12288、14336、16384、18432、20480。如果要存储的数据大于5120 GB，Elasticsearch版本必须为6.7、7.X或日志增强版。\n当磁盘类型为ESSD云盘时，可取值范围为20~6144。"
          },
          "Required": true,
          "Default": 20
        },
        "Spec": {
          "AssociationPropertyMetadata": {
            "ZoneId": "$${ZoneId}",
            "NodeType": "DataNodeSpec"
          },
          "AssociationProperty": "ALIYUN::Elasticsearch::Instance::Spec",
          "Type": "String",
          "Description": {
            "en": "The data node specifications of the Elasticsearch instance."
          },
          "Required": true
        }
      }
    },
    "Description": {
      "en": "The Elasticsearch cluster's data node setting."
    },
    "Label": {
      "en": "DataNode",
      "zh-cn": "Elasticsearch集群的数据节点设置"
    }
  }
  EOT
}

variable "kibana_whitelist" {
  type        = any
  description = <<EOT
  {
    "Description": {
      "en": "Set the Kibana's IP whitelist in internet network."
    },
    "Label": {
      "en": "KibanaWhitelist",
      "zh-cn": "Kibana的IP白名单列表"
    }
  }
  EOT
}

variable "ymlconfig" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "CreateIndex": {
          "Type": "String",
          "Description": {
            "en": "Specifies whether to automatically create an index when a new document \nis uploaded to your Elasticsearch cluster but no index exists. \nWe recommend that you disable Auto Indexing because indexes created \nby this feature may not meet your business requirements. \nThis parameter corresponds to the action.auto_create_index configuration \nitem in the YML file. The default value of this configuration item is false."
          },
          "Required": false
        },
        "DestructiveRequiresName": {
          "Type": "Boolean",
          "Description": {
            "en": "Specifies whether to specify the index name when you delete an index. \nIf you set this parameter to Allow Wildcards, you can use wildcards to \ndelete multiple indexes at a time. Deleted indexes cannot be recovered. \nExercise caution when you configure this parameter.\nThis parameter corresponds to the action.destructive_requires_name configuration \nitem in the YML file. The default value of this configuration item is true."
          },
          "Required": false
        },
        "OtherConfigs": {
          "Type": "Json",
          "Description": {
            "en": "Other Configurations."
          },
          "Required": false
        },
        "Watcher": {
          "Type": "Boolean",
          "Description": {
            "en": "If you enable Watcher, you can use the X-Pack Watcher feature. \nYou must clear the .watcher-history* index on a regular basis to free up disk space.\nThis parameter corresponds to the xpack.watcher.enabled configuration item in the YML file. \nThe default value of this configuration item is false."
          },
          "Required": false
        },
        "AuditLog": {
          "Type": "Boolean",
          "Description": {
            "en": "If you enable Audit Log Indexing, the system generates audit logs \nfor the create, delete, modify, and search operations that are performed \nin the Elasticsearch cluster. These logs consume disk space and affect \ncluster performance. Therefore, we recommend that you disable Audit Log \nIndexing and exercise caution when you configure this parameter.\nThis parameter is unavailable for Elasticsearch clusters of V7.0 or later."
          },
          "Required": false
        }
      }
    },
    "Description": {
      "en": "In the YML Configuration section of the Cluster \nConfiguration page of your Alibaba Cloud Elasticsearch cluster, \nyou can enable the Auto Indexing, Audit Log Indexing, or Watcher feature."
    },
    "Label": {
      "en": "YMLConfig",
      "zh-cn": "YAML文件配置"
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

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "Unit of prepaid time period, it could be Month/Year. Default value is Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "包年包月计费方式的时长单位"
    }
  }
  EOT
}

variable "password" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "Password",
    "Description": {
      "en": "The password of the instance. The password can be 8 to 32 characters in length and must contain three of the following conditions: uppercase letters, lowercase letters, numbers, and special characters (!@#$%&*()_+-=)."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "实例的密码"
    }
  }
  EOT
}

variable "zone_count" {
  type        = number
  default     = 1
  description = <<EOT
  {
    "Description": {
      "en": "If multiple zones are selected, the one you select and the one shown on the console is the zone where the cluster traffic ingress is located. For the actual deployment, the system will deploy instances in availability zones where there is sufficient inventory of machines of the selected specification.",
      "zh-cn": "如果选择多可用区，您所选的以及控制台上显示的是集群流量入口所在的可用区。实际部署时，系统会在所选规格机器库存充足的可用区部署实例。"
    },
    "AllowedValues": [
      1,
      2,
      3
    ],
    "Label": {
      "en": "ZoneCount",
      "zh-cn": "实例的可用区个数"
    }
  }
  EOT
}

resource "alicloud_elasticsearch_instance" "instance" {
  description          = var.description
  resource_group_id    = var.resource_group_id
  public_whitelist     = var.public_whitelist
  instance_charge_type = var.instance_charge_type
  vswitch_id           = var.vswitch_id
  period               = var.period
  enable_public        = var.enable_public
  private_whitelist    = var.private_whitelist
  version              = var.version_937085a4
  kibana_whitelist     = var.kibana_whitelist
  tags                 = var.tags
  password             = var.password
  zone_count           = var.zone_count
}

output "status" {
  value       = alicloud_elasticsearch_instance.instance.status
  description = "The Elasticsearch instance status. Includes active, activating, inactive. Some operations are denied when status is not active."
}

output "instance_id" {
  value       = alicloud_elasticsearch_instance.instance.id
  description = "The ID of the Elasticsearch instance."
}

output "version" {
  value       = alicloud_elasticsearch_instance.instance.version
  description = "Elasticsearch version."
}

output "instance_charge_type" {
  value       = alicloud_elasticsearch_instance.instance.instance_charge_type
  description = "Instance charge type."
}

output "kibana_port" {
  value       = alicloud_elasticsearch_instance.instance.kibana_port
  description = "Kibana console port."
}

output "vswitch_id" {
  value       = alicloud_elasticsearch_instance.instance.vswitch_id
  description = "The ID of VSwitch."
}

output "port" {
  value       = alicloud_elasticsearch_instance.instance.port
  description = " Instance connection port."
}

output "domain" {
  value       = alicloud_elasticsearch_instance.instance.domain
  description = "Instance connection domain (only VPC network access supported)."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

output "kibana_domain" {
  value       = alicloud_elasticsearch_instance.instance.kibana_domain
  description = "Kibana console domain (Internet access supported)."
}

output "public_domain" {
  value       = alicloud_elasticsearch_instance.instance.public_domain
  description = "Instance public connection domain."
}

