variable "cold_storage_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Instance low-frequency storage space. Unit: GB.\n> Pay-As-You-Go (PostPaid) instances ignore this parameter."
    },
    "Label": {
      "en": "ColdStorageSize",
      "zh-cn": "实例低频存储空间"
    }
  }
  EOT
}

variable "leader_instance_id" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The id of leader instance."
    },
    "Label": {
      "en": "LeaderInstanceId",
      "zh-cn": "主实例ID"
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
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "ZoneId",
    "Description": {
      "en": "The zone Id."
    },
    "Label": {
      "en": "ZoneId",
      "zh-cn": "可用区ID"
    }
  }
  EOT
}

variable "product_code" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "product code."
    },
    "Label": {
      "en": "ProductCode",
      "zh-cn": "产品code"
    }
  }
  EOT
}

variable "pricing_cycle" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "PricingCycle"
    },
    "Description": {
      "en": "Billing cycle. Value:\n- Month: monthly billing\n- Hour: hourly billing\n>>\n> - PrePaid only supports Month\n> - PostPaid only supports Hour\n>- The Shared type is automatically set to Hour without specifying it."
    },
    "AllowedValues": [
      "Month",
      "Hour"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "计费周期"
    }
  }
  EOT
}

variable "scale_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Change matching type. Value:\n- UPGRADE: UPGRADE\n- DOWNGRADE: Downgrading\n>>\n>- The upgrade specification cannot be less than the original specification. A blank field indicates that the original specification remains unchanged. On this basis, at least one specification is larger than the original specification.\n>- The downgrading specification cannot be greater than the original specification. A blank field indicates that the original specification remains unchanged. On this basis, at least one specification is smaller than the original specification."
    },
    "AllowedValues": [
      "DOWNGRADE",
      "UPGRADE"
    ],
    "Label": {
      "en": "ScaleType",
      "zh-cn": "更改匹配类型"
    }
  }
  EOT
}

variable "storage_size" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The standard storage space of the instance. Unit: GB.\n> Pay-As-You-Go instances (PostPaid) ignore this parameter."
    },
    "Label": {
      "en": "StorageSize",
      "zh-cn": "实例标准存储空间"
    }
  }
  EOT
}

variable "cpu" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Instance specifications. Value:\n- 8 cores 32 GB (number of compute nodes: 1)\n- 16 cores 64 GB (number of compute nodes: 1)\n- 32 core 128 GB (number of compute nodes: 2)\n- 64 core 256 GB (number of compute nodes: 4)\n- 96 core 384 GB (number of computing nodes: 6)\n- 128 core 512 GB (number of compute nodes: 8)\n- Wait\n>>\n>- just fill in the audit number.\n>- Please submit a work order application for purchasing 1024 or above specifications.\n>- Shared instance types do not need to specify specifications.\n> The specification of -8 core 32GB (number of computing nodes: 1) is only for experience use and cannot be used for production."
    },
    "Label": {
      "en": "Cpu",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The buying cycle. Buy for 2 months.\n> If the Payment type is PostPaid, you do not need to specify it."
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
      60
    ],
    "Label": {
      "en": "Duration",
      "zh-cn": "购买周期"
    }
  }
  EOT
}

variable "auto_pay" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to pay automatically. The default value is true. Value:\n- true: automatic payment\n- false: only generate orders, not pay\n> The default value is true. If the balance of your payment method is insufficient, you can set the parameter AutoPay to false, and an unpaid order will be generated. You can log in to the user Center to pay by yourself."
    },
    "Label": {
      "en": "AutoPay",
      "zh-cn": "是否自动支付"
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
      "en": "The name of the resource."
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例名称"
    }
  }
  EOT
}

variable "endpoints" {
  type        = any
  nullable    = false
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "Parameters": {
        "Type": {
          "Type": "String",
          "Description": {
            "en": "The network type."
          },
          "Required": false
        },
        "Endpoint": {
          "Type": "String",
          "Description": {
            "en": "Domain name."
          },
          "Required": false
        },
        "VpcId": {
          "AssociationProperty": "ALIYUN::ECS::VPC::VPCId",
          "Type": "String",
          "Description": {
            "en": "VPC primary key."
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
            "en": "The ID of the virtual switch."
          },
          "Required": false
        },
        "Enabled": {
          "Type": "Boolean",
          "Description": {
            "en": "Whether to turn on the network."
          },
          "Required": false
        },
        "VpcInstanceId": {
          "Type": "String",
          "Description": {
            "en": "The vpc instance ID."
          },
          "Required": false
        },
        "AlternativeEndpoints": {
          "Type": "String",
          "Description": {
            "en": "Some old instances have both AnyTunnel and SingleTunnel enabled. When switching from AnyTunnel to SingleTunnel, the endpoints of both are retained. Therefore, one more field is required to store the Endpoint."
          },
          "Required": false
        }
      }
    },
    "AssociationProperty": "List[Parameters]",
    "Description": {
      "en": "List of domain names."
    },
    "Label": {
      "en": "Endpoints",
      "zh-cn": "域名列表"
    }
  }
  EOT
}

variable "gateway_count" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Number of gateway nodes."
    },
    "Label": {
      "en": "GatewayCount",
      "zh-cn": "网关数量"
    }
  }
  EOT
}

variable "initial_databases" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Initialize the database and split multiple database names \",\"."
    },
    "Label": {
      "en": "InitialDatabases",
      "zh-cn": "初始化数据库并拆分为多个数据库名称 "
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
      "en": "The payment type of the resource."
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "Standard",
      "Follower",
      "Warehouse",
      "Shared"
    ],
    "Description": {
      "en": "The instance type. Value:\n- Standard: Universal.\n- Follower: Read-only slave instance.\n- Warehouse: calculation group type.\n- Shared: Shared."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例类型"
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
      "en": "Tags of instance."
    },
    "Label": {
      "en": "Tags",
      "zh-cn": "实例标签"
    },
    "MaxLength": 20
  }
  EOT
}

resource "alicloud_hologram_instance" "extension_resource" {
  cold_storage_size  = var.cold_storage_size
  leader_instance_id = var.leader_instance_id
  resource_group_id  = var.resource_group_id
  zone_id            = var.zone_id
  pricing_cycle      = var.pricing_cycle
  scale_type         = var.scale_type
  storage_size       = var.storage_size
  cpu                = var.cpu
  duration           = var.duration
  auto_pay           = var.auto_pay
  instance_name      = var.instance_name
  endpoints          = var.endpoints
  gateway_count      = var.gateway_count
  initial_databases  = var.initial_databases
  payment_type       = var.payment_type
  instance_type      = var.instance_type
  tags               = var.tags
}

output "cold_storage_size" {
  value       = alicloud_hologram_instance.extension_resource.cold_storage_size
  description = "Instance low-frequency storage space. Unit: GB."
}

output "resource_group_id" {
  value       = alicloud_hologram_instance.extension_resource.resource_group_id
  description = "The ID of the resource group."
}

output "suspend_reason" {
  // Could not transform ROS Attribute SuspendReason to Terraform attribute.
  value       = null
  description = "Reason for suspension."
}

output "zone_id" {
  value       = alicloud_hologram_instance.extension_resource.zone_id
  description = "The zone Id."
}

output "instance_id" {
  value       = alicloud_hologram_instance.extension_resource.id
  description = "Resource attribute fields that represent the resource's primary key."
}

output "memory" {
  // Could not transform ROS Attribute Memory to Terraform attribute.
  value       = null
  description = "Memory."
}

output "instance_owner" {
  // Could not transform ROS Attribute InstanceOwner to Terraform attribute.
  value       = null
  description = "The instance owner."
}

output "create_time" {
  value       = alicloud_hologram_instance.extension_resource.create_time
  description = "The creation time of the resource."
}

output "cpu" {
  value       = alicloud_hologram_instance.extension_resource.cpu
  description = "Instance specifications."
}

output "storage_size" {
  value       = alicloud_hologram_instance.extension_resource.storage_size
  description = "The standard storage space of the instance. Unit: GB."
}

output "enable_hive_access" {
  // Could not transform ROS Attribute EnableHiveAccess to Terraform attribute.
  value       = null
  description = "Whether data Lake acceleration is enabled."
}

output "expiration_time" {
  // Could not transform ROS Attribute ExpirationTime to Terraform attribute.
  value       = null
  description = "Expiration time."
}

output "gateway_cpu" {
  // Could not transform ROS Attribute GatewayCpu to Terraform attribute.
  value       = null
  description = "Cpu resources of the Gateway."
}

output "endpoints" {
  value       = alicloud_hologram_instance.extension_resource.endpoints
  description = "List of domain names."
}

output "instance_name" {
  value       = alicloud_hologram_instance.extension_resource.instance_name
  description = "The name of the resource."
}

output "compute_node_count" {
  // Could not transform ROS Attribute ComputeNodeCount to Terraform attribute.
  value       = null
  description = "Number of compute nodes."
}

output "gateway_count" {
  value       = alicloud_hologram_instance.extension_resource.gateway_count
  description = "Number of gateway nodes."
}

output "auto_renewal" {
  // Could not transform ROS Attribute AutoRenewal to Terraform attribute.
  value       = null
  description = "Whether automatic renewal is enabled."
}

output "version" {
  // Could not transform ROS Attribute Version to Terraform attribute.
  value       = null
  description = "The instance version."
}

output "commodity_code" {
  // Could not transform ROS Attribute CommodityCode to Terraform attribute.
  value       = null
  description = "The commodity code."
}

output "gateway_memory" {
  // Could not transform ROS Attribute GatewayMemory to Terraform attribute.
  value       = null
  description = "Gateway memory resources."
}

output "payment_type" {
  value       = alicloud_hologram_instance.extension_resource.payment_type
  description = "The payment type of the resource."
}

output "instance_type" {
  value       = alicloud_hologram_instance.extension_resource.instance_type
  description = "The instance type."
}

output "tags" {
  value       = alicloud_hologram_instance.extension_resource.tags
  description = "Instance tag."
}

