variable "db_node_storage_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Instance node storage type. Valid values:  cloud_essd, cloud_efficiency."
    },
    "Label": {
      "en": "DbNodeStorageType",
      "zh-cn": "节点存储空间类型"
    }
  }
  EOT
}

variable "dbnode_storage" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of a single node. Valid values: 100 to 32000. Unit: GB.\nNote self value is a multiple of 100."
    },
    "Label": {
      "en": "DBNodeStorage",
      "zh-cn": "节点存储空间"
    }
  }
  EOT
}

variable "encryption_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Kms key type, only cloud disk encryption is supported and the value is CloudDisk."
    },
    "Label": {
      "en": "EncryptionType",
      "zh-cn": "加密类型"
    }
  }
  EOT
}

variable "category" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The edition of the cluster. Valid values:\nBasic: Single-replica Edition\nHighAvailability: Double-replica Edition"
    },
    "Label": {
      "en": "Category",
      "zh-cn": "集群系列"
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
      "en": "ZoneId"
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
      "en": "VSwitchId"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
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
      "zh-cn": "集群备注信息"
    },
    "MinLength": 2,
    "MaxLength": 256
  }
  EOT
}

variable "period" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period.If the payment type is Prepaid, this parameter is mandatory. Specify the prepaid cluster as a yearly or monthly type. Valid values:  Year, Month."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "预付费集群的付费周期"
    }
  }
  EOT
}

variable "encryption_key" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "KMS key ID"
    },
    "Label": {
      "en": "EncryptionKey",
      "zh-cn": "密钥管理服务KMS的密钥ID"
    }
  }
  EOT
}

variable "dbcluster_network_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Network type of the cluster instance, value: VPC"
    },
    "Label": {
      "en": "DBClusterNetworkType",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

variable "dbcluster_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The specification of the cluster.\nIf the cluster is of the Single-replica Edition, the following values are valid:\nS4: 4 cores, 16 GB.\nS8: 8 cores, 32 GB.\nS16: 16 cores, 64 GB.\nS32: 32 cores, 128 GB.\nS64: 64 cores, 256 GB.\nS104: 104 cores, 384 GB.\nIf the cluster is of the Double-replica Edition, the following values are valid:\nC4: 4 cores, 16 GB.\nC8: 8 cores, 32 GB.\nC16: 16 cores, 64 GB.\nC32: 32 cores, 128 GB.\nC64: 64 cores, 256 GB.\nC104: 104 cores, 384 GB."
    },
    "Label": {
      "en": "DBClusterType",
      "zh-cn": "集群类型"
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
      "en": "VpcId"
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "dbcluster_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Version, value:  19.15.2.2"
    },
    "Label": {
      "en": "DBClusterVersion",
      "zh-cn": "实例版本"
    }
  }
  EOT
}

variable "dbnode_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The number of nodes.\nIf the cluster is of the Single-replica Edition, the value ranges from 1 to 48.\nIf the cluster is of the Double-replica Edition, the value ranges from 1 to 24."
    },
    "Label": {
      "en": "DBNodeCount",
      "zh-cn": "节点组数量"
    }
  }
  EOT
}

variable "used_time" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The subscription duration. Valid values:\nWhen Period is Month, it could be from 1 to 9, 12, 24, 36.\n When Period is Year, it could be from 1 to 3."
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
      "en": "UsedTime",
      "zh-cn": "实例使用时间"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "PayAsYouGo",
      "Subscription"
    ],
    "Description": {
      "en": "The billing method of the cluster. Valid values:\nPostpaid: pay-as-you-go\nPrepaid: subscription"
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

resource "alicloud_click_house_db_cluster" "click_housedbcluster" {
  encryption_type = var.encryption_type
  category        = var.category
  zone_id         = var.zone_id
  vswitch_id      = var.vswitch_id
  period          = var.period
  encryption_key  = var.encryption_key
  vpc_id          = var.vpc_id
  used_time       = var.used_time
  payment_type    = var.payment_type
}

output "category" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.category
  description = "The edition of the cluster."
}

output "port" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.port
  description = "Connection port"
}

output "dbcluster_id" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.id
  description = "The id of DBCluster"
}

output "encryption_key" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.encryption_key
  description = "KMS key ID"
}

output "dbcluster_network_type" {
  // Could not transform ROS Attribute DBClusterNetworkType to Terraform attribute.
  value       = null
  description = "Network type of the cluster instance, value: VPC"
}

output "dbcluster_type" {
  // Could not transform ROS Attribute DBClusterType to Terraform attribute.
  value       = null
  description = "The specification of the cluster."
}

output "dbcluster_version" {
  // Could not transform ROS Attribute DBClusterVersion to Terraform attribute.
  value       = null
  description = "Version, value:  19.15.2.2"
}

output "commodity_code" {
  // Could not transform ROS Attribute CommodityCode to Terraform attribute.
  value       = null
  description = "Product Code"
}

output "dbnode_count" {
  // Could not transform ROS Attribute DBNodeCount to Terraform attribute.
  value       = null
  description = "The number of nodes."
}

output "payment_type" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.payment_type
  description = "PayType"
}

output "public_connection_string" {
  // Could not transform ROS Attribute PublicConnectionString to Terraform attribute.
  value       = null
  description = "Internet connection address"
}

output "lock_reason" {
  // Could not transform ROS Attribute LockReason to Terraform attribute.
  value       = null
  description = "Reason for lock"
}

output "bid" {
  // Could not transform ROS Attribute Bid to Terraform attribute.
  value       = null
  description = "BusinessID"
}

output "engine" {
  // Could not transform ROS Attribute Engine to Terraform attribute.
  value       = null
  description = "Engine"
}

output "dbnode_storage" {
  // Could not transform ROS Attribute DBNodeStorage to Terraform attribute.
  value       = null
  description = "The storage capacity of a single node."
}

output "db_node_storage_type" {
  // Could not transform ROS Attribute DbNodeStorageType to Terraform attribute.
  value       = null
  description = "Instance node storage type. Valid values:  cloud_essd, cloud_efficiency."
}

output "is_expired" {
  // Could not transform ROS Attribute IsExpired to Terraform attribute.
  value       = null
  description = "IsExpired"
}

output "encryption_type" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.encryption_type
  description = "Kms key type, only cloud disk encryption is supported and the value is CloudDisk."
}

output "engine_version" {
  // Could not transform ROS Attribute EngineVersion to Terraform attribute.
  value       = null
  description = "EngineVersion"
}

output "storage_type" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.storage_type
  description = "StorageType"
}

output "zone_id" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.zone_id
  description = "ZoneId"
}

output "vswitch_id" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.vswitch_id
  description = "VSwitchId"
}

output "dbcluster_description" {
  // Could not transform ROS Attribute DBClusterDescription to Terraform attribute.
  value       = null
  description = "The description of the cluster."
}

output "period" {
  // Could not transform ROS Attribute Period to Terraform attribute.
  value       = null
  description = "Prepaid time period.If the payment type is Prepaid, this parameter is mandatory. Specify the prepaid cluster as a yearly or monthly type. Valid values:  Year, Month."
}

output "lock_mode" {
  // Could not transform ROS Attribute LockMode to Terraform attribute.
  value       = null
  description = "LockMode"
}

output "dbnode_class" {
  // Could not transform ROS Attribute DBNodeClass to Terraform attribute.
  value       = null
  description = "DBNodeClass"
}

output "vpc_id" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.vpc_id
  description = "VpcId"
}

output "vpc_cloud_instance_id" {
  // Could not transform ROS Attribute VpcCloudInstanceId to Terraform attribute.
  value       = null
  description = "VpcCloudInstanceId"
}

output "connection_string" {
  value       = alicloud_click_house_db_cluster.click_housedbcluster.connection_string
  description = "ConnectionString"
}

output "public_port" {
  // Could not transform ROS Attribute PublicPort to Terraform attribute.
  value       = null
  description = "PublicPort"
}

output "ali_uid" {
  // Could not transform ROS Attribute AliUid to Terraform attribute.
  value       = null
  description = "AliUid"
}

