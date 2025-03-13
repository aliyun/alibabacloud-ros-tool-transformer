variable "enable_creatednsrecord_in_pvzt" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to automatically create Privatezone records. \nIf you enable automatic Privatezone record creation, Privatezone records will be automatically created when VPC instances are added.\nValid values:\n- **true**: Automatically creates a Privatezone record.\n- **false** (default): Do not automatically create Privatezone records."
    },
    "Label": {
      "en": "EnableCreateDNSRecordInPvzt",
      "zh-cn": "是否自动创建Privatezone记录"
    }
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
      "en": "The ID of the vpc."
    },
    "Label": {
      "en": "VpcId",
      "zh-cn": "专有网络ID"
    }
  }
  EOT
}

variable "instance_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the instance."
    },
    "Label": {
      "en": "InstanceId",
      "zh-cn": "实例ID"
    }
  }
  EOT
}

variable "module_name" {
  type        = string
  default     = "Registry"
  description = <<EOT
  {
    "Description": {
      "en": "The name of the module in the instance for which a whitelist is configured. Valid values:\n- **Registry** (default): Access the image repository.\n- **Chart**: Access Helm Chart."
    },
    "Label": {
      "en": "ModuleName",
      "zh-cn": "设置访问的模块"
    }
  }
  EOT
}

variable "vswitch_id" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The ID of the vswitch."
    },
    "Label": {
      "en": "VswitchId",
      "zh-cn": "虚拟交换机ID"
    }
  }
  EOT
}

resource "alicloud_cr_vpc_endpoint_linked_vpc" "instance_vpc_endpoint_linked_vpc" {
  vpc_id      = var.vpc_id
  instance_id = var.instance_id
  module_name = var.module_name
  vswitch_id  = var.vswitch_id
}

output "vpc_id" {
  value       = alicloud_cr_vpc_endpoint_linked_vpc.instance_vpc_endpoint_linked_vpc.vpc_id
  description = "The ID of the vpc."
}

output "instance_id" {
  value       = alicloud_cr_vpc_endpoint_linked_vpc.instance_vpc_endpoint_linked_vpc.instance_id
  description = "The ID of the instance."
}

output "vswitch_id" {
  value       = alicloud_cr_vpc_endpoint_linked_vpc.instance_vpc_endpoint_linked_vpc.vswitch_id
  description = "The ID of the vswitch."
}

