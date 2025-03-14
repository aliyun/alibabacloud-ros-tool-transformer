variable "description" {
  type        = string
  description = <<EOT
  {
    "AssociationProperty": "TextArea",
    "Description": {
      "en": "The description of the Internet Shared Bandwidth instance.\nThe description must be 2 to 256 characters in length. It must start with a letter,\nand cannot start with http:// or https://."
    },
    "Label": {
      "en": "Description",
      "zh-cn": "共享带宽的描述信息"
    },
    "MinLength": 2,
    "MaxLength": 256
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

variable "zone" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "Zone Id."
    },
    "Label": {
      "en": "Zone",
      "zh-cn": "共享带宽的可用区"
    }
  }
  EOT
}

variable "isp" {
  type        = string
  default     = "BGP"
  description = <<EOT
  {
    "Description": {
      "en": "Line type of EIP, value: BGP (multi-line)."
    },
    "Label": {
      "en": "ISP",
      "zh-cn": "EIP的线路类型"
    }
  }
  EOT
}

variable "bandwidth" {
  type        = number
  nullable    = false
  description = <<EOT
  {
    "Description": {
      "en": "The peak bandwidth of the Internet Shared Bandwidth instance. Unit: Mbit/s."
    },
    "MinValue": 2,
    "Label": {
      "en": "Bandwidth",
      "zh-cn": "共享带宽的带宽峰值"
    }
  }
  EOT
}

variable "ratio" {
  type        = number
  default     = 100
  description = <<EOT
  {
    "Description": {
      "en": "The minimum consumption ratio of the Internet Shared Bandwidth instance. Default to 100.\nNote This parameter is only supported on the China site."
    },
    "MinValue": 0,
    "Label": {
      "en": "Ratio",
      "zh-cn": "共享带宽的保底百分比"
    },
    "MaxValue": 100
  }
  EOT
}

variable "deletion_protection" {
  type        = bool
  description = <<EOT
  {
    "Description": {
      "en": "Whether to enable deletion protection.\nDefault to False."
    },
    "Label": {
      "en": "DeletionProtection",
      "zh-cn": "是否启用删除保护"
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

variable "internet_charge_type" {
  type        = string
  description = <<EOT
  {
    "AssociationPropertyMetadata": {
      "LocaleKey": "InternetChargeType"
    },
    "Description": {
      "en": "The billing model of the Internet Shared Bandwidth instance. Allowed values:\nPayByBandwidth (default): Billed by bandwidth.\nPayBy95: Charged at Enhanced 95."
    },
    "Label": {
      "en": "InternetChargeType",
      "zh-cn": "共享带宽的计费方式"
    }
  }
  EOT
}

variable "name" {
  type        = string
  description = <<EOT
  {
    "Description": {
      "en": "The name of the Internet Shared Bandwidth instance.\nThe name must be 2 to 128 characters in length and can contain letters, numbers, periods\n(.), underscores (_), and hyphens (-). The name must start with a letter, and cannot\nstart with http:// or https://."
    },
    "Label": {
      "en": "Name",
      "zh-cn": "共享带宽的名称"
    },
    "MinLength": 2,
    "MaxLength": 128
  }
  EOT
}

resource "alicloud_common_bandwidth_package" "common_bandwidth_package" {
  description          = var.description
  resource_group_id    = var.resource_group_id
  zone                 = var.zone
  isp                  = var.isp
  bandwidth            = var.bandwidth
  ratio                = var.ratio
  deletion_protection  = var.deletion_protection
  tags                 = var.tags
  internet_charge_type = var.internet_charge_type
  name                 = var.name
}

output "bandwidth_package_id" {
  value       = alicloud_common_bandwidth_package.common_bandwidth_package.id
  description = "The ID of the Internet Shared Bandwidth instance."
}

output "arn" {
  // Could not transform ROS Attribute Arn to Terraform attribute.
  value       = null
  description = "The Alibaba Cloud Resource Name (ARN)."
}

