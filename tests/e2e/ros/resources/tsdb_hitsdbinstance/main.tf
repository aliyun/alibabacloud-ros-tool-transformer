variable "instance_storage" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The storage capacity of the instance. Unit: GB. For example, the value 50 indicates 50 GB."
    },
    "MinValue": 40,
    "Label": {
      "en": "InstanceStorage",
      "zh-cn": "存储空间"
    },
    "MaxValue": 32000
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
      "en": "The zone ID of the instance."
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
      "en": "The ID of the virtual private cloud (VPC) that is connected to the instance."
    },
    "Label": {
      "en": "VPCId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "instance_alias" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The alias of the instance."
    },
    "Label": {
      "en": "InstanceAlias",
      "zh-cn": "实例的别名"
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
      "en": "The unit of the validity period. This parameter is valid only when the PayType parameter is set to PREPAY. Default value: Month."
    },
    "AllowedValues": [
      "Month",
      "Year"
    ],
    "Label": {
      "en": "PricingCycle",
      "zh-cn": "预付费时长单位"
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
        "Required": false
      }
    },
    "AssociationProperty": "List[Parameter]",
    "Description": {
      "en": "List of the IP patterns.For example, [\"127.0.0.1\", \"192.168.0.1/24\"]"
    },
    "Label": {
      "en": "SecurityIpList",
      "zh-cn": "实例的白名单列表"
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
      "en": "The ID of the VSwitch in the specified VPC."
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "交换机ID"
    }
  }
  EOT
}

variable "disk_category" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The category of disk."
    },
    "Label": {
      "en": "DiskCategory",
      "zh-cn": "TSDB for InfluxDB®️的磁盘类型"
    }
  }
  EOT
}

variable "instance_class" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The type of the instance."
    },
    "Label": {
      "en": "InstanceClass",
      "zh-cn": "实例的规格"
    }
  }
  EOT
}

variable "duration" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The validity period of the instance. This parameter is valid only when the PayType parameter is set to PREPAY. Default value: 1."
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
      9
    ],
    "Label": {
      "en": "Duration",
      "zh-cn": "购买时长"
    }
  }
  EOT
}

variable "pay_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The billing method. Valid values: \n- **prepay**: The prepay value indicates the subscription method."
    },
    "AllowedValues": [
      "POSTPAY",
      "PREPAY"
    ],
    "Label": {
      "en": "PayType",
      "zh-cn": "付费类型"
    }
  }
  EOT
}

resource "alicloud_tsdb_instance" "hitsdbinstance" {
  instance_storage = var.instance_storage
  zone_id          = var.zone_id
  instance_alias   = var.instance_alias
  vswitch_id       = var.vswitch_id
  disk_category    = var.disk_category
  instance_class   = var.instance_class
  duration         = var.duration
  payment_type     = var.pay_type
}

output "instance_id" {
  value       = alicloud_tsdb_instance.hitsdbinstance.id
  description = "The ID of the instance."
}

output "reverse_vpc_port" {
  // Could not transform ROS Attribute ReverseVpcPort to Terraform attribute.
  value       = null
  description = "Reverse vpc port of the instance."
}

output "reverse_vpc_ip" {
  // Could not transform ROS Attribute ReverseVpcIp to Terraform attribute.
  value       = null
  description = "Reverse vpc ip of the instance."
}

output "public_connection_string" {
  // Could not transform ROS Attribute PublicConnectionString to Terraform attribute.
  value       = null
  description = "Public connection string of the instance."
}

output "engine_type" {
  value       = alicloud_tsdb_instance.hitsdbinstance.engine_type
  description = "Engine type of the instance."
}

output "order_id" {
  // Could not transform ROS Attribute OrderId to Terraform attribute.
  value       = null
  description = "Order id of created instance."
}

output "connection_string" {
  // Could not transform ROS Attribute ConnectionString to Terraform attribute.
  value       = null
  description = "Connection string of the instance."
}

