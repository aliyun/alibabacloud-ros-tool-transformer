variable "mse_version" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Required, the value is as follows:\n\n-'mse_dev': indicates the development version.\n-'Mse_pro': means professional version. When this version is selected, the specification is 2c4g or above, and the specification is 3 nodes or above."
    },
    "Label": {
      "en": "MseVersion",
      "zh-cn": "集群版本"
    }
  }
  EOT
}

variable "private_slb_specification" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "PrivateSlbSpecification",
      "zh-cn": "私网SLB规格"
    }
  }
  EOT
}

variable "cluster_version" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster version, such as ZooKeeper_3_8_0,NACOS_2_0_0"
    },
    "AllowedPattern": "^[A-Za-z0-9_-]+$",
    "Label": {
      "en": "ClusterVersion",
      "zh-cn": "集群版本"
    }
  }
  EOT
}

variable "connection_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "network connect type"
    },
    "AllowedValues": [
      "eni",
      "slb"
    ],
    "AllowedPattern": "^[A-Za-z0-9_-]+$",
    "Label": {
      "en": "ConnectionType",
      "zh-cn": "网络连接类型"
    }
  }
  EOT
}

variable "acl_entry_list" {
  type        = any
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameter": {
        "Type": "String",
        "Description": {
          "en": "acl entry"
        },
        "AllowedPattern": "^[A-Za-z0-9_./-]+$",
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "The public network whitelist list is used only when the public network is enabled."
    },
    "Label": {
      "en": "AclEntryList",
      "zh-cn": "白名单列表"
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
      "en": "switcher Id"
    },
    "AllowedPattern": "(.*)",
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "cluster_specification" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Cluster specifications. Note the msversion requirements of the version parameter,\nOptional parameters:\n\"MSE_ SC _1_2_60_c\",\n\"MSE_ SC _2_4_60_c\",\n\"MSE_ SC _4_8_60_c\",\n\"MSE_ SC _8_16_60_c\",\n\"MSE_ SC _16_32_60_c\""
    },
    "AllowedPattern": "^[A-Za-z0-9_-]+$",
    "Label": {
      "en": "ClusterSpecification",
      "zh-cn": "引擎规格"
    }
  }
  EOT
}

variable "pub_slb_specification" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "PubSlbSpecification",
      "zh-cn": "公网SLB规格"
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
      "en": "cluster type"
    },
    "AllowedValues": [
      "Nacos-Ans",
      "ZooKeeper"
    ],
    "AllowedPattern": "^[A-Za-z0-9_-]+$",
    "Label": {
      "en": "ClusterType",
      "zh-cn": "集群类型"
    }
  }
  EOT
}

variable "disk_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "disk type"
    },
    "AllowedPattern": "^[A-Za-z0-9_-]+$",
    "Label": {
      "en": "DiskType",
      "zh-cn": "磁盘类型"
    }
  }
  EOT
}

variable "cluster_alias_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "cluster alias name"
    },
    "AllowedPattern": "(.*)",
    "Label": {
      "en": "ClusterAliasName",
      "zh-cn": "集群别名"
    }
  }
  EOT
}

variable "instance_count" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "1",
      "3",
      "5",
      "7",
      "9"
    ],
    "Description": {
      "en": "instance count"
    },
    "Label": {
      "en": "InstanceCount",
      "zh-cn": "实例数"
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
      "en": "vpc id"
    },
    "AllowedPattern": "(.*)",
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "request_pars" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "RequestPars",
      "zh-cn": "扩展请求参数"
    }
  }
  EOT
}

variable "pub_network_flow" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Public network bandwidth. If the bandwidth is greater than 0, the public network is enabled."
    },
    "AllowedPattern": "^[0-9]*$",
    "Label": {
      "en": "PubNetworkFlow",
      "zh-cn": "公网带宽"
    }
  }
  EOT
}

variable "accept_language" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "AcceptLanguage",
      "zh-cn": "返回结果显示的语言"
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
      "en": "Network type (whether private network is enabled or not). privatenet indicates that private network is enabled."
    },
    "AllowedValues": [
      "pubnet",
      "both",
      "privatenet"
    ],
    "AllowedPattern": "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$",
    "Label": {
      "en": "NetType",
      "zh-cn": "网络类型"
    }
  }
  EOT
}

resource "alicloud_mse_cluster" "msecluster" {
  mse_version               = var.mse_version
  private_slb_specification = var.private_slb_specification
  cluster_version           = var.cluster_version
  connection_type           = var.connection_type
  acl_entry_list            = var.acl_entry_list
  vswitch_id                = var.vswitch_id
  cluster_specification     = var.cluster_specification
  pub_slb_specification     = var.pub_slb_specification
  cluster_type              = var.cluster_type
  disk_type                 = var.disk_type
  cluster_alias_name        = var.cluster_alias_name
  instance_count            = var.instance_count
  vpc_id                    = var.vpc_id
  request_pars              = var.request_pars
  pub_network_flow          = var.pub_network_flow
  net_type                  = var.net_type
}

output "mcpenabled" {
  // Could not transform ROS Attribute MCPEnabled to Terraform attribute.
  value       = null
  description = "Whether MCP takes effect, the value is as follows: true: valid false: not valid"
}

output "internet_address" {
  // Could not transform ROS Attribute InternetAddress to Terraform attribute.
  value       = null
  description = "internet address"
}

output "acl_entry_list" {
  // Could not transform ROS Attribute AclEntryList to Terraform attribute.
  value       = null
  description = "The public network whitelist list is used only when the public network is enabled."
}

output "cpu" {
  // Could not transform ROS Attribute Cpu to Terraform attribute.
  value       = null
  description = "cpu core size"
}

output "internet_port" {
  // Could not transform ROS Attribute InternetPort to Terraform attribute.
  value       = null
  description = "internet port"
}

output "config_auth_enabled" {
  // Could not transform ROS Attribute ConfigAuthEnabled to Terraform attribute.
  value       = null
  description = "Whether the configuration supports it. Valid values: true: false: not supported"
}

output "intranet_port" {
  // Could not transform ROS Attribute IntranetPort to Terraform attribute.
  value       = null
  description = "intranet port"
}

output "disk_type" {
  // Could not transform ROS Attribute DiskType to Terraform attribute.
  value       = null
  description = "disk type"
}

output "app_version" {
  value       = alicloud_mse_cluster.msecluster.app_version
  description = "app version"
}

output "pay_info" {
  // Could not transform ROS Attribute PayInfo to Terraform attribute.
  value       = null
  description = "pay info"
}

output "config_secret_enabled" {
  // Could not transform ROS Attribute ConfigSecretEnabled to Terraform attribute.
  value       = null
  description = "Whether the configuration password takes effect. The value is as follows: true: valid false: not valid"
}

output "cluster_name" {
  // Could not transform ROS Attribute ClusterName to Terraform attribute.
  value       = null
  description = "cluster name"
}

output "intranet_domain" {
  // Could not transform ROS Attribute IntranetDomain to Terraform attribute.
  value       = null
  description = "intranet domain"
}

output "net_type" {
  value       = alicloud_mse_cluster.msecluster.net_type
  description = "Network type (whether private network is enabled or not). privatenet indicates that private network is enabled."
}

output "mse_version" {
  value       = alicloud_mse_cluster.msecluster.mse_version
  description = <<EOT
  "Required, the value is as follows:\n\n-'mse_dev': indicates the development version.\n-'Mse_pro': means professional version. When this version is selected, the specification is 2c4g or above, and the specification is 3 nodes or above."
  EOT
}

output "cluster_version" {
  value       = alicloud_mse_cluster.msecluster.cluster_version
  description = "Cluster version, such as ZooKeeper_3_8_0,NACOS_2_0_0"
}

output "connection_type" {
  value       = alicloud_mse_cluster.msecluster.connection_type
  description = "network connect type"
}

output "instance_id" {
  // Could not transform ROS Attribute InstanceId to Terraform attribute.
  value       = null
  description = "instance id"
}

output "cluster_id" {
  value       = alicloud_mse_cluster.msecluster.id
  description = "cluster id"
}

output "internet_domain" {
  // Could not transform ROS Attribute InternetDomain to Terraform attribute.
  value       = null
  description = "internet domain"
}

output "acl_id" {
  // Could not transform ROS Attribute AclId to Terraform attribute.
  value       = null
  description = "acl id"
}

output "cluster_specification" {
  value       = alicloud_mse_cluster.msecluster.cluster_specification
  description = <<EOT
  "Cluster specifications. Note the msversion requirements of the version parameter,\nOptional parameters:\n\"MSE_ SC _1_2_60_c\",\n\"MSE_ SC _2_4_60_c\",\n\"MSE_ SC _4_8_60_c\",\n\"MSE_ SC _8_16_60_c\",\n\"MSE_ SC _16_32_60_c\""
  EOT
}

output "vswitch_id" {
  value       = alicloud_mse_cluster.msecluster.vswitch_id
  description = "switcher Id"
}

output "health_status" {
  // Could not transform ROS Attribute HealthStatus to Terraform attribute.
  value       = null
  description = "health status"
}

output "memory_capacity" {
  // Could not transform ROS Attribute MemoryCapacity to Terraform attribute.
  value       = null
  description = "memory capacity"
}

output "cluster_type" {
  value       = alicloud_mse_cluster.msecluster.cluster_type
  description = "cluster type"
}

output "cluster_alias_name" {
  value       = alicloud_mse_cluster.msecluster.cluster_alias_name
  description = "cluster alias name"
}

output "instance_count" {
  value       = alicloud_mse_cluster.msecluster.instance_count
  description = "instance count"
}

output "intranet_address" {
  // Could not transform ROS Attribute IntranetAddress to Terraform attribute.
  value       = null
  description = "intranet address"
}

output "disk_capacity" {
  // Could not transform ROS Attribute DiskCapacity to Terraform attribute.
  value       = null
  description = "disk capacity, unit: G"
}

output "vpc_id" {
  value       = alicloud_mse_cluster.msecluster.vpc_id
  description = "vpc id"
}

output "pub_network_flow" {
  value       = alicloud_mse_cluster.msecluster.pub_network_flow
  description = "Public network bandwidth. If the bandwidth is greater than 0, the public network is enabled."
}

