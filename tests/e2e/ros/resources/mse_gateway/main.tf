variable "backupvswitch_id" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "VSwitchId For Backup"
    },
    "Label": {
      "en": "BackupVSwitchId",
      "zh-cn": "备交换机ID"
    }
  }
  EOT
}

variable "enterprise_security_group" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "EnterpriseSecurityGroup",
      "zh-cn": "网关是否为企业安全组类型"
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
      "en": "VpcId"
    },
    "Label": {
      "en": "VpcId",
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
      "VpcId": "$${VpcId}"
    },
    "AssociationProperty": "ALIYUN::VPC::VSwitch::VSwitchId",
    "Description": {
      "en": "VSwitchId"
    },
    "Label": {
      "en": "VSwitchId",
      "zh-cn": "主交换机ID"
    }
  }
  EOT
}

variable "slb_spec" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "SlbSpec",
      "zh-cn": "私网SLB规格"
    }
  }
  EOT
}

variable "spec" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "MSE_GTW_2_4_200_c",
      "MSE_GTW_4_8_200_c",
      "MSE_GTW_8_16_200_c",
      "MSE_GTW_16_32_200_c"
    ],
    "Description": {
      "en": "Gateway Node Specifications"
    },
    "Label": {
      "en": "Spec",
      "zh-cn": "网关节点规格"
    }
  }
  EOT
}

variable "internet_slb_spec" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "InternetSlbSpec",
      "zh-cn": "公网SLB规格"
    }
  }
  EOT
}

variable "replica" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "Gateway Node Number"
    },
    "Label": {
      "en": "Replica",
      "zh-cn": "节点数量"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Label": {
      "en": "Name",
      "zh-cn": "网关名称"
    }
  }
  EOT
}

resource "alicloud_mse_gateway" "msegateway" {
  vpc_id            = var.vpc_id
  vswitch_id        = var.vswitch_id
  slb_spec          = var.slb_spec
  spec              = var.spec
  internet_slb_spec = var.internet_slb_spec
  replica           = var.replica
}

output "gateway_unique_id" {
  value       = alicloud_mse_gateway.msegateway.id
  description = "Gateway unique identification"
}

output "backupvswitch_id" {
  // Could not transform ROS Attribute BackupVSwitchId to Terraform attribute.
  value       = null
  description = "VSwitchId For Backup"
}

output "vpc_id" {
  value       = alicloud_mse_gateway.msegateway.vpc_id
  description = "VpcId"
}

output "vswitch_id" {
  value       = alicloud_mse_gateway.msegateway.vswitch_id
  description = "VSwitchId"
}

output "payment_type" {
  // Could not transform ROS Attribute PaymentType to Terraform attribute.
  value       = null
  description = "The payment type of the resource"
}

output "spec" {
  value       = alicloud_mse_gateway.msegateway.spec
  description = "Gateway Node Specifications"
}

output "replica" {
  value       = alicloud_mse_gateway.msegateway.replica
  description = "Gateway Node Number"
}

