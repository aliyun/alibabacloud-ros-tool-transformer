variable "stream_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of LindormStream nodes in the instance. Valid values:\nlindorm.g.xlarge: Each node has 4 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.g.2xlarge: Each node has 8 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.g.4xlarge: Each node has 16 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.g.8xlarge: Each node has 32 dedicated CPU cores and 128 GB of dedicated memory.\nlindorm.c.xlarge: Each node has 4 dedicated CPU cores and 8 GB of dedicated memory.\nlindorm.c.2xlarge: Each node has 8 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.c.4xlarge: Each node has 16 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.c.8xlarge: Each node has 32 dedicated CPU cores and 64 GB of dedicated memory."
    },
    "Label": {
      "en": "StreamSpec",
      "zh-cn": "实例的流引擎节点规格"
    }
  }
  EOT
}

variable "instance_storage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of the instance you want to create. Unit: GB."
    },
    "Label": {
      "en": "InstanceStorage",
      "zh-cn": "实例的存储容量"
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
      "en": "The ID of the resource group to which the Lindorm instance belongs."
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
      "en": "The ID of the zone in which you want to create the instance."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "实例的可用区ID"
    }
  }
  EOT
}

variable "instance_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InstanceChargeType"
    },
    "Description": {
      "en": "The billing method of the instance you want to create. Valid values:\nPREPAY: subscription.\nPOSTPAY: pay-as-you-go.\nDefault value: POSTPAY"
    },
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Label": {
      "en": "InstanceChargeType",
      "zh-cn": "实例的付费类型"
    }
  }
  EOT
}

variable "stream_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of LindormStream nodes in the instance. Valid values: integers from 0 to 90."
    },
    "MinValue": 0,
    "Label": {
      "en": "StreamNum",
      "zh-cn": "实例的流引擎节点数量"
    },
    "MaxValue": 90
  }
  EOT
}

variable "cold_storage" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The cold storage capacity of the instance. By default, if you leave this parameter unspecified, cold storage is not enabled for the instance. Unit: GB. Valid values: 800 to 1000000."
    },
    "MinValue": 800,
    "Label": {
      "en": "ColdStorage",
      "zh-cn": "实例的冷存储容量"
    },
    "MaxValue": 1000000
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
      "en": "The ID of the vSwitch to which you want the instance to connect."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "虚拟交换机的ID"
    }
  }
  EOT
}

variable "disk_category" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "capacity_cloud_storage",
      "cloud_efficiency",
      "cloud_ssd",
      "local_hdd_pro",
      "local_ssd_pro"
    ],
    "Description": {
      "en": "The storage type of the instance. Valid values:\ncloud_efficiency: This instance uses the Standard type of storage.\ncloud_ssd: This instance uses the Performance type of storage.\ncapacity_cloud_storage: This instance uses the Capacity type of storage.\nlocal_ssd_pro: This instance uses local SSDs.\nlocal_hdd_pro: This instance uses local HDDs."
    },
    "Label": {
      "en": "DiskCategory",
      "zh-cn": "实例的存储类型"
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
      "en": "The subscription period of the instance. The valid values of this parameter depend on the value of the PeriodUnit parameter.\nIf PeriodUnit is set to Month, Valid values are 1,2,3,4,5,6,7,8,9,12,24,36.\nIf PeriodUnit is set to Year, set this parameter to an integer that ranges from 1 to 3.\nNoteThis parameter is available and required when the PayType parameter is set to PREPAY."
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
      "zh-cn": "实例包年包月的时间"
    }
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to enable the release protection feature for the instance. Default is false."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否开启删除保护"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The name of the instance that you want to create."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "solr_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of LindormSearch nodes in the instance. Valid values: integers from 0 to 60."
    },
    "MinValue": 0,
    "Label": {
      "en": "SolrNum",
      "zh-cn": "实例的搜索引擎节点数量"
    },
    "MaxValue": 60
  }
  EOT
}

variable "solr_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the LindormSearch nodes in the instance. Valid values:\nlindorm.g.xlarge: Each node has 4 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.g.2xlarge: Each node has 8 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.g.4xlarge: Each node has 16 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.g.8xlarge: Each node has 32 dedicated CPU cores and 128 GB of dedicated memory."
    },
    "Label": {
      "en": "SolrSpec",
      "zh-cn": "实例的搜索引擎节点规格"
    }
  }
  EOT
}

variable "filestore_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of LindormDFS nodes in the instance. The valid values of this parameter depend on the value of the PayType parameter.\nIf the PayType parameter is set to PREPAY, set this parameter to an integer that ranges from 0 to 60.\nIf the PayType parameter is set to POSTPAY, set this parameter to an integer that ranges from 0 to 8."
    },
    "MinValue": 0,
    "Label": {
      "en": "FilestoreNum",
      "zh-cn": "实例的文件引擎节点数量"
    },
    "MaxValue": 60
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
      "en": "The ID of the VPC in which you want to create the instance."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "实例的专有网络ID"
    }
  }
  EOT
}

variable "security_ip_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "The security ip of lindorm instance."
        },
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The ip white list of instance."
    },
    "Label": {
      "en": "SecurityIpList",
      "zh-cn": "需要设置的白名单IP地址"
    }
  }
  EOT
}

variable "lindorm_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of LindormTable nodes in the instance. Valid values:\nlindorm.g.xlarge: Each node has 4 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.g.2xlarge: Each node has 8 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.g.4xlarge: Each node has 16 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.g.8xlarge: Each node has 32 dedicated CPU cores and 128 GB of dedicated memory.\nlindorm.c.xlarge: Each node has 4 dedicated CPU cores and 8 GB of dedicated memory.\nlindorm.c.2xlarge: Each node has 8 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.c.4xlarge: Each node has 16 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.c.8xlarge: Each node has 32 dedicated CPU cores and 64 GB of dedicated memory."
    },
    "Label": {
      "en": "LindormSpec",
      "zh-cn": "实例的宽表引擎节点规格"
    }
  }
  EOT
}

variable "tsdb_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the LindormTSDB nodes in the instance. Valid values:\nlindorm.g.xlarge: Each node has 4 dedicated CPU cores and 16 GB of dedicated memory.\nlindorm.g.2xlarge: Each node has 8 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.g.4xlarge: Each node has 16 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.g.8xlarge: Each node has 32 dedicated CPU cores and 128 GB of dedicated memory."
    },
    "Label": {
      "en": "TsdbSpec",
      "zh-cn": "实例的时序引擎节点规格"
    }
  }
  EOT
}

variable "core_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the nodes in the instance if you set DiskCategory to local_ssd_pro or local_hdd_pro.\nWhen DiskCategory is set to local_ssd_pro, you can set this parameter to the following values:\nlindorm.i2.xlarge: Each node has 4 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.i2.2xlarge: Each node has 8 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.i2.4xlarge: Each node has 16 dedicated CPU cores and 128 GB of dedicated memory.\nlindorm.i2.8xlarge: Each node has 32 dedicated CPU cores and 256 GB of dedicated memory.\nWhen DiskCategory is set to local_hdd_pro, you can set this parameter to the following values:\nlindorm.d1.2xlarge: Each node has 8 dedicated CPU cores and 32 GB of dedicated memory.\nlindorm.d1.4xlarge: Each node has 16 dedicated CPU cores and 64 GB of dedicated memory.\nlindorm.d1.6xlarge: Each node has 24 dedicated CPU cores and 96 GB of dedicated memory."
    },
    "Label": {
      "en": "CoreSpec",
      "zh-cn": "实例的本地盘类型节点规格"
    }
  }
  EOT
}

variable "lindorm_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of LindormTable nodes in the instance. The valid values of this parameter depend on the value of the PayType parameter.\nIf the PayType parameter is set to PREPAY, set this parameter to an integer that ranges from 0 to 90.\nIf the PayType parameter is set to POSTPAY, set this parameter to an integer that ranges from 0 to 400.\n** This parameter is required if you want to create a multi-zone instance. ** The valid values of this parameter range from 4 to 400 if you want to create a multi-zone instance."
    },
    "MinValue": 0,
    "Label": {
      "en": "LindormNum",
      "zh-cn": "实例的宽表引擎节点数量"
    },
    "MaxValue": 400
  }
  EOT
}

variable "filestore_spec" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The specification of LindormDFS nodes in the instance. Set the value of this parameter to lindorm.c.xlarge, which indicates that each node has 4 dedicated CPU cores and 8 GB of dedicated memory."
    },
    "Label": {
      "en": "FilestoreSpec",
      "zh-cn": "实例的文件引擎节点规格"
    }
  }
  EOT
}

variable "tsdb_num" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The number of the LindormTSDB nodes in the instance. The valid values of this parameter depend on the value of the PayType parameter.\nIf the PayType parameter is set to PREPAY, set this parameter to an integer that ranges from 0 to 24.\nIf the PayType parameter is set to POSTPAY, set this parameter to an integer that ranges from 0 to 32."
    },
    "MinValue": 0,
    "Label": {
      "en": "TsdbNum",
      "zh-cn": "实例的时序引擎节点数量"
    },
    "MaxValue": 32
  }
  EOT
}

variable "period_unit" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriodUnit",
    "Description": {
      "en": "The period based on which you are charged for the instance. Valid values:\nMonth: You are charged for the instance on a monthly basis.\nYear: You are charged for the instance on a yearly basis.\nNoteThis parameter is available and required when the PayType parameter is set to PREPAY."
    },
    "AllowedValues": [
      "Month",
      "Year",
      "month",
      "year"
    ],
    "Label": {
      "en": "PeriodUnit",
      "zh-cn": "实例购买的付费周期"
    }
  }
  EOT
}

resource "alicloud_lindorm_instance" "lindorm_instance" {
  stream_engine_specification = var.stream_spec
  instance_storage            = var.instance_storage
  resource_group_id           = var.resource_group_id
  zone_id                     = var.zone_id
  payment_type                = var.instance_charge_type
  stream_engine_node_count    = var.stream_num
  cold_storage                = var.cold_storage
  vswitch_id                  = var.vswitch_id
  disk_category               = var.disk_category
  duration                    = var.period
  instance_name               = var.instance_name
  search_engine_node_count    = var.solr_num
  search_engine_specification = var.solr_spec
  file_engine_node_count      = var.filestore_num
  vpc_id                      = var.vpc_id
  core_spec                   = var.core_spec
  file_engine_specification   = var.filestore_spec
  pricing_cycle               = var.period_unit
}

output "jdbc_url_list" {
  // Could not transform ROS Attribute JdbcUrlList to Terraform attribute.
  value       = null
  description = "The list of the jdbc connection address."
}

output "auth_infos" {
  // Could not transform ROS Attribute AuthInfos to Terraform attribute.
  value       = null
  description = "The list of the Lindorm instance auth infos."
}

output "instance_id" {
  value       = alicloud_lindorm_instance.lindorm_instance.id
  description = "The ID of the Lindorm instance that is created."
}

