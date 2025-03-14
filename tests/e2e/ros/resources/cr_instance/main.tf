variable "instance_storage_name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Custom OSS Bucket name."
    },
    "Label": {
      "en": "InstanceStorageName",
      "zh-cn": "容器镜像服务企业版使用的自定义OSS Bucket名称"
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
      "en": "Instance name.The value contains 3 to 30 lowercase letters, digits, and delimiters \"-\"(it can not be first or last)."
    },
    "AllowedPattern": "^[a-z0-9][a-z0-9-]{1,28}[a-z0-9]$",
    "Label": {
      "en": "InstanceName",
      "zh-cn": "容器镜像服务企业版实例的名称"
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

variable "image_scanner" {
  type        = string
  nullable    = false
  description = <<EOT
  {
    "AllowedValues": [
      "ACR",
      "SAS"
    ],
    "Description": {
      "en": "Security scan engine."
    },
    "Label": {
      "en": "ImageScanner",
      "zh-cn": "镜像安全扫描引擎"
    }
  }
  EOT
}

variable "renewal_status" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal status, value:\n- AutoRenewal: automatic renewal.\n- ManualRenewal: manual renewal.\nDefault ManualRenewal."
    },
    "AllowedValues": [
      "AutoRenewal",
      "ManualRenewal"
    ],
    "Label": {
      "en": "RenewalStatus",
      "zh-cn": "自动续费状态"
    }
  }
  EOT
}

variable "renew_period" {
  type        = number
  description = <<EOT
  {
    "Description": {
      "en": "Automatic renewal cycle, in months.\nWhen RenewalStatus is set to AutoRenewal, it must be set."
    },
    "Label": {
      "en": "RenewPeriod",
      "zh-cn": "自动续费周期"
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
      "en": "Prepaid cycle. The unit is Monthly, please enter an integer multiple of 12 for annual paid products."
    },
    "AllowedValues": [
      1,
      2,
      3,
      6,
      12,
      24,
      36,
      48,
      60
    ],
    "Label": {
      "en": "Period",
      "zh-cn": "预付费周期"
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
      "Basic",
      "Standard",
      "Advanced"
    ],
    "Description": {
      "en": "The Value configuration of the Group 1 attribute of Container Mirror Service Enterprise Edition. Valid values:\nBasic: Basic instance\nStandard: Standard instance\nAdvanced: Advanced Edition Instance."
    },
    "Label": {
      "en": "InstanceType",
      "zh-cn": "容器镜像服务企业版实例类型"
    }
  }
  EOT
}

resource "alicloud_cr_ee_instance" "extension_resource" {
  instance_name  = var.instance_name
  renewal_status = var.renewal_status
  renew_period   = var.renew_period
  period         = var.period
  instance_type  = var.instance_type
}

output "instance_name" {
  value       = alicloud_cr_ee_instance.extension_resource.instance_name
  description = "InstanceName."
}

output "modified_time" {
  // Could not transform ROS Attribute ModifiedTime to Terraform attribute.
  value       = null
  description = "Last modification time."
}

output "resource_group_id" {
  // Could not transform ROS Attribute ResourceGroupId to Terraform attribute.
  value       = null
  description = "The ID of the resource group."
}

output "instance_id" {
  value       = alicloud_cr_ee_instance.extension_resource.id
  description = "The first ID of the resource."
}

output "instance_specification" {
  // Could not transform ROS Attribute InstanceSpecification to Terraform attribute.
  value       = null
  description = "InstanceSpecification."
}

output "create_time" {
  value       = alicloud_cr_ee_instance.extension_resource.created_time
  description = "The creation time of the resource."
}

