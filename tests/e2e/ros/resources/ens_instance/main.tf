variable "auto_renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "The time period of auto renew. it will take effect.It could be 1, 2, 3, 6, 12. Default value is 1."
    },
    "Label": {
      "en": "AutoRenewPeriod",
      "zh-cn": "每次自动续费的时长"
    }
  }
  EOT
}

variable "key_pair_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "SSH key pair name."
    },
    "Label": {
      "en": "KeyPairName",
      "zh-cn": "密钥对名称"
    }
  }
  EOT
}

variable "private_ip_address" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Private IP for the instance created."
    },
    "Label": {
      "en": "PrivateIpAddress",
      "zh-cn": "内网地址"
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
      "en": "User data to pass to instance. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
    },
    "Label": {
      "en": "UserData",
      "zh-cn": "自定义数据"
    }
  }
  EOT
}

variable "ip_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "ip type, It could be ipv4Andipv6,ipv4,ipv6.default value isi pv4."
    },
    "Label": {
      "en": "IpType",
      "zh-cn": "IP类型"
    }
  }
  EOT
}

variable "system_disk_size" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Disk size of the system disk."
    },
    "Label": {
      "en": "SystemDiskSize",
      "zh-cn": "系统盘大小"
    }
  }
  EOT
}

variable "auto_renew" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Whether renew the fee automatically?it could be True,FalseDefault value is False."
    },
    "Label": {
      "en": "AutoRenew",
      "zh-cn": "是否要自动续费"
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
      "en": "The vSwitch Id to create ens instance."
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
  nullable    = false
  description = <<EOT
  {
    "AssociationProperty": "PayPeriod",
    "Description": {
      "en": "Prepaid time period. Unit is month, it could be from 1 to 9 or 12. Default value is 1."
    },
    "Label": {
      "en": "Period",
      "zh-cn": "购买资源的时长"
    }
  }
  EOT
}

variable "quantity" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "number of instances to create."
    },
    "Label": {
      "en": "Quantity",
      "zh-cn": "实例数量"
    }
  }
  EOT
}

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "Instance Charge type.it could be 95BandwidthByMonth, PayByBandwidth4thMonth."
    },
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "公网付费类型"
    }
  }
  EOT
}

variable "instance_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Instance name"
    },
    "Label": {
      "en": "InstanceName",
      "zh-cn": "实例的名称"
    }
  }
  EOT
}

variable "unique_suffix" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Specifies whether to automatically append sequential suffixes to the hostnames specified by the HostName parameter and instance names specified by the InstanceName parameter when you create multiple instances at a time. The sequential suffix ranges from 001 to 999. Valid values:  true false Default value: false."
    },
    "Label": {
      "en": "UniqueSuffix",
      "zh-cn": "是否为HostName和InstanceName添加有序后缀"
    }
  }
  EOT
}

variable "image_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Image ID to create ens instance.",
      "zh-cn": "镜像文件ID，启动实例时选择的镜像资源。"
    },
    "Label": {
      "en": "ImageId",
      "zh-cn": "镜像文件ID"
    }
  }
  EOT
}

variable "payment_type" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Payment Type.only support value Subscription."
    },
    "Label": {
      "en": "PaymentType",
      "zh-cn": "付费方式"
    }
  }
  EOT
}

variable "data_disk_size" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size."
    },
    "Label": {
      "en": "DataDiskSize",
      "zh-cn": "数据盘的容量大小"
    }
  }
  EOT
}

variable "ens_region_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ENS Region Id."
    },
    "Label": {
      "en": "EnsRegionId",
      "zh-cn": "ENS地域ID"
    }
  }
  EOT
}

variable "instance_type" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "ENS instance supported instance type, make sure it should be correct."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "实例规格"
    }
  }
  EOT
}

variable "host_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The hostname of the instance."
    },
    "Label": {
      "en": "HostName",
      "zh-cn": "云服务器的主机名"
    }
  }
  EOT
}

variable "password" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Password of created ens instance. Must contain at least 3 types of special character, lower character, upper character, number."
    },
    "Label": {
      "en": "Password",
      "zh-cn": "实例密码"
    }
  }
  EOT
}

resource "alicloud_ens_instance" "ensinstance" {
  key_pair_name        = var.key_pair_name
  private_ip_address   = var.private_ip_address
  user_data            = var.user_data
  ip_type              = var.ip_type
  vswitch_id           = var.vswitch_id
  period               = var.period
  internet_charge_type = var.internet_charge_type
  instance_name        = var.instance_name
  unique_suffix        = var.unique_suffix
  image_id             = var.image_id
  payment_type         = var.payment_type
  ens_region_id        = var.ens_region_id
  instance_type        = var.instance_type
  host_name            = var.host_name
  password             = var.password
}

output "auto_renew_period" {
  // Could not transform ROS Attribute AutoRenewPeriod to Terraform attribute.
  value       = null
  description = "The time period of auto renew. it will take effect.It could be 1, 2, 3, 6, 12. Default value is 1."
}

output "key_pair_name" {
  value       = alicloud_ens_instance.ensinstance.key_pair_name
  description = "SSH key pair name."
}

output "private_ip_address" {
  value       = alicloud_ens_instance.ensinstance.private_ip_address
  description = "Private IP for the instance created."
}

output "ip_type" {
  // Could not transform ROS Attribute IpType to Terraform attribute.
  value       = null
  description = "ip type, It could be ipv4Andipv6,ipv4,ipv6.default value isi pv4."
}

output "instance_id" {
  value       = alicloud_ens_instance.ensinstance.id
  description = "InstanceId."
}

output "system_disk_size" {
  // Could not transform ROS Attribute SystemDiskSize to Terraform attribute.
  value       = null
  description = "Disk size of the system disk."
}

output "user_data" {
  // Could not transform ROS Attribute UserData to Terraform attribute.
  value       = null
  description = "User data to pass to instance. [1, 16KB] characters.User data should not be base64 encoded. If you want to pass base64 encoded string to the property, use function Fn::Base64Decode to decode the base64 string first."
}

output "auto_renew" {
  // Could not transform ROS Attribute AutoRenew to Terraform attribute.
  value       = null
  description = "Whether renew the fee automatically?it could be True,FalseDefault value is False."
}

output "vswitch_id" {
  value       = alicloud_ens_instance.ensinstance.vswitch_id
  description = "The vSwitch Id to create ens instance."
}

output "quantity" {
  // Could not transform ROS Attribute Quantity to Terraform attribute.
  value       = null
  description = "number of instances to create."
}

output "period" {
  // Could not transform ROS Attribute Period to Terraform attribute.
  value       = null
  description = "Prepaid time period. Unit is month, it could be from 1 to 9 or 12. Default value is 1."
}

output "internet_charge_type" {
  // Could not transform ROS Attribute InternetChargeType to Terraform attribute.
  value       = null
  description = "Instance Charge type.it could be 95BandwidthByMonth, PayByBandwidth4thMonth."
}

output "instance_name" {
  value       = alicloud_ens_instance.ensinstance.instance_name
  description = "Instance name"
}

output "public_ips" {
  // Could not transform ROS Attribute PublicIps to Terraform attribute.
  value       = null
  description = "Public IP"
}

output "unique_suffix" {
  // Could not transform ROS Attribute UniqueSuffix to Terraform attribute.
  value       = null
  description = "Specifies whether to automatically append sequential suffixes to the hostnames specified by the HostName parameter and instance names specified by the InstanceName parameter when you create multiple instances at a time. The sequential suffix ranges from 001 to 999. Valid values:  true false Default value: false."
}

output "private_ips" {
  // Could not transform ROS Attribute PrivateIps to Terraform attribute.
  value       = null
  description = "Private IP"
}

output "image_id" {
  value       = alicloud_ens_instance.ensinstance.image_id
  description = "Image ID to create ens instance."
}

output "payment_type" {
  value       = alicloud_ens_instance.ensinstance.payment_type
  description = "Payment Type.only support value Subscription."
}

output "data_disk_size" {
  // Could not transform ROS Attribute DataDiskSize to Terraform attribute.
  value       = null
  description = "Disk size of the system disk, range from 20 to 500 GB. If you specify with your own image, make sure the system disk size bigger than image size."
}

output "instance_type" {
  value       = alicloud_ens_instance.ensinstance.instance_type
  description = "ENS instance supported instance type, make sure it should be correct."
}

output "ens_region_id" {
  value       = alicloud_ens_instance.ensinstance.ens_region_id
  description = "ENS Region Id."
}

output "host_name" {
  value       = alicloud_ens_instance.ensinstance.host_name
  description = "The hostname of the instance."
}

